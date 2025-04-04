module 0x80dc1ac38e0d2d17f2bde95950564f74b373e0469ae5152e54d5a7094710baf2::qtq_faucet_coin {
    struct QTQ_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun brun(arg0: &mut 0x2::coin::TreasuryCap<QTQ_FAUCET_COIN>, arg1: 0x2::coin::Coin<QTQ_FAUCET_COIN>) {
        0x2::coin::burn<QTQ_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: QTQ_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QTQ_FAUCET_COIN>(arg0, 6, b"QTQ_FAUCET_COIN", b"QTQ_FAUCET_COIN", b"this is a coin for qtq faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QTQ_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<QTQ_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<QTQ_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QTQ_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

