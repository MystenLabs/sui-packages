module 0x851ca5db193e8269611a2e7dbdf55b0d1a865ce88afb23e862c252fbf8213996::suimyexamplecoin {
    struct SUIMYEXAMPLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMYEXAMPLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMYEXAMPLECOIN>(arg0, 6, b"MYC", b"My Coin", b"Don't ask why", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMYEXAMPLECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMYEXAMPLECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

