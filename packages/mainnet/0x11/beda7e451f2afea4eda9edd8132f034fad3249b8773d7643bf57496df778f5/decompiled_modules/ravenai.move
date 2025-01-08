module 0x11beda7e451f2afea4eda9edd8132f034fad3249b8773d7643bf57496df778f5::ravenai {
    struct RAVENAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAVENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RAVENAI>(arg0, 6, b"RAVENAI", b"Raven by SuiAI", b"An AI agent with a mysterious and captivating personality, designed to spark curiosity and engagement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/file_MSG_39bq_Vh8ir_Ytfr9_T_Ly_Ev_dc97d472e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAVENAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAVENAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

