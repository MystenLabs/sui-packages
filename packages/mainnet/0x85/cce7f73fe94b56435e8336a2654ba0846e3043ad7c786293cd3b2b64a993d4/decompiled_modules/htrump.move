module 0x85cce7f73fe94b56435e8336a2654ba0846e3043ad7c786293cd3b2b64a993d4::htrump {
    struct HTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HTRUMP>(arg0, 14735500404768239970, b"HopTrump", b"HTRUMP", b"HOP TRUMP ($HTRUMP):HTRUMP", b"https://images.hop.ag/ipfs/QmbHk1HtAXJKsmEXw78fBmnvNK3Zugr1gVVKMDVnLtD9Za", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

