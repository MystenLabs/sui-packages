module 0x8c9d51404ca2f5e16e3482c96fcfa647f226a9596264a4ec8250d8de21c0901::htoken {
    struct HTOKEN has drop {
        dummy_field: bool,
    }

    struct LimitConfig has store, key {
        id: 0x2::object::UID,
        owner: address,
        max_sell: u64,
    }

    public fun transfer(arg0: &mut 0x2::coin::Coin<HTOKEN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HTOKEN>>(0x2::coin::split<HTOKEN>(arg0, arg2, arg3), arg1);
    }

    fun assert_sell(arg0: u64, arg1: &LimitConfig) {
        assert!(arg0 <= arg1.max_sell, 100);
    }

    fun init(arg0: HTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTOKEN>(arg0, 9, b"HBAR", b"HBAR Token", b"HBAR Official SUI Community Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = LimitConfig{
            id       : 0x2::object::new(arg1),
            owner    : 0x2::tx_context::sender(arg1),
            max_sell : 1000000000000,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HTOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<LimitConfig>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HTOKEN>(arg0, arg1, arg2, arg3);
    }

    public fun set_max_sell(arg0: &mut LimitConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 101);
        arg0.max_sell = arg1;
    }

    // decompiled from Move bytecode v7
}

