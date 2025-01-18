module 0xba1575973a9e4efb40b1c24312849e2db4f289089bab2e261a69667a0a08c952::going_to_moon {
    struct GOING_TO_MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOING_TO_MOON, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GOING_TO_MOON>(arg0, 12561493628854423080, b"TRUMP", b"going to moon^^", b"soon to mooon ^^ contineu #LFG", b"https://images.hop.ag/ipfs/Qme5rAG5brn3srYtQ3ppwzkGih55oDv3c5jjanWgzMdSVJ", 0x1::string::utf8(b"https://x.com/PATELJI11378754"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/CRYPTO_PROVIDER1"), arg1);
    }

    // decompiled from Move bytecode v6
}

