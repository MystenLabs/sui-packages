module 0x35d38bd46fe73e4e21fce981da1991af6e6253e55745192efe550762b7f3070b::carlywei_faucet_coin {
    struct CARLYWEI_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARLYWEI_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARLYWEI_FAUCET_COIN>(arg0, 8, b"CARLYWEI_PUBLIC", b"carlywei Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CARLYWEI_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARLYWEI_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CARLYWEI_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CARLYWEI_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

