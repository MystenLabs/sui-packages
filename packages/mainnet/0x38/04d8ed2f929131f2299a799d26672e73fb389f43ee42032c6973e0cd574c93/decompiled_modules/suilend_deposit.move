module 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_deposit {
    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_amount: u64,
        vt_amount: u64,
        total_deposited: u64,
        total_borrowed: u64,
        total_vt_supply: u64,
    }

    fun calc_deposit_flash_loan_amount<T0, T1, T2>(arg0: u64, arg1: &0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::config::Config<T0, T1, T2>) : u64 {
        let (v0, v1) = 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::config::target_leverage<T0, T1, T2>(arg1);
        0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::utils::safe_mul_div(arg0, v0 - v1, v1)
    }

    public fun get_deposit_receipt<T0, T1, T2, T3>(arg0: &0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::Vault<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>, arg1: 0x2::balance::Balance<T0>, arg2: &0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Acl, arg3: &0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::AggregatorAcl, arg4: &0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::version::assert_current_version(arg4);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::access(arg2), 0x1::option::some<0x2::object::ID>(0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::access_id(arg3)), arg5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(&mut v1, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::access(arg2), b"deposit_balance", arg1);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(&mut v1, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::access(arg2), b"loan_amount", calc_deposit_flash_loan_amount<T0, T1, T2>(v0, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0)));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(&mut v1, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::access(arg2), b"loan_type", 0x1::type_name::get<T0>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(&mut v1, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::access(arg2), b"pool_id", *0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::get_extra_info<T0, T1, T3, vector<u8>, 0x2::object::ID>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::protocol_config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), b"pool_id"));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(&mut v1, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::access(arg2), b"vault_id", 0x2::object::id<0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::Vault<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>>(arg0));
        v1
    }

    public fun process_deposit_receipt<T0, T1, T2, T3>(arg0: &mut 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::Vault<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Acl, arg4: &0x2::clock::Clock, arg5: &0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::version::Version, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::version::assert_current_version(arg5);
        let v0 = 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::access(arg3);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(arg2, v0, b"vault_id") == 0x2::object::id<0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::Vault<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>>(arg0), 1);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(arg2, v0, b"deposit_balance");
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(arg2, v0, b"funds");
        let v3 = 0x2::balance::value<T0>(&v1);
        let v4 = 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::deposited<T0, T1, T3>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::protocol_config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1);
        let v5 = if (v4 > 0) {
            0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::utils::safe_mul_div(v3 + 0x2::balance::value<T0>(&v2), 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::config::total_vt_supply<T0, T1, T2>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0)), v4)
        } else {
            v3 + 0x2::balance::value<T0>(&v2)
        };
        0x2::balance::join<T0>(&mut v1, v2);
        0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::deposit<T0, T1, T3>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::protocol_config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), v1, arg1, arg4, arg6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T1>, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(arg2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::access(arg3), b"funds", 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::borrow<T0, T1, T3>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::protocol_config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::acl::Access>(arg2, v0, b"repay_amount"), arg1, arg4, arg6));
        let v6 = 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::config::mint_vt<T0, T1, T2>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::config_mut<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), v5, arg6);
        assert!(0x2::coin::value<T2>(&v6) > 0, 2);
        0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::config::assert_deposits_enabled<T0, T1, T2>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::deposited<T0, T1, T3>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::protocol_config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1));
        let v7 = DepositEvent{
            vault_id        : 0x2::object::id<0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::Vault<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>>(arg0),
            deposit_amount  : v3,
            vt_amount       : 0x2::coin::value<T2>(&v6),
            total_deposited : 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::deposited<T0, T1, T3>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::protocol_config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1),
            total_borrowed  : 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::borrowed<T0, T1, T3>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::protocol_config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1),
            total_vt_supply : 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::config::total_vt_supply<T0, T1, T2>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0)),
        };
        0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::event::emit<DepositEvent>(v7);
        0x2::coin::into_balance<T2>(v6)
    }

    // decompiled from Move bytecode v6
}

