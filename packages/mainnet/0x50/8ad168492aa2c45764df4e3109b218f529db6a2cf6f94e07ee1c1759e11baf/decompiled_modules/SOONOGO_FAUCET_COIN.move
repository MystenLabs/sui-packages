module 0x508ad168492aa2c45764df4e3109b218f529db6a2cf6f94e07ee1c1759e11baf::SOONOGO_FAUCET_COIN {
    struct SOONOGO_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOONOGO_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOONOGO_FAUCET_COIN>(arg0, 8, b"Soonogo faucet", b"Soonogo's faucet coin", b"Soonogo's faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOONOGO_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SOONOGO_FAUCET_COIN>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOONOGO_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SOONOGO_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

