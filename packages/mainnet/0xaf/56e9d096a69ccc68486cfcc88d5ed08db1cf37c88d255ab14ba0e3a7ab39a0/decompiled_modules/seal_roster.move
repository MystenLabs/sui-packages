module 0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::seal_roster {
    entry fun seal_approve_cf_history(arg0: &0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::Roster, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 40, 101);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::has_cf_history(arg0, v0), 102);
        let v1 = 0x2::address::to_bytes(v0);
        let v2 = 0;
        while (v2 < 32) {
            assert!(*0x1::vector::borrow<u8>(&arg1, v2) == *0x1::vector::borrow<u8>(&v1, v2), 100);
            v2 = v2 + 1;
        };
    }

    entry fun seal_approve_roster_reader(arg0: &0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::Roster, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 40, 101);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::has_address(arg0, v0), 100);
        assert!(0x1::string::length(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::record_walrus_blob_id(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::lookup_by_address(arg0, v0))) > 0, 102);
        let v1 = 0x2::address::to_bytes(v0);
        let v2 = 0;
        while (v2 < 32) {
            assert!(*0x1::vector::borrow<u8>(&arg1, v2) == *0x1::vector::borrow<u8>(&v1, v2), 101);
            v2 = v2 + 1;
        };
    }

    entry fun seal_approve_roster_reader_v2(arg0: vector<u8>, arg1: &0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::Roster, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 40, 101);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        assert!(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::has_name(arg1, v0), 100);
        let v2 = 0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::lookup_by_name(arg1, v0);
        assert!(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::record_sui_address(v2) == 0x2::tx_context::sender(arg2), 100);
        assert!(0x1::string::length(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::record_walrus_blob_id(v2)) > 0, 102);
    }

    entry fun seal_approve_roster_reader_v3(arg0: vector<u8>, arg1: &0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::Roster, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 40, 101);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v2));
            v2 = v2 + 1;
        };
        if (0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::has_name(arg1, v1)) {
            let v3 = 0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::lookup_by_name(arg1, v1);
            if (0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::record_sui_address(v3) == v0 && 0x1::string::length(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::record_walrus_blob_id(v3)) > 0) {
                return
            };
        };
        assert!(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::has_ens_name(arg1, v1), 100);
        let v4 = 0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::lookup_by_ens(arg1, v1);
        assert!(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::record_sui_address(v4) == v0, 100);
        assert!(0x1::string::length(0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster::record_walrus_blob_id(v4)) > 0, 102);
    }

    // decompiled from Move bytecode v7
}

