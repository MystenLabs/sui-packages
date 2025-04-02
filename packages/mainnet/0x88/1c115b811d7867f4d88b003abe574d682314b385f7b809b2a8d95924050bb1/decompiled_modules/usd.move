module 0x881c115b811d7867f4d88b003abe574d682314b385f7b809b2a8d95924050bb1::usd {
    struct USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD>(arg0, 8, b"USD", b"USD", b"this id a USD", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

