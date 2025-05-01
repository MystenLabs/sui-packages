module 0x7369252b7570156656f90c16bfb4a9dada1ca1ec762a07788e4f35b7e9030693::testy {
    struct TESTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTY, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 750 || 0x2::tx_context::epoch(arg1) == 751, 1);
        let (v0, v1) = 0x2::coin::create_currency<TESTY>(arg0, 9, b"testy", b"testy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTY>(&mut v2, 1000000000000000000, @0x1143a0ce07aaa1acee7ac587af12d7d7eb6787de0eb586c3ca66194096c5f1cc, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTY>>(v2, @0x1143a0ce07aaa1acee7ac587af12d7d7eb6787de0eb586c3ca66194096c5f1cc);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

