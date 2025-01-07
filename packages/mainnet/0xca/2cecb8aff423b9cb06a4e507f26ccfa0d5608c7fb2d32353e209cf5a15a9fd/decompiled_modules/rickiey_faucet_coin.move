module 0xca2cecb8aff423b9cb06a4e507f26ccfa0d5608c7fb2d32353e209cf5a15a9fd::rickiey_faucet_coin {
    struct RICKIEY_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKIEY_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKIEY_FAUCET_COIN>(arg0, 8, b"RICKIEY_PUBLIC", b"rickiey Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RICKIEY_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICKIEY_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RICKIEY_FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RICKIEY_FAUCET_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

