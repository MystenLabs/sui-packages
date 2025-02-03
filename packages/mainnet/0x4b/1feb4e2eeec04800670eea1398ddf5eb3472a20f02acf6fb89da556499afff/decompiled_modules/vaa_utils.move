module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::vaa_utils {
    public fun parse_cancel_collateral_payload(arg0: vector<0x1::string::String>) : (0x1::string::String, 0x1::string::String) {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 2, 1);
        (*0x1::vector::borrow<0x1::string::String>(&arg0, 0), *0x1::vector::borrow<0x1::string::String>(&arg0, 1))
    }

    public fun parse_create_loan_cross_chain_payload(arg0: vector<0x1::string::String>) : (0x1::string::String, 0x1::string::String, u64, 0x1::string::String, u64, u64, 0x1::string::String, 0x1::string::String) {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 8, 1);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::string_to_u64(*0x1::vector::borrow<0x1::string::String>(&arg0, 4));
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::string_to_u64(*0x1::vector::borrow<0x1::string::String>(&arg0, 2));
        let v2 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::string_to_u64(*0x1::vector::borrow<0x1::string::String>(&arg0, 5));
        assert!(0x1::option::is_some<u64>(&v0) && 0x1::option::is_some<u64>(&v1) && 0x1::option::is_some<u64>(&v2), 2);
        (*0x1::vector::borrow<0x1::string::String>(&arg0, 0), *0x1::vector::borrow<0x1::string::String>(&arg0, 1), 0x1::option::extract<u64>(&mut v1), *0x1::vector::borrow<0x1::string::String>(&arg0, 3), 0x1::option::extract<u64>(&mut v0), 0x1::option::extract<u64>(&mut v2), *0x1::vector::borrow<0x1::string::String>(&arg0, 6), *0x1::vector::borrow<0x1::string::String>(&arg0, 7))
    }

    public fun parse_liquidate_collateral_payload(arg0: vector<0x1::string::String>) : (0x1::string::String, 0x1::string::String, u64, u64) {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 4, 1);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::string_to_u64(*0x1::vector::borrow<0x1::string::String>(&arg0, 2));
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::string_to_u64(*0x1::vector::borrow<0x1::string::String>(&arg0, 3));
        assert!(0x1::option::is_some<u64>(&v0) && 0x1::option::is_some<u64>(&v1), 2);
        (*0x1::vector::borrow<0x1::string::String>(&arg0, 0), *0x1::vector::borrow<0x1::string::String>(&arg0, 1), 0x1::option::extract<u64>(&mut v0), 0x1::option::extract<u64>(&mut v1))
    }

    public fun parse_refund_collateral_to_repaid_borrower_payload(arg0: vector<0x1::string::String>) : (0x1::string::String, 0x1::string::String) {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 2, 1);
        (*0x1::vector::borrow<0x1::string::String>(&arg0, 0), *0x1::vector::borrow<0x1::string::String>(&arg0, 1))
    }

    public fun parse_update_deposit_collateral_payload(arg0: vector<0x1::string::String>) : (0x1::string::String, u64, u64, 0x1::string::String, 0x1::string::String) {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 5, 1);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::string_to_u64(*0x1::vector::borrow<0x1::string::String>(&arg0, 1));
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::string_to_u64(*0x1::vector::borrow<0x1::string::String>(&arg0, 2));
        assert!(0x1::option::is_some<u64>(&v0), 2);
        assert!(0x1::option::is_some<u64>(&v1), 2);
        (*0x1::vector::borrow<0x1::string::String>(&arg0, 0), 0x1::option::extract<u64>(&mut v0), 0x1::option::extract<u64>(&mut v1), *0x1::vector::borrow<0x1::string::String>(&arg0, 3), *0x1::vector::borrow<0x1::string::String>(&arg0, 4))
    }

    public fun parse_update_withdraw_collateral_payload(arg0: vector<0x1::string::String>) : (0x1::string::String, u64, u64, 0x1::string::String, 0x1::string::String) {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 5, 1);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::string_to_u64(*0x1::vector::borrow<0x1::string::String>(&arg0, 1));
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::string_to_u64(*0x1::vector::borrow<0x1::string::String>(&arg0, 2));
        assert!(0x1::option::is_some<u64>(&v0) && 0x1::option::is_some<u64>(&v1), 2);
        (*0x1::vector::borrow<0x1::string::String>(&arg0, 0), 0x1::option::extract<u64>(&mut v0), 0x1::option::extract<u64>(&mut v1), *0x1::vector::borrow<0x1::string::String>(&arg0, 3), *0x1::vector::borrow<0x1::string::String>(&arg0, 4))
    }

    // decompiled from Move bytecode v6
}

