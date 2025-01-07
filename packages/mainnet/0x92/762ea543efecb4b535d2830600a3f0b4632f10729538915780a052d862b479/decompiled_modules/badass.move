module 0x92762ea543efecb4b535d2830600a3f0b4632f10729538915780a052d862b479::badass {
    struct BADASS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BADASS>, arg1: 0x2::coin::Coin<BADASS>) {
        0x2::coin::burn<BADASS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BADASS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BADASS>>(0x2::coin::mint<BADASS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BADASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADASS>(arg0, 9, b"Badass", b"BADASS", b"Badass is the swag token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

