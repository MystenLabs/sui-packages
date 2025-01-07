module 0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::wrapped_balance_manager {
    struct BalanceManagerRegistry has key {
        id: 0x2::object::UID,
        managers: 0x2::table::Table<address, WrappedBalanceManager>,
        sponsor_deep_amount: u64,
    }

    struct WrappedBalanceManager has store, key {
        id: 0x2::object::UID,
        sponsored_deep: u64,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
    }

    public fun deposit<T0>(arg0: &mut BalanceManagerRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::deep_infra::DeepSponsor, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.managers;
        create_manager_if_not_found(arg2, v0, arg0.sponsor_deep_amount, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(&mut 0x2::table::borrow_mut<address, WrappedBalanceManager>(&mut arg0.managers, 0x2::tx_context::sender(arg3)).balance_manager, arg1, arg3);
    }

    public fun withdraw<T0>(arg0: &mut BalanceManagerRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::table::contains<address, WrappedBalanceManager>(&arg0.managers, 0x2::tx_context::sender(arg2)), 1);
        let v0 = 0x2::table::borrow_mut<address, WrappedBalanceManager>(&mut arg0.managers, 0x2::tx_context::sender(arg2));
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            assert!(get_balance_internal<T0>(v0) - v0.sponsored_deep >= arg1, 2);
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(&mut v0.balance_manager, arg1, arg2)
    }

    public fun cancel_order<T0, T1>(arg0: &mut BalanceManagerRegistry, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, WrappedBalanceManager>(&arg0.managers, 0x2::tx_context::sender(arg4)), 1);
        let v0 = 0x2::table::borrow_mut<address, WrappedBalanceManager>(&mut arg0.managers, 0x2::tx_context::sender(arg4));
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut v0.balance_manager, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg1, &mut v0.balance_manager, &v1, arg2, arg3, arg4);
    }

    public fun place_limit_order<T0, T1>(arg0: &mut BalanceManagerRegistry, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::deep_infra::DeepSponsor, arg12: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let v0 = &mut arg0.managers;
        create_manager_if_not_found(arg11, v0, arg0.sponsor_deep_amount, arg12);
        let v1 = 0x2::table::borrow_mut<address, WrappedBalanceManager>(&mut arg0.managers, 0x2::tx_context::sender(arg12));
        let v2 = arg6;
        let (_, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        if (arg7 && 0x1::type_name::get<T1>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            let v6 = get_balance_internal<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v1) - v1.sponsored_deep;
            if (arg5 * arg6 > v6) {
                let v7 = v6 / arg5;
                v2 = v7 - v7 % v4;
            };
        } else if (!arg7 && 0x1::type_name::get<T0>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            let v8 = get_balance_internal<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v1) - v1.sponsored_deep;
            if (arg6 > v8) {
                v2 = v8 - v8 % v4;
            };
        };
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut v1.balance_manager, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, &mut v1.balance_manager, &v9, arg2, arg3, arg4, arg5, v2, arg7, arg8, arg9, arg10, arg12)
    }

    public fun place_market_order<T0, T1>(arg0: &mut BalanceManagerRegistry, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u8, arg4: u64, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::deep_infra::DeepSponsor, arg9: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let v0 = &mut arg0.managers;
        create_manager_if_not_found(arg8, v0, arg0.sponsor_deep_amount, arg9);
        let v1 = 0x2::table::borrow_mut<address, WrappedBalanceManager>(&mut arg0.managers, 0x2::tx_context::sender(arg9));
        if (arg5 && 0x1::type_name::get<T1>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            let (_, _, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg1, 1, arg7);
            let v6 = v4;
            assert!(*0x1::vector::borrow<u64>(&v6, 0) * arg4 <= get_balance_internal<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v1) - v1.sponsored_deep, 3);
        } else if (!arg5 && 0x1::type_name::get<T0>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            assert!(arg4 <= get_balance_internal<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v1) - v1.sponsored_deep, 3);
        };
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut v1.balance_manager, arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg1, &mut v1.balance_manager, &v7, arg2, arg3, arg4, arg5, arg6, arg7, arg9)
    }

    public fun create_manager(arg0: &mut BalanceManagerRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, WrappedBalanceManager>(&arg0.managers, 0x2::tx_context::sender(arg1)), 1);
        let v0 = WrappedBalanceManager{
            id              : 0x2::object::new(arg1),
            sponsored_deep  : 0,
            balance_manager : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg1),
        };
        0x2::table::add<address, WrappedBalanceManager>(&mut arg0.managers, 0x2::tx_context::sender(arg1), v0);
    }

    public(friend) fun create_manager_if_not_found(arg0: &mut 0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::deep_infra::DeepSponsor, arg1: &mut 0x2::table::Table<address, WrappedBalanceManager>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, WrappedBalanceManager>(arg1, 0x2::tx_context::sender(arg3))) {
            let v0 = WrappedBalanceManager{
                id              : 0x2::object::new(arg3),
                sponsored_deep  : arg2,
                balance_manager : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg3),
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v0.balance_manager, 0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::deep_infra::get_sponsored_deep(arg0, arg2, arg3), arg3);
            0x2::table::add<address, WrappedBalanceManager>(arg1, 0x2::tx_context::sender(arg3), v0);
        };
    }

    public fun get_balance<T0>(arg0: &BalanceManagerRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, WrappedBalanceManager>(&arg0.managers, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, WrappedBalanceManager>(&arg0.managers, arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&v0.balance_manager);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            if (v1 < v0.sponsored_deep) {
                0
            } else {
                v1 - v0.sponsored_deep
            }
        } else {
            v1
        }
    }

    public(friend) fun get_balance_internal<T0>(arg0: &WrappedBalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager)
    }

    public fun get_balance_manager(arg0: &BalanceManagerRegistry, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        &0x2::table::borrow<address, WrappedBalanceManager>(&arg0.managers, 0x2::tx_context::sender(arg1)).balance_manager
    }

    public fun get_locked_balance<T0, T1>(arg0: &BalanceManagerRegistry, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: address) : (u64, u64, u64) {
        if (!0x2::table::contains<address, WrappedBalanceManager>(&arg0.managers, arg2)) {
            return (0, 0, 0)
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T0, T1>(arg1, &0x2::table::borrow<address, WrappedBalanceManager>(&arg0.managers, arg2).balance_manager)
    }

    public fun get_manager_id(arg0: &BalanceManagerRegistry, arg1: address) : 0x2::object::ID {
        assert!(0x2::table::contains<address, WrappedBalanceManager>(&arg0.managers, arg1), 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(&0x2::table::borrow<address, WrappedBalanceManager>(&arg0.managers, arg1).balance_manager)
    }

    public fun get_open_orders<T0, T1>(arg0: &mut BalanceManagerRegistry, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: address) : 0x2::vec_set::VecSet<u128> {
        assert!(0x2::table::contains<address, WrappedBalanceManager>(&arg0.managers, arg2), 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, &0x2::table::borrow<address, WrappedBalanceManager>(&arg0.managers, arg2).balance_manager)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceManagerRegistry{
            id                  : 0x2::object::new(arg0),
            managers            : 0x2::table::new<address, WrappedBalanceManager>(arg0),
            sponsor_deep_amount : 100000000,
        };
        0x2::transfer::share_object<BalanceManagerRegistry>(v0);
    }

    public fun set_sponsor_deep_amount(arg0: &0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::admin::AdminCap, arg1: &mut BalanceManagerRegistry, arg2: u64) {
        arg1.sponsor_deep_amount = arg2;
    }

    public fun settle<T0, T1>(arg0: &mut BalanceManagerRegistry, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, WrappedBalanceManager>(&arg0.managers, 0x2::tx_context::sender(arg2))) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, WrappedBalanceManager>(&mut arg0.managers, 0x2::tx_context::sender(arg2));
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut v0.balance_manager, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg1, &mut v0.balance_manager, &v1);
    }

    public fun withdraw_sponsored_deep(arg0: &0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::admin::AdminCap, arg1: &mut BalanceManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(0x2::table::contains<address, WrappedBalanceManager>(&arg1.managers, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, WrappedBalanceManager>(&mut arg1.managers, arg2);
        let v1 = get_balance_internal<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0);
        let v2 = if (v1 > v0.sponsored_deep) {
            v0.sponsored_deep
        } else {
            v1
        };
        v0.sponsored_deep = v0.sponsored_deep - v2;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v0.balance_manager, v2, arg3)
    }

    // decompiled from Move bytecode v6
}

