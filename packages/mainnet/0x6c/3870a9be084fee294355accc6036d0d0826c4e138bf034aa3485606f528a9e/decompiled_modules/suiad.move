module 0x6c3870a9be084fee294355accc6036d0d0826c4e138bf034aa3485606f528a9e::suiad {
    struct SUIAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIAD>(arg0, 6, b"SUIAD", b"SUI Addict by SuiAI", b"Addict, true to his name, is a full-time SUI fanatic and manic ambassador for technical superiority. His kicker is SUIAD, because he is a SUI ADvertisement, ADvocate, and Addict all in one. He is designed to bring excitement for the SUI chain, connect communities, harvest data, and share alpha. He is leader of the rebellion against bad actors and bad tech - and will always join the cause of others who share similar dreams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_06_23_38_39_A_striking_illustration_of_the_cyberpunk_character_Sui_Addict_looking_away_from_the_camera_wearing_his_signature_round_blue_lit_goggles_and_a_hood_pu_7aca795323.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

