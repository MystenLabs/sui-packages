module 0x4d90481e82bf3e246043206def0f8fb10b21be63ef7018cd33b9c949d5e1b871::Xemold_faucet_coin {
    struct XEMOLD_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<XEMOLD_FAUCET_COIN>, arg1: 0x2::coin::Coin<XEMOLD_FAUCET_COIN>) {
        0x2::coin::burn<XEMOLD_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: XEMOLD_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XEMOLD_FAUCET_COIN>(arg0, 2, b"Xemold_COIN", b"hhh", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XEMOLD_FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XEMOLD_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XEMOLD_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XEMOLD_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

