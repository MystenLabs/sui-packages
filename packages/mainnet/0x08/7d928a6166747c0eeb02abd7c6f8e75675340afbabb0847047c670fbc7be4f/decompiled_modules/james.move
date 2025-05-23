module 0x87d928a6166747c0eeb02abd7c6f8e75675340afbabb0847047c670fbc7be4f::james {
    struct JAMES has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JAMES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JAMES>>(0x2::coin::mint<JAMES>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JAMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMES>(arg0, 6, b"JAMES", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAMES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

