module 0xbee4985dd5d024b4a5c060413434325e43634e52cd2a9a2ca552a996492ce0fd::nyk_agents {
    struct NYK_AGENTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYK_AGENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NYK_AGENTS>(arg0, 6, 0x1::string::utf8(b"Nyk agents"), 0x1::string::utf8(b"Nyk agents"), 0x1::string::utf8(b"Shipment of AI Agent Infrastructure"), 0x1::string::utf8(b"https://pbs.twimg.com/profile_images/2057159180876992512/68LNjhek_400x400.jpg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYK_AGENTS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NYK_AGENTS>>(0x2::coin_registry::finalize<NYK_AGENTS>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

