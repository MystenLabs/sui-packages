module 0x5d6ea8c40947b51b72762be9a94b0a2265d9508e8ec1ecc199251d295d956689::babydoge {
    struct BABYDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BABYDOGE>, arg1: 0x2::coin::Coin<BABYDOGE>) {
        0x2::coin::burn<BABYDOGE>(arg0, arg1);
    }

    fun init(arg0: BABYDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDOGE>(arg0, 2, b"BabyDoge", b"BabyDoge", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABYDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

