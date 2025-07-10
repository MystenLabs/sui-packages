module 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::route {
    public fun add<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::VaultCap, arg1: &mut 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::Vault<T0, T1, T2, T3>, arg2: vector<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>, arg3: bool, arg4: &0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::version::Version) {
        0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::version::assert_supported_version(arg4);
        0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::check_vault_cap_compatibility<T0, T1, T2, T3>(arg1, arg0);
        0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::add_swap_route<T0, T1, T2, T3, T4>(arg1, arg2, arg3);
    }

    public fun consume_receipt<T0, T1, T2, T3: copy + drop + store, T4>(arg0: 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt, arg1: &mut 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::Vault<T0, T1, T2, T3>, arg2: &0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::VaultAcl, arg3: &0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::version::assert_supported_version(arg3);
        if (0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::swap_route_returns_x<T0, T1, T2, T3, T4>(arg1)) {
            let v0 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::Access>(&mut arg0, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::access(arg2), b"funds");
            let v1 = 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::calc_fee<T0, T1, T2, T3>(arg1, 0x2::coin::value<T0>(&v0));
            if (v1 > 0) {
                0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::add_fee_a<T0, T1, T2, T3>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v1, arg4)));
            };
            0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::add_free_balance_a<T0, T1, T2, T3>(arg1, 0x2::coin::into_balance<T0>(v0));
        } else {
            let v2 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::Access>(&mut arg0, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::access(arg2), b"funds");
            let v3 = 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::calc_fee<T0, T1, T2, T3>(arg1, 0x2::coin::value<T1>(&v2));
            if (v3 > 0) {
                0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::add_fee_b<T0, T1, T2, T3>(arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v2, v3, arg4)));
            };
            0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::add_free_balance_b<T0, T1, T2, T3>(arg1, 0x2::coin::into_balance<T1>(v2));
        };
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, u8, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::Access>(&mut arg0, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::access(arg2), b"current_index");
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, u8, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::Access>(&mut arg0, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::access(arg2), b"final_index");
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::burn(arg0);
    }

    public(friend) fun issue_receipt<T0, T1, T2, T3: copy + drop + store, T4>(arg0: 0x2::balance::Balance<T4>, arg1: &0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::Vault<T0, T1, T2, T3>, arg2: &0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::VaultAcl, arg3: &0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::RouterAcl, arg4: &mut 0x2::tx_context::TxContext) : 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt {
        let (v0, _) = 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::get_swap_route<T0, T1, T2, T3, T4>(arg1);
        let v2 = v0;
        let v3 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::issue<0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::Access>(0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::access(arg2), 0x1::option::some<0x2::object::ID>(0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::access_id(arg3)), arg4);
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, 0x2::coin::Coin<T4>, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::Access>(&mut v3, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::access(arg2), b"funds", 0x2::coin::from_balance<T4>(arg0, arg4));
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, u8, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::Access>(&mut v3, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::access(arg2), b"current_index", 0);
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, u8, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::Access>(&mut v3, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::access(arg2), b"final_index", ((0x1::vector::length<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>(&v2) - 1) as u8));
        while (!0x1::vector::is_empty<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>(&v2)) {
            0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<u8, 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::Access>(&mut v3, 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault_acl::access(arg2), (0x1::vector::length<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>(&v2) as u8), 0x1::vector::pop_back<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>(&mut v2));
        };
        0x1::vector::destroy_empty<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>(v2);
        v3
    }

    public fun remove<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::VaultCap, arg1: &mut 0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::Vault<T0, T1, T2, T3>, arg2: &0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::version::Version) {
        0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::version::assert_supported_version(arg2);
        0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::check_vault_cap_compatibility<T0, T1, T2, T3>(arg1, arg0);
        0x285fe9f083aa626081f886383ecc58b7af7b98a2e6bd240f635998fee03f2d8a::vault::remove_swap_route<T0, T1, T2, T3, T4>(arg1);
    }

    // decompiled from Move bytecode v6
}

