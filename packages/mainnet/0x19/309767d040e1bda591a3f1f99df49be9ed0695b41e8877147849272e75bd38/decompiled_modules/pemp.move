module 0x19309767d040e1bda591a3f1f99df49be9ed0695b41e8877147849272e75bd38::pemp {
    struct PEMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEMP>(arg0, 6, b"PEMP", b"Move Pemp", x"4d6f76652050656d702c206120636f6d6d756e6974792d64726976656e20636f696e206f6e2053554920626c6f636b636861696e2e0a4e4f205554494c4954592c204e4f2042554c4c534849542c204a5553542050555245204d454d452e0a0a41504520796f7572206c69666520736176696e67732c2050454d5020495420555021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MGA_LOGO_2_1_835cde83a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

