module 0x8d1561fe989995a69f0e0009be68c65cee806b57a40fdc9316f8ca1091d97a9d::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPFROG>(arg0, 5209881115828204525, b"Hop Frog", b"HOPFROG", b"The central place on the muted gray background is occupied by an unusual light blue frog, as if descended from the pages of an ancient legend. Its large, round eyes are pierced by a golden glow - inside them, an elegant Chinese symbol sparkles, like an imprint of hidden wisdom. On the back of the frog rests a massive shuriken, giving it a warlike appearance, and on its head a small black tuft of hair coquettishly sticks out, adding a hint of mischief. The frog's fingers are folded in a symbolic gesture, like those of characters from the world of Naruto, creating an aura of calm concentration. It seems to be thinking about eternal truths imbued with ancient knowledge, and only the quiet light of the background emphasizes its mysterious strength and calm.", b"https://images.hop.ag/ipfs/QmZKE1HpBuHLzrFSyNpwSyAsBFZCvViMLkrwRTazBtnNyb", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

