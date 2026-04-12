Add-Type -AssemblyName System.Drawing
$dir = Join-Path (Split-Path $PSScriptRoot -Parent) "img"
New-Item -ItemType Directory -Force -Path $dir | Out-Null

function Save-Icon {
  param([int]$Size, [string]$Name)
  $bmp = New-Object System.Drawing.Bitmap $Size, $Size
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.Clear([System.Drawing.Color]::FromArgb(255, 254, 254, 254))
  $m = [int]($Size * 0.15)
  $fill = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 255, 140, 0))
  $g.FillEllipse($fill, $m, $m, $Size - 2 * $m, $Size - 2 * $m)
  $w = [Math]::Max(2, [int]($Size / 48))
  $pen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(255, 178, 34, 34), $w)
  $g.DrawEllipse($pen, $m, $m, $Size - 2 * $m, $Size - 2 * $m)
  $out = Join-Path $dir $Name
  $bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
  $g.Dispose()
  $bmp.Dispose()
  $fill.Dispose()
  $pen.Dispose()
  Write-Host "Wrote $out"
}

Save-Icon 32 "favicon.png"
Save-Icon 120 "icon_120.png"
Save-Icon 180 "icon_180.png"
Save-Icon 192 "icon_192.png"
Save-Icon 512 "icon_512.png"
