module 0x74c0eaa134e6c1985dbc6fd47fe90ad09981add516217caba8221e9dd9c4b9c8::evanweb3 {
    struct EVANWEB3 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EVANWEB3>, arg1: 0x2::coin::Coin<EVANWEB3>) {
        0x2::coin::burn<EVANWEB3>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EVANWEB3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EVANWEB3>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: EVANWEB3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVANWEB3>(arg0, 0, b"evanweb3", b"EVANWEB3", b"Releap Profile Token: evanweb3", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVANWEB3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVANWEB3>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<EVANWEB3>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<EVANWEB3> {
        0x2::coin::mint<EVANWEB3>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

