module 0xe3b88e1acb4824cab2b5c2741c93b21d662d87183937e68d033f7e80640c054b::badass {
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
        let (v0, v1) = 0x2::coin::create_currency<BADASS>(arg0, 9, b"badass", b"BADASS", b"badass is the sexy token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

