module 0xd1ff65c20541ddb1991bbeeb4ce56e95e978b09a2bfdefae6528ab6585a10593::std {
    struct STD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STD>(arg0, 6, b"STD", b"Sis The Dog", b"SIS THE DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s88_M_Qr_Emd_Bga_F_Msk_QW_2j_Kvm1_Spfoe1b_Vy_YM_Kbc1pump_c91c449160.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STD>>(v1);
    }

    // decompiled from Move bytecode v6
}

