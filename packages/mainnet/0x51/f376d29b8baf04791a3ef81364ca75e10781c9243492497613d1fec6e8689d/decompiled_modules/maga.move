module 0x51f376d29b8baf04791a3ef81364ca75e10781c9243492497613d1fec6e8689d::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MAGA>(arg0, 9754653112837299359, b"Maga", b"Maga", b"American maga", b"https://images.hop.ag/ipfs/QmcDf2etnRA8n5RL9FqApJHcq8mBkZsVKuYaBz4JzfVVT5", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

