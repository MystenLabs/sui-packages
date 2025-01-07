module 0x55588f8d4093990f2f848ae4e42e375a7af233cdd414e2a24a6c25350c9ae7a::nyl_faucet_coin {
    struct NYL_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NYL_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NYL_FAUCET_COIN>>(0x2::coin::mint<NYL_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NYL_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYL_FAUCET_COIN>(arg0, 9, b"NYL_FAUCET", b"NYL_FAUCET", b"my faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYL_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<NYL_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

