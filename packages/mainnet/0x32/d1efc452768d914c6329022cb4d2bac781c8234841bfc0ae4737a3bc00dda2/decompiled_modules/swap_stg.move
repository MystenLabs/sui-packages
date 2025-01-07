module 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::swap_stg {
    public fun add_swap_route<T0, T1, T2, T3>(arg0: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::VaultCap, arg1: &mut 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: bool, arg4: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::Version) {
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::assert_current_version(arg4);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::check_vault_cap_compatibility<T0, T1, T2>(arg1, arg0);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::add_swap_route<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun consume_receipt<T0, T1, T2, T3>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>, arg2: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::VaultAcl, arg3: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::assert_current_version(arg3);
        if (0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::swap_route_returns_x<T0, T1, T2, T3>(arg1)) {
            0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::add_reward_x<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::Access>(&mut arg0, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::access(arg2), b"funds")));
        } else {
            0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::add_reward_y<T0, T1, T2>(arg1, 0x2::coin::into_balance<T1>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::Access>(&mut arg0, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::access(arg2), b"funds")));
        };
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::Access>(&mut arg0, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::access(arg2), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::Access>(&mut arg0, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::access(arg2), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
    }

    public fun issue_receipt<T0, T1, T2, T3>(arg0: &mut 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>, arg1: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::VaultAcl, arg2: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg3: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::Version, arg4: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::assert_current_version(arg3);
        let (v0, _) = 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::get_swap_route<T0, T1, T2, T3>(arg0);
        let v2 = v0;
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::Access>(0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::access(arg1), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg2)), arg4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T3>, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::Access>(&mut v3, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::access(arg1), b"funds", 0x2::coin::from_balance<T3>(0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::get_reward_balance<T0, T1, T2, T3>(arg0), arg4));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::Access>(&mut v3, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::access(arg1), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::Access>(&mut v3, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::access(arg1), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::Access>(&mut v3, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_acl_stg::access(arg1), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v2));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v2);
        v3
    }

    public fun remove_swap_route<T0, T1, T2, T3>(arg0: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::VaultCap, arg1: &mut 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>, arg2: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::Version) {
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::assert_current_version(arg2);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::check_vault_cap_compatibility<T0, T1, T2>(arg1, arg0);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::remove_swap_route<T0, T1, T2, T3>(arg1);
    }

    // decompiled from Move bytecode v6
}

