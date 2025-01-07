module 0x19f6915ddd61bfcd522a632b757fbfe02ecbff0fecb29a03e694f22a05fa16::yogoo {
    struct YOGOO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YOGOO>, arg1: 0x2::coin::Coin<YOGOO>) {
        0x2::coin::burn<YOGOO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YOGOO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YOGOO>>(0x2::coin::mint<YOGOO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YOGOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOGOO>(arg0, 9, b"yogoo", b"YOGOO", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOGOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOGOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

