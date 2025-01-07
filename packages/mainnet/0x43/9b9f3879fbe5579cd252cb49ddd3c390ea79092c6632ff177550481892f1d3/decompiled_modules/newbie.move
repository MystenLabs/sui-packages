module 0x439b9f3879fbe5579cd252cb49ddd3c390ea79092c6632ff177550481892f1d3::newbie {
    struct NEWBIE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEWBIE>, arg1: 0x2::coin::Coin<NEWBIE>) {
        0x2::coin::burn<NEWBIE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEWBIE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEWBIE>>(0x2::coin::mint<NEWBIE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NEWBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWBIE>(arg0, 9, b"newbie", b"NEWBIE", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWBIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWBIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

