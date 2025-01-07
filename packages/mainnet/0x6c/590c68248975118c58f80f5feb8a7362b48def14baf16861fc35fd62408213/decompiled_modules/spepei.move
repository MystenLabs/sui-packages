module 0x6c590c68248975118c58f80f5feb8a7362b48def14baf16861fc35fd62408213::spepei {
    struct SPEPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPEI>(arg0, 6, b"SPEPEI", b"spepei", b"spepei", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPEI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SPEPEI>>(0x2::coin::mint<SPEPEI>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPEI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

