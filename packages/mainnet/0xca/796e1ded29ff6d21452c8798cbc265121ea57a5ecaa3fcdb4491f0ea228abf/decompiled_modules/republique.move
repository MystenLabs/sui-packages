module 0xca796e1ded29ff6d21452c8798cbc265121ea57a5ecaa3fcdb4491f0ea228abf::republique {
    struct REPUBLIQUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REPUBLIQUE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 1188 || 0x2::tx_context::epoch(arg1) == 1189, 0);
        let (v1, v2) = 0x2::coin::create_currency<REPUBLIQUE>(arg0, 8, b"AMOG-R1", b"Republique", x"557020476f657320414d4f472052657075626c697175652e0a0a616d6f672d72657075626c697175652e636f6d0a0a58206163636f756e743a2040616d6f675f776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmcAyaF3UWFPCfvYCVGFgmovi94fHksF6cEAKnGqdLQebc"))), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<REPUBLIQUE>(&mut v3, 4400000000000000, @0x8c57b114a3e7d972ec4a1a25ccbed1245ea7621711efc6bdfcb9b1dea2a81b8e, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REPUBLIQUE>>(v3, @0x8c57b114a3e7d972ec4a1a25ccbed1245ea7621711efc6bdfcb9b1dea2a81b8e);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REPUBLIQUE>>(v2);
    }

    // decompiled from Move bytecode v6
}

