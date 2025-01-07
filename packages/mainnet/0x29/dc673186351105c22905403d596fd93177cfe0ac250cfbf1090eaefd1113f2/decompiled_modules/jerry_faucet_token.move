module 0x29dc673186351105c22905403d596fd93177cfe0ac250cfbf1090eaefd1113f2::jerry_faucet_token {
    struct JERRY_FAUCET_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JERRY_FAUCET_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JERRY_FAUCET_TOKEN>>(0x2::coin::mint<JERRY_FAUCET_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JERRY_FAUCET_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERRY_FAUCET_TOKEN>(arg0, 6, b"JERT", b"JerryWuFaucet", b"custom token faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JERRY_FAUCET_TOKEN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JERRY_FAUCET_TOKEN>>(v0);
    }

    // decompiled from Move bytecode v6
}

