module 0xf06c7175c67a88e1d42c6f3ba24856b20497daad1c161519b4d0e28a27c7c82a::guttail_faucet_coin {
    struct GUTTAIL_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUTTAIL_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUTTAIL_FAUCET_COIN>(arg0, 8, b"GUTTAIL_PUBLIC", b"guttail Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GUTTAIL_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUTTAIL_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUTTAIL_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GUTTAIL_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

