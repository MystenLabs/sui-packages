module 0xebda4656236c29b3a4472f35ae6a4a27e17b65259611d549b5b260e2f8e5abe2::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTCOIN>(arg0, 9, b"FARTCOIN", b"fartcoin", b"ZO Virtual Coin for fartcoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARTCOIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FARTCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

