module 0xa2980da5a6af88e1327a74debe58cc1b3ee6097b676d3212af68213f68cf0325::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 750 || 0x2::tx_context::epoch(arg1) == 751, 1);
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"testz", b"test", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 1000000000000000000, @0x1143a0ce07aaa1acee7ac587af12d7d7eb6787de0eb586c3ca66194096c5f1cc, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0x1143a0ce07aaa1acee7ac587af12d7d7eb6787de0eb586c3ca66194096c5f1cc);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

