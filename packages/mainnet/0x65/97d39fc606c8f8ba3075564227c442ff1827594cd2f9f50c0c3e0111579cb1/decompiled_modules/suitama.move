module 0x6597d39fc606c8f8ba3075564227c442ff1827594cd2f9f50c0c3e0111579cb1::suitama {
    struct SUITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 6, b"SUITAMA", b"SUITAMA MOVEPUMP", x"2453554954414d412c207468652066697273742073757065726865726f206f66207468652053756920436861696e2c2069732066696e616c6c79206865726520746f20626520746865206e65787420626967206d656d6520746f6b656e20696e20746865207370616365210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A56_A077_F_A81_F_4_A31_A8_D6_71_A234_DDD_420_dec21cd9d4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

