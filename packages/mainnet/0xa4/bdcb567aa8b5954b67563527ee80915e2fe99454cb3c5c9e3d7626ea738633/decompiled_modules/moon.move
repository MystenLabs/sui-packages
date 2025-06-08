module 0xa4bdcb567aa8b5954b67563527ee80915e2fe99454cb3c5c9e3d7626ea738633::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOON>, arg1: 0x2::coin::Coin<MOON>) {
        0x2::coin::burn<MOON>(arg0, arg1);
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"Moon", b"Moon", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

