module 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::process_deposit_helper {
    public(friend) fun consume_swap_receipt<T0>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::VaultAcl) : 0x2::coin::Coin<T0> {
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::Access>(&mut arg0, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::access(arg1), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::Access>(&mut arg0, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::access(arg1), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::Access>(&mut arg0, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::access(arg1), b"funds")
    }

    public(friend) fun get_amount_to_swap(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == 0) {
            0x2::math::divide_and_round_up(arg0, 2)
        } else {
            let v1 = 0x2::math::divide_and_round_up(arg1 * arg3, arg2);
            0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::safe_math::safe_mul_div_u64(arg0, v1, 1 + v1)
        }
    }

    public(friend) fun issue_swap_receipt<T0>(arg0: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::VaultAcl, arg1: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        let v0 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::Access>(0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::access(arg0), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg1)), arg4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::Access>(&mut v0, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::access(arg0), b"funds", 0x2::coin::from_balance<T0>(arg3, arg4));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::Access>(&mut v0, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::access(arg0), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::Access>(&mut v0, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::access(arg0), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg2) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg2)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::Access>(&mut v0, 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_acl::access(arg0), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg2) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut arg2));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

