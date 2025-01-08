module 0xd0d95a6d0f01f37b2315b765387727cc91734ca53c9b9f28db1c587b1144b3d9::ravenai {
    struct RAVENAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAVENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RAVENAI>(arg0, 6, b"RAVENAI", b"Raven by SuiAI", b"An AI agent with a mysterious and captivating personality, designed to spark curiosity and engagement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/file_MSG_39bq_Vh8ir_Ytfr9_T_Ly_Ev_6982f316f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAVENAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAVENAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

