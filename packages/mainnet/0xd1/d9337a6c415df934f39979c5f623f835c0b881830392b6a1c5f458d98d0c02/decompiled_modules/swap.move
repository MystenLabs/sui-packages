module 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::swap {
    public fun add_swap_route<T0, T1, T2, T3>(arg0: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::VaultCap, arg1: &mut 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: bool, arg4: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::Version) {
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::assert_supported_version(arg4);
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::check_vault_cap_compatibility<T0, T1, T2>(arg1, arg0);
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun consume_receipt<T0, T1, T2, T3>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::Vault<T0, T1, T2>, arg2: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::VaultAcl, arg3: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::assert_supported_version(arg3);
        if (0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::swap_route_returns_x<T0, T1, T2, T3>(arg1)) {
            0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::add_reward_x<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::Access>(&mut arg0, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::access(arg2), b"funds")));
        } else {
            0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::add_reward_y<T0, T1, T2>(arg1, 0x2::coin::into_balance<T1>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::Access>(&mut arg0, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::access(arg2), b"funds")));
        };
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::Access>(&mut arg0, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::access(arg2), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::Access>(&mut arg0, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::access(arg2), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
    }

    public fun issue_receipt<T0, T1, T2, T3>(arg0: &mut 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::Vault<T0, T1, T2>, arg1: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::VaultAcl, arg2: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg3: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::assert_supported_version(arg3);
        let (v0, _) = 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::get_swap_route<T0, T1, T2, T3>(arg0);
        let v2 = v0;
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::Access>(0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::access(arg1), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg2)), arg4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T3>, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::Access>(&mut v3, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::access(arg1), b"funds", 0x2::coin::from_balance<T3>(0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::get_reward_balance<T0, T1, T2, T3>(arg0), arg4));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::Access>(&mut v3, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::access(arg1), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::Access>(&mut v3, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::access(arg1), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::Access>(&mut v3, 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault_acl::access(arg1), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v2));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v2);
        v3
    }

    public fun remove_swap_route<T0, T1, T2, T3>(arg0: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::VaultCap, arg1: &mut 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::Vault<T0, T1, T2>, arg2: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::Version) {
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::assert_supported_version(arg2);
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::check_vault_cap_compatibility<T0, T1, T2>(arg1, arg0);
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault::remove_swap_route<T0, T1, T2, T3>(arg1);
    }

    // decompiled from Move bytecode v6
}

