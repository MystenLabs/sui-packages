module 0x27febc71bfbd6ee501d50af009a7d6f1a8326ea533d0713965e8a7aaa413022::cool {
    struct COOL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<COOL>, arg1: 0x2::coin::Coin<COOL>) {
        0x2::coin::burn<COOL>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COOL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COOL>>(0x2::coin::mint<COOL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOL>(arg0, 9, b"cool", b"COOL", b"cool is the token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

