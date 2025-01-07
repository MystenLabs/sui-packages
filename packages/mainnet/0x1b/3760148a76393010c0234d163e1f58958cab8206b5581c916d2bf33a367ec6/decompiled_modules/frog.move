module 0x1b3760148a76393010c0234d163e1f58958cab8206b5581c916d2bf33a367ec6::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<FROG>(arg0, 1897396603626700532, b"HopFrog", b"FROG", b"live", b"https://images.hop.ag/ipfs/QmUxugtFwfRN2WVLSW9BTrKqM9c6udo7bM7aU81NkhTcUr", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

