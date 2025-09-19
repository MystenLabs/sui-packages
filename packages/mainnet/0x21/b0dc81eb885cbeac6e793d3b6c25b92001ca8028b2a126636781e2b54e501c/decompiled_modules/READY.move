module 0x21b0dc81eb885cbeac6e793d3b6c25b92001ca8028b2a126636781e2b54e501c::READY {
    struct READY has drop {
        dummy_field: bool,
    }

    fun init(arg0: READY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<READY>(arg0, 9, b"ready", b"READY", b"readey", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<READY>>(0x2::coin::mint<READY>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<READY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<READY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

