module 0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin {
    struct ALEXWAKER_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALEXWAKER_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALEXWAKER_FAUCET_COIN>(arg0, 9, b"AWF", b"AlexWaker_FAUCET_COIN", b"alexwaker faucet coin. ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALEXWAKER_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ALEXWAKER_FAUCET_COIN>>(v0);
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<ALEXWAKER_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ALEXWAKER_FAUCET_COIN>>(0x2::coin::mint<ALEXWAKER_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

