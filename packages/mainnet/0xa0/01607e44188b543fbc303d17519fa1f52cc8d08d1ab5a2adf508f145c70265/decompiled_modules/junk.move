module 0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk {
    struct JUNK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUNK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JUNK> {
        0x2::coin::mint<JUNK>(arg0, arg1, arg2)
    }

    fun init(arg0: JUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNK>(arg0, 6, b"JUNK", b"Junk", b"rescue ops", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

