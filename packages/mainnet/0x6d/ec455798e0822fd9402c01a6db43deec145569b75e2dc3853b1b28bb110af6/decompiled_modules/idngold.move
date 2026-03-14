module 0x6dec455798e0822fd9402c01a6db43deec145569b75e2dc3853b1b28bb110af6::idngold {
    struct IDNGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDNGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 1066 || 0x2::tx_context::epoch(arg1) == 1067, 0);
        let (v1, v2) = 0x2::coin::create_currency<IDNGOLD>(arg0, 9, b"idng", b"IDNGold", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmTNVnD6pF7ggHaEAREKbYpvn1AfcimvCdoLZSag2V9cjp"))), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<IDNGOLD>(&mut v3, 100000000000000000, @0x1ef4a827791d158f2779e3057c3d04493db9fd991d943dde3dc62a091497e5ed, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDNGOLD>>(v3, @0x1ef4a827791d158f2779e3057c3d04493db9fd991d943dde3dc62a091497e5ed);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IDNGOLD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

