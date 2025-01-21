module 0x8b1fd97b2eb75371281a60fef13329fb332988620cec2503a9238f1137e3331::jnp {
    struct JNP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<JNP>(arg0, 7568813949897324348, b"JAPAN Nature Project", b"JNP", b"JAPAN Nature Project", b"https://images.hop.ag/ipfs/QmYweYb4PGN7LDcLjnHbLMaZZBR5ks1cvUKRiVXiT31A4Q", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

