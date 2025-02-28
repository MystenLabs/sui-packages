module 0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc {
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

    // decompiled from Move bytecode v6
}

