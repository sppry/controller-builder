$map=@{
  'White'='solid-white-decorative-trim-shell-for-ps5-controller-diy-replacement-clip-shell-for-ps5-controller-custom-plates-cover-for-ps5-controller-with-accent-rings-gpfm5008'
  'Black'='replacement-decorative-trim-shell-with-accent-rings-compatible-with-ps5-controller-solid-black'
  'New Hope Gray'='extremerate-replacement-decorative-trim-shell-with-accent-rings-compatible-with-ps5-controller-new-hope-gray'
  'Blue'='blue-decorative-trim-shell-for-ps5-controller-soft-touch-diy-replacement-clip-shell-for-ps5-controller-custom-plates-cover-for-ps5-controller-w-accent-rings-gpfp3019'
  'Heaven Blue'='extremerate-replacement-decorative-trim-shell-with-accent-rings-compatible-with-ps5-controller-heaven-blue'
  'Neon Green'='neon-green-decorative-trim-shell-for-ps5-controller-soft-touch-diy-replacement-clip-shell-for-ps5-controller-custom-plates-cover-for-ps5-controller-w-accent-rings-gpfp3024'
  'Green'='green-decorative-trim-shell-for-ps5-controller-soft-touch-diy-replacement-clip-shell-for-ps5-controller-custom-plates-cover-for-ps5-controller-w-accent-rings-gpfp3006'
  'Racing Green'='racing-green-decorative-trim-shell-for-ps5-controller-soft-touch-diy-replacement-clip-shell-for-ps5-controller-custom-plates-cover-for-ps5-controller-with-accent-rings-gpfp3014'
  'Light Cyan'='extremerate-replacement-decorative-trim-shell-with-accent-rings-compatible-with-ps5-controller-light-cyan'
  'Orange'='orange-decorative-trim-shell-for-ps5-controller-soft-touch-diy-replacement-clip-shell-for-ps5-controller-custom-plates-cover-for-ps5-controller-w-accent-rings-gpfp3004'
  'Caution Yellow'='caution-yellow-decorative-trim-shell-for-ps5-controller-soft-touch-diy-replacement-clip-shell-for-ps5-controller-custom-plates-cover-for-ps5-controller-with-accent-rings-gpfp3009'
  'Passion Red'='passion-red-decorative-trim-shell-for-ps5-controller-soft-touch-diy-replacement-clip-shell-for-ps5-controller-custom-plates-cover-for-ps5-controller-with-accent-rings-gpfp3029'
  'Cherry Blossom Pink'='extremerate-replacement-decorative-trim-shell-with-accent-rings-compatible-with-ps5-controller-cherry-blossoms-pink'
  'Purple'='chameleon-purple-blue-decorative-trim-shell-for-ps5-controller-diy-replacement-clip-shell-for-ps5-controller-custom-plates-cover-for-ps5-controller-w-accent-rings-gpfp3001'
  'Light Violet'='extremerate-replacement-decorative-trim-shell-with-accent-rings-compatible-with-ps5-controller-light-violet'
  'Matcha Green'='extremerate-replacement-decorative-trim-shell-with-accent-rings-compatible-with-ps5-controller-matcha-green'
}
$out=@()
foreach($name in $map.Keys){
  $h=$map[$name]
  $u="https://www.extremerate.com/products/$h.js"
  try{
    $p=(Invoke-WebRequest -UseBasicParsing -Uri $u).Content|ConvertFrom-Json
    $img=''
    if($p.images.Count -ge 2){$img=$p.images[1]} elseif($p.images.Count -ge 1){$img=$p.images[0]}
    if($img -and $img.StartsWith('//')){$img='https:'+$img}
    $out+=[pscustomobject]@{name=$name; image=$img; count=$p.images.Count; title=$p.title}
  } catch {
    $out+=[pscustomobject]@{name=$name; image=''; count=0; title='ERR'}
  }
}
$out|Sort-Object name|ConvertTo-Json -Depth 6
