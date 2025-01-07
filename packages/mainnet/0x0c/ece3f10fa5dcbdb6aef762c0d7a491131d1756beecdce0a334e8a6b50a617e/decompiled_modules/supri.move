module 0xcece3f10fa5dcbdb6aef762c0d7a491131d1756beecdce0a334e8a6b50a617e::supri {
    struct SUPRI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPRI>, arg1: 0x2::coin::Coin<SUPRI>) {
        0x2::coin::burn<SUPRI>(arg0, arg1);
    }

    fun init(arg0: SUPRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPRI>(arg0, 9, b"li.fi", b"li.fi", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPRI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPRI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUPRI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUPRI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

