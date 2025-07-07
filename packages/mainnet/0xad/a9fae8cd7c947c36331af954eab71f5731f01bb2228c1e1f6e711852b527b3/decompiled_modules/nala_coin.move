module 0xada9fae8cd7c947c36331af954eab71f5731f01bb2228c1e1f6e711852b527b3::nala_coin {
    struct NALA_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NALA_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NALA_COIN>>(0x2::coin::mint<NALA_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NALA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALA_COIN>(arg0, 6, b"NALA_COIN", b"NALA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NALA_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALA_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

