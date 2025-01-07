module 0xaa5a02b5d6d8f52210e478e4fa5a0b344eb78fa19406427512e99907ca6cb12a::eai {
    struct EAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EAI>(arg0, 6, b"EAI", b"Eliza Ai Agents", b"Eliza is a powerful multi-agent simulation framework designed to create, deploy, and manage autonomous AI agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5866_3d0c00caab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

