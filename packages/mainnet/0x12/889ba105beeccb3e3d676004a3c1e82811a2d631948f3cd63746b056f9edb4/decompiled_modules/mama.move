module 0x12889ba105beeccb3e3d676004a3c1e82811a2d631948f3cd63746b056f9edb4::mama {
    struct MAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMA>(arg0, 6, b"MAMA", b"Screaming Hyrax", b"MAMA!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7q_B_Ke_PC_5_Sq_ZKDR_Nsb_Nhq_D6_Y6_S8_JW_2_CM_3_Ko_Rv3zt_Dpump_41da6a20c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

