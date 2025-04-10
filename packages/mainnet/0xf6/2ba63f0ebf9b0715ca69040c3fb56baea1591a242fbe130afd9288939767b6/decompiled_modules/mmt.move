module 0xf62ba63f0ebf9b0715ca69040c3fb56baea1591a242fbe130afd9288939767b6::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MMT>, arg1: 0x2::coin::Coin<MMT>) {
        0x2::coin::burn<MMT>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MMT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MMT>>(0x2::coin::mint<MMT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT>(arg0, 9, b"test MMT", b"MMT", b"Test Mmt token for Mmt Finance protocol.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MMT>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

