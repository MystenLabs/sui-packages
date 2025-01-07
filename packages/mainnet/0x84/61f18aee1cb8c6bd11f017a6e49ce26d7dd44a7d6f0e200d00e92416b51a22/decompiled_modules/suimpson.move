module 0x8461f18aee1cb8c6bd11f017a6e49ce26d7dd44a7d6f0e200d00e92416b51a22::suimpson {
    struct SUIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPSON>(arg0, 6, b"SUIMPSON", b"Bart Suimpson", b"Own Your Laughter with Bart Suimpson!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suimpson_Move_Logo_0f0a872a0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

