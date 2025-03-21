module 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::kriya_adapter {
    public fun flash_swap<T0, T1>(arg0: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::AggregatorAcl, arg3: &0x2::clock::Clock, arg4: &0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::version::Version, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt {
        0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::version::assert_current_version(arg4);
        let v0 = 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::access(arg2);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"amount");
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x1::type_name::TypeName, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"input_type");
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, bool, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"fix_input");
        let v4 = 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg1);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::borrow_data<vector<u8>, 0x2::object::ID, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"pool_id") == &v4, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::error::invalid_pool_id());
        assert!(v2 == 0x1::type_name::get<T0>() || v2 == 0x1::type_name::get<T1>(), 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::error::invalid_input_type());
        let v5 = v2 == 0x1::type_name::get<T0>();
        let (v6, v7, v8) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, v5, v3, v1, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::utils::calc_sqrt_limit_price_with_slippage(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u128, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"slippage_up"), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u128, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"slippage_down"), v5), arg3, arg5, arg6);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        let (v12, v13) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v9);
        if (v3) {
            if (v5) {
                assert!(v12 == v1, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::error::slippage_exceeded());
            } else {
                assert!(v13 == v1, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::error::slippage_exceeded());
            };
        } else if (v5) {
            assert!(0x2::balance::value<T1>(&v10) == v1, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::error::slippage_exceeded());
        } else {
            assert!(0x2::balance::value<T0>(&v11) == v1, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::error::slippage_exceeded());
        };
        if (v5) {
            0x2::balance::destroy_zero<T0>(v11);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T1>, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"funds", v10);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"repay_type", 0x1::type_name::get<T0>());
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"repay_amount", v12);
        } else {
            0x2::balance::destroy_zero<T1>(v10);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"funds", v11);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"repay_type", 0x1::type_name::get<T1>());
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(arg0, v0, b"repay_amount", v13);
        };
        v9
    }

    public fun repay_flash_swap<T0, T1>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::AggregatorAcl, arg4: &0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::version::Version, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::version::assert_current_version(arg4);
        let v0 = 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::access(arg3);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x1::type_name::TypeName, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(&mut arg0, v0, b"repay_type");
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(&mut arg0, v0, b"pool_id") == 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg2), 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::error::invalid_pool_id());
        assert!(v1 == 0x1::type_name::get<T0>() || v1 == 0x1::type_name::get<T1>(), 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::error::invalid_repay_type());
        let (v2, v3) = if (0x1::type_name::get<T0>() == v1) {
            (0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(&mut arg0, v0, b"funds"), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::Access>(&mut arg0, v0, b"funds"))
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg2, arg1, v2, v3, arg5, arg6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
    }

    // decompiled from Move bytecode v6
}

