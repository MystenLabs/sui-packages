module 0xb13cb0d65d3aa96b43dd0768fe8d49fec8eedb0ad2cb3c1bcdaa3f6b8cd620d0::lu_coin {
    struct LU_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LU_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LU_COIN>>(0x2::coin::mint<LU_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LU_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LU_COIN>(arg0, 8, b"LU", b"Lu", b"my coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LU_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LU_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

