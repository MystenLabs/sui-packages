module 0xc923f6daf7e45605ebe33516e13008dce07225a462b46fa171d3b4da92e756c7::prueba_phx {
    struct PRUEBA_PHX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRUEBA_PHX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 942 || 0x2::tx_context::epoch(arg1) == 943, 0);
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency_v2<PRUEBA_PHX>(arg0, 9, b"pphx", b"prueba phx", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), true, arg1);
        let v4 = v1;
        0x2::coin::mint_and_transfer<PRUEBA_PHX>(&mut v4, 8888888888000000000, @0xbcbe736f0e081074ff43cd4028662399e370b6202ad1db0de24ccd7b17601e1a, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRUEBA_PHX>>(v4, @0xbcbe736f0e081074ff43cd4028662399e370b6202ad1db0de24ccd7b17601e1a);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PRUEBA_PHX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PRUEBA_PHX>>(v2, @0x4b9c4a38125012a033c435d25fa34cd3597ada17e2de0ebc3e129b3733ae4961);
    }

    // decompiled from Move bytecode v6
}

