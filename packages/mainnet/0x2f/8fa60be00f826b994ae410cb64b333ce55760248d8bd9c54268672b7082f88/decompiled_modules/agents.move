module 0x2f8fa60be00f826b994ae410cb64b333ce55760248d8bd9c54268672b7082f88::agents {
    struct AGENTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENTS>(arg0, 6, b"AgentS", b"Agent Sonic", b"Agent Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6557_7fc229f7ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

