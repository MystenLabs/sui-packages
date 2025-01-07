module 0x6aeea8a177777c804b9344d389182ba14f50d71d68d39d295ac260372465ec84::jnathantay_faucet_coin {
    struct JNATHANTAY_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNATHANTAY_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNATHANTAY_FAUCET_COIN>(arg0, 8, b"JNATHANTAY_PUBLIC", b"jnathantay Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JNATHANTAY_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JNATHANTAY_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JNATHANTAY_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JNATHANTAY_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

