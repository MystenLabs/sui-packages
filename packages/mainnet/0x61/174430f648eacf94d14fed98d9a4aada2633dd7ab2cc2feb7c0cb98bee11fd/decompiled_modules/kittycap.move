module 0x61174430f648eacf94d14fed98d9a4aada2633dd7ab2cc2feb7c0cb98bee11fd::kittycap {
    struct KITTYCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTYCAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<KITTYCAP>(arg0, 7583647752735481023, b"Kitty Cap", b"KittyCap", b"Little bit of fluff", b"https://images.hop.ag/ipfs/QmYY4Sev6q49xBfujNBGnjbpjoAnpw3ssg8FAUEQi3wvWf", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

