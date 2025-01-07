module 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::process_deposit_helper {
    fun closer(arg0: u128, arg1: u128, arg2: u128) : bool {
        let v0 = if (arg0 > arg2) {
            arg0 - arg2
        } else {
            arg2 - arg0
        };
        let v1 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        v0 < v1
    }

    public(friend) fun consume_swap_receipt<T0>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::VaultAcl) : 0x2::coin::Coin<T0> {
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::Access>(&mut arg0, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::access(arg1), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::Access>(&mut arg0, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::access(arg1), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::Access>(&mut arg0, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::access(arg1), b"funds")
    }

    public fun get_amount_to_swap<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>) : u64 {
        let v0 = 1000000;
        let v1 = (arg1 as u128) * (v0 as u128) / (arg2 as u128);
        let v2 = 0;
        let v3 = arg0 / 2;
        while (v2 < 8) {
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg3, true, true, v3);
            let v5 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4) as u128) * (v0 as u128) / ((arg0 - v3) as u128);
            if (v2 == 0) {
            } else if (v5 > v1) {
                let v6 = 0 + v3;
                v3 = v6 / 2;
            } else {
                let v7 = arg0 + v3;
                v3 = v7 / 2;
            };
            v2 = v2 + 1;
        };
        v3
    }

    public(friend) fun issue_swap_receipt<T0>(arg0: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::VaultAcl, arg1: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        let v0 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::Access>(0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::access(arg0), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg1)), arg4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::Access>(&mut v0, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::access(arg0), b"funds", 0x2::coin::from_balance<T0>(arg3, arg4));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::Access>(&mut v0, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::access(arg0), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::Access>(&mut v0, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::access(arg0), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg2) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg2)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::Access>(&mut v0, 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_acl::access(arg0), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg2) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut arg2));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

