module 0x7118cd264d804b0fef1aa7de5da76b8394db74eb9db239a2c6ddbbeb25885373::suiwalletbot {
    struct SUIWALLETBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWALLETBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWALLETBOT>(arg0, 6, b"SuiWalletBot", b"Sui Wallet Bot", x"4f6666696369616c205375692057616c6c657420426f74206f6e2054656c656772616d200a0a68747470733a2f2f742e6d652f53756957616c6c6574426f745f626f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_26_21_58_49_A_stylized_blue_rock_symbol_shaped_like_a_water_droplet_designed_as_a_logo_The_rock_has_a_smooth_minimalist_look_with_flat_edges_and_a_clean_modern_56742c4f84.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWALLETBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWALLETBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

