module 0x8d0acb5850b8ec6abe565bc56e042b7e3c7f92e867e4ca753c042f9600642cc7::hbtsui {
    struct HBTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBTSUI>(arg0, 9, b"HBTSUI", b"HeartbeatSui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HBTSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

