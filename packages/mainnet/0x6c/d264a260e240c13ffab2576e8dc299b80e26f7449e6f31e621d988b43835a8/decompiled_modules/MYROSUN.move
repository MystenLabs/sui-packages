module 0x6cd264a260e240c13ffab2576e8dc299b80e26f7449e6f31e621d988b43835a8::MYROSUN {
    struct MYROSUN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYROSUN>, arg1: 0x2::coin::Coin<MYROSUN>) {
        0x2::coin::burn<MYROSUN>(arg0, arg1);
    }

    fun init(arg0: MYROSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYROSUN>(arg0, 9, b"MYRO", b"MYRO SUN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYROSUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYROSUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYROSUN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYROSUN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

