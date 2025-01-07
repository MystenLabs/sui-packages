module 0x4eec6da6bcfd2557c4edcb55dca270fda4f6057134f2f52c626fff1308924e38::i {
    struct I has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<I>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<I>>(0x2::coin::mint<I>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: I, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<I>(arg0, 6, b"I", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<I>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<I>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

