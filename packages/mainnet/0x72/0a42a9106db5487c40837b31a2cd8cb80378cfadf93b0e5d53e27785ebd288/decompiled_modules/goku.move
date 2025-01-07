module 0x720a42a9106db5487c40837b31a2cd8cb80378cfadf93b0e5d53e27785ebd288::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<GOKU>(arg0, 6519772689552764102, b"Goku MEME SUI", b"GOKU", b"#1 meme on SUI Network.", b"https://images.hop.ag/ipfs/QmQnWduoSCLa5a93HhXinhweXi7pDbn3dKSx1P3AZpXzkG", 0x1::string::utf8(b"https://x.com/GokuMemeSUI"), 0x1::string::utf8(b"https://goku.meme/"), 0x1::string::utf8(b"https://t.me/GokuOnSUI"), arg1);
    }

    // decompiled from Move bytecode v6
}

