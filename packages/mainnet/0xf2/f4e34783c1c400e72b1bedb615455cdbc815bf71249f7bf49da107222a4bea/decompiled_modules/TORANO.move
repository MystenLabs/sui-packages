module 0xf2f4e34783c1c400e72b1bedb615455cdbc815bf71249f7bf49da107222a4bea::TORANO {
    struct TORANO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TORANO>, arg1: 0x2::coin::Coin<TORANO>) {
        0x2::coin::burn<TORANO>(arg0, arg1);
    }

    fun init(arg0: TORANO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORANO>(arg0, 9, b"MAMA", b"TORANO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TORANO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORANO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TORANO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TORANO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

