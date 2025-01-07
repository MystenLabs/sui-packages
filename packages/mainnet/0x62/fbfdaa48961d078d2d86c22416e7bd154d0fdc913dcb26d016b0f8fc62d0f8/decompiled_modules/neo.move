module 0x62fbfdaa48961d078d2d86c22416e7bd154d0fdc913dcb26d016b0f8fc62d0f8::neo {
    struct NEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEO>(arg0, 6, b"NEO", b"Neo Whale AI", b"AI-powered memecoin riding the Sui Network wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e52aa2a1_a6f0_494c_8f49_0577e3efc4a1_cf5ce0a350.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

