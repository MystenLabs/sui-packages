module 0xe2048ffb31148c76117447efb1bd438e5486ee6e7932899d7f715b833edbba8e::euro {
    struct EURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EURO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 885 || 0x2::tx_context::epoch(arg1) == 886, 0);
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency_v2<EURO>(arg0, 9, b"EURO", b"EURO", b"EURO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/Qmd61MvbSZynq3YrYcqxRT6BPnUNYG2SVRdzLQquRFrfFb"))), true, arg1);
        let v4 = v1;
        0x2::coin::mint_and_transfer<EURO>(&mut v4, 1000000000000000, @0x1524fe34a5f2f169ff92d65a5de77318b100b944ab0d1dd97708be4b2d07a073, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EURO>>(v4, @0x1524fe34a5f2f169ff92d65a5de77318b100b944ab0d1dd97708be4b2d07a073);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EURO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<EURO>>(v2, @0x1524fe34a5f2f169ff92d65a5de77318b100b944ab0d1dd97708be4b2d07a073);
    }

    // decompiled from Move bytecode v6
}

