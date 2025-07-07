module 0x53646c3b8759b5e0d050bcf23eedb778cea5dc51c49c21618f0b5f2574a960f7::lucy_coin {
    struct LUCY_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUCY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUCY_COIN>>(0x2::coin::mint<LUCY_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LUCY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCY_COIN>(arg0, 6, b"LUCY_COIN", b"LUCY", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

