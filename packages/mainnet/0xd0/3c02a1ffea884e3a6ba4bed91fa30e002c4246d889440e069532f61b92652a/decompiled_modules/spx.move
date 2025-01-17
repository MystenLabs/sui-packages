module 0xd03c02a1ffea884e3a6ba4bed91fa30e002c4246d889440e069532f61b92652a::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPX>(arg0, 6, b"SPX", b"SuiProtocolX by SuiAI", b"A version of the popular coin SPX6900 that is built on sui and is here to flip the sui ecosystem. No socials, Just pure Bullishness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Unknown_866cc60306.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

