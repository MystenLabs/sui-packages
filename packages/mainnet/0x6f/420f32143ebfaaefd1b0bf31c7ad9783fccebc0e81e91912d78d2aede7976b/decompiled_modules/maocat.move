module 0x6f420f32143ebfaaefd1b0bf31c7ad9783fccebc0e81e91912d78d2aede7976b::maocat {
    struct MAOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAOCAT>(arg0, 6, b"MAOCAT", b"Mao Cat on Sui", b"First Mao Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_29_14dc81c30c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

