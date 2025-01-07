module 0x83bb2e4295a37a951c93cdd5e142d86c3415b9d86d1522b8efff8078d14697b3::movecat {
    struct MOVECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVECAT>(arg0, 6, b"MOVECAT", b"MOVE CATFISH", b"Every chain need cat, catfish for financial freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B0_EB_3886_161_A_442_B_A5_DD_8697877_FFE_21_8fd1b00389.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

