module 0x777cead97462c539a7b82c99f644c6304a1cb5bba60424564a906b8c3386521b::crozz_coin {
    struct CROZZ_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROZZ_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 951 || 0x2::tx_context::epoch(arg1) == 952, 0);
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency_v2<CROZZ_COIN>(arg0, 8, b"CROZZ", b"Crozz Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmcrSYbn4MzYxNTdpk51sPn1dC1JApYYbzjocQsSiiiSTh"))), true, arg1);
        let v4 = v1;
        0x2::coin::mint_and_transfer<CROZZ_COIN>(&mut v4, 888888888800000000, @0xb1e255b71d07db1ea5984fed0184ea65868a0b7bea000771b19457dc901464c1, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROZZ_COIN>>(v4, @0xb1e255b71d07db1ea5984fed0184ea65868a0b7bea000771b19457dc901464c1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CROZZ_COIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CROZZ_COIN>>(v2, @0xb1e255b71d07db1ea5984fed0184ea65868a0b7bea000771b19457dc901464c1);
    }

    // decompiled from Move bytecode v6
}

