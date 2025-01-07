module 0x39aceb039500153a64f21349ed9cdcf0797096f3ed1f376aa233106a0b0a091e::tokenb {
    struct TOKENB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENB>(arg0, 6, b"TOKENB", b"TOKEN B by SuiAI", b"TOKENB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Leonardo_Phoenix_10_A_vibrant_and_festive_background_for_an_ev_3_30f0780b51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

