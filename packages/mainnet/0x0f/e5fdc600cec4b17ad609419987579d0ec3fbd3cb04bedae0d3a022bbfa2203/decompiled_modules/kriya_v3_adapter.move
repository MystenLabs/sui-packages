module 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::kriya_v3_adapter {
    fun swap<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let (v4, v5) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v3);
        if (arg3) {
            0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v1, arg9));
            0x2::balance::destroy_zero<T0>(v0);
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg9)), 0x2::balance::zero<T1>(), arg8, arg9);
        } else {
            0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v0, arg9));
            0x2::balance::destroy_zero<T1>(v1);
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg9)), arg8, arg9);
        };
        (arg1, arg2)
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let (v1, v2) = swap<T0, T1>(arg0, arg1, v0, true, true, arg2, 4295048016, arg4, arg3, arg5);
        0x2::coin::destroy_zero<T0>(v1);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let (v1, v2) = swap<T0, T1>(arg0, v0, arg1, false, true, arg2, 79226673515401279992447579054, arg4, arg3, arg5);
        0x2::coin::destroy_zero<T1>(v2);
        v1
    }

    public fun swap_router<T0, T1>(arg0: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access(arg3);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"current_index");
        assert!(v1 <= *0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::borrow_data<vector<u8>, u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"final_index"), 0);
        let (v2, v3) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, v1));
        assert!(0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg1) == v2, 0);
        if (v3) {
            let v4 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"funds");
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T1>, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"funds", swap_a2b<T0, T1>(arg1, v4, 0x2::coin::value<T0>(&v4), arg2, arg4, arg5));
        } else {
            let v5 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"funds");
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"funds", swap_b2a<T0, T1>(arg1, v5, 0x2::coin::value<T1>(&v5), arg2, arg4, arg5));
        };
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::Access>(arg0, v0, b"current_index", v1 + 1);
    }

    // decompiled from Move bytecode v6
}

