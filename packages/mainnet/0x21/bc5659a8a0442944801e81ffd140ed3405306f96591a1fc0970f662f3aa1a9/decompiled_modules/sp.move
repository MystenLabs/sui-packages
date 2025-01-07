module 0x21bc5659a8a0442944801e81ffd140ed3405306f96591a1fc0970f662f3aa1a9::sp {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP>(arg0, 6, b"SP", b"Sui Pill", b"Suipill on Sui / 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FY_Cu_Z_Rt_UUAAZP_1i_095b2d1a82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SP>>(v1);
    }

    // decompiled from Move bytecode v6
}

