Power Appsのエラーハンドリング基礎

# はじめに

Power Appsのエラーハンドリングは、キャンバスアプリを構築する上で重要な要素です。Power Fxやその他の機能が常に想定通りに動作するとは限らないため、ユーザーに適切なガイダンスを提供する必要があります。また、継続的な監視と改善のためにエラーを追跡する必要もあります。

このガイドでは、キャンバスアプリで利用できる基本的なエラーハンドリング手法について説明します。

# フォームコントロール

フォームコントロールは、データ入力画面を作成する際によく使用される基本的なコントロールです。フォームコントロールには、使いやすい組み込みのエラーハンドリング機能があります。

## Form.Valid
`Form.Valid`を使用すると、フォームが送信可能な状態かどうかを確認できます。エラーがアクティブ、または必須フィールドが空の場合は false を返します。これを[送信]ボタンのDisplayModeプロパティに設定します:

```javascript
// フォームが送信可能か分析し、準備できていない場合はボタンを無効化
If(
    myForm.Valid,
    DisplayMode.Edit,
    DisplayMode.Disabled
)
```

## OnFailure 
フォームコントロールの`OnFailure`プロパティを使用して、送信失敗時のカスタム処理を実装できます。以下のような処理を実装可能です:

- Notify関数によるユーザー通知
- メール送信
- エラーリストやテーブルへのパッチ処理
- その他のカスタム処理

# 一般的なエラーハンドリング関数

## IsBlank
`IsBlank`関数は、コントロールまたは値が空の場合にtrue、そうでない場合はfalseを返すブール値を返します。使い方は簡単で、分析したいコントロールや値を関数内で指定するだけです:

```javascript
// コントロールの出力が空かどうかを判定
IsBlank(txtInput.Text)
```

## IfError
`IfError`関数は、計算が失敗した場合にフォールバック値を返します。これは、無効な除算など計算エラーの処理に便利です:

```javascript
// エラーが発生した場合は0を返す
IfError(
    txtValue01.Text / txtValue02.Text,
    0
)
```

データソースへのパッチ処理でも使用できます:

```javascript
IfError(
    // このパッチでエラーが発生した場合
    Patch(
        Characters,
        Defaults(Characters),
        {Allegiance: "Dark Side"}
    ),
    // ユーザーに通知
    Notify(
        "エラーが発生しました",
        NotificationType.Error,
        2000
    )
)
```

## IsError
`IsError`関数はエラーの有無を検出し、ブール値を返します。計算結果がエラーかどうかを確認するのに使用できます:

```javascript
// 計算がエラーかどうかを評価
IsError(
    txtValue01.Text / txtValue02.Text  
)
```

## IsBlankOrError
`IsBlankOrError`は、`IsBlank`と`IfError`の機能を1つの関数にまとめた便利な関数です。入力が空またはエラーの場合にtrueを返します:

```javascript
// コントロールが空またはエラーがあるかを判定
IsBlankOrError(txtInput.Text)
```

これはUIへのビジュアルフィードバックを提供するのにも便利です:

```javascript
// テキスト入力の受け入れ状態を視覚的に表示
If(
    IsBlankOrError(Self.Text),
    Color.Red,
    Color.Black
)
```

# アプリ全体のエラーハンドリング 

## App.OnError
`OnError`プロパティは、アプリ内の未ハンドルのエラーをキャッチする優れた方法です。デザインモードで[App]を選択し、プロパティリストから[OnError]を選択して設定できます。

以下のようなエラー情報を取得できます:

```javascript
Notify(
    $"{FirstError.Message}, 発生箇所: {FirstError.Observed}, ソース: {FirstError.Kind}",
    NotificationType.Error,
    2000
)
```

## カスタムエラー
`Error`関数を使用して、独自のエラーを作成することもできます:

```javascript
// 開始日が終了日より後の場合にエラーを生成
If(
    dtpStartDate.SelectedDate > dtpEndDate.SelectedDate,
    Error(
        {
            Message: "開始日は終了日より前でなければなりません", 
            Kind: ErrorKind.Validation
        }
    )
)
```

# 一般的なシナリオと実装パターン

## 単一のデータソースへのパッチ
パッチ処理の周りにエラーハンドリングを実装するのがベストプラクティスです:

```javascript
IfError(
    // パッチ処理
    Patch(
        Characters,
        Defaults(Characters),
        {Allegiance: "Dark Side"}
    ),
    // エラー発生時の処理
    Concurrent(
        // ユーザーに通知
        Notify(
            "エラーが発生しました",
            NotificationType.Error,
            2000
        ),
        // モニターにトレース情報を送信
        Trace(
            $"パッチエラー発生時刻: {Now()}",
            TraceSeverity.Error,
            {
                Screen: App.ActiveScreen.Name,
                User: User().Email
            }
        )
    )
)
```

## 連続するデータソースへのパッチ
最初のパッチが成功した場合にのみ2番目のパッチを実行する場合:

```javascript
IfError(
    // パッチ1を試行
    Patch(
        Characters,
        Defaults(Characters),
        {
            Title: txtNewCharacter01.Text,
            Allegiance: "Dark Side"
        }
    ),
    // パッチ1が失敗した場合に通知
    Notify(
        "最初の処理に失敗しました",
        NotificationType.Error,
        2000
    ),
    // パッチ1が成功した場合はパッチ2を試行
    Patch(
        Characters,
        Defaults(Characters),
        {
            Title: txtNewCharacter02.Text, 
            Allegiance: "Rebels"
        }
    )
)
```

## エラーの抑制
Office 365 Users コネクタなどで、ユーザープロファイル情報が空の場合などにエラーを抑制して代替値を提供できます:

```javascript
// ユーザー画像が取得できない場合はサンプル画像を表示
IfError(
    Office365Users.UserPhotoV2(cmbUserDirectory.Selected.Mail),
    SampleImage
)
```

または`IsBlankOrError`を使用:

```javascript
If(
    IsBlankOrError(Office365Users.UserPhotoV2(cmbUserDirectory.Selected.Mail)),
    SampleImage
)
```

## 未ハンドルエラーのログ
アプリの継続的な改善とUXの向上のために、未ハンドルのエラーをキャッチして記録することが重要です。App.OnErrorプロパティを使用して:

1. FirstErrorでエラー詳細を取得
2. Notify関数でユーザーに情報を表示  
3. Trace関数でモニターに情報を送信
4. 専用のエラーログリストにパッチ

これらの処理をConcurrent関数内で実行し、必要に応じて個別のエラーハンドリングを適用します。

# まとめ

最も基本的なエラーハンドリングでも、開発者とユーザーの両方に大きな価値をもたらします。エラーを適切に特定、解決し、グレースフルに失敗するようにアプリを構築することは、優れたユーザーエクスペリエンスを提供する上で重要です。

これらのエラーハンドリング手法は、キャンバスアプリの品質と信頼性を向上させる強力なツールとなります。