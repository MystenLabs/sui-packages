module 0x5c096f77a4dbc3be9ec01456d9c9bf5f6e2e374391b05cd26e755223a22aad29::xiaoshenyuan_faucet_coin {
    struct XIAOSHENYUAN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIAOSHENYUAN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIAOSHENYUAN_FAUCET_COIN>(arg0, 8, b"XIAOSHENYUAN_PUBLIC", b"xiaoshenyuan Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<XIAOSHENYUAN_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIAOSHENYUAN_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XIAOSHENYUAN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XIAOSHENYUAN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

