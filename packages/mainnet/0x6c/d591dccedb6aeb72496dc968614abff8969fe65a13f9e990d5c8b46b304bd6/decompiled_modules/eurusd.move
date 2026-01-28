module 0x6cd591dccedb6aeb72496dc968614abff8969fe65a13f9e990d5c8b46b304bd6::eurusd {
    struct EURUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: EURUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EURUSD>(arg0, 9, b"EURUSD", b"EURUSD", b"ZO Virtual Coin for EURUSD (EUR/USD)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EURUSD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EURUSD>>(v0);
    }

    // decompiled from Move bytecode v6
}

