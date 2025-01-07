module 0xfc76ca14cf9a3e6aa547797c1862dc246fe5f834a249fe8a831562a3ce74d095::ailofi {
    struct AILOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AILOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AILOFI>(arg0, 6, b"AILOFI", b"0xLofi Agent Lofi by SuiAI", x"30784c4f464920697320616e2041492d64726976656e2c204c6f66692d696e737069726564206167656e74206f6e2074686520537569206e6574776f726b2e2041667465722063656e7475726965732066726f7a656e20696e207468652048696d616c617961732c206865e2809973206e6f77206177616b6520616e6420726561647920746f20736861706520612062726967687465722c206d6f72652063726561746976652066757475726520776974682068697320636f696e2c202441494c4f46492e20f09fa78a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_07_22_26_54_A_modern_minimalist_AI_generated_rendition_of_a_cartoon_yeti_with_blue_and_white_fur_large_expressive_eyes_and_a_slightly_humorous_facial_expressio_fba8a21073.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AILOFI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AILOFI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

