module 0xe70ffedcecd051a721e7862646a3f87b5a7897fd00f1e465876e3f0b78052a2b::suimpson {
    struct SUIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPSON>(arg0, 6, b"Suimpson", b"Homer Suimpson", b"Homer Simpson Coin will help everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CES_679209eace.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

