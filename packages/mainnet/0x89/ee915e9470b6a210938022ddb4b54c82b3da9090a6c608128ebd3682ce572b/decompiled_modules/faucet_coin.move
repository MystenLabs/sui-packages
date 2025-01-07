module 0x89ee915e9470b6a210938022ddb4b54c82b3da9090a6c608128ebd3682ce572b::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: 0x2::coin::Coin<FAUCET_COIN>) {
        0x2::coin::burn<FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 6, b"lianshus", b"lianshusFaucet", b"lianshus Faucet Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

