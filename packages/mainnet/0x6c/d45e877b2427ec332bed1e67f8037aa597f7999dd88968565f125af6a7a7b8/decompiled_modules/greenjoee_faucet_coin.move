module 0x6cd45e877b2427ec332bed1e67f8037aa597f7999dd88968565f125af6a7a7b8::greenjoee_faucet_coin {
    struct GREENJOEE_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENJOEE_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENJOEE_FAUCET_COIN>(arg0, 8, b"GREENJOEE_PUBLIC", b"greenjoee Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GREENJOEE_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREENJOEE_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GREENJOEE_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GREENJOEE_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

