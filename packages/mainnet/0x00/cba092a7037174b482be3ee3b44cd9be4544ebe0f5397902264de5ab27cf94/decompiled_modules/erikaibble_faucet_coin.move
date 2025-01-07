module 0xcba092a7037174b482be3ee3b44cd9be4544ebe0f5397902264de5ab27cf94::erikaibble_faucet_coin {
    struct ERIKAIBBLE_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIKAIBBLE_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIKAIBBLE_FAUCET_COIN>(arg0, 8, b"ERIKAIBBLE_PUBLIC", b"erikaibble Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ERIKAIBBLE_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERIKAIBBLE_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ERIKAIBBLE_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ERIKAIBBLE_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

