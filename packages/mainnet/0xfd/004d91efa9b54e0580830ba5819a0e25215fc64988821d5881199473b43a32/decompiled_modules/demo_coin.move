module 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::demo_coin {
    struct DEMO_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMO_COIN>(arg0, 6, b"DEMO", b"Demo Launch Coin", b"Test coin for Sui Market Place launchpad development.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMO_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEMO_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

