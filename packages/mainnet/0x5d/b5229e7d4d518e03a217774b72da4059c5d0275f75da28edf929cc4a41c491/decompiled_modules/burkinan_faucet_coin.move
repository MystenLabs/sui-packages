module 0x5db5229e7d4d518e03a217774b72da4059c5d0275f75da28edf929cc4a41c491::burkinan_faucet_coin {
    struct BURKINAN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURKINAN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURKINAN_FAUCET_COIN>(arg0, 8, b"BURKINAN_PUBLIC", b"burkinan Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BURKINAN_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURKINAN_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BURKINAN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BURKINAN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

