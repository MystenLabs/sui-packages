module 0x38f1945074c2348e88ff05f420cb0cc64e1df7df653b836dc6020972b9b7369c::heart {
    struct HEART has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEART>(arg0, 6, b"HEART", b"Move Pump Love", b"I love Move Pump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/love_f8d41c47e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEART>>(v1);
    }

    // decompiled from Move bytecode v6
}

