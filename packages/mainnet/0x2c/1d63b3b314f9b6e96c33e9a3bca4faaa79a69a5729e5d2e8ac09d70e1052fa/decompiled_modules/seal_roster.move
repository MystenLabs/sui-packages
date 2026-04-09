module 0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::seal_roster {
    entry fun seal_approve_roster_reader(arg0: &0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::Roster, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 40, 101);
        assert!(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::has_address(arg0, 0x2::tx_context::sender(arg2)), 100);
        assert!(0x1::string::length(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::record_walrus_blob_id(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::lookup_by_address(arg0, 0x2::tx_context::sender(arg2)))) > 0, 102);
    }

    // decompiled from Move bytecode v6
}

