module 0x1f4b2e96b269a0d44ef03ac545c2fbc16b2e79ea290ff47d50f1dc2726713da3::ucl_ars_spo1_2026_04_15_draw_no {
    struct UCL_ARS_SPO1_2026_04_15_DRAW_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCL_ARS_SPO1_2026_04_15_DRAW_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCL_ARS_SPO1_2026_04_15_DRAW_NO>(arg0, 0, b"UCL_ARS_SPO1_2026_04_15_DRAW_NO", b"UCL_ARS_SPO1_2026_04_15_DRAW NO", b"UCL_ARS_SPO1_2026_04_15_DRAW NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UCL_ARS_SPO1_2026_04_15_DRAW_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCL_ARS_SPO1_2026_04_15_DRAW_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

