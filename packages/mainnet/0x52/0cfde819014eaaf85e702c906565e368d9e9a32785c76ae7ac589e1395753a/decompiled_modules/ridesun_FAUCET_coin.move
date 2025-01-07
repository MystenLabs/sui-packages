module 0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin {
    struct RIDESUN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<RIDESUN_FAUCET_COIN>, arg1: 0x2::coin::Coin<RIDESUN_FAUCET_COIN>) {
        0x2::coin::burn<RIDESUN_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: RIDESUN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIDESUN_FAUCET_COIN>(arg0, 2, b"RIDESUN_FAUCET_COIN", b"RIDESUN", b"ridesun's first faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIDESUN_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RIDESUN_FAUCET_COIN>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIDESUN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RIDESUN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

