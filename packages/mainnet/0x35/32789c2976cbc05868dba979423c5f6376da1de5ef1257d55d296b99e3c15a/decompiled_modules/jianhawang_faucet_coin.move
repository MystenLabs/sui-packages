module 0x3532789c2976cbc05868dba979423c5f6376da1de5ef1257d55d296b99e3c15a::jianhawang_faucet_coin {
    struct JIANHAWANG_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIANHAWANG_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIANHAWANG_FAUCET_COIN>(arg0, 8, b"JIANHAWANG_PUBLIC", b"jianhawang Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JIANHAWANG_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIANHAWANG_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JIANHAWANG_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JIANHAWANG_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

