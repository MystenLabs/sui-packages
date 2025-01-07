module 0x613537fb401af3ee89f102871472722139cd296f3a135ae897bb37fe3198c714::cj_coin {
    struct CJ_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CJ_COIN>, arg1: 0x2::coin::Coin<CJ_COIN>) {
        0x2::coin::burn<CJ_COIN>(arg0, arg1);
    }

    fun init(arg0: CJ_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJ_COIN>(arg0, 6, b"CJ", b"CJ_COIN_FAUCET", b"publish a coin on sui mainnet by cj", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CJ_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CJ_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CJ_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CJ_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

