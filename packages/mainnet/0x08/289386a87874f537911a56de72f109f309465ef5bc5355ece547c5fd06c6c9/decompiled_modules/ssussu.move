module 0x8289386a87874f537911a56de72f109f309465ef5bc5355ece547c5fd06c6c9::ssussu {
    struct SSUSSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUSSU, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SSUSSU>(arg0, 4647669151021224692, b"$SU$SU", b"SSUSSU", b"SUSUCOIN", b"https://images.hop.ag/ipfs/QmeCyHxvERuD6n5HqS6Gy2JP5KVL5QxLyimrjDVp5RM6LE", 0x1::string::utf8(b"https://x.com/susucoins?s=21"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

