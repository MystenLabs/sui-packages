module 0x3996a157d50c751d59e05377102f2e8835ac1a2238de410f4ad2c05f7f1ca6e7::faucet {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET>(arg0, 9, b"FAUCET", b"faucetmycoin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

