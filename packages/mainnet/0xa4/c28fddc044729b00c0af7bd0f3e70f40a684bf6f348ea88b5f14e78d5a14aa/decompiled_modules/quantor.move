module 0xa4c28fddc044729b00c0af7bd0f3e70f40a684bf6f348ea88b5f14e78d5a14aa::quantor {
    struct QUANTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<QUANTOR>(arg0, 6, b"QUANTOR", b"QuantorAI by SuiAI", b"Quantor is a revolutionary AI platform that turns your dreams into websites in seconds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Adobe_Stock_355152341_machine_learning_scaled_e1679479470340_8b87372ea7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QUANTOR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTOR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

