module 0x2cc4b37b9c40bfcae1112fc4061540b700add46fdcf4226a2ad43b4a09d25859::skarn {
    struct SKARN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKARN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 1130 || 0x2::tx_context::epoch(arg1) == 1131, 0);
        let (v1, v2) = 0x2::coin::create_currency<SKARN>(arg0, 9, b"SKARN", b"SKARN", b"The investment model is linked to the insurance value of cargo transported by vessel. At the start of the voyage, cargo is insured at a defined value - upon successful arrival, investors participate in the finalized commercial outcome.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmWad64onVPVDR5DZJEi4eDjt4Sb6XGBi92i4QHd6R2VAM"))), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SKARN>(&mut v3, 10000000000000000, @0x3c137d2d81ea96918c2873dd7375d32f8acc3632c481ad9af3190c40410497a3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKARN>>(v3, @0x3c137d2d81ea96918c2873dd7375d32f8acc3632c481ad9af3190c40410497a3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKARN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

