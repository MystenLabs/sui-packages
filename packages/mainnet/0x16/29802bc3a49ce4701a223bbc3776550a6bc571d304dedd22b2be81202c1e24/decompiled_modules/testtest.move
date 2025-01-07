module 0x1629802bc3a49ce4701a223bbc3776550a6bc571d304dedd22b2be81202c1e24::testtest {
    struct TESTTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTEST>(arg0, 6, b"Testtest", b"Test", b"testetst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bildschirmfoto_2024_10_07_um_10_30_55_88bbbf979a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

