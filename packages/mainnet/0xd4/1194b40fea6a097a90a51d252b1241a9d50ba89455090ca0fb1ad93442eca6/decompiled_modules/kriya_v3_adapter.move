module 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::kriya_v3_adapter {
    public fun swap<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let (v4, v5) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v3);
        let (v6, v7) = if (arg3) {
            0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v1, arg9));
            0x2::balance::destroy_zero<T0>(v0);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg9)), 0x2::balance::zero<T1>())
        } else {
            0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v0, arg9));
            0x2::balance::destroy_zero<T1>(v1);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg9)))
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, v6, v7, arg8, arg9);
        (arg1, arg2)
    }

    public fun swap_router<T0, T1>(arg0: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::RouterAcl, arg3: &0x2::clock::Clock, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::access(arg2);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"current_index");
        assert!(v1 <= *0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::borrow_data<vector<u8>, u8, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"final_index"), 0);
        let (v2, v3) = 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::bag_value::unwrap(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<u8, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::bag_value::Value, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, v1));
        assert!(0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg1) == v2, 0);
        if (v3) {
            let v4 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"funds");
            let v5 = 0x2::coin::zero<T1>(arg5);
            let (v6, v7) = swap<T0, T1>(arg1, v4, v5, true, true, 0x2::coin::value<T0>(&v4), 4295048017, arg3, arg4, arg5);
            0x2::coin::destroy_zero<T0>(v6);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T1>, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"funds", v7);
        } else {
            let v8 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"funds");
            let v9 = 0x2::coin::zero<T0>(arg5);
            let (v10, v11) = swap<T0, T1>(arg1, v9, v8, false, true, 0x2::coin::value<T1>(&v8), 79226673515401279992447579054, arg3, arg4, arg5);
            0x2::coin::destroy_zero<T1>(v11);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"funds", v10);
        };
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"current_index", v1 + 1);
    }

    // decompiled from Move bytecode v6
}

