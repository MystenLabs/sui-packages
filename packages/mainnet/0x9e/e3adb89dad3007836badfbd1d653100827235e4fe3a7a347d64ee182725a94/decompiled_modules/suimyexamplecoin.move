module 0x9ee3adb89dad3007836badfbd1d653100827235e4fe3a7a347d64ee182725a94::suimyexamplecoin {
    struct SUIMYEXAMPLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMYEXAMPLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMYEXAMPLECOIN>(arg0, 6, b"MYC", b"My Coin", b"Don't ask why", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMYEXAMPLECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMYEXAMPLECOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

