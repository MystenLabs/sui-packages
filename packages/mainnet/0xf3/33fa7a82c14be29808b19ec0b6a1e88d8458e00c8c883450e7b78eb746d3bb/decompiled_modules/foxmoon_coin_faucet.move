module 0xf333fa7a82c14be29808b19ec0b6a1e88d8458e00c8c883450e7b78eb746d3bb::foxmoon_coin_faucet {
    struct FOXMOON_COIN_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXMOON_COIN_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXMOON_COIN_FAUCET>(arg0, 9, b"FXCF", b"Foxmoon Coin Faucet", b"Foxmoon's first faucet coin.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOXMOON_COIN_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FOXMOON_COIN_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOXMOON_COIN_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FOXMOON_COIN_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

