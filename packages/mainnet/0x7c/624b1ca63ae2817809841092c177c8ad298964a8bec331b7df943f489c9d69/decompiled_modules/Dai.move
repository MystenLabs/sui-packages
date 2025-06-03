module 0x7c624b1ca63ae2817809841092c177c8ad298964a8bec331b7df943f489c9d69::Dai {
    struct DAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DAI>, arg1: 0x2::coin::Coin<DAI>) {
        0x2::coin::burn<DAI>(arg0, arg1);
    }

    fun init(arg0: DAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAI>(arg0, 9, b"DAI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

