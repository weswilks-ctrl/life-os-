Add-Type -AssemblyName System.Drawing

function New-LifeOSIcon($size, $outPath) {
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    $bg = [System.Drawing.ColorTranslator]::FromHtml("#05060a")
    $orange = [System.Drawing.ColorTranslator]::FromHtml("#ff7a1a")

    $g.Clear($bg)

    $scale = $size / 100.0
    $center = 50 * $scale
    $ringR = 34 * $scale
    $strokeW = 4 * $scale
    $dotR = 16 * $scale

    $pen = New-Object System.Drawing.Pen($orange, $strokeW)
    $ringRect = New-Object System.Drawing.RectangleF(($center - $ringR), ($center - $ringR), ($ringR * 2), ($ringR * 2))
    $g.DrawEllipse($pen, $ringRect)

    $brush = New-Object System.Drawing.SolidBrush($orange)
    $dotRect = New-Object System.Drawing.RectangleF(($center - $dotR), ($center - $dotR), ($dotR * 2), ($dotR * 2))
    $g.FillEllipse($brush, $dotRect)

    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)

    $g.Dispose()
    $bmp.Dispose()
    $pen.Dispose()
    $brush.Dispose()
}

New-Item -ItemType Directory -Force -Path "$PSScriptRoot\..\icons" | Out-Null
New-LifeOSIcon -size 192 -outPath "$PSScriptRoot\..\icons\icon-192.png"
New-LifeOSIcon -size 512 -outPath "$PSScriptRoot\..\icons\icon-512.png"
Write-Output "Icons generated."
