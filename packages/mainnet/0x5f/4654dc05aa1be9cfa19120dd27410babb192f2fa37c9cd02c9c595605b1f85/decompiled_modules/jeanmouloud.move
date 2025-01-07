module 0x5f4654dc05aa1be9cfa19120dd27410babb192f2fa37c9cd02c9c595605b1f85::jeanmouloud {
    struct JEANMOULOUD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JEANMOULOUD>, arg1: 0x2::coin::Coin<JEANMOULOUD>) {
        0x2::coin::burn<JEANMOULOUD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JEANMOULOUD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JEANMOULOUD>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: JEANMOULOUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEANMOULOUD>(arg0, 0, b"jeanmouloud", b"JEANMOULOUD", b"Releap Profile Token: jeanmouloud", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEANMOULOUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEANMOULOUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<JEANMOULOUD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JEANMOULOUD> {
        0x2::coin::mint<JEANMOULOUD>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

