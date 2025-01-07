module 0x9e9edf18d8bd8a6875ce6356fee24ba55d7a6352d8661d553339489135681cd::siuuu {
    struct SIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SIUUU>(arg0, 141004163799396548, b"Siuuu", b"Siuuu ", b"CR7 the GOAT", b"https://images.hop.ag/ipfs/Qmbbu1gDXKEVxTMNCN2zLEUJm2AMetrCjWAX8NQXTXgeue", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

