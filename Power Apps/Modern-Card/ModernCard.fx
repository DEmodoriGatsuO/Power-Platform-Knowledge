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
    $"<div style='{styles.container}border:1px solid {If(
        isSelected,
        colors.borderSelected,
        colors.borderNormal
    )};background:{If(
        isSelected,
        colors.backgroundSelected,
        colors.background
    )};'>
        <div style='{styles.header}'>
            <span style='{styles.title}color:{colors.text};'>{title}</span>
            <div style='{styles.indicator}background:{If(
        isSelected,
        colors.indicatorSelected,
        colors.indicatorNormal
    )};'></div>
        </div>
        <div style='{styles.value}'>{value}</div>
    </div>"
)