module 0xdccd0ac23ec4917243a0864f2c1568a8696b9003199e883ecd6cb15ae85969e7::BIBIKA {
    struct BIBIKA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BIBIKA>, arg1: 0x2::coin::Coin<BIBIKA>) {
        0x2::coin::burn<BIBIKA>(arg0, arg1);
    }

    fun init(arg0: BIBIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBIKA>(arg0, 9, b"BIBIKA", b"BIBIKA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIBIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBIKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIBIKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BIBIKA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

