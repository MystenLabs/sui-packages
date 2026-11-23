module 0x970abec4bddf0a703456855db391fc2303a42837408562e70e0b0f85ab8b4e4d::tst0111 {
    struct TST0111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST0111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST0111>(arg0, 9, b"TST0111", b"Test TST0111 DO NOT BUY", b"self-launch snipe test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST0111>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST0111>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

