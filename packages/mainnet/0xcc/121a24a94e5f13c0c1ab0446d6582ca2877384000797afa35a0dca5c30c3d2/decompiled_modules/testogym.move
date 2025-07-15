module 0xcc121a24a94e5f13c0c1ab0446d6582ca2877384000797afa35a0dca5c30c3d2::testogym {
    struct TESTOGYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTOGYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTOGYM>(arg0, 6, b"TESTOGYM", b"TESTOSTERONE", b"TESTOGYM FOR HIGH TESTOSTERONE!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bdfccc1a8b6bbf6dcca40b11fb32915c_b3ee96efda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTOGYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTOGYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

