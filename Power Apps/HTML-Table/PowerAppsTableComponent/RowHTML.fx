With(
    {
        IDStyle: "width: 5%; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; padding: 8px; text-align: center;",
        ProductNameStyle: "width: 20%; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; padding: 8px; word-break: break-word;",
        DescriptionStyle: "width: 25%; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; padding: 8px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;",
        DateStyle: "width: 15%; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; padding: 8px; text-align: center;",
        PriceStyle: "width: 10%; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; padding: 8px; text-align: right;",
        CategoryStyle: "width: 15%; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; padding: 8px; text-align: left;"
    },
    $"
    <table style='width: 100%; border-collapse: collapse; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;'>
        <tbody>
            <tr>
                <td style='{IDStyle}'>{ThisItem.ID}</td>
                <td style='{ProductNameStyle}'>
                    <a href='https://example.com/item/{ThisItem.ID}' target='_blank' style='color: #0078D7; text-decoration: none;'> {ThisItem.Column1} </a>
                </td>
                <td style='{DescriptionStyle}'>{ThisItem.Column2}</td>
                <td style='{DateStyle}'>{ThisItem.Column3}</td>
                <td style='{PriceStyle}'>¥{ThisItem.Column4}</td>
                <td style='{CategoryStyle}'>{ThisItem.Column5}</td>
            </tr>
        </tbody>
    </table>"
)
