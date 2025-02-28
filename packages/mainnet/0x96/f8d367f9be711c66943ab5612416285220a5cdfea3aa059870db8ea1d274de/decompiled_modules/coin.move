module 0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 6, b"WUSDC", b"Wrapped USD Coin", b"Wrapped version of USDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun unwrap(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: &mut 0x2::coin::TreasuryCap<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>, arg2: 0x2::coin::Coin<COIN>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC> {
        0x2::coin::burn<COIN>(arg0, arg2);
        0x2::coin::mint<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(arg1, 0x2::coin::value<COIN>(&arg2), arg3)
    }

    public fun wrap(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: 0x2::coin::Coin<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COIN> {
        0x2::coin::destroy_zero<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(arg1);
        0x2::coin::mint<COIN>(arg0, 0x2::coin::value<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

