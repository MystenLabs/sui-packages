module 0x3dfdb45c71902eb547bd8a7278f0f4c28c232f9dec52d6952e3a5f1258f11254::shhhh {
    struct SHHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHHHH>(arg0, 6, b"SHHHH", b"SHHHH ON SUI", b"FIRST SHHHH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_22_23_53_03_299f828923.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

