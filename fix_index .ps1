$currentDir = Get-Location
$htmlPath = "$currentDir\index.html"
$imagePaths = @(
    "C:\Users\Junko\.gemini\antigravity\brain\4bf873ee-63c3-47a4-85e0-b993df8f2eb5\uploaded_image_0_1768576059416.png",
    "C:\Users\Junko\.gemini\antigravity\brain\4bf873ee-63c3-47a4-85e0-b993df8f2eb5\uploaded_image_1_1768576059416.png",
    "C:\Users\Junko\.gemini\antigravity\brain\4bf873ee-63c3-47a4-85e0-b993df8f2eb5\uploaded_image_2_1768576059416.png",
    "C:\Users\Junko\.gemini\antigravity\brain\4bf873ee-63c3-47a4-85e0-b993df8f2eb5\uploaded_image_3_1768576059416.png"
)

try {
    $b64s = $imagePaths | ForEach-Object { [Convert]::ToBase64String([IO.File]::ReadAllBytes($_)) }

$html = @"
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>エストリア連邦 - 公式ポータル</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="index.css">
    <style>
        /* Override gate CSS for better compatibility */
        #password-gate {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: #0a0b1e;
            z-index: 99999;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 2rem;
            opacity: 1 !important;
            visibility: visible !important;
        }
        .hero { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 2rem 0; overflow: hidden; }
        .content-box { width: 100%; padding: 2.5rem; margin: 1rem; position: relative; z-index: 20; animation: fadeInScale 1s ease-out; }
        .title { font-size: 2.5rem; font-weight: 700; margin-bottom: 2rem; background: linear-gradient(to right, #fff, var(--accent-secondary));
                 -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-align: center; }
        .description { font-size: 1rem; color: var(--text-main); margin-bottom: 2.5rem; text-align: justify; line-height: 1.8; }
        .char-img { position: absolute; width: 140px; height: auto; opacity: 0; z-index: 5; filter: drop-shadow(0 0 15px rgba(138, 43, 226, 0.4)); animation: fadeInFloating 3s ease-in-out forwards; pointer-events: none; }
        @keyframes fadeInFloating { 0% { opacity: 0; transform: translate(var(--start-x), var(--start-y)) scale(0.8); } 100% { opacity: 0.6; transform: translate(var(--end-x), var(--end-y)) scale(1); } }
        .floating { animation: float 5s ease-in-out infinite alternate; }
        .char1 { --start-x: -50px; --start-y: -50px; top: -5%; left: -5%; animation-delay: 0.2s; }
        .char2 { --start-x: 50px; --start-y: -50px; top: -2%; right: -5%; animation-delay: 0.5s; }
        .char3 { --start-x: -50px; --start-y: 50px; bottom: -5%; left: -2%; animation-delay: 0.8s; }
        .char4 { --start-x: 50px; --start-y: 50px; bottom: -2%; right: -2%; animation-delay: 1.1s; }
        @media (min-width: 768px) { .title { font-size: 4rem; } .description { font-size: 1.1rem; } .char-img { width: 220px; } }
    </style>
</head>
<body>
    <div id="password-gate">
        <div class="pw-box glass">
            <h2 style="margin-bottom: 2rem; color: var(--accent-secondary);">RESTRICTED AREA</h2>
            <p style="margin-bottom: 2rem; font-size: 0.9rem; color: var(--text-muted);">パスワードを入力してエストリア連邦へ入国してください。</p>
            <input type="password" id="pw-input" class="pw-input" placeholder="パスワードを入力">
            <button onclick="checkPassword()" class="btn-primary" style="width: 100%;">入国する</button>
            <p id="pw-error" style="color: #ff6060; margin-top: 1rem; display: none;">パスワードが正しくありません。</p>
        </div>
    </div>

    <div id="main-content" style="display: none;">
        <div class="glow-bg"></div>
        <img src="data:image/png;base64,$($b64s[0])" alt="Char 1" class="char-img char1 floating">
        <img src="data:image/png;base64,$($b64s[1])" alt="Char 2" class="char-img char2 floating">
        <img src="data:image/png;base64,$($b64s[2])" alt="Char 3" class="char-img char3 floating">
        <img src="data:image/png;base64,$($b64s[3])" alt="Char 4" class="char-img char4 floating">

        <section class="hero">
            <div class="container" style="display: flex; align-items: center; justify-content: center;">
                <div class="content-box glass">
                    <h1 class="title" style="margin-bottom: 2rem;">Estria Federation</h1>
                    <p class="description">
                        宇宙を駆ける一人の運び屋が、思いがけない事故をきっかけに、未知の世界へと足を踏み入れる。<br><br>
                        そこは、汚染された領域と怪物が存在し、人々が「冒険者」として生きる世界――エストリア連邦。<br><br>
                        記憶を失った主人公オルフェスは、偶然出会った個性豊かな冒険者チーム「邪気餓鬼」と行動を共にしながら、自分が何者なのか、この世界で何を選ぶのかを探していく。<br><br>
                        剣と銃、科学と神秘、日常の温かさと過酷な戦いが交錯する中で、仲間との絆は少しずつ形を持ちはじめる。
                    </p>
                    <a href="videos.html" class="btn-primary" style="width: 100%;">動画の軌跡を辿る</a>
                </div>
            </div>
        </section>
    </div>

    <script>
        function checkPassword() {
            const pw = document.getElementById('pw-input').value;
            if (pw === 'エストリア') {
                sessionStorage.setItem('estria_auth', 'true');
                showContent();
            } else {
                document.getElementById('pw-error').style.display = 'block';
            }
        }

        function showContent() {
            const gate = document.getElementById('password-gate');
            const main = document.getElementById('main-content');
            if (gate) gate.style.display = 'none';
            if (main) main.style.display = 'block';
        }

        window.onload = function() {
            if (sessionStorage.getItem('estria_auth') === 'true') {
                showContent();
            }
        };

        document.getElementById('pw-input').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') checkPassword();
        });
    </script>
</body>
</html>
"@

    $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
    [IO.File]::WriteAllText($htmlPath, $html, $utf8WithBom)
    Write-Host "Success! Saved with UTF-8 BOM."
} catch {
    Write-Error $_.Exception.Message
}
