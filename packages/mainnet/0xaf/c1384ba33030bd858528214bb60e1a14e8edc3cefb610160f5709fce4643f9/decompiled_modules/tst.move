module 0xafc1384ba33030bd858528214bb60e1a14e8edc3cefb610160f5709fce4643f9::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0903545354045445535408414c4920544553543e68747470733a2f2f63727970746f746f6b656e6d616b65722e636f6d2f746f6b656e2d6173736574732f363766313130366632613536663437382e706e67000064a7b3b6e00d");
        let (v1, v2) = 0x2::coin::create_currency<TST>(arg0, 0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<TST>>(0x2::coin::mint<TST>(&mut v3, 0x2::bcs::peel_u64(&mut v0), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST>>(v2);
    }

    // decompiled from Move bytecode v7
}

