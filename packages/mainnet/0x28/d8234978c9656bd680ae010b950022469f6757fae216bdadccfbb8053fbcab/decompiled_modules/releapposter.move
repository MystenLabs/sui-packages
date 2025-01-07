module 0x28d8234978c9656bd680ae010b950022469f6757fae216bdadccfbb8053fbcab::releapposter {
    struct RELEAPPOSTER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RELEAPPOSTER>, arg1: 0x2::coin::Coin<RELEAPPOSTER>) {
        0x2::coin::burn<RELEAPPOSTER>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RELEAPPOSTER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RELEAPPOSTER>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: RELEAPPOSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RELEAPPOSTER>(arg0, 0, b"releapposter", b"RELEAPPOSTER", b"Releap Profile Token: releapposter", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RELEAPPOSTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RELEAPPOSTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<RELEAPPOSTER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RELEAPPOSTER> {
        0x2::coin::mint<RELEAPPOSTER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

