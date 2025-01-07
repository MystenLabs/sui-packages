module 0x45427ab18b9908386e7a7795b7a0aad12c0c5dfc3b919633c23a0b3be106de71::movecat {
    struct MOVECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVECAT>(arg0, 6, b"MOVECAT", b"MOVE CATFISH", x"457665727920636861696e206e656564206361742c206361746669736820666f722066696e616e6369616c2066726565646f6d2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B0_EB_3886_161_A_442_B_A5_DD_8697877_FFE_21_8fd1b00389_69e31f77f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

