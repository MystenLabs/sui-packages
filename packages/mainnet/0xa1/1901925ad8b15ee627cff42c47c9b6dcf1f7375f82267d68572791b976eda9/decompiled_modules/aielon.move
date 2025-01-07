module 0xa11901925ad8b15ee627cff42c47c9b6dcf1f7375f82267d68572791b976eda9::aielon {
    struct AIELON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIELON>, arg1: 0x2::coin::Coin<AIELON>) {
        0x2::coin::burn<AIELON>(arg0, arg1);
    }

    fun init(arg0: AIELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIELON>(arg0, 2, b"AIELON", b"ELON", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIELON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIELON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

