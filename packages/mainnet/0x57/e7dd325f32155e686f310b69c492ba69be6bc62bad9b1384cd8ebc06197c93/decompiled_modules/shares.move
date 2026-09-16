module 0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares {
    struct SHARES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARES>(arg0, 9, b"SAPPL", b"Sui AAPL Share", b"Sui AAPL economic share position (9 decimals); distinct from the Robinhood ERC-20 stock token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

