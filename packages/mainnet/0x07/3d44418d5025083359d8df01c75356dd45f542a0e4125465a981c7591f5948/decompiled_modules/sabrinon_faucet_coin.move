module 0x73d44418d5025083359d8df01c75356dd45f542a0e4125465a981c7591f5948::sabrinon_faucet_coin {
    struct SABRINON_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SABRINON_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SABRINON_FAUCET_COIN>(arg0, 8, b"SABRINON_PUBLIC", b"sabrinon Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SABRINON_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SABRINON_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SABRINON_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SABRINON_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

