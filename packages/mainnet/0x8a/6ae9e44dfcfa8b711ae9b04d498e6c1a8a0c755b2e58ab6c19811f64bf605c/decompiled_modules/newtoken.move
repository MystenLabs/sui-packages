module 0x8a6ae9e44dfcfa8b711ae9b04d498e6c1a8a0c755b2e58ab6c19811f64bf605c::newtoken {
    struct NEWTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWTOKEN>(arg0, 6, b"NEWT", b"New Test Token", b"SDK test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

