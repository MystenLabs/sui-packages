module 0x173fd2ea6d0ed6259b2c6c28ec3768bafc5a09a4b7e7f5c0e3fc6865da5dd379::yeet {
    struct YEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEET>(arg0, 6, b"Yeet", b"yeet", b"Yeeeeeeeeet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fr_Vs_ZW_Op_400x400_b07b9d2815.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

