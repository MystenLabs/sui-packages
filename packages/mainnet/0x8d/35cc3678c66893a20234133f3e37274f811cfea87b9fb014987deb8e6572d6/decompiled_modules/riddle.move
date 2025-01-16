module 0x8d35cc3678c66893a20234133f3e37274f811cfea87b9fb014987deb8e6572d6::riddle {
    struct RIDDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIDDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RIDDLE>(arg0, 6, b"RIDDLE", b"Arkin the Riddle bot by SuiAI", b"First riddle bot in sui that will make you confuse and smart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_16_18_01_20_A_futuristic_and_whimsical_riddle_solving_robot_designed_with_a_sleek_metallic_body_and_glowing_LED_panels_that_display_riddles_The_robot_has_expres_e642f5c882.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIDDLE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIDDLE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

