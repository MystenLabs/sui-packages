module 0x88a65ed1d3bf4c0f640f67e3dbbab675acda88814c4f1bfe2dd4e388286f5181::terricwang_faucet_coin {
    struct TERRICWANG_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERRICWANG_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERRICWANG_FAUCET_COIN>(arg0, 8, b"TERRICWANG_PUBLIC", b"terricwang Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TERRICWANG_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERRICWANG_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TERRICWANG_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TERRICWANG_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

