module 0x74e6adcd0c4456938defa2589760c1cbb15b1e617839e20ef5b7386586740f13::suiszn {
    struct SUISZN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISZN>, arg1: 0x2::coin::Coin<SUISZN>) {
        0x2::coin::burn<SUISZN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISZN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISZN>>(0x2::coin::mint<SUISZN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUISZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISZN>(arg0, 9, b"suiszn", b"SUISZN", b"test token ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISZN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISZN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

