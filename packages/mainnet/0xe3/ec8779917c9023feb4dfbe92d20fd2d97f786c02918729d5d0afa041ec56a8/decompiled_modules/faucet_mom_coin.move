module 0xe3ec8779917c9023feb4dfbe92d20fd2d97f786c02918729d5d0afa041ec56a8::faucet_mom_coin {
    struct FAUCET_MOM_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_MOM_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_MOM_COIN>>(0x2::coin::mint<FAUCET_MOM_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAUCET_MOM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_MOM_COIN>(arg0, 6, b"MM", b"faucet mom coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_MOM_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_MOM_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

