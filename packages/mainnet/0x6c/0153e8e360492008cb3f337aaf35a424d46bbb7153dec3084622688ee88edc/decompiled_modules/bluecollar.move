module 0x6c0153e8e360492008cb3f337aaf35a424d46bbb7153dec3084622688ee88edc::bluecollar {
    struct BLUECOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECOLLAR>(arg0, 6, b"BLUECOLLAR", b"Just a blue collar guy", x"576520646f6e7420636f6d706c61696e3b207765206a75737420776f726b2e2054686174732077686f207765206172652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P8_Kft_Aa_Dei1xi_Kz_Lr_Pu_PY_Ax_Q_Sw_Fgfw_R6_Dg_B7c_Gw_K_Hv_SV_cc0cb667a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECOLLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECOLLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

