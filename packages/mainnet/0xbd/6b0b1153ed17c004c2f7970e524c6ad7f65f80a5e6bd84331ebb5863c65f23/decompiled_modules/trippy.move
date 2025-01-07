module 0xbd6b0b1153ed17c004c2f7970e524c6ad7f65f80a5e6bd84331ebb5863c65f23::trippy {
    struct TRIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIPPY>(arg0, 6, b"TRIPPY", b"TRIPPY SUI", b"WELCOME TO THE TRIP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vb_Eu4_S7bgj56_Kh_Nux2u97r_PL_Cpdd_Hz4_Y3m_CKF_Kw_Sva_AS_2d394943ee.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

