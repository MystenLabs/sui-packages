module 0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin {
    struct DCM_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DCM_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DCM_FAUCET_COIN>>(0x2::coin::mint<DCM_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DCM_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCM_FAUCET_COIN>(arg0, 6, b"dcming666Faucet", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCM_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DCM_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

