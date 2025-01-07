module 0x4571d0d90c6979aba3f68495bbc2b610ceb2850f0b911d6c512ceb1a0d996bc9::testet {
    struct TESTET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTET, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TESTET>(arg0, 2521246696591873838, b"TESTET", b"TESTET", b"TESTET", b"https://images.hop.ag/ipfs/QmbVNm8iKNs2n19zoks75PqXyQKYQFA1eCQfQ9VPoWcuhc", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

