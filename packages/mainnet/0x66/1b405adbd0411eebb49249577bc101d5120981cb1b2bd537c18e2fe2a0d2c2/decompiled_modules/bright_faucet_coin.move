module 0x661b405adbd0411eebb49249577bc101d5120981cb1b2bd537c18e2fe2a0d2c2::bright_faucet_coin {
    struct BRIGHT_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRIGHT_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BRIGHT_FAUCET_COIN>>(0x2::coin::mint<BRIGHT_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BRIGHT_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIGHT_FAUCET_COIN>(arg0, 6, b"BrightFaucet", b"bright faucet coin", b"faucet_token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRIGHT_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BRIGHT_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

