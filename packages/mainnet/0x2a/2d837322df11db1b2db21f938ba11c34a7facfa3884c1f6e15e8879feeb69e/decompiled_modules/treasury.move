module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::treasury {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        balance: 0x2::balance::Balance<T0>,
        history: 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec::TableVec<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>,
        deposit_guard: 0x1::option::Option<address>,
        withdraw_guard: 0x2::vec_map::VecMap<address, u64>,
        withdraw_mode: u8,
        inflow: u128,
        outflow: u128,
        permission: address,
    }

    public fun new<T0>(arg0: 0x1::string::String, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) : Treasury<T0> {
        let v0 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission>(arg1);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg1, &v0, 700, arg2);
        new_imp<T0>(&arg0, &v0, arg2)
    }

    public fun ASSERT_WITHDRAW_MODE_GUARD_ONLY<T0>(arg0: &Treasury<T0>) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::ONLY_GUARD(arg0.withdraw_mode == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_GUARD_ONLY());
    }

    public fun atLeast_record<T0>(arg0: &Treasury<T0>, arg1: u8, arg2: &0x1::option::Option<address>, arg3: &0x1::option::Option<address>, arg4: bool, arg5: u8) : bool {
        let v0 = 0;
        let v1 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec::length<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&arg0.history);
        while (v1 > 0) {
            if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Is_record(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&arg0.id, &arg0.history, v1 - 1), arg1, arg2, arg3, arg4)) {
                v0 = v0 + 1;
            };
            if (v0 >= (arg5 as u16)) {
                return true
            };
            v1 = v1 - 1;
        };
        false
    }

    public fun create<T0>(arg0: Treasury<T0>) : address {
        0x2::transfer::share_object<Treasury<T0>>(arg0);
        0x2::object::id_address<Treasury<T0>>(&arg0)
    }

    public fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::option::Option<address>, arg5: &0x2::clock::Clock, arg6: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg7: &mut 0x2::tx_context::TxContext) : address {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg6, &arg0.permission, 702, arg7);
        let v0 = 0x1::option::none<address>();
        deposit_imp<T0>(arg0, arg1, arg2, &arg3, &arg4, &v0, arg5, arg7)
    }

    public fun deposit_forGuard<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::option::Option<address>, arg5: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg6: &0x2::clock::Clock, arg7: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg8: &mut 0x2::tx_context::TxContext) : address {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg7, &arg0.permission, 702, arg8);
        let v0 = 0x1::option::some<address>(0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg5));
        deposit_imp<T0>(arg0, arg1, arg2, &arg3, &arg4, &v0, arg6, arg8)
    }

    public fun deposit_forGuard_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::option::Option<address>, arg6: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg7: &0x2::clock::Clock, arg8: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg9: &mut 0x2::tx_context::TxContext) : address {
        if (0x1::option::is_some<address>(&arg1.deposit_guard) && 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::USE_PASSPORT(0x1::option::borrow<address>(&arg1.deposit_guard), arg0, arg9)) {
            let v0 = 0x1::option::none<address>();
            return deposit_imp<T0>(arg1, arg2, arg3, &arg4, &arg5, &v0, arg7, arg9)
        };
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg8, &arg1.permission, 702, arg9);
        let v1 = 0x1::option::some<address>(0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg6));
        deposit_imp<T0>(arg1, arg2, arg3, &arg4, &arg5, &v1, arg7, arg9)
    }

    public fun deposit_guard_none<T0>(arg0: &mut Treasury<T0>, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg1, &arg0.permission, 705, arg2);
        deposit_guard_none_imp<T0>(arg0);
    }

    fun deposit_guard_none_imp<T0>(arg0: &mut Treasury<T0>) {
        arg0.deposit_guard = 0x1::option::none<address>();
    }

    public fun deposit_guard_none_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 705, arg3);
        deposit_guard_none_imp<T0>(arg1);
    }

    public fun deposit_guard_set<T0>(arg0: &mut Treasury<T0>, arg1: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 705, arg3);
        deposit_guard_set_imp<T0>(arg0, arg1);
    }

    fun deposit_guard_set_imp<T0>(arg0: &mut Treasury<T0>, arg1: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard) {
        arg0.deposit_guard = 0x1::option::some<address>(0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg1));
    }

    public fun deposit_guard_set_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 705, arg4);
        deposit_guard_set_imp<T0>(arg1, arg2);
    }

    fun deposit_imp<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x1::string::String, arg4: &0x1::option::Option<address>, arg5: &0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_U64_ADD_UPFLOW(0x2::balance::value<T0>(&arg0.balance), v0);
        let v1 = 0x2::object::id_address<Treasury<T0>>(arg0);
        let v2 = 0x1::option::none<address>();
        let v3 = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::create_fromObject2<T0>(&v1, 0x2::coin::value<T0>(&arg1), arg4, arg5, arg2, arg3, &v2, arg6, arg7);
        let v4 = 0x1::option::none<address>();
        let v5 = 0x2::tx_context::sender(arg7);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec::push_back<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&mut arg0.id, &mut arg0.history, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_new(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::OP_DEPOSIT(), &v3, &v4, v0, 0x2::clock::timestamp_ms(arg6), &v5));
        arg0.inflow = arg0.inflow + (v0 as u128);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        v3
    }

    public fun deposit_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg8: &mut 0x2::tx_context::TxContext) : address {
        if (0x1::option::is_some<address>(&arg1.deposit_guard) && 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::USE_PASSPORT(0x1::option::borrow<address>(&arg1.deposit_guard), arg0, arg8)) {
            let v0 = 0x1::option::none<address>();
            return deposit_imp<T0>(arg1, arg2, arg3, &arg4, &arg5, &v0, arg6, arg8)
        };
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg7, &arg1.permission, 702, arg8);
        let v1 = 0x1::option::none<address>();
        deposit_imp<T0>(arg1, arg2, arg3, &arg4, &arg5, &v1, arg6, arg8)
    }

    public fun description_set<T0>(arg0: &mut Treasury<T0>, arg1: 0x1::string::String, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 704, arg3);
        description_set_imp<T0>(arg0, &arg1);
    }

    fun description_set_imp<T0>(arg0: &mut Treasury<T0>, arg1: &0x1::string::String) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg1);
        arg0.description = *arg1;
    }

    public fun description_set_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: 0x1::string::String, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 704, arg4);
        description_set_imp<T0>(arg1, &arg2);
    }

    public fun guard_query<T0>(arg0: &Treasury<T0>, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport) {
        let v0 = 0x2::object::id_address<Treasury<T0>>(arg0);
        let (v1, v2, _) = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 1400) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &arg0.permission);
        } else if (v2 == 1401) {
            let v4 = 0x2::balance::value<T0>(&arg0.balance);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v4);
        } else if (v2 == 1402) {
            let v5 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec::length<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&arg0.history);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v5);
        } else if (v2 == 1403) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u128>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U128(), &arg0.inflow);
        } else if (v2 == 1404) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u128>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U128(), &arg0.outflow);
        } else if (v2 == 1405) {
            let v6 = 0x1::option::is_some<address>(&arg0.deposit_guard);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v6);
        } else if (v2 == 1406) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.deposit_guard));
        } else if (v2 == 1407) {
            let v7 = 0x2::vec_map::size<address, u64>(&arg0.withdraw_guard);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v7);
        } else if (v2 == 1408) {
            let v8 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            let v9 = 0x2::vec_map::contains<address, u64>(&arg0.withdraw_guard, &v8);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v9);
        } else if (v2 == 1409) {
            let v10 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), 0x2::vec_map::get<address, u64>(&arg0.withdraw_guard, &v10));
        } else if (v2 == 1410) {
            let v11 = 0x1::option::none<address>();
            let v12 = 0x1::option::none<address>();
            let v13 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v11, &v12, true);
            let v14 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_time(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v13));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v14);
        } else if (v2 == 1411) {
            let v15 = 0x1::option::none<address>();
            let v16 = 0x1::option::none<address>();
            let v17 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v15, &v16, true);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_signer(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v17)));
        } else if (v2 == 1412) {
            let v18 = 0x1::option::none<address>();
            let v19 = 0x1::option::none<address>();
            let v20 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v18, &v19, true);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_payment(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v20)));
        } else if (v2 == 1413) {
            let v21 = 0x1::option::none<address>();
            let v22 = 0x1::option::none<address>();
            let v23 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v21, &v22, true);
            let v24 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_amount(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v23));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v24);
        } else if (v2 == 1414) {
            let v25 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v26 = 0x1::option::none<address>();
            let v27 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v25, &v26, true);
            let v28 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_time(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v27));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v28);
        } else if (v2 == 1415) {
            let v29 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v30 = 0x1::option::none<address>();
            let v31 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v29, &v30, true);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_signer(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v31)));
        } else if (v2 == 1416) {
            let v32 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v33 = 0x1::option::none<address>();
            let v34 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v32, &v33, true);
            let v35 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_amount(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v34));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v35);
        } else if (v2 == 1417) {
            let v36 = 0x1::option::none<address>();
            let v37 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v38 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v36, &v37, true);
            let v39 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_time(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v38));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v39);
        } else if (v2 == 1418) {
            let v40 = 0x1::option::none<address>();
            let v41 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v42 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v40, &v41, true);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_payment(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v42)));
        } else if (v2 == 1419) {
            let v43 = 0x1::option::none<address>();
            let v44 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v45 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v43, &v44, true);
            let v46 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_amount(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v45));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v46);
        } else if (v2 == 1420) {
            let v47 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v48 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v49 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v47, &v48, true);
            let v50 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_time(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v49));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v50);
        } else if (v2 == 1421) {
            let v51 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v52 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v53 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v51, &v52, true);
            let v54 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_amount(0x1::option::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v53));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v54);
        } else if (v2 == 1422) {
            let v55 = 0x1::option::none<address>();
            let v56 = 0x1::option::none<address>();
            let v57 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v55, &v56, true);
            let v58 = 0x1::option::is_some<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v57);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v58);
        } else if (v2 == 1423) {
            let v59 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v60 = 0x1::option::none<address>();
            let v61 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v59, &v60, true);
            let v62 = 0x1::option::is_some<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v61);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v62);
        } else if (v2 == 1424) {
            let v63 = 0x1::option::none<address>();
            let v64 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v65 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v63, &v64, true);
            let v66 = 0x1::option::is_some<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v65);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v66);
        } else if (v2 == 1425) {
            let v67 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v68 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v69 = recent_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v67, &v68, true);
            let v70 = 0x1::option::is_some<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v69);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v70);
        } else if (v2 == 1426) {
            let v71 = 0x1::option::none<address>();
            let v72 = 0x1::option::none<address>();
            let v73 = atLeast_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v71, &v72, true, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v73);
        } else if (v2 == 1427) {
            let v74 = 0x1::option::none<address>();
            let v75 = 0x1::option::some<address>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            let v76 = atLeast_record<T0>(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1), &v74, &v75, true, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v76);
        } else if (v2 == 1428) {
            let v77 = 0x1::type_name::get<T0>();
            let v78 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v77));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &v78);
        } else if (v2 == 1429) {
            let v79 = 0x1::type_name::get_with_original_ids<T0>();
            let v80 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v79));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &v80);
        } else if (v2 == 1430) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u8>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U8(), &arg0.withdraw_mode);
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::Q_CMD_NOT_MATCH();
        };
    }

    fun new_imp<T0>(arg0: &0x1::string::String, arg1: &address, arg2: &mut 0x2::tx_context::TxContext) : Treasury<T0> {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg0);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_address(&v0);
        Treasury<T0>{
            id             : v0,
            description    : *arg0,
            balance        : 0x2::balance::zero<T0>(),
            history        : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec::empty<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&v1),
            deposit_guard  : 0x1::option::none<address>(),
            withdraw_guard : 0x2::vec_map::empty<address, u64>(),
            withdraw_mode  : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_PERMISSION(),
            inflow         : 0,
            outflow        : 0,
            permission     : *arg1,
        }
    }

    public fun new_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: 0x1::string::String, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : Treasury<T0> {
        let v0 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission>(arg2);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &v0, 700, arg3);
        new_imp<T0>(&arg1, &v0, arg3)
    }

    public fun permission_set<T0>(arg0: &mut Treasury<T0>, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_CREATOR(arg1, arg3);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_ADMIN(arg2, arg3);
        arg0.permission = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission>(arg2);
    }

    public fun receive<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::transfer::Receiving<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::CoinWrapper<T0>>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::Payment<T0>, arg3: &0x2::clock::Clock, arg4: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg4, &arg0.permission, 701, arg5);
        receive_imp<T0>(arg0, arg1, arg2, arg3)
    }

    fun receive_imp<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::transfer::Receiving<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::CoinWrapper<T0>>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::Payment<T0>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::unwrap_assert<T0>(0x2::transfer::public_receive<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::CoinWrapper<T0>>(&mut arg0.id, arg1), arg2);
        let v1 = 0x2::coin::value<T0>(&v0);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_U64_ADD_UPFLOW(0x2::balance::value<T0>(&arg0.balance), v1);
        let v2 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::Payment<T0>>(arg2);
        let v3 = 0x1::option::none<address>();
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec::push_back<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&mut arg0.id, &mut arg0.history, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_new(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::OP_RECEIVE(), &v2, &v3, v1, 0x2::clock::timestamp_ms(arg3), 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::payment_signer<T0>(arg2)));
        arg0.inflow = arg0.inflow + (v1 as u128);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(v0))
    }

    public fun receive_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: 0x2::transfer::Receiving<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::CoinWrapper<T0>>, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::Payment<T0>, arg4: &0x2::clock::Clock, arg5: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, &arg1.permission, 701, arg6);
        receive_imp<T0>(arg1, arg2, arg3, arg4)
    }

    public fun recent_record<T0>(arg0: &Treasury<T0>, arg1: u8, arg2: &0x1::option::Option<address>, arg3: &0x1::option::Option<address>, arg4: bool) : 0x1::option::Option<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record> {
        let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec::length<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&arg0.history);
        while (v0 > 0) {
            let v1 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec::borrow<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&arg0.id, &arg0.history, v0 - 1);
            if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Is_record(v1, arg1, arg2, arg3, arg4)) {
                return 0x1::option::some<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(*v1)
            };
            v0 = v0 - 1;
        };
        0x1::option::none<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>()
    }

    public fun withdraw<T0>(arg0: &mut Treasury<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg8: &mut 0x2::tx_context::TxContext) : address {
        let v0 = arg0.withdraw_mode == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_BOTH() || arg0.withdraw_mode == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_PERMISSION();
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::ONLY_GUARD_MODE(v0);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg7, &arg0.permission, 703, arg8);
        let v1 = 0x1::option::none<address>();
        let v2 = 0x1::option::none<address>();
        withdraw_imp<T0>(arg0, &arg1, &arg2, arg3, &arg4, &arg5, &v1, &v2, arg6, arg8)
    }

    public fun withdraw_forGuard<T0>(arg0: &mut Treasury<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::option::Option<address>, arg6: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg7: &0x2::clock::Clock, arg8: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg9: &mut 0x2::tx_context::TxContext) : address {
        let v0 = arg0.withdraw_mode == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_BOTH() || arg0.withdraw_mode == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_PERMISSION();
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::ONLY_GUARD_MODE(v0);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg8, &arg0.permission, 703, arg9);
        let v1 = 0x1::option::some<address>(0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg6));
        let v2 = 0x1::option::none<address>();
        withdraw_imp<T0>(arg0, &arg1, &arg2, arg3, &arg4, &arg5, &v1, &v2, arg7, arg9)
    }

    public fun withdraw_forGuard_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::option::Option<address>, arg7: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg8: &0x2::clock::Clock, arg9: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg10: &mut 0x2::tx_context::TxContext) : address {
        let v0 = arg1.withdraw_mode == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_BOTH() || arg1.withdraw_mode == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_PERMISSION();
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::ONLY_GUARD_MODE(v0);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg9, &arg1.permission, 703, arg10);
        let v1 = 0x1::option::some<address>(0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg7));
        let v2 = 0x1::option::none<address>();
        withdraw_imp<T0>(arg1, &arg2, &arg3, arg4, &arg5, &arg6, &v1, &v2, arg8, arg10)
    }

    public fun withdraw_guard_add<T0>(arg0: &mut Treasury<T0>, arg1: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg2: u64, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg3, &arg0.permission, 707, arg4);
        withdraw_guard_add_imp<T0>(arg0, arg1, arg2);
    }

    fun withdraw_guard_add_imp<T0>(arg0: &mut Treasury<T0>, arg1: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg2: u64) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::IMMUTABLE(arg0.withdraw_mode != 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_GUARD_ONLY());
        let v0 = 0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg1);
        if (0x2::vec_map::contains<address, u64>(&arg0.withdraw_guard, &v0)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.withdraw_guard, &v0) = arg2;
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::GUARD_COUNT(0x2::vec_map::size<address, u64>(&arg0.withdraw_guard));
            0x2::vec_map::insert<address, u64>(&mut arg0.withdraw_guard, v0, arg2);
        };
    }

    public fun withdraw_guard_add_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg3: u64, arg4: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 707, arg5);
        withdraw_guard_add_imp<T0>(arg1, arg2, arg3);
    }

    public fun withdraw_guard_remove<T0>(arg0: &mut Treasury<T0>, arg1: vector<address>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 707, arg3);
        withdraw_guard_remove_imp<T0>(arg0, &arg1);
    }

    public fun withdraw_guard_remove_all<T0>(arg0: &mut Treasury<T0>, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg1, &arg0.permission, 707, arg2);
        withdraw_guard_remove_all_imp<T0>(arg0);
    }

    fun withdraw_guard_remove_all_imp<T0>(arg0: &mut Treasury<T0>) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::IMMUTABLE(arg0.withdraw_mode != 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_GUARD_ONLY());
        arg0.withdraw_guard = 0x2::vec_map::empty<address, u64>();
    }

    public fun withdraw_guard_remove_all_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 707, arg3);
        withdraw_guard_remove_all_imp<T0>(arg1);
    }

    fun withdraw_guard_remove_imp<T0>(arg0: &mut Treasury<T0>, arg1: &vector<address>) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::IMMUTABLE(arg0.withdraw_mode != 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_GUARD_ONLY());
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            let v1 = 0x1::vector::borrow<address>(arg1, v0);
            if (0x2::vec_map::contains<address, u64>(&arg0.withdraw_guard, v1)) {
                let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.withdraw_guard, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun withdraw_guard_remove_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: vector<address>, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 707, arg4);
        withdraw_guard_remove_imp<T0>(arg1, &arg2);
    }

    fun withdraw_imp<T0>(arg0: &mut Treasury<T0>, arg1: &vector<address>, arg2: &vector<u64>, arg3: u64, arg4: &0x1::string::String, arg5: &0x1::option::Option<address>, arg6: &0x1::option::Option<address>, arg7: &0x1::option::Option<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        while (v1 < 0x1::vector::length<u64>(arg2)) {
            let v3 = 0x1::vector::borrow<u64>(arg2, v1);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_U64_SUB_UPFLOW(0x2::balance::value<T0>(&arg0.balance), *v3);
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, *v3), arg9));
            v0 = v0 + *v3;
            v1 = v1 + 1;
        };
        if (0x1::option::is_some<address>(arg7)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::MAX(*0x2::vec_map::get<address, u64>(&arg0.withdraw_guard, 0x1::option::borrow<address>(arg7)) >= v0);
        };
        let v4 = 0x1::option::some<address>(0x2::object::id_address<Treasury<T0>>(arg0));
        let v5 = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::create_fromObject<T0>(arg1, &mut v2, arg5, arg6, arg3, arg4, &v4, arg8, arg9);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(v2);
        let v6 = 0x2::tx_context::sender(arg9);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table_vec::push_back<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record>(&mut arg0.id, &mut arg0.history, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::Record_new(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::OP_WITHDRAW(), &v5, arg7, v0, 0x2::clock::timestamp_ms(arg8), &v6));
        arg0.outflow = arg0.outflow + (v0 as u128);
        v5
    }

    public fun withdraw_mode_set<T0>(arg0: &mut Treasury<T0>, arg1: u8, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 706, arg3);
        withdraw_mode_set_imp<T0>(arg0, arg1);
    }

    fun withdraw_mode_set_imp<T0>(arg0: &mut Treasury<T0>, arg1: u8) {
        if (arg0.withdraw_mode == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_GUARD_ONLY()) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::IMMUTABLE(arg1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_GUARD_ONLY());
        } else {
            if (arg1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_GUARD_ONLY()) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::GUARD_NONE(0x2::vec_map::size<address, u64>(&arg0.withdraw_guard) > 0);
            } else {
                let v0 = arg1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_BOTH() || arg1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_PERMISSION();
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::MODE(v0);
            };
            arg0.withdraw_mode = arg1;
        };
    }

    public fun withdraw_mode_set_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: u8, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 706, arg4);
        withdraw_mode_set_imp<T0>(arg1, arg2);
    }

    public fun withdraw_useGuard<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg9: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg8);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::NOT_FOUND(0x2::vec_map::contains<address, u64>(&arg1.withdraw_guard, &v0));
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ASSERT_PASSPORT(&v0, arg0, arg9);
        let v1 = 0x1::option::none<address>();
        let v2 = 0x1::option::some<address>(v0);
        withdraw_imp<T0>(arg1, &arg2, &arg3, arg4, &arg5, &arg6, &v1, &v2, arg7, arg9)
    }

    public fun withdraw_useGuard_forGuard<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::option::Option<address>, arg7: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg8: &0x2::clock::Clock, arg9: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg10: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg9);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::NOT_FOUND(0x2::vec_map::contains<address, u64>(&arg1.withdraw_guard, &v0));
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ASSERT_PASSPORT(&v0, arg0, arg10);
        let v1 = 0x1::option::some<address>(0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg7));
        let v2 = 0x1::option::some<address>(v0);
        withdraw_imp<T0>(arg1, &arg2, &arg3, arg4, &arg5, &arg6, &v1, &v2, arg8, arg10)
    }

    public fun withdraw_with_passport<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Treasury<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg9: &mut 0x2::tx_context::TxContext) : address {
        let v0 = arg1.withdraw_mode == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_BOTH() || arg1.withdraw_mode == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::WITHDRAW_MODE_PERMISSION();
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::treasury::ONLY_GUARD_MODE(v0);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg8, &arg1.permission, 703, arg9);
        let v1 = 0x1::option::none<address>();
        let v2 = 0x1::option::none<address>();
        withdraw_imp<T0>(arg1, &arg2, &arg3, arg4, &arg5, &arg6, &v1, &v2, arg7, arg9)
    }

    // decompiled from Move bytecode v6
}

