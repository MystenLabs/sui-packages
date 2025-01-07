module 0xb07129c3ae8286e21399d85fe6ada35f30ed320113e115b6765f19b3cc31b10b::raynor_faucet_coin {
    struct RAYNOR_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAYNOR_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RAYNOR_FAUCET_COIN>>(0x2::coin::mint<RAYNOR_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RAYNOR_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAYNOR_FAUCET_COIN>(arg0, 6, b"RFC", b"raynor faucet coin", b"faucetcoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAYNOR_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RAYNOR_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

