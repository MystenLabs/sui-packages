module 0xb2c1c058f984c3e76e577838a295af8444e13385131c5ef3168ca710ce496eeb::newtoken {
    struct NEWTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWTOKEN>(arg0, 6, b"newtoken", b"newtoken", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEWTOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

