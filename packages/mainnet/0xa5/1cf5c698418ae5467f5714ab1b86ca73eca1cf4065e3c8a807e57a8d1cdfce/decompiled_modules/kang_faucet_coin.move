module 0xa51cf5c698418ae5467f5714ab1b86ca73eca1cf4065e3c8a807e57a8d1cdfce::kang_faucet_coin {
    struct KANG_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<KANG_FAUCET_COIN>, arg1: 0x2::coin::Coin<KANG_FAUCET_COIN>) {
        0x2::coin::burn<KANG_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: KANG_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KANG_FAUCET_COIN>(arg0, 9, b"KANGFAUCET", b"Faucet Coin", b"It's the faucet coin.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KANG_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<KANG_FAUCET_COIN>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KANG_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KANG_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

