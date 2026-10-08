module 0x3ba3897f2b16dd4eacd44d80aa6353761c27242f13f0cd685ab33a90b480eecd::atk {
    struct ATK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ATK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ATK> {
        0x2::coin::mint<ATK>(arg0, arg1, arg2)
    }

    fun init(arg0: ATK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATK>(arg0, 6, b"ATK", b"Attack deposit coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

