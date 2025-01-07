module 0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin {
    struct TUTUSTACK_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TUTUSTACK_FAUCET_COIN>, arg1: 0x2::coin::Coin<TUTUSTACK_FAUCET_COIN>) {
        0x2::coin::burn<TUTUSTACK_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: TUTUSTACK_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUTUSTACK_FAUCET_COIN>(arg0, 2, b"TUTUSTACK_FAUCET_COIN", b"TUTUSTACK_FAUCET_COIN", b"tutustack's first faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUTUSTACK_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TUTUSTACK_FAUCET_COIN>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TUTUSTACK_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TUTUSTACK_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

