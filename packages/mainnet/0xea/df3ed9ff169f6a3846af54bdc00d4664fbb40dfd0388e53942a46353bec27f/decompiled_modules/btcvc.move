module 0xeadf3ed9ff169f6a3846af54bdc00d4664fbb40dfd0388e53942a46353bec27f::btcvc {
    struct BTCVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCVC>(arg0, 8, b"sysBTCvc", b"SY BTCvc", b"SY BTCvc", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCVC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCVC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

