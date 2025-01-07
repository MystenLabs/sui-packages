module 0x97a0ca74fc9e75c9ce94fcdb8aa1ed9e1f6ec81e7ea993ae2b4a96aab7b209ee::shannon2z_faucet_coin {
    struct SHANNON2Z_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHANNON2Z_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHANNON2Z_FAUCET_COIN>(arg0, 8, b"SHANNON2Z_PUBLIC", b"shannon2z Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SHANNON2Z_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHANNON2Z_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHANNON2Z_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHANNON2Z_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

