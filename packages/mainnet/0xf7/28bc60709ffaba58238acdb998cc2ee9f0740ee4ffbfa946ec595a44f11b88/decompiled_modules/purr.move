module 0xf728bc60709ffaba58238acdb998cc2ee9f0740ee4ffbfa946ec595a44f11b88::purr {
    struct PURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURR, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PURR>(arg0, 18068993058677934930, b"PurrCat", b"PURR", b"Sui Purr Cat. The cat Purrs", b"https://images.hop.ag/ipfs/QmRkPH3nxFN97YLKeqJ7nH2ZZwLGZKNsdRP6a1sfSKU3pC", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

