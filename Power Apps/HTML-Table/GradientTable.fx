With(
    {
        TableBorder: "border: 1px solid #ddd; padding: 8px; text-align: center;",
        HeaderStyle: "border: 1px solid #ddd; padding: 10px; background: linear-gradient(to bottom, #0078D7, #005A9E); color: white; font-weight: bold; border-bottom: 3px solid #004578;",
        IDStyle: "border: 1px solid #ddd; padding: 8px; min-width: 50px; max-width: 70px; text-align: center; font-weight: bold;",
        ProductNameStyle: "border: 1px solid #ddd; padding: 8px; min-width: 180px; max-width: 250px; word-break: break-word;",
        DescriptionStyle: "border: 1px solid #ddd; padding: 8px; min-width: 200px; max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;",
        DateStyle: "border: 1px solid #ddd; padding: 8px; min-width: 100px; max-width: 120px; text-align: center;",
        PriceStyle: "border: 1px solid #ddd; padding: 8px; min-width: 80px; max-width: 100px; text-align: right;",
        CategoryStyle: "border: 1px solid #ddd; padding: 8px; min-width: 130px; max-width: 170px; text-align: left;"
    },
    $"
    <table style='width: 100%; border-collapse: collapse; border: 1px solid #ddd;'>
        <thead>
            <tr>
                <th style='{HeaderStyle}'>No.</th>
                <th style='{HeaderStyle}'>商品名</th>
                <th style='{HeaderStyle}'>説明</th>
                <th style='{HeaderStyle}'>日付</th>
                <th style='{HeaderStyle}'>価格</th>
                <th style='{HeaderStyle}'>カテゴリ</th>
            </tr>
        </thead>
        <tbody>
            {Concat(
                YourCollection, 
                $"
                <tr>
                    <td style='{IDStyle}'>{ID}</td>
                    <td style='{ProductNameStyle}'>
                        <a href='https://example.com/item/{ID}' target='_blank' style='color: #0078D7; text-decoration: none;'> {Column1} </a>
                    </td>
                    <td style='{DescriptionStyle}'>{Column2}</td>
                    <td style='{DateStyle}'>{Column3}</td>
                    <td style='{PriceStyle}'>¥{Column4}</td>
                    <td style='{CategoryStyle}'>{Column5}</td>
                </tr>"
            )}
        </tbody>
    </table>"
)
