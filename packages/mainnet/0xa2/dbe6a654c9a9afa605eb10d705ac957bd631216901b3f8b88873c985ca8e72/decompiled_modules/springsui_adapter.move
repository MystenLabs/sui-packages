module 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::springsui_adapter {
    public fun spring_sui_router<T0: drop>(arg0: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access(arg3);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"current_index");
        assert!(v1 <= *0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::borrow_data<vector<u8>, u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"final_index"), 0);
        let (v2, v3) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, v1));
        assert!(0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg1) == v2, 0);
        if (v3) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"funds", 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg1, arg2, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"funds"), arg4));
        } else {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"funds", 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg1, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"funds"), arg2, arg4));
        };
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"current_index", v1 + 1);
    }

    // decompiled from Move bytecode v6
}

