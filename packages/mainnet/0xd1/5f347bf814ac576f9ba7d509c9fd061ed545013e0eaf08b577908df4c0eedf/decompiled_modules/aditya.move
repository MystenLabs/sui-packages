module 0xd15f347bf814ac576f9ba7d509c9fd061ed545013e0eaf08b577908df4c0eedf::aditya {
    struct ADITYA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ADITYA>, arg1: 0x2::coin::Coin<ADITYA>) {
        0x2::coin::burn<ADITYA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ADITYA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ADITYA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ADITYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADITYA>(arg0, 0, b"aditya", b"ADITYA", b"Releap Profile Token: aditya", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADITYA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADITYA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<ADITYA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ADITYA> {
        0x2::coin::mint<ADITYA>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

