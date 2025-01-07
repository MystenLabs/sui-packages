module 0xd22e1135ed2ec7280e734b261290ac64567cf1f1a124f98d2c4cdc29cf1a11ce::dcming666_coin {
    struct DCMING666_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DCMING666_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DCMING666_COIN>>(0x2::coin::mint<DCMING666_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DCMING666_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCMING666_COIN>(arg0, 6, b"dcming666", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCMING666_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCMING666_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

