module 0x1daa5890d5075dcc3564533875bc83f9c3d30e3675dd20fadda67751de79568::skippy {
    struct SKIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIPPY>(arg0, 6, b"SKIPPY", b"SKIPPY AI", b" Passionate creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SKIPPY_315af5f29c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

