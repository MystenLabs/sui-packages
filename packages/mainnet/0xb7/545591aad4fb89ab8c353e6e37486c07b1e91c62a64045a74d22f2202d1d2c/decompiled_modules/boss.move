module 0xb7545591aad4fb89ab8c353e6e37486c07b1e91c62a64045a74d22f2202d1d2c::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOSS>(arg0, 6, b"BOSS", b"BOSS by SuiAI", b"BOSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_02_12_12_26_31_A_modern_and_sleek_cryptocurrency_logo_for_SUAI_token_The_logo_features_a_futuristic_minimalistic_design_with_a_combination_of_blue_and_silver_color_80e3237a8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOSS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

