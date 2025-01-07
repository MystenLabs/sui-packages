module 0x795e61345204f040469a10369e9cdc13e9005a55398c665278c2ed870d00e4d7::katol {
    struct KATOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<KATOL>(arg0, 16223984157945354403, b"Fury Katol", b"KATOL", b"Hi, I am Mr Katol. Please find me a good home", b"https://images.hop.ag/ipfs/QmVyomWVDkRXWwKN2xoH4iUCLWMb7s1E9KmpqoNThDfYRW", 0x1::string::utf8(b"https://x.com/BigKatol?t=pL1JUdcHAXOh0YnFYIWkBw&s=09"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

