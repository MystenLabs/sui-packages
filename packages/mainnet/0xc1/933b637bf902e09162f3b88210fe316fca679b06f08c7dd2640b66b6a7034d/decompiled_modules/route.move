module 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::route {
    public fun add<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::VaultCap, arg1: &mut 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::Vault<T0, T1, T2, T3>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: bool, arg4: &0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::version::Version) {
        0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::version::assert_supported_version(arg4);
        0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::check_vault_cap_compatibility<T0, T1, T2, T3>(arg1, arg0);
        0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::add_swap_route<T0, T1, T2, T3, T4>(arg1, arg2, arg3);
    }

    public fun consume_receipt<T0, T1, T2, T3: copy + drop + store, T4>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::Vault<T0, T1, T2, T3>, arg2: &0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::VaultAcl, arg3: &0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::version::assert_supported_version(arg3);
        if (0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::swap_route_returns_x<T0, T1, T2, T3, T4>(arg1)) {
            let v0 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::Access>(&mut arg0, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::access(arg2), b"funds");
            let v1 = 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::calc_fee<T0, T1, T2, T3>(arg1, 0x2::coin::value<T0>(&v0));
            if (v1 > 0) {
                0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::add_fee_a<T0, T1, T2, T3>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v1, arg4)));
            };
            0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::add_free_balance_a<T0, T1, T2, T3>(arg1, 0x2::coin::into_balance<T0>(v0));
        } else {
            let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::Access>(&mut arg0, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::access(arg2), b"funds");
            let v3 = 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::calc_fee<T0, T1, T2, T3>(arg1, 0x2::coin::value<T1>(&v2));
            if (v3 > 0) {
                0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::add_fee_b<T0, T1, T2, T3>(arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v2, v3, arg4)));
            };
            0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::add_free_balance_b<T0, T1, T2, T3>(arg1, 0x2::coin::into_balance<T1>(v2));
        };
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::Access>(&mut arg0, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::access(arg2), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::Access>(&mut arg0, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::access(arg2), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
    }

    public(friend) fun issue_receipt<T0, T1, T2, T3: copy + drop + store, T4>(arg0: 0x2::balance::Balance<T4>, arg1: &0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::Vault<T0, T1, T2, T3>, arg2: &0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::VaultAcl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        let (v0, _) = 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::get_swap_route<T0, T1, T2, T3, T4>(arg1);
        let v2 = v0;
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::Access>(0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::access(arg2), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg3)), arg4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T4>, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::Access>(&mut v3, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::access(arg2), b"funds", 0x2::coin::from_balance<T4>(arg0, arg4));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::Access>(&mut v3, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::access(arg2), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::Access>(&mut v3, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::access(arg2), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::Access>(&mut v3, 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault_acl::access(arg2), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v2));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v2);
        v3
    }

    public fun remove<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::VaultCap, arg1: &mut 0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::Vault<T0, T1, T2, T3>, arg2: &0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::version::Version) {
        0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::version::assert_supported_version(arg2);
        0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::check_vault_cap_compatibility<T0, T1, T2, T3>(arg1, arg0);
        0xc1933b637bf902e09162f3b88210fe316fca679b06f08c7dd2640b66b6a7034d::vault::remove_swap_route<T0, T1, T2, T3, T4>(arg1);
    }

    // decompiled from Move bytecode v6
}

