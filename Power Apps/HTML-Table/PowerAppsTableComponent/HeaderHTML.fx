With(
    {
        TableBorder: "border-bottom: 1px solid #E1E5EA; padding: 10px; text-align: center;",
        HeaderStyle: "border-bottom: 2px solid #E1E5EA; padding: 14px; background: #F5F7F9; color: #222; font-weight: bold; text-align: left; border-radius: 8px 8px 0 0; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.08);",
        IDStyle: "width: 5%; min-width: 50px; border-bottom: 1px solid #E1E5EA; padding: 10px; text-align: center; border-radius: 4px 0 0 4px;",
        ProductNameStyle: "width: 20%; min-width: 180px; border-bottom: 1px solid #E1E5EA; padding: 10px; word-break: break-word;",
        DescriptionStyle: "width: 25%; min-width: 250px; border-bottom: 1px solid #E1E5EA; padding: 10px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;",
        DateStyle: "width: 15%; min-width: 100px; border-bottom: 1px solid #E1E5EA; padding: 10px; text-align: center;",
        PriceStyle: "width: 10%; min-width: 80px; border-bottom: 1px solid #E1E5EA; padding: 10px; text-align: right;",
        CategoryStyle: "width: 15%; min-width: 130px; border-bottom: 1px solid #E1E5EA; padding: 10px; text-align: left; border-radius: 0 4px 4px 0;"
    },
    $"
    <table style='width: 100%; border-collapse: collapse; border-bottom: 1px solid #E1E5EA;'>
        <thead>
            <tr>
                <th style='{IDStyle}'>No.</th>
                <th style='{ProductNameStyle}'>商品名</th>
                <th style='{DescriptionStyle}'>説明</th>
                <th style='{DateStyle}'>日付</th>
                <th style='{PriceStyle}'>価格</th>
                <th style='{CategoryStyle}'>カテゴリ</th>
            </tr>
        </thead>
    </table>"
)
