module 0x1a1d1c29e8b6e8e85d80fa85f13f8dcd3fdd54fcb674b39943c4434b5b9313f3::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DINO>(arg0, 5221733959863167757, b"HopDino", b"Dino", x"4f6e65206f66207468652066697273742062696767657374206d656d65636f696e73206f6e2053756920f09fa696575241414141414141414141414141414141414141414821", b"https://images.hop.ag/ipfs/QmbGUEdWeJ7cFNoCjA9pHAn8pedbQvbwtkn5QU3ptksX4w", 0x1::string::utf8(b"https://x.com/HopDinoSui"), 0x1::string::utf8(b"https://dinomemecoin.com"), 0x1::string::utf8(b"https://t.me/HopDinoSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

