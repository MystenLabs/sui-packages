module 0x81a384b62633d238c95c7d6dc11700c8dadef9e28cd965eabd21e2cd6358b6a::movestudent1coin {
    struct MOVESTUDENT1COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOVESTUDENT1COIN>, arg1: 0x2::coin::Coin<MOVESTUDENT1COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MOVESTUDENT1COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOVESTUDENT1COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOVESTUDENT1COIN>>(0x2::coin::mint<MOVESTUDENT1COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOVESTUDENT1COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVESTUDENT1COIN>(arg0, 9, b"MOVESTUDENT1COIN", b"MOVESTUDENT1", b"build coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVESTUDENT1COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVESTUDENT1COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

