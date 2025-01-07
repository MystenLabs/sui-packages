module 0x3b2101ff00612b8c6cf151ababb474e21c8462ef36b659cb964bd3564edc8741::dbt {
    struct DBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBT>(arg0, 6, b"DBT", b"DONT BUY TOKEN", b"Dont Buy This Token, this is useless. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_26_11_51_34_A_bold_and_minimalistic_logo_design_for_DONT_BUY_TOKEN_The_design_should_feature_sharp_futuristic_font_styles_with_a_strong_modern_aesthetic_Use_97d265cf6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

