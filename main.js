document.addEventListener('DOMContentLoaded', () => {
    // パスワード設定（ここは変更可能にしておく）
    const CORRECT_PASSWORD = "エストリアよ永遠に";

    // セクション要素
    const loginSection = document.getElementById('login-section');
    const homeSection = document.getElementById('home-section');
    const categorySection = document.getElementById('category-section');
    const characterSection = document.getElementById('character-section');
    const glossarySection = document.getElementById('glossary-section');
    const videoSection = document.getElementById('video-section');

    // UI要素
    const loginForm = document.getElementById('login-form');
    const passwordInput = document.getElementById('password-input');
    const errorMsg = document.getElementById('error-msg');
    
    // ボタン要素
    const toCategoriesBtn = document.getElementById('to-categories-btn');
    const categoryPrologueBtn = document.getElementById('category-prologue-btn');
    const toCharactersBtn = document.getElementById('to-characters-btn');
    const toGlossaryBtn = document.getElementById('to-glossary-btn');
    const backToHomeBtn = document.getElementById('back-to-home-btn');
    const backToCategoriesBtn = document.getElementById('back-to-categories-btn');
    const backToHomeFromCharBtn = document.getElementById('back-to-home-from-char-btn');
    const backToHomeFromGlosBtn = document.getElementById('back-to-home-from-glos-btn');
    const logoutBtn = document.getElementById('logout-btn');

    // 初期状態チェック：すでにセッションにログイン情報があるか
    if (sessionStorage.getItem('estria_logged_in') === 'true') {
        showSection(homeSection);
    } else {
        showSection(loginSection);
    }

    // ログイン処理
    loginForm.addEventListener('submit', (e) => {
        e.preventDefault(); // フォームのデフォルト送信を防ぐ

        const inputVal = passwordInput.value.trim();

        if (inputVal === CORRECT_PASSWORD) {
            // ログイン成功
            sessionStorage.setItem('estria_logged_in', 'true');
            passwordInput.value = ''; // 入力をクリア
            errorMsg.classList.add('hidden');
            showSection(homeSection);
        } else {
            // パスワードエラー
            errorMsg.classList.remove('hidden');
        }
    });

    // 分類(カテゴリ)選択画面へ
    toCategoriesBtn.addEventListener('click', () => {
        showSection(categorySection);
    });

    // 「序章」カテゴリから動画一覧へ
    categoryPrologueBtn.addEventListener('click', () => {
        showSection(videoSection);
    });

    // 登場人物画面へ
    toCharactersBtn.addEventListener('click', () => {
        showSection(characterSection);
        window.scrollTo(0, 0); // 上までスクロール
    });

    // 固有名詞画面へ
    toGlossaryBtn.addEventListener('click', () => {
        showSection(glossarySection);
        window.scrollTo(0, 0);
    });

    // カテゴリ選択からホームに戻る
    backToHomeBtn.addEventListener('click', () => {
        showSection(homeSection);
    });

    // 登場人物画面からホームに戻る
    backToHomeFromCharBtn.addEventListener('click', () => {
        showSection(homeSection);
    });

    // 固有名詞画面からホームに戻る
    backToHomeFromGlosBtn.addEventListener('click', () => {
        showSection(homeSection);
    });

    // 動画一覧からカテゴリ選択に戻る
    backToCategoriesBtn.addEventListener('click', () => {
        showSection(categorySection);
        stopAllVideos();
    });

    // 退出（ログアウト）ボタン
    logoutBtn.addEventListener('click', () => {
        sessionStorage.removeItem('estria_logged_in');
        showSection(loginSection);
        stopAllVideos();
    });

    // 汎用画面切り替え関数
    function showSection(targetSection) {
        // すべてを非表示
        [loginSection, homeSection, categorySection, characterSection, glossarySection, videoSection].forEach(sec => {
            sec.classList.remove('active');
            setTimeout(() => {
                if(!sec.classList.contains('active')) {
                    sec.style.display = 'none';
                }
            }, 500); // 念のためCSSのtransitionと合わせる
        });

        // 目的のセクションを表示
        targetSection.style.display = 'flex';
        // 少し遅延を入れてopacityトランジションを効かせる
        setTimeout(() => {
            targetSection.classList.add('active');
        }, 10);
    }

    // iframe内の動画を停止させる簡易関数 (srcを再セットすることでリセットする)
    function stopAllVideos() {
        const iframes = document.querySelectorAll('iframe');
        iframes.forEach(iframe => {
            const currentSrc = iframe.src;
            iframe.src = currentSrc;
        });
    }
});
