module 0x9f08c77e89af768d7ee5accf8b66b07d606a84b5939e6896a1ae92d519523eac::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX>(arg0, 9, b"SPX", b"SPX6900", b"ZO Virtual Coin for SPX6900", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPX>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPX>>(v0);
    }

    // decompiled from Move bytecode v6
}

