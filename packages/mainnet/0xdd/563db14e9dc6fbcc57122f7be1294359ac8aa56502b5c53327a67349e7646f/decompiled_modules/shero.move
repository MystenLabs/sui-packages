module 0xdd563db14e9dc6fbcc57122f7be1294359ac8aa56502b5c53327a67349e7646f::shero {
    struct SHERO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHERO>, arg1: 0x2::coin::Coin<SHERO>) {
        0x2::coin::burn<SHERO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHERO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHERO>>(0x2::coin::mint<SHERO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHERO>(arg0, 9, b"Shero", b"SHERO", b"shero the test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHERO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHERO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

