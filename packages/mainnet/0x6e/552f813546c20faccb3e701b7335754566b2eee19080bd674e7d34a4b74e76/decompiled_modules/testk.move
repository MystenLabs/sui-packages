module 0x6e552f813546c20faccb3e701b7335754566b2eee19080bd674e7d34a4b74e76::testk {
    struct TESTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTK>(arg0, 9, b"TESTK", b"TESTK", b"TESTIUR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTK>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

