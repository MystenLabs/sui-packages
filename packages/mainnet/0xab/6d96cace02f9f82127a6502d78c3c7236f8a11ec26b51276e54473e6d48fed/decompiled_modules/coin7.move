module 0xab6d96cace02f9f82127a6502d78c3c7236f8a11ec26b51276e54473e6d48fed::coin7 {
    struct COIN7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN7>(arg0, 9, b"A", b"a", b"A", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN7>>(v0, @0x0);
    }

    // decompiled from Move bytecode v6
}

