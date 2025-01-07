module 0xed51ec6aee75c0758e9a4eea2e2b4884f7c63c7190cc747e20cd9ff06368670a::baby_faucet_coin {
    struct BABY_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BABY_FAUCET_COIN>, arg1: 0x2::coin::Coin<BABY_FAUCET_COIN>) {
        0x2::coin::burn<BABY_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: BABY_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY_FAUCET_COIN>(arg0, 9, b"BABY", b"BABY_FAUCET_COIN", b"ChainBabyCoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BABY_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABY_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABY_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

