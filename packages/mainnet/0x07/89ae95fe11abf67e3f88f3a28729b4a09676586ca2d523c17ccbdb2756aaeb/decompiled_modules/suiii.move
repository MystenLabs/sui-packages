module 0x789ae95fe11abf67e3f88f3a28729b4a09676586ca2d523c17ccbdb2756aaeb::suiii {
    struct SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIII>(arg0, 6, b"SUIII", b"Suiii.Ai by SuiAI", b"Predict Better, Play Smarter, Win More. ..Leveraging Ai Agents to enhance predictive accuracy in sports and enhance betting potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Copy_of_0xe3360ed65e5e6c1d584647d02333aead5942357502574654c266d83cf8c455a0towel_TOWEL_200_x_200_px_500_x_500_px_4dcf62b435.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIII>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIII>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

