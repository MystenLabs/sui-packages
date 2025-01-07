module 0xba5d4f63fb896cb96668ba14849f1ee4a02c9e5666128cccef254a4a40827ada::zimknn_faucet_coin {
    struct ZIMKNN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIMKNN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIMKNN_FAUCET_COIN>(arg0, 8, b"ZIMKNN_PUBLIC", b"zimknn Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZIMKNN_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIMKNN_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZIMKNN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZIMKNN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

