module 0x1b098b350ade0f4cecfa410953d18fe6c35e1e2fb1c6f4de176e5dffe7a96de5::tora {
    struct TORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORA>(arg0, 6, b"TORA", b"TOAD ORACLE", b"The wise toad of the crypto pond, hopping through the blockchain to bring you the secrets of the universe! With TORA, every leap is a prophecy, and every transaction is sprinkled with magic. Trust the Toad; it knows the way! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_12_00_30_17_A_cartoon_frog_with_a_more_serious_expression_standing_upright_and_wearing_a_wizard_cap_The_frog_has_a_stern_look_large_eyes_with_a_focused_gaze_a_63b79e6506.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

