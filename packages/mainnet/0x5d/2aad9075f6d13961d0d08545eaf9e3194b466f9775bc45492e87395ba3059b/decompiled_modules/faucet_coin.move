module 0x5d2aad9075f6d13961d0d08545eaf9e3194b466f9775bc45492e87395ba3059b::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 8, b"Helen2022a_faucet", b"Helen2022a_faucet_coin", b"First faucet coin created by Helen2022a", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0);
    }

    public entry fun mint_and_send(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

