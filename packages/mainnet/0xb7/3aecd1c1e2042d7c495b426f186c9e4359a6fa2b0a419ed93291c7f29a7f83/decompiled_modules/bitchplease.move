module 0xb73aecd1c1e2042d7c495b426f186c9e4359a6fa2b0a419ed93291c7f29a7f83::bitchplease {
    struct BITCHPLEASE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BITCHPLEASE>, arg1: 0x2::coin::Coin<BITCHPLEASE>) {
        0x2::coin::burn<BITCHPLEASE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BITCHPLEASE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BITCHPLEASE>>(0x2::coin::mint<BITCHPLEASE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BITCHPLEASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCHPLEASE>(arg0, 9, b"BITCHPLEASE", b"BITCHPLEASE", b"Testing Testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCHPLEASE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCHPLEASE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

