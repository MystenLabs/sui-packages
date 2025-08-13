module 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MMT>(arg0, 9, b"MMT", b"MMT", b"Momentum token", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MMT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMT>>(v2);
    }

    // decompiled from Move bytecode v6
}

