module 0x20bf0078ab6cab00add9f9dd4bd3585603bf35e494bf6f81dfda6b2c5ef789a0::spy {
    struct SPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPY>(arg0, 9, b"SPY", b"SPDR S&P 500 ETF", b"ZO Virtual Coin for SPDR S&P 500 ETF Trust", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPY>>(v0);
    }

    // decompiled from Move bytecode v6
}

