module 0xcf8892e660068b746bb7444c799bf4489bbe4ab51fbc1bacb3ba190f3e576d29::agx {
    struct AGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AGX>(arg0, 6, b"AGX", b"Agent x", b"This is the first and best Agent x coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_02_23_19_49_37_A_futuristic_cryptocurrency_coin_named_Agent_X_on_the_Sui_network_The_coin_has_a_sleek_metallic_design_with_a_glowing_neon_blue_X_in_the_center_f903ae4f3f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

