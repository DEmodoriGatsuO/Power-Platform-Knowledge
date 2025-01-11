# Power Apps Card Component

シンプルで再利用可能な選択可能なカードコンポーネントです。ダッシュボードやメトリクス表示に適しています。

## 特徴

- クリックで選択/非選択の状態を切り替え可能
- インラインスタイルですべてのスタイリングを管理
- カスタマイズ可能なタイトルと値
- 選択状態を視覚的に表現（背景色、ボーダー、インジケーター）
- Power Appsのコントロールとして実装

## 使用方法

### 1. HTMLテキストコントロールの追加

1. Power Appsキャンバスに新しいHTMLテキストコントロールを追加
2. 下記のプロパティを設定：
   - `HtmlText`: 下記のコードスニペットを設定
   - `OnSelect`: `UpdateContext({locCardProps: !locCardProps})`

### 2. コードの実装

```javascript
With(
    {
        colors: {
            background: "white",
            backgroundSelected: "rgb(249,250,251)",
            borderNormal: "rgb(229,231,235)",
            borderSelected: "rgb(209,213,219)",
            text: "rgb(75,85,99)",
            indicatorSelected: "rgb(59,130,246)",
            indicatorNormal: "rgb(229,231,235)"
        },
        styles: {
            container: "padding:1rem;border-radius:0.5rem;",
            header: "display:flex;align-items:center;justify-content:space-between;margin-bottom:0.5rem;",
            title: "font-size:0.875rem;",
            indicator: "width:0.75rem;height:0.75rem;border-radius:9999px;",
            value: "font-size:1.5rem;font-weight:bold;"
        },
        title: "総ユーザー数",
        value: "24,583",
        isSelected: locCardProps
    },
    $"<div style='{styles.container}border:1px solid {If(isSelected, colors.borderSelected, colors.borderNormal)};background:{If(isSelected, colors.backgroundSelected, colors.background)};'>
        <div style='{styles.header}'>
            <span style='{styles.title}color:{colors.text};'>{title}</span>
            <div style='{styles.indicator}background:{If(isSelected, colors.indicatorSelected, colors.indicatorNormal)};'></div>
        </div>
        <div style='{styles.value}'>{value}</div>
    </div>"
)
```

## カスタマイズ

### カラーパレット

`colors`オブジェクトで以下の色を設定可能：
- `background`: 非選択時の背景色
- `backgroundSelected`: 選択時の背景色
- `borderNormal`: 非選択時のボーダー色
- `borderSelected`: 選択時のボーダー色
- `text`: テキスト色
- `indicatorSelected`: 選択時のインジケーター色
- `indicatorNormal`: 非選択時のインジケーター色

### スタイル

`styles`オブジェクトで以下のスタイルを設定可能：
- `container`: カードのコンテナスタイル
- `header`: ヘッダー部分のスタイル
- `title`: タイトルのスタイル
- `indicator`: インジケーターのスタイル
- `value`: 値のスタイル

## 状態管理

- `locCardProps`: コンテキスト変数として選択状態を管理
- `OnSelect`イベントでトグル処理を実装

## 制限事項

- インラインスタイルのみをサポート
- 外部CSSは使用不可
- アニメーションは未実装

## 今後の拡張案

1. 複数カードの選択状態管理
   - Record型を使用した状態管理の実装
2. クリック時のコールバック関数
   - カスタムアクションの追加
3. アニメーション効果
   - CSSトランジションの実装

## 動作確認済み環境

- Power Apps Version: 2024-01
- ブラウザ: Microsoft Edge, Google Chrome

## サンプル - アクティブ
<!-- 選択状態のカード -->
<div style="padding:1rem;border-radius:0.5rem;border:1px solid rgb(209,213,219);background:rgb(249,250,251);">
    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:0.5rem;">
        <span style="font-size:0.875rem;color:rgb(75,85,99);">総ユーザー数</span>
        <div style="width:0.75rem;height:0.75rem;border-radius:9999px;background:rgb(59,130,246);"></div>
    </div>
    <div style="font-size:1.5rem;font-weight:bold;">24,583</div>
</div>

## サンプル - 非アクティブ
<!-- 非選択状態のカード -->
<div style="padding:1rem;border-radius:0.5rem;border:1px solid rgb(229,231,235);background:white;">
    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:0.5rem;">
        <span style="font-size:0.875rem;color:rgb(75,85,99);">総ユーザー数</span>
        <div style="width:0.75rem;height:0.75rem;border-radius:9999px;background:rgb(229,231,235);"></div>
    </div>
    <div style="font-size:1.5rem;font-weight:bold;">24,583</div>
</div>