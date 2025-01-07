module 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::swap {
    public fun add_swap_route<T0, T1, T2, T3>(arg0: &0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::AdminCap, arg1: &mut 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::Vault<T0, T1, T2>, arg2: vector<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>, arg3: bool) {
        0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public fun consume_receipt<T0, T1, T2, T3>(arg0: 0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::StratsReceipt, arg1: &mut 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::Vault<T0, T1, T2>, arg2: &0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::VaultAcl, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::swap_route_returns_x<T0, T1, T2, T3>(arg1)) {
            0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::add_reward_x<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::Access>(&mut arg0, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::access(arg2), b"funds")));
        } else {
            0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::add_reward_y<T0, T1, T2>(arg1, 0x2::coin::into_balance<T1>(0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::Access>(&mut arg0, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::access(arg2), b"funds")));
        };
        0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::remove_data<vector<u8>, u8, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::Access>(&mut arg0, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::access(arg2), b"current_index");
        0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::remove_data<vector<u8>, u8, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::Access>(&mut arg0, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::access(arg2), b"final_index");
        0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::burn(arg0);
    }

    public fun issue_receipt<T0, T1, T2, T3>(arg0: &mut 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::Vault<T0, T1, T2>, arg1: &0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::VaultAcl, arg2: &0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::acl::RouterAcl, arg3: &mut 0x2::tx_context::TxContext) : 0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::StratsReceipt {
        let (v0, _) = 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::get_swap_route<T0, T1, T2, T3>(arg0);
        let v2 = v0;
        let v3 = 0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::issue<0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::Access>(0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::access(arg1), 0x1::option::some<0x2::object::ID>(0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::acl::access_id(arg2)), arg3);
        0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::add_data<vector<u8>, 0x2::coin::Coin<T3>, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::Access>(&mut v3, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::access(arg1), b"funds", 0x2::coin::from_balance<T3>(0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::get_reward_balance<T0, T1, T2, T3>(arg0), arg3));
        0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::add_data<vector<u8>, u8, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::Access>(&mut v3, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::access(arg1), b"current_index", 0);
        0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::add_data<vector<u8>, u8, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::Access>(&mut v3, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::access(arg1), b"final_index", ((0x1::vector::length<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>(&v2) - 1) as u8));
        while (!0x1::vector::is_empty<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>(&v2)) {
            0xfdbd3d8dac427ef4fdbfb83553c5ac1f0f82f0ce01add04b738dcea7da6bd52a::receipt::add_data<u8, 0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::Access>(&mut v3, 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault_acl::access(arg1), (0x1::vector::length<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>(&v2) as u8), 0x1::vector::pop_back<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>(&mut v2));
        };
        0x1::vector::destroy_empty<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>(v2);
        v3
    }

    public fun remove_swap_route<T0, T1, T2, T3>(arg0: &0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::AdminCap, arg1: &mut 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::Vault<T0, T1, T2>) {
        0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::remove_swap_route<T0, T1, T2, T3>(arg1);
    }

    // decompiled from Move bytecode v6
}

