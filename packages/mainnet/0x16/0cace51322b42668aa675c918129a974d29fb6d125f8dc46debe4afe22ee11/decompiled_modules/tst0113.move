module 0x160cace51322b42668aa675c918129a974d29fb6d125f8dc46debe4afe22ee11::tst0113 {
    struct TST0113 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST0113, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST0113>(arg0, 9, b"TST0113", b"Test TST0113 DO NOT BUY", b"self-launch snipe test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST0113>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST0113>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

