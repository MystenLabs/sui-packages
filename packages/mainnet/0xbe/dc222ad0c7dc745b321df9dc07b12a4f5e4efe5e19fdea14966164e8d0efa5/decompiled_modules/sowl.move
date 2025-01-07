module 0xbedc222ad0c7dc745b321df9dc07b12a4f5e4efe5e19fdea14966164e8d0efa5::sowl {
    struct SOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOWL>(arg0, 6, b"SOWL", b"Sowl on Sui", b"Meet the owl on sui memecoin. aiming for the new season of memecoin will giving you a wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_22_01_59_aba06b4e05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

