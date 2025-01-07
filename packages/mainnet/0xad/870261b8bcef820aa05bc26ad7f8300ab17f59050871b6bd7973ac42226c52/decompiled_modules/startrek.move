module 0xc48c0e86531d4827dc314262ffc463f44d6aadbea898ccd3669f7d09131b7b28::startrek {
    struct STARTREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARTREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARTREK>(arg0, 9, b"STK", b"Startrek Coin", b"learn to earn", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARTREK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARTREK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

