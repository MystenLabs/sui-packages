module 0x38974bd3a9dad0e8274024b49642e2f0fa94fc4889219791e3742c8730528fd0::m4sk93_coin {
    struct M4SK93_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<M4SK93_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<M4SK93_COIN>>(0x2::coin::mint<M4SK93_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: M4SK93_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M4SK93_COIN>(arg0, 6, b"MK", b"M4sk93 Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M4SK93_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M4SK93_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

