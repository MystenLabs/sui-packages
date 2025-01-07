module 0x3b1fc7ca2dc1860695cecf6c56858fe32d8fb2b3623cbbe840a74bbcc8b1b36::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: 0x2::coin::Coin<FAUCET_COIN>) {
        0x2::coin::burn<FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 2, b"Faucet_coin", b"syc", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

