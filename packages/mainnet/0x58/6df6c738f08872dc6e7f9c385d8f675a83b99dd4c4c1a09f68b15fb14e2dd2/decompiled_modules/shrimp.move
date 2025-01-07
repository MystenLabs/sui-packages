module 0x586df6c738f08872dc6e7f9c385d8f675a83b99dd4c4c1a09f68b15fb14e2dd2::shrimp {
    struct SHRIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMP>(arg0, 6, b"Shrimp", b"Shrimpy", b"Low in calories and High in protein!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Shrimpy_e34ebc2097.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

