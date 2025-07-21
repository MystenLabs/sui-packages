module 0x5636f43e8b5cc3667f840a203176e2e09d45e541d2192d3bfede1c54c93c51ad::suitest {
    struct SUITEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUITEST>(arg0, 6, b"SUITEST", b"SuiTest", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $SUITEST + SuiTest TG: https://t.co/FBT42rI52N WEBSITE: https://t.co/OOBLA8EDuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suitest-7w12n6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITEST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

