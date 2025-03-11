module 0xd51e10cd9e9e8f3d67e05fda2abf41ff7b1a4f63c7044dca5d1c4df537a80bd::qtq_faucet_coin {
    struct QTQ_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<QTQ_FAUCET_COIN>, arg1: 0x2::coin::Coin<QTQ_FAUCET_COIN>) {
        0x2::coin::burn<QTQ_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: QTQ_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QTQ_FAUCET_COIN>(arg0, 6, b"QTQ_Faucet_Coin", b"QTQ_Faucet_Coin", b"this is a coin for qtq_faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QTQ_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<QTQ_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<QTQ_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QTQ_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

