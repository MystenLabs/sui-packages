module 0x5b3799a0c2e5dcedf689e86cadaf060703654c3c7211fd6ff948e5518a5f9368::AmuroToruCoin {
    struct AMUROTORUCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AMUROTORUCOIN>, arg1: 0x2::coin::Coin<AMUROTORUCOIN>) {
        0x2::coin::burn<AMUROTORUCOIN>(arg0, arg1);
    }

    fun init(arg0: AMUROTORUCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMUROTORUCOIN>(arg0, 6, b"AMUROTORUCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMUROTORUCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMUROTORUCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AMUROTORUCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AMUROTORUCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

