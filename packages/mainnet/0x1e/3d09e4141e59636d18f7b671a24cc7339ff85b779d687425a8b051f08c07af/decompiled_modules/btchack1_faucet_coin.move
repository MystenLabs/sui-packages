module 0x1e3d09e4141e59636d18f7b671a24cc7339ff85b779d687425a8b051f08c07af::btchack1_faucet_coin {
    struct BTCHACK1_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCHACK1_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCHACK1_FAUCET_COIN>(arg0, 9, b"ANLIEN7", b"BTCHACK1_FAUCET_COIN", b"BTCHACK1 FAUCET COIN  ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCHACK1_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BTCHACK1_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BTCHACK1_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BTCHACK1_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

