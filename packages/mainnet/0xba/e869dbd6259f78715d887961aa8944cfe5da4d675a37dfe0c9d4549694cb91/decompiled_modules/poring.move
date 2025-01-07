module 0xbae869dbd6259f78715d887961aa8944cfe5da4d675a37dfe0c9d4549694cb91::poring {
    struct PORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORING, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PORING>(arg0, 1395842978781568177, b"PORING", b"PORING", b"$PORING - The true meme token on $SUI blockchain with fair distribution on the http://hop.fun platform", b"https://images.hop.ag/ipfs/QmRvP58hy4h4Y2gs4LUAraA5Wffh44Xgix6fEPB1zbwEwe", 0x1::string::utf8(b"https://x.com/PoringSui"), 0x1::string::utf8(b"https://poringsui.fun"), 0x1::string::utf8(b"https://t.me/PoringSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

