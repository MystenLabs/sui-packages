module 0x6794fc42f7fc267d95e83a59623c96f952420d4473b6fa70b012427217def2f8::bank {
    struct BANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 883 || 0x2::tx_context::epoch(arg1) == 884, 0);
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency_v2<BANK>(arg0, 9, b"BANK", b"BANK", b"SUI Asset Management Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmYPHNUN7uKXz35LzLGPqCqx2ELYhPoLdnRYQAvRLfCQc3"))), true, arg1);
        let v4 = v1;
        0x2::coin::mint_and_transfer<BANK>(&mut v4, 1000000000000000, @0xebdce6f165b23ec6e2c330a18fa52122ecaebc28d4feed913f44b4705f21a53f, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANK>>(v4, @0xebdce6f165b23ec6e2c330a18fa52122ecaebc28d4feed913f44b4705f21a53f);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BANK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BANK>>(v2, @0xebdce6f165b23ec6e2c330a18fa52122ecaebc28d4feed913f44b4705f21a53f);
    }

    // decompiled from Move bytecode v6
}

