module 0xd028f4b63810817b7bdc11acd7f90316eba4771b9f71c64ba3bfc6533107ea7e::booshi {
    struct BOOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOSHI>(arg0, 6, b"BOOSHI", b"Booshi On Sui", b"First Booshi On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_13_b5f5e9db13.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

