module 0xe60509f9449a617699d1016a6700367fce6f1166e356ce554a97e42673720f2d::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"SUIT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

