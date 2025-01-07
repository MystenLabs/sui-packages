module 0x574f142882b3c10e10acb05b214b13f9fa4b990a6b987f74cbe4a96e1cdf57f2::kitkat {
    struct KITKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITKAT>(arg0, 6, b"KITKAT", b"Mira's Dog", b"Straight magic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X5_D_Wa_Ekz_MXCS_7e_A_Si_WV_9orr_T_Hydv_Tps8i_W7f_Fq7_Rte_W8_d208e2ce24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

