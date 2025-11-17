module 0x8e2fcd2f5f3f15c2bcc114597b5cce9697970d24a397534c0a6fe8bb1ef6a390::alphaswap {
    struct ALPHASWAP has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ALPHASWAP>, arg1: 0x2::coin::Coin<ALPHASWAP>) {
        0x2::coin::burn<ALPHASWAP>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ALPHASWAP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ALPHASWAP>>(0x2::coin::mint<ALPHASWAP>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<ALPHASWAP>) : u64 {
        0x2::coin::total_supply<ALPHASWAP>(arg0)
    }

    fun init(arg0: ALPHASWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHASWAP>(arg0, 6, b"ALPHA", b"AlphaSwap Token", b"Um token para o projeto AlphaSwap na Sui blockchain", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPHASWAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHASWAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

