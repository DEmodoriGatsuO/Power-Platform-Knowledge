# PowerAppsTableComponent

## 📌 概要
`PowerAppsTableComponent` は **Power Apps** で利用できる **モダンなテーブルコンポーネント** です。  
HTML の `HtmlViewer` を活用し、**ヘッダー固定** + **可変行のボディ** を Power Apps 内で実現できます。

---

## 📌 特徴
✅ **ヘッダー固定 & ボディ可変**: データ数に応じてスクロール可能  
✅ **Power Apps の `HtmlViewer` を利用**: HTML テーブル形式で表現  
✅ **スタイリッシュなデザイン**: モダンな外観 & ボーダースタイルを調整  
✅ **コードのメンテナンス性向上**: コントロール名をベストプラクティスに統一  
✅ **データソースの柔軟性**: `YourCollection` などの Power Apps のデータと連携  

---

## 📌 コンポーネント構成
| **コントロール名** | **役割** |
|--------------|---------------------------|
| `conTable`   | **全体を囲うメインのコンテナ** |
| `conHeader`  | **ヘッダー部分のコンテナ** |
| `htmHeader`  | **HTML形式のヘッダー（テーブルのタイトル行）** |
| `galBody`    | **データ行を表示するギャラリー** |
| `htmRow`     | **ギャラリー内の各行のHTML行** |

---

## 📌 設定方法
1. **Power Apps 内のキャンバスアプリにコンポーネントを追加**
2. `conTable` を **スクリーン上に配置**
3. `YourCollection` を作成し、 `galBody.Items` に適用  
   ```powerapps
   ClearCollect(
       YourCollection,
       ForAll(
           Sequence(10),
           {
               ID: Value, 
               Column1: "商品" & Value, 
               Column2: "これは説明文" & Value & "です。",
               Column3: Text(Today() - Value, "yyyy/mm/dd"),
               Column4: Text(RandBetween(500, 5000), "#,##0") & "円",
               Column5: "カテゴリ" & Mod(Value, 5)
           }
       )
   )
   ```
4. `htmRow` の `HtmlText` に `YourCollection` の値が反映されているか確認

---

## 📌 カスタマイズ方法
### 1️⃣ **スタイル変更**
`HeaderStyle` などの変数を調整して、ボーダーや背景色を変更可能
```powerapps
HeaderStyle: "border-bottom: 2px solid #E1E5EA; padding: 14px; background: #F5F7F9; color: #222; font-weight: bold; text-align: left;"
```

### 2️⃣ **列幅の調整**
`IDStyle` などの `width` を変更し、カラムの幅を適宜変更可能
```powerapps
IDStyle: "width: 5%; min-width: 50px; text-align: center;"
```

---

## 📌 ライセンス
MIT

---

## 📌 貢献
バグ報告や機能提案は `Issues` にて受け付けています。