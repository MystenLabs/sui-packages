module 0xf2a5fb01f60eb2cf59dfaab992811ad1262d6d36d7181913f0ce08e7573d27a2::flytam_faucet_coin {
    struct FLYTAM_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLYTAM_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLYTAM_FAUCET_COIN>>(0x2::coin::mint<FLYTAM_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FLYTAM_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYTAM_FAUCET_COIN>(arg0, 6, b"FLYTAM_FAUCET_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLYTAM_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FLYTAM_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

