module 0x579f6b60efa69e233e0f6eddd5938a42b511aac3cc74a1ac002f0e2a501ba5c1::oricat {
    struct ORICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORICAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<ORICAT>(arg0, 1450826994404031036, b"ORICAT SUI", b"ORICAT", b"SUI ORICAT is the notorious local drug dealer in Matt Furie Boy's Club universe", b"https://images.hop.ag/ipfs/QmbCCDw72PwSRZWGr5MvjvM9ML26U6f7AgQDZB7C69DVvE", 0x1::string::utf8(b"https://x.com/oricatsui"), 0x1::string::utf8(b"https://www.oricat.lol/"), 0x1::string::utf8(b"https://t.me/oricatportal"), arg1);
    }

    // decompiled from Move bytecode v6
}

