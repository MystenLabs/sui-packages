module 0x649a7d4f30ecbd001992ebf809a387b2446c7a75afaa423dfccdf68c2667749c::stussy {
    struct STUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUSSY>(arg0, 6, b"STUSSY", b"STUSSY SUI", b"WELCOME TO AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_02_08_41_12_02457c7a2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUSSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUSSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

