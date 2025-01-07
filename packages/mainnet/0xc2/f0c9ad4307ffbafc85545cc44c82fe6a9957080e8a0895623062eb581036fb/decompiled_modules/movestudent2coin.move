module 0xc2f0c9ad4307ffbafc85545cc44c82fe6a9957080e8a0895623062eb581036fb::movestudent2coin {
    struct MOVESTUDENT2COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOVESTUDENT2COIN>, arg1: 0x2::coin::Coin<MOVESTUDENT2COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MOVESTUDENT2COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOVESTUDENT2COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOVESTUDENT2COIN>>(0x2::coin::mint<MOVESTUDENT2COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOVESTUDENT2COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVESTUDENT2COIN>(arg0, 9, b"MOVESTUDENT2COIN", b"MOVESTUDENT2", b"build coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVESTUDENT2COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVESTUDENT2COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

