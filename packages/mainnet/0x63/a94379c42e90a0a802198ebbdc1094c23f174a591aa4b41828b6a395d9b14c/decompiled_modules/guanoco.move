module 0x63a94379c42e90a0a802198ebbdc1094c23f174a591aa4b41828b6a395d9b14c::guanoco {
    struct GUANOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUANOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 1013 || 0x2::tx_context::epoch(arg1) == 1014, 0);
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency_v2<GUANOCO>(arg0, 9, b"GNC", b"GUANOCO", b"GuanoCo (GNC) is a sustainability-focused token on the Sui Network, designed to support energy innovation, environmental initiatives, and scalable decentralized applications through fast, efficient, and eco-friendly blockchain infrastructure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmQiwVdedrm1CqdYNVL9JXeVjaZ3mtS7MUaAVjmCydVGkp"))), false, arg1);
        let v4 = v1;
        0x2::coin::mint_and_transfer<GUANOCO>(&mut v4, 18400000000000000000, @0x2b05eddc80f3b984d54f77b33646f6f31e8b448e876554ab88eea9cdc5fef896, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUANOCO>>(v4, @0x2b05eddc80f3b984d54f77b33646f6f31e8b448e876554ab88eea9cdc5fef896);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUANOCO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GUANOCO>>(v2, @0x2b05eddc80f3b984d54f77b33646f6f31e8b448e876554ab88eea9cdc5fef896);
    }

    // decompiled from Move bytecode v6
}

