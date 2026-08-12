module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl {
    struct Access has store, key {
        id: 0x2::object::UID,
    }

    struct Acl has key {
        id: 0x2::object::UID,
        access: Access,
    }

    public(friend) fun access(arg0: &Acl) : &Access {
        &arg0.access
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Access{id: 0x2::object::new(arg0)};
        let v1 = Acl{
            id     : 0x2::object::new(arg0),
            access : v0,
        };
        0x2::transfer::share_object<Acl>(v1);
    }

    public fun issue_migration_generic_close_receipt<T0, T1, T2, T3: store>(arg0: &Acl, arg1: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg2: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg3: u64, arg4: 0x2::object::ID, arg5: u128, arg6: u128, arg7: &0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::AggregatorAcl, arg8: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, T3>(arg1, arg2);
        let v0 = &arg0.access;
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<Access>(v0, 0x1::option::some<0x2::object::ID>(0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::access_id(arg7)), arg8);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, Access>(&mut v1, v0, b"slippage_up", arg5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, Access>(&mut v1, v0, b"slippage_down", arg6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, Access>(&mut v1, v0, b"amount", arg3);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, Access>(&mut v1, v0, b"input_type", 0x1::type_name::get<T0>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, Access>(&mut v1, v0, b"fix_input", false);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, Access>(&mut v1, v0, b"pool_id", arg4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, Access>(&mut v1, v0, b"flow_id", 1);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, Access>(&mut v1, v0, b"vault_id", 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>>(arg2));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, Access>(&mut v1, v0, b"expected_debt", arg3);
        v1
    }

    public fun issue_migration_reward_receipt<T0, T1, T2, T3: store, T4>(arg0: &Acl, arg1: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T4>, arg3: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg4: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg5: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_manager_v2<T0, T1, T2, T3>(arg1, arg5);
        assert!(!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg3), 202);
        let v0 = &arg0.access;
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<Access>(v0, 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg4)), arg5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, Access>(&mut v1, v0, b"flow_id", 3);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, Access>(&mut v1, v0, b"vault_id", 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, Access>(&mut v1, v0, b"reward_type", 0x1::type_name::get<T4>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, Access>(&mut v1, v0, b"input_amount", 0x2::coin::value<T4>(&arg2));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T4>, Access>(&mut v1, v0, b"funds", arg2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, Access>(&mut v1, v0, b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, Access>(&mut v1, v0, b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg3) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg3)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, Access>(&mut v1, v0, (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg3) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut arg3));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(arg3);
        v1
    }

    public fun issue_migration_spring_close_receipt<T0, T1, T2, T3: store>(arg0: &Acl, arg1: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg2: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg3: u64, arg4: 0x2::object::ID, arg5: &0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::AggregatorAcl, arg6: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, T3>(arg1, arg2);
        let v0 = &arg0.access;
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<Access>(v0, 0x1::option::some<0x2::object::ID>(0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::access_id(arg5)), arg6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, Access>(&mut v1, v0, b"loan_amount", arg3);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, Access>(&mut v1, v0, b"loan_type", 0x1::type_name::get<T1>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, Access>(&mut v1, v0, b"pool_id", arg4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, Access>(&mut v1, v0, b"flow_id", 2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, Access>(&mut v1, v0, b"vault_id", 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>>(arg2));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, Access>(&mut v1, v0, b"expected_debt", arg3);
        v1
    }

    public fun put_migration_close_repayment<T0, T1, T2, T3: store>(arg0: &Acl, arg1: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg2: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg3: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg4: 0x2::balance::Balance<T0>) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, T3>(arg1, arg2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, Access>(arg3, &arg0.access, b"funds", arg4);
    }

    public fun take_migration_close_inputs<T0, T1, T2, T3: store>(arg0: &Acl, arg1: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg2: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg3: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt) : (u64, 0x2::balance::Balance<T1>, u64) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_unwinding_v2<T0, T1, T2, T3>(arg1, arg2);
        let v0 = &arg0.access;
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, Access>(arg3, v0, b"flow_id");
        assert!(v1 == 1 || v1 == 2, 201);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, Access>(arg3, v0, b"vault_id") == 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>>(arg2), 200);
        (0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, Access>(arg3, v0, b"expected_debt"), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, Access>(arg3, v0, b"funds"), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, Access>(arg3, v0, b"repay_amount"))
    }

    public fun take_migration_reward_output<T0, T1, T2, T3: store>(arg0: &Acl, arg1: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>, arg2: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &0x2::tx_context::TxContext) : (0x1::type_name::TypeName, u64, 0x2::coin::Coin<T0>) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_assert_manager_v2<T0, T1, T2, T3>(arg1, arg3);
        let v0 = &arg0.access;
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, Access>(&mut arg2, v0, b"flow_id") == 3, 201);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, Access>(&mut arg2, v0, b"vault_id") == 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, T3>>(arg1), 200);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, Access>(&mut arg2, v0, b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, Access>(&mut arg2, v0, b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg2);
        (0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x1::type_name::TypeName, Access>(&mut arg2, v0, b"reward_type"), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, Access>(&mut arg2, v0, b"input_amount"), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, Access>(&mut arg2, v0, b"funds"))
    }

    // decompiled from Move bytecode v7
}

