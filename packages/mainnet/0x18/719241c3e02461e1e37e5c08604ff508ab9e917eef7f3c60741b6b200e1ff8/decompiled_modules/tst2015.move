module 0x18719241c3e02461e1e37e5c08604ff508ab9e917eef7f3c60741b6b200e1ff8::tst2015 {
    struct TST2015 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST2015, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST2015>(arg0, 9, b"TST2015", b"Test TST2015 DO NOT BUY", b"self-launch snipe test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST2015>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST2015>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

