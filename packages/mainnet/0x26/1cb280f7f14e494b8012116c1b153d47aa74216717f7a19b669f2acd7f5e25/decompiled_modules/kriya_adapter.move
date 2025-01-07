module 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::kriya_adapter {
    public fun flash_swap<T0, T1>(arg0: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::AggregatorAcl, arg3: &0x2::clock::Clock, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt {
        let v0 = 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::access(arg2);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x1::type_name::TypeName, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"input_type");
        let v2 = 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg1);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::borrow_data<vector<u8>, 0x2::object::ID, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"pool_id") == &v2, 0);
        assert!(v1 == 0x1::type_name::get<T0>() || v1 == 0x1::type_name::get<T1>(), 0);
        let v3 = v1 == 0x1::type_name::get<T0>();
        let (v4, v5, v6) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, v3, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, bool, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"fix_input"), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"amount"), 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::utils::calc_sqrt_limit_price_with_slippage(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"slippage"), v3), arg3, arg4, arg5);
        let v7 = v6;
        let (v8, v9) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v7);
        if (v3) {
            0x2::balance::destroy_zero<T0>(v4);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T1>, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"funds", v5);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"repay_type", 0x1::type_name::get<T0>());
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"repay_amount", v8);
        } else {
            0x2::balance::destroy_zero<T1>(v5);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"funds", v4);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"repay_type", 0x1::type_name::get<T1>());
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"repay_amount", v9);
        };
        v7
    }

    public fun repay_flash_swap<T0, T1>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::AggregatorAcl, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::access(arg3);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x1::type_name::TypeName, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(&mut arg0, v0, b"repay_type");
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(&mut arg0, v0, b"pool_id") == 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg2), 0);
        assert!(v1 == 0x1::type_name::get<T0>() || v1 == 0x1::type_name::get<T1>(), 0);
        let (v2, v3) = if (0x1::type_name::get<T0>() == v1) {
            (0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(&mut arg0, v0, b"funds"), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(&mut arg0, v0, b"funds"))
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg2, arg1, v2, v3, arg4, arg5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
    }

    // decompiled from Move bytecode v6
}

