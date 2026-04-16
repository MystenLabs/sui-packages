module 0xbe255a553a89448cb550666987b37aae7812b1b731931755222f2c98ffaece13::primary {
    struct PRIMARY has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY>, arg1: 0x2::coin::Coin<PRIMARY>) {
        0x2::coin::burn<PRIMARY>(arg0, arg1);
    }

    fun init(arg0: PRIMARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMARY>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PRIMARY>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMARY>>(v1);
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRIMARY> {
        0x2::coin::mint<PRIMARY>(arg0, arg1, arg2)
    }

    public entry fun supply_to(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMARY>>(0x2::coin::mint<PRIMARY>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

