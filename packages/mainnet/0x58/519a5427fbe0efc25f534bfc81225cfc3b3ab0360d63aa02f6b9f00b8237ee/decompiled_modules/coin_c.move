module 0x58519a5427fbe0efc25f534bfc81225cfc3b3ab0360d63aa02f6b9f00b8237ee::coin_c {
    struct COIN_C has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_C>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN_C>>(0x2::coin::mint<COIN_C>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COIN_C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_C>(arg0, 6, b"COINC", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_C>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_C>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

