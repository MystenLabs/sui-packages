module 0x4422e64d25156c0135b2321bfcf2c283b9688ecab55597beee5f8266d3295c8b::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<FROG>(arg0, 810729870209734560, b"HopFrog", b"FROG", b"First Frog on Hop Fun", b"https://images.hop.ag/ipfs/QmSmdDtnR8MgnwnmRJJcqdxiHBXLTPhZBdTFB5ydATCCvW", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

