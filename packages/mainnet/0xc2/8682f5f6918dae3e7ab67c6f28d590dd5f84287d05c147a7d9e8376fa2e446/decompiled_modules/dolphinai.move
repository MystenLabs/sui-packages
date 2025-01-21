module 0xc28682f5f6918dae3e7ab67c6f28d590dd5f84287d05c147a7d9e8376fa2e446::dolphinai {
    struct DOLPHINAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHINAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHINAI>(arg0, 6, b"DOLPHINAI", b"Dolphin Agent AI", b"Dolphin Agent leverages the power of AI with a continuously updated training model and the inherent transparency of blockchain to develop a robust and democratic project framework. By democratizing the AI development process and lowering the barriers to entry found in traditional systems, Dolphin Agent ensures equal access for individuals, businesses, and communities to co-create the future of AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6214_4476a6cdd2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHINAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHINAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

