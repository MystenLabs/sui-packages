module 0x6f02062d1a6a39af31b996975b7681b346483810aab5640ced2d0eec17f8be09::fasda {
    struct FASDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FASDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FASDA>(arg0, 6, b"Fasda", b"dafa", b"asdfasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U2_E_Kd8nzzwb_JP_8_Cq_S_Bgy_Jenn1_Wq_Y5_EX_7d_B_Co_Q9_P_Sf_ZKE_b611efc485.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FASDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FASDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

