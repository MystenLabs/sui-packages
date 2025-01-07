module 0xb0b06cc47146f8d4f0db905dc1492354169ae416c78d371e14f0d13c8876836::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://etherscan.io/token/images/centre-usdc_28.png"));
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 8, b"FaucetCoin", b"FaucetCoin", b"faucet coin.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

