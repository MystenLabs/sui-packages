module 0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::winter {
    struct WINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER>(arg0, 9, b"WINTER", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_internal(arg0: &mut 0x2::coin::TreasuryCap<WINTER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WINTER> {
        0x2::coin::mint<WINTER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

