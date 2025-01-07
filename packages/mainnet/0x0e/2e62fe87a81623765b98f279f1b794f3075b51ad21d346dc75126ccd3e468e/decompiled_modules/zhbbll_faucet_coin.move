module 0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin {
    struct ZHBBLL_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZHBBLL_FAUCET_COIN>, arg1: 0x2::coin::Coin<ZHBBLL_FAUCET_COIN>) {
        0x2::coin::burn<ZHBBLL_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: ZHBBLL_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHBBLL_FAUCET_COIN>(arg0, 9, b"ZHBBLL_FAUCET", b"ZHBBLL_FAUCET_COIN", b"ChainBabyCoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHBBLL_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZHBBLL_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZHBBLL_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZHBBLL_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

