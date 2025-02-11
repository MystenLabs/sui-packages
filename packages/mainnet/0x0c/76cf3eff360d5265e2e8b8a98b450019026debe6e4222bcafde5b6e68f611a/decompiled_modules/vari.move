module 0xc76cf3eff360d5265e2e8b8a98b450019026debe6e4222bcafde5b6e68f611a::vari {
    struct VARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VARI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VARI>(arg0, 6, b"VARI", b"VARI by SuiAI", b"VARI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_02_11_15_06_25_A_modern_and_sleek_logo_design_for_the_brand_VARI_The_logo_should_feature_bold_clean_typography_with_a_futuristic_touch_The_text_should_be_in_a_m_5b25761a73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VARI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VARI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

