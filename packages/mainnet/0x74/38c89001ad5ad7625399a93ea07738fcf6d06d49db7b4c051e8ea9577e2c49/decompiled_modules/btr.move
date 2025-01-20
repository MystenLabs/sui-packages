module 0x7438c89001ad5ad7625399a93ea07738fcf6d06d49db7b4c051e8ea9577e2c49::btr {
    struct BTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BTR>(arg0, 6, b"BTR", b"BTR by SuiAI", b"Btr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_20_12_09_50_A_digital_illustration_of_a_modern_logo_design_for_BTR_The_logo_features_sleek_bold_lettering_in_a_contemporary_sans_serif_font_with_BTR_promin_c34c0aee9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

