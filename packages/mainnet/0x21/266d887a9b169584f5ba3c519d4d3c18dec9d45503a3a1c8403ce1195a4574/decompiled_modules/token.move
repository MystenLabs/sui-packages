module 0x21266d887a9b169584f5ba3c519d4d3c18dec9d45503a3a1c8403ce1195a4574::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TOKEN>(arg0, 17384673277522822067, b"Token2123", b"Token", b"Tokenss", b"https://images.hop.ag/ipfs/QmV2mH3h9B6nQEGRgyTTUgvkcoYraq6zVJs24n37WYHcrD", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

