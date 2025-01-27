module 0x6a8a3d535948a70a14b9b314cb25b54c251e3f6d4a28a1f2a47a743be4b4310d::forge {
    struct FORGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORGE>(arg0, 6, b"FORGE", b"AGENT FORGE", b"Building AI-powered agents for automation, crypto, content, & beyond. Forge your AI Agents $FORGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AGENTFORGE_c682352afc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

