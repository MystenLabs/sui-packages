module 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::spring_sui_adapter {
    fun calc_amount_with_fees(arg0: u64, arg1: u64) : u64 {
        let v0 = 10000;
        (((arg0 as u128) * v0 / (v0 - (arg1 as u128)) + (arg0 as u128) / v0) as u64)
    }

    public fun flash_swap<T0: drop, T1, T2>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::weight::WeightHook<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg4: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T2>, arg5: &0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::AggregatorAcl, arg6: &0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::version::Version, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &mut 0x2::tx_context::TxContext) : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashLoanReceipt {
        0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::version::assert_current_version(arg6);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>() || 0x1::type_name::get<T2>() == 0x1::type_name::get<0x2::sui::SUI>(), 0);
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::weight::rebalance<T0>(arg1, arg2, arg0, arg8);
        let v0 = 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::access(arg5);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::borrow_data<vector<u8>, 0x1::type_name::TypeName, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"loan_type");
        let v2 = 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg0);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::borrow_data<vector<u8>, 0x2::object::ID, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"pool_id") == &v2, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::error::invalid_pool_id());
        let v3 = 0x1::type_name::get<T0>();
        let v4 = v1 == &v3;
        let v5 = if (v4) {
            calc_amount_with_fees(lst_amount_to_sui_amount<T0>(arg0, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"loan_amount")), 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::sui_mint_fee_bps(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::fee_config<T0>(arg0)))
        } else {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"loan_amount")
        };
        let v6 = 0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>();
        let v7 = if (v6) {
            v5
        } else {
            0
        };
        let v8 = if (!v6) {
            v5
        } else {
            0
        };
        let (v9, v10, v11) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_loan<T1, T2>(arg4, v7, v8, arg7, arg8);
        let v12 = v11;
        if (v4) {
            if (v6) {
                0x2::balance::destroy_zero<T2>(v10);
                0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T1>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"funds", v9);
                0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"funds", 0x2::coin::into_balance<T0>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg0, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"funds"), arg8), arg8)));
                let (v13, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_receipt_debts(&v12);
                0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"repay_amount", v13);
            } else {
                0x2::balance::destroy_zero<T1>(v9);
                0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T2>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"funds", v10);
                0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"funds", 0x2::coin::into_balance<T0>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg0, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"funds"), arg8), arg8)));
                let (_, v16) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_receipt_debts(&v12);
                0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"repay_amount", v16);
            };
        } else {
            let v17 = if (v6) {
                0x2::balance::destroy_zero<T2>(v10);
                0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T1>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"funds", v9);
                let (v18, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_receipt_debts(&v12);
                v18
            } else {
                0x2::balance::destroy_zero<T1>(v9);
                0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T2>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"funds", v10);
                let (_, v21) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_receipt_debts(&v12);
                v21
            };
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg3, v0, b"repay_amount", sui_amount_to_lst_amount<T0>(arg0, calc_amount_with_fees(v17, 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::redeem_fee_bps(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::fee_config<T0>(arg0)))));
        };
        v12
    }

    fun lst_amount_to_sui_amount<T0>(arg0: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: u64) : u64 {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T0>(arg0);
        assert!(v0 > 0, 0);
        (((0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T0>(arg0) as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    public fun repay_flash_swap<T0: drop, T1, T2>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashLoanReceipt, arg4: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T2>, arg5: &0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::AggregatorAcl, arg6: &0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::version::Version, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::version::assert_current_version(arg6);
        let v0 = 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::access(arg5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x1::type_name::TypeName, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg2, v0, b"loan_type");
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg2, v0, b"pool_id") == 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg0), 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::error::invalid_pool_id());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg2, v0, b"funds", 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg0, 0x2::coin::from_balance<T0>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg2, v0, b"funds"), arg8), arg1, arg8)));
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_loan<T1, T2>(arg4, arg3, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg2, v0, b"funds"), 0x2::balance::zero<T2>(), arg7, arg8);
        } else {
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_loan<T1, T2>(arg4, arg3, 0x2::balance::zero<T1>(), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T2>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(arg2, v0, b"funds"), arg7, arg8);
        };
    }

    public fun repay_flash_swap_<T0: drop, T1, T2>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashLoanReceipt, arg4: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T2>, arg5: &0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::AggregatorAcl, arg6: &0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::version::Version, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::version::assert_current_version(arg6);
        let v0 = 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::access(arg5);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(&mut arg2, v0, b"pool_id") == 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg0), 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::error::invalid_pool_id());
        if (0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x1::type_name::TypeName, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(&mut arg2, v0, b"loan_type") == 0x1::type_name::get<T0>()) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(&mut arg2, v0, b"funds", 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(&mut arg2, v0, b"funds"));
            if (0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>()) {
                0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_loan<T1, T2>(arg4, arg3, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(&mut arg2, v0, b"funds"), 0x2::balance::zero<T2>(), arg7, arg8);
            } else {
                0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_loan<T1, T2>(arg4, arg3, 0x2::balance::zero<T1>(), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T2>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(&mut arg2, v0, b"funds"), arg7, arg8);
            };
        } else {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(&mut arg2, v0, b"funds", 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg0, 0x2::coin::from_balance<T0>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(&mut arg2, v0, b"funds"), arg8), arg1, arg8)));
            if (0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>()) {
                0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_loan<T1, T2>(arg4, arg3, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(&mut arg2, v0, b"funds"), 0x2::balance::zero<T2>(), arg7, arg8);
            } else {
                0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_loan<T1, T2>(arg4, arg3, 0x2::balance::zero<T1>(), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T2>, 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::acl::Access>(&mut arg2, v0, b"funds"), arg7, arg8);
            };
        };
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg2);
    }

    fun sui_amount_to_lst_amount<T0>(arg0: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: u64) : u64 {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T0>(arg0);
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T0>(arg0);
        if (v0 == 0 || v1 == 0) {
            return arg1
        };
        (((v1 as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

