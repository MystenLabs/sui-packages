module 0x5b59b07ea6e8038e4b9f6f280930a39d60790f20b96119153e657e6470a1d189::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOON>, arg1: 0x2::coin::Coin<MOON>) {
        0x2::coin::burn<MOON>(arg0, arg1);
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 2, b"MN", b"Moon", b"my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cetus.zone/coin-metadata/mainnet/icon/3c86d496-1c05-440b-ab0f-fc7642fe9805.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

