module 0xc8709fd01438ba1a8cd63b20e53ec23d49a883fa6f79eb19247541543492b490::suipig {
    struct SUIPIG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPIG>, arg1: 0x2::coin::Coin<SUIPIG>) {
        0x2::coin::burn<SUIPIG>(arg0, arg1);
    }

    fun init(arg0: SUIPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIG>(arg0, 2, b"SuiPig", b"SuiPig", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPIG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPIG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

