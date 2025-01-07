module 0xc82e8f7a20c5b46e54cd3d051ca5c4313c04e4431f42e676397e6e461fa0d602::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 6, b"FauC", b"Faucet Coin", b"Get some free coins!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

