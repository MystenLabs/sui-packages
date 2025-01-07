module 0x407268f7fca8aba320e07cd0b8482f969a233eded49fe4788d929cb5c3a76761::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<FROG>(arg0, 15359003206483264999, b"Hop Frog", b"Frog", b"Hop Frog knows that true power comes not from external validation, but from within.", b"https://images.hop.ag/ipfs/QmW91UZV7CH6QebunZdLwi7NtQZfXT99rfsc56uiRkHuZp", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

