module 0xefa5cde339a13fd19d84c90ceddfefe5ac1bbe8c666219391a6986482affa035::orange {
    struct ORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGE>(arg0, 6, b"ORANGE", b"OrangeBot", b"OrangeBot is a powerful SaaS tool designed for managing and automating community engagement for blockchain projects on the Sui network. Our goal is to provide efficient solutions for token management, visibility, and growth through innovative features.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250110_234229_038_8ad692c4bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORANGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

