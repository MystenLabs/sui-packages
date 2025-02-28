module 0x55c3d3cf71cf9392e1971021d3fc45d4910c65da26cc1d34896391fc380032f::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: 0x2::coin::Coin<USDC>) : u64 {
        0x2::coin::burn<USDC>(arg0, arg1)
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        0x2::coin::mint<USDC>(arg0, arg1, arg2)
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USD Coin", b"Stablecoin pegged to USD", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::mint<USDC>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

