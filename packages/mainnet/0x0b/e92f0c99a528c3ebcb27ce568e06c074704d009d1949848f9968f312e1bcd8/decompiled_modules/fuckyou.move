module 0xbe92f0c99a528c3ebcb27ce568e06c074704d009d1949848f9968f312e1bcd8::fuckyou {
    struct FUCKYOU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FUCKYOU>, arg1: 0x2::coin::Coin<FUCKYOU>) {
        0x2::coin::burn<FUCKYOU>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FUCKYOU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FUCKYOU>>(0x2::coin::mint<FUCKYOU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FUCKYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKYOU>(arg0, 9, b"fuckyou", b"FUCKYOU", b"fuck you", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUCKYOU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKYOU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

