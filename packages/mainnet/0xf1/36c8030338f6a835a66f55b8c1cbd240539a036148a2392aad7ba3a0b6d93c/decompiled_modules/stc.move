module 0xf136c8030338f6a835a66f55b8c1cbd240539a036148a2392aad7ba3a0b6d93c::stc {
    struct STC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STC>(arg0, 6, b"STC", b"Sui Test Coin", b"Don't but this test coin, please", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_29_14_56_51_A_minimalist_logo_design_for_a_cryptocurrency_called_Test_Coin_The_logo_features_a_simple_and_modern_circular_coin_design_with_the_word_TEST_bold_f7db7374af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STC>>(v1);
    }

    // decompiled from Move bytecode v6
}

