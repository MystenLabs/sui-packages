module 0x45eff526e95089c6391d9c82278f18cc0d983d348bc68da65a175b1514eb90e2::simbaa {
    struct SIMBAA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIMBAA>, arg1: 0x2::coin::Coin<SIMBAA>) {
        0x2::coin::burn<SIMBAA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIMBAA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SIMBAA>>(0x2::coin::mint<SIMBAA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SIMBAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBAA>(arg0, 9, b"Simbaa", b"SIMBAA", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMBAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBAA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

