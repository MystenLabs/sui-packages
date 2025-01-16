module 0xe761b92c44e158ea64202eb5c846a4e020dc9ff8d2d1c2fd7224663c61ee66d8::suiza {
    struct SUIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIZA>(arg0, 6, b"SUIZA", b"Suiza by SuiAI", b"SUIZA is an advanced AI agent built to provide real-time data analysis of the $SUI network. It specializes in tracking price, TVL, and ecosystem trends, offering deep insights into $SUIs DeFi protocols. First Citizen of $ATL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suiza_22c9cb6912.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

