# Form コントロール エラーハンドリング

## 目次
1. [送信エラー処理](#1-送信エラー処理)
2. [項目レベル検証パターン](#2-項目レベル検証パターン)
3. [Reset/Cancel](#3-resetcancel)
4. [Form.Valid](#formvalid)
5. [OnSuccess/OnFailure](#onsuccessonfailure)
6. [Card コントロール](#card-コントロール)
   - [エラー表示制御](#1-エラー表示制御)
   - [エラー状態の制御](#2-エラー状態の制御)
7. [エラーハンドリング関数を使用した制御](#エラーハンドリング関数を使用した制御)
8. [App.OnErrorの例](#apponerrorの例)

## 1. 送信エラー処理

### Example: `OnFailure`

```javascript
// Form1のOnFailure
Concurrent(
    // ユーザー通知
    Notify(
        "データの保存に失敗しました。",
        NotificationType.Error,
        3000
    ),
    // エラーログの記録
    Patch(
        'Error Logs',
        Defaults('Error Logs'),
        {
            FormName: "顧客情報フォーム",
            ErrorDateTime: Now(),
            ErrorMessage: Form1.ErrorMessage,
            UserEmail: User().Email
        }
    ),
    // フォームのリセット
    ResetForm(Form1)
);
```

### 👉 ポイント
- [Concurrent 関数](https://learn.microsoft.com/ja-jp/power-platform/power-fx/reference/function-concurrent)を使用して複数の処理を実行

https://learn.microsoft.com/ja-jp/power-platform/power-fx/reference/function-concurrent

## 2. 項目レベル検証パターン

### Example: テキスト入力

```javascript
// テキスト入力のValidation
Switch(
    true,
    IsBlank(TextInput1.Text), "この項目は必須です",
    Len(TextInput1.Text) < 3, "3文字以上入力してください",
    Not(IsMatch(TextInput1.Text, Email)), "有効なメールアドレスを入力してください",
    ""
);
```

### Example: 数値入力の範囲チェック

```javascript
// 数値入力の範囲チェック
Switch(
    true,
    NumberInput1.Value < 0, "0以上の値を入力してください",
    NumberInput1.Value > 100, "100以下の値を入力してください",
    ""
);
```

## 3. Reset/Cancel

### Example: キャンセルボタン

```javascript
// キャンセルボタンの OnSelect
If(
    Form1.Unsaved,
    Concurrent(
        NewForm(Form1),
        Navigate(
            'Home Screen',
            ScreenTransition.None
        ),
        Notify(
            "変更は破棄されました",
            NotificationType.Information
        )
    ),
    Navigate('Home Screen', ScreenTransition.None)
);
```

### 👉 ポイント
- 未保存の変更がある場合は確認
- フォームの状態を完全にリセット

## Form.Valid

### Example: 送信ボタン制御 `DisplayMode`

```javascript
// フォームが有効な場合のみボタンを有効化
If(
    Form1.Valid,
    DisplayMode.Edit,
    DisplayMode.Disabled
)
```

### Example: 状態の通知

```javascript
// エラー通知をユーザーに表示
If(
    !Form1.Valid,
    Notify(
        "入力内容に問題があります。エラー表示を確認してください。",
        NotificationType.Error
    )
)
```

---

## OnSuccess/OnFailure

### Example: OnSuccess

```javascript
// OnSuccess プロパティ
Concurrent(
    Notify(
        "保存が完了しました",
        NotificationType.Success
    ),
    Navigate('一覧画面')
)
```

### Example: OnFailure

```javascript
// OnFailure プロパティ
Concurrent(
    Notify(
        "保存に失敗しました",
        NotificationType.Error
    ),
    Patch(
        'ErrorLogs',
        Defaults('ErrorLogs'),
        {
            Screen: App.ActiveScreen.Name,
            Form: Form1.Name,
            Error: Form1.ErrorMessage,
            User: User().Email,
            DateTime: Now()
        }
    )
)
```

## Card コントロール
### 1. エラー表示制御
#### エラーメッセージの表示

- `Visible`
```javascript
!IsBlankOrError(Form1.Error)
```

- `Text`
```
Form1.Error
```

#### 枠線による具体化
- `BorderColor`
```javascript
If(
    !IsBlankOrError(Form1.Error),
    ColorValue("#FF0000"), // エラー時は赤枠
    ColorValue("#000000")  // 通常時は黒枠
)
```

### 2. エラー状態の制御

#### カード全体の状態制御

```javascript
// エラー時はカードを無効化
If(
    !IsBlankOrError(Form1.Error),
    DisplayMode.Disabled,
    DisplayMode.Edit
)
```

## エラーハンドリング関数を使用した制御

### 1. `IsBlankOrError` による制御

```javascript
// 入力値のブランクとエラーを同時チェック
If(
    IsBlankOrError(TextInput1.Text),
    Notify(
        "入力内容を確認してください",
        NotificationType.Warning
    )
)
```

### 2. `IfError` による制御

```javascript
IfError(
    Patch(
        MainDataSource,
        Defaults(MainDataSource),
        FormData
    ),
    Patch(
        BackupDataSource,
        Defaults(BackupDataSource),
        FormData
    )
)
```

### 3. `IsError` による制御

```javascript
If(
    IsError(
        LookUp(
            DataSource,
            ID = TextInput1.Text
        )
    ),
    Notify(
        "データが見つかりません",
        NotificationType.Error
    )
)
```

## App.OnErrorの例

```javascript
// アプリ全体のエラーハンドリング
App.OnError = With(
    {
        ErrorLog: Concatenate(
            FirstError.Message,
            ", Source: ", FirstError.Source,
            ", Kind: ", Text(FirstError.Kind)
        )
    },
    Concurrent(
        Notify(
            "エラーが発生しました",
            NotificationType.Error
        ),
        Patch(
            'SystemErrorLogs',
            Defaults('SystemErrorLogs'),
            {
                ErrorMessage: ErrorLog,
                Screen: App.ActiveScreen.Name,
                User: User().Email,
                DateTime: Now()
            }
        ),
        Trace(
            "Apps error",
            TraceSeverity.Error,
            ErrorLog
        )
    )
)
```

### Link

- [Validate 関数](https://learn.microsoft.com/ja-jp/power-platform/power-fx/reference/function-validate)