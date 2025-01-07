module 0x882c170a8b0c518d254ba5281b984b54bb7ff35cba021d7b6a7d0362d2bb4e4a::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DINO>(arg0, 14981834870951423877, b"DINO", b"DINO", x"4f6e65206f66207468652066697273742062696767657374206d656d65636f696e73206f6e2053756920f09fa69657524141414141414141414141414141414141414141482120f09fa696", b"https://images.hop.ag/ipfs/QmbGUEdWeJ7cFNoCjA9pHAn8pedbQvbwtkn5QU3ptksX4w", 0x1::string::utf8(b"https://x.com/HopDinoSui"), 0x1::string::utf8(b"https://dinomemecoin.com/"), 0x1::string::utf8(b"https://t.me/HopDinoSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

