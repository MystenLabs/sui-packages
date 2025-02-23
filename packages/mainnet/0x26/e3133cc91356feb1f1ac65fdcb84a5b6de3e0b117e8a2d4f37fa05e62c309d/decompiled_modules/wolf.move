module 0x26e3133cc91356feb1f1ac65fdcb84a5b6de3e0b117e8a2d4f37fa05e62c309d::wolf {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 6, b"WOLF", b"WOLFAISUI", b"Welcome to the Suai Wolf Pack!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_1_2025_02_23_16_51_03_97a5f6a0b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

