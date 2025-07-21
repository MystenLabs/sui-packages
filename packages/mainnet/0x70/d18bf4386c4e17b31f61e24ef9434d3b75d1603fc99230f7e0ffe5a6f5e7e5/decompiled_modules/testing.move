module 0x70d18bf4386c4e17b31f61e24ef9434d3b75d1603fc99230f7e0ffe5a6f5e7e5::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTING>(arg0, 6, b"TESTING", b"testinggg", b"@SuiAIFun @suilaunchcoin @SuiNetwork @SuiFoundation @aixdg_agent @tokeninsight_io $testing + testinggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/testing-7lnhtj.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTING>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

