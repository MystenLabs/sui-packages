module 0x4f0b6d02a089347f1e04328a8c8ce77fde24382406263d7f31ffbb29bc4c4dda::djendjcn_faucet_coin {
    struct DJENDJCN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DJENDJCN_FAUCET_COIN>, arg1: 0x2::coin::Coin<DJENDJCN_FAUCET_COIN>) {
        0x2::coin::burn<DJENDJCN_FAUCET_COIN>(arg0, arg1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<DJENDJCN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DJENDJCN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DJENDJCN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJENDJCN_FAUCET_COIN>(arg0, 9, b"DJENDJCN_FAUCET_COIN", b"DJENDJCN_FAUCET_COIN", b"my first faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJENDJCN_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DJENDJCN_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

