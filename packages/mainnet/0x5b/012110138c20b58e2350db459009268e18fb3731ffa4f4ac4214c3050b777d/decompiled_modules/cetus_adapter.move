module 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::cetus_adapter {
    public fun flash_swap<T0, T1>(arg0: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::AggregatorAcl, arg4: &0x2::clock::Clock) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1> {
        let v0 = 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::access(arg3);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x1::type_name::TypeName, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"input_type");
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::borrow_data<vector<u8>, 0x2::object::ID, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"pool_id") == &v2, 0);
        assert!(v1 == 0x1::type_name::get<T0>() || v1 == 0x1::type_name::get<T1>(), 0);
        let v3 = v1 == 0x1::type_name::get<T0>();
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg1, v3, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, bool, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"fix_input"), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"amount"), 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::utils::calc_sqrt_limit_price_with_slippage(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(arg0, v0, b"slippage"), v3), arg4);
        let v7 = v6;
        let (v8, v9) = if (v3) {
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7), 0)
        } else {
            (0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7))
        };
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

    public fun repay_flash_swap<T0, T1>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::AggregatorAcl) {
        let v0 = 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::access(arg4);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x1::type_name::TypeName, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(&mut arg0, v0, b"repay_type");
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(&mut arg0, v0, b"pool_id") == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0);
        assert!(v1 == 0x1::type_name::get<T0>() || v1 == 0x1::type_name::get<T1>(), 0);
        let (v2, v3) = if (0x1::type_name::get<T0>() == v1) {
            (0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(&mut arg0, v0, b"funds"), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::Access>(&mut arg0, v0, b"funds"))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg2, v2, v3, arg1);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
    }

    // decompiled from Move bytecode v6
}

