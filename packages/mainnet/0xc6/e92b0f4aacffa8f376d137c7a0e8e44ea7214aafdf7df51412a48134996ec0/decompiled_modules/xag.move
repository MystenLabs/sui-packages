module 0xc6e92b0f4aacffa8f376d137c7a0e8e44ea7214aafdf7df51412a48134996ec0::xag {
    struct XAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAG>(arg0, 9, b"XAG", b"XAG", b"ZO Virtual Coin for XAG (Silver)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XAG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XAG>>(v0);
    }

    // decompiled from Move bytecode v6
}

