module 0x61540dc416a406c21172a8a2bc0b178be87bc0b4455aa7939c5c858a0064f31c::testolino {
    struct TESTOLINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTOLINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTOLINO>(arg0, 9, b"TESTOLINO", b"TESTOLINO", b"TESTOLINO BRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTOLINO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTOLINO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTOLINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

