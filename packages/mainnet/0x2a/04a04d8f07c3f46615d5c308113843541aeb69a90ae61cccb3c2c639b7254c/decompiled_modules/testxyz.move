module 0x2a04a04d8f07c3f46615d5c308113843541aeb69a90ae61cccb3c2c639b7254c::testxyz {
    struct TESTXYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTXYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTXYZ>(arg0, 6, b"TESTXYZ", b"Testingxyz", b"testingxyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picture1_189b03b24a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTXYZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTXYZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

