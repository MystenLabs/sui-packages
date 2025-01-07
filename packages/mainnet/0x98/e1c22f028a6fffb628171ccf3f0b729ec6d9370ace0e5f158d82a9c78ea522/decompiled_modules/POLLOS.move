module 0x98e1c22f028a6fffb628171ccf3f0b729ec6d9370ace0e5f158d82a9c78ea522::POLLOS {
    struct POLLOS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<POLLOS>, arg1: 0x2::coin::Coin<POLLOS>) {
        0x2::coin::burn<POLLOS>(arg0, arg1);
    }

    fun init(arg0: POLLOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLOS>(arg0, 2, b"POLLOS", b"POLLOS", b"100% BURNED LP, Im your RobinHood", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLLOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POLLOS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<POLLOS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

