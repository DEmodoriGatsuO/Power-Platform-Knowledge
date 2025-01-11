With(
    {
        colors: {
            background: "#ffffff",
            backgroundAlt: "#f8f9fa",
            border: "#dee2e6"
        },
        sizes: {
            padding: "12px",
            personWidth: "200px",
            noteWidth: "400px",
            dateWidth: "160px"
        },
        cellBase: "padding: 12px; border: 1px solid #dee2e6;"
    },
    $"<table style='width: 100%; border-collapse: collapse;'>
        <thead>
            <tr>
                <th style='{cellBase} background-color: {colors.backgroundAlt}; font-weight: bold;'>Content</th>
                <th style='{cellBase} background-color: {colors.backgroundAlt}; font-weight: bold; width: {sizes.personWidth};'>Name</th>
                <th style='{cellBase} background-color: {colors.backgroundAlt}; font-weight: bold; min-width: {sizes.noteWidth};'>Note</th>
                <th style='{cellBase} background-color: {colors.backgroundAlt}; font-weight: bold; width: {sizes.dateWidth};'>Date</th>
            </tr>
        </thead>
        <tbody>
            <tr style='background-color: {colors.background};'>
                <td style='{cellBase}'>TaskA</td>
                <td style='{cellBase}'>Suzuki Naoto</td>
                <td style='{cellBase}'>To Do Line1 Line2</td>
                <td style='{cellBase}'>{Today()}</td>
            </tr>
            <tr style='background-color: {colors.backgroundAlt};'>
                <td style='{cellBase}'>TaskA</td>
                <td style='{cellBase}'>Suzuki Naoto</td>
                <td style='{cellBase}'>To Do Line1 Line2</td>
                <td style='{cellBase}'>{Today()}</td>
            </tr>
            <tr style='background-color: {colors.background};'>
                <td style='{cellBase}'>TaskA</td>
                <td style='{cellBase}'>Suzuki Naoto</td>
                <td style='{cellBase}'>To Do Line1 Line2</td>
                <td style='{cellBase}'>{Today()}</td>
            </tr>
        </tbody>
    </table>"
)