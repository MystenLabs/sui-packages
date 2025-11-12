module 0x505cc7f8f13fbf4fd793edc060860e53542681a8831051e4874a4c5ccb4377bd::prueba_phx5 {
    struct PRUEBA_PHX5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRUEBA_PHX5, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 944 || 0x2::tx_context::epoch(arg1) == 945, 0);
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency_v2<PRUEBA_PHX5>(arg0, 9, b"PHX5", b"Prueba PHX5", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), true, arg1);
        let v4 = v1;
        0x2::coin::mint_and_transfer<PRUEBA_PHX5>(&mut v4, 8888888888000000000, @0xb1e255b71d07db1ea5984fed0184ea65868a0b7bea000771b19457dc901464c1, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRUEBA_PHX5>>(v4, @0xb1e255b71d07db1ea5984fed0184ea65868a0b7bea000771b19457dc901464c1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PRUEBA_PHX5>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PRUEBA_PHX5>>(v2, @0xb1e255b71d07db1ea5984fed0184ea65868a0b7bea000771b19457dc901464c1);
    }

    // decompiled from Move bytecode v6
}

