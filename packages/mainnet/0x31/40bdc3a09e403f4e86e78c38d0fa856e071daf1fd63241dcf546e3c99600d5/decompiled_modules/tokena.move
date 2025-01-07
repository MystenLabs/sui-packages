module 0x3140bdc3a09e403f4e86e78c38d0fa856e071daf1fd63241dcf546e3c99600d5::tokena {
    struct TOKENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENA>(arg0, 6, b"TOKENA", b"TOKEN A by SuiAI", b"TOKENA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/29017bddf8d13e49aa188784ed0f335b_44fee502c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

