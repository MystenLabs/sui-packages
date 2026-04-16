module 0x1f4b2e96b269a0d44ef03ac545c2fbc16b2e79ea290ff47d50f1dc2726713da3::ucl_ars_spo1_2026_04_15_draw_yes {
    struct UCL_ARS_SPO1_2026_04_15_DRAW_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCL_ARS_SPO1_2026_04_15_DRAW_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCL_ARS_SPO1_2026_04_15_DRAW_YES>(arg0, 0, b"UCL_ARS_SPO1_2026_04_15_DRAW_YES", b"UCL_ARS_SPO1_2026_04_15_DRAW YES", b"UCL_ARS_SPO1_2026_04_15_DRAW YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UCL_ARS_SPO1_2026_04_15_DRAW_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCL_ARS_SPO1_2026_04_15_DRAW_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

