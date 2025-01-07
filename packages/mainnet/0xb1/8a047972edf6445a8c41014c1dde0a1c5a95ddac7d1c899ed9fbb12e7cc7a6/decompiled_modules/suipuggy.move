module 0xb18a047972edf6445a8c41014c1dde0a1c5a95ddac7d1c899ed9fbb12e7cc7a6::suipuggy {
    struct SUIPUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUGGY>(arg0, 6, b"SuiPuggy", b"PUGGY", b"SuiPuggy: The cutest and most playful token on Sui blockchain! Powered by memes, fueled by fun, and built for the community. Join the Puggy gang and let's make the moon our playground!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_21_15_16_49_A_futuristic_crypto_token_design_featuring_a_playful_pug_as_the_central_icon_The_pug_has_a_metallic_gold_and_silver_sheen_wearing_stylish_futuristic_2cbeab452e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

