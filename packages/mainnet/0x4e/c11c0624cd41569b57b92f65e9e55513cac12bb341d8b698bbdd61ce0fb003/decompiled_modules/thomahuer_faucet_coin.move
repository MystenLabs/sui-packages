module 0x4ec11c0624cd41569b57b92f65e9e55513cac12bb341d8b698bbdd61ce0fb003::thomahuer_faucet_coin {
    struct THOMAHUER_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOMAHUER_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THOMAHUER_FAUCET_COIN>(arg0, 8, b"THOMAHUER_PUBLIC", b"thomahuer Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<THOMAHUER_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THOMAHUER_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THOMAHUER_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<THOMAHUER_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

