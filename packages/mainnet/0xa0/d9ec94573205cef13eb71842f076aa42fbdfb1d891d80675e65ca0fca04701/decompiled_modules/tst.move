module 0xa0d9ec94573205cef13eb71842f076aa42fbdfb1d891d80675e65ca0fca04701::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"Total supply token ", b"Just the funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000514074_492785c7d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

