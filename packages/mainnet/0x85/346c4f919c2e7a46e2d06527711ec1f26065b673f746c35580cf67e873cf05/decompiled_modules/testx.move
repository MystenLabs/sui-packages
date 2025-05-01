module 0x85346c4f919c2e7a46e2d06527711ec1f26065b673f746c35580cf67e873cf05::testx {
    struct TESTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTX, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 750 || 0x2::tx_context::epoch(arg1) == 751, 1);
        let (v0, v1) = 0x2::coin::create_currency<TESTX>(arg0, 9, b"testx", b"testx", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTX>(&mut v2, 1000000000000000000, @0x1143a0ce07aaa1acee7ac587af12d7d7eb6787de0eb586c3ca66194096c5f1cc, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTX>>(v2, @0x1143a0ce07aaa1acee7ac587af12d7d7eb6787de0eb586c3ca66194096c5f1cc);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

