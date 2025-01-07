module 0x7e8741cbf64779d0c83971b756bc153926d89f2882be3b08ec6946f503c4e669::unlizhao_faucet_coin {
    struct UNLIZHAO_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNLIZHAO_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNLIZHAO_FAUCET_COIN>(arg0, 8, b"UNLIZHAO_PUBLIC", b"unlizhao Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<UNLIZHAO_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNLIZHAO_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UNLIZHAO_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<UNLIZHAO_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

