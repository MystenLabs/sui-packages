module 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        x_reserve: 0x2::balance::Balance<T0>,
        x_coin_scale: u64,
        x_pool_rate: u32,
        x_pool_fee: 0x2::balance::Balance<T0>,
        x_transaction_fee: 0x2::balance::Balance<T0>,
        y_reserve: 0x2::balance::Balance<T1>,
        y_coin_scale: u64,
        y_pool_rate: u32,
        y_pool_fee: 0x2::balance::Balance<T1>,
        y_transaction_fee: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        lp_dead: 0x2::balance::Balance<LP<T0, T1>>,
        lp_locked: 0x2::balance::Balance<LP<T0, T1>>,
        lp_lock_data: vector<0x2::object::ID>,
        tx_count: u64,
        create_time: u64,
        trading_time: u64,
        can_change_fee: bool,
        can_whitelist: bool,
        whitelist: 0x2::table::Table<address, bool>,
        can_blacklist: bool,
        blacklist: 0x2::table::Table<address, bool>,
    }

    struct PoolOwner<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct LPLockOwner<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lock_amount: u64,
        lock_time: u64,
        expired_time: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP<T0, T1>>, u64, u64, u64) {
        let (v0, v1, v2) = get_reserves_size<T0, T1>(arg0);
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = 0x2::coin::into_balance<T1>(arg3);
        let v6 = 0x2::balance::value<T1>(&v5);
        let (v7, v8) = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::tools::calc_optimal_values(v4, v6, arg2, arg4, v0, v1);
        let v9 = if (v2 == 0) {
            let v10 = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::maths::sqrt(0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::maths::mul_to_u128(v7, v8));
            assert!(v10 > 1000, 505);
            0x2::balance::join<LP<T0, T1>>(&mut arg0.lp_dead, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, 1000));
            v10 - 1000
        } else {
            let v11 = (v2 as u128) * (v7 as u128) / (v0 as u128);
            let v12 = (v2 as u128) * (v8 as u128) / (v1 as u128);
            if (v11 < v12) {
                assert!(v11 < (18446744073709551615 as u128), 501);
                (v11 as u64)
            } else {
                assert!(v12 < (18446744073709551615 as u128), 501);
                (v12 as u64)
            }
        };
        assert!(v9 > 0, 506);
        if (v7 < v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v4 - v7), arg5), 0x2::tx_context::sender(arg5));
        };
        if (v8 < v6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v6 - v8), arg5), 0x2::tx_context::sender(arg5));
        };
        assert!(0x2::balance::join<T0>(&mut arg0.x_reserve, v3) < 1844674407370955, 507);
        assert!(0x2::balance::join<T1>(&mut arg0.y_reserve, v5) < 1844674407370955, 507);
        arg0.tx_count = arg0.tx_count + 1;
        (0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v9), arg5), v7, v8, arg0.tx_count)
    }

    public fun create_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: u64, arg2: u32, arg3: u64, arg4: u32, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id                : 0x2::object::new(arg9),
            x_reserve         : 0x2::balance::zero<T0>(),
            x_coin_scale      : arg1,
            x_pool_rate       : arg2,
            x_pool_fee        : 0x2::balance::zero<T0>(),
            x_transaction_fee : 0x2::balance::zero<T0>(),
            y_reserve         : 0x2::balance::zero<T1>(),
            y_coin_scale      : arg3,
            y_pool_rate       : arg4,
            y_pool_fee        : 0x2::balance::zero<T1>(),
            y_transaction_fee : 0x2::balance::zero<T1>(),
            lp_supply         : 0x2::balance::create_supply<LP<T0, T1>>(v0),
            lp_dead           : 0x2::balance::zero<LP<T0, T1>>(),
            lp_locked         : 0x2::balance::zero<LP<T0, T1>>(),
            lp_lock_data      : 0x1::vector::empty<0x2::object::ID>(),
            tx_count          : 0,
            create_time       : 0x2::clock::timestamp_ms(arg0),
            trading_time      : arg5,
            can_change_fee    : arg6,
            can_whitelist     : arg7,
            whitelist         : 0x2::table::new<address, bool>(arg9),
            can_blacklist     : arg8,
            blacklist         : 0x2::table::new<address, bool>(arg9),
        };
        let v2 = 0x2::object::id<Pool<T0, T1>>(&v1);
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
        let v3 = PoolOwner<T0, T1>{
            id      : 0x2::object::new(arg9),
            pool_id : v2,
        };
        0x2::transfer::public_transfer<PoolOwner<T0, T1>>(v3, 0x2::tx_context::sender(arg9));
        v2
    }

    fun get_reserves_size<T0, T1>(arg0: &mut Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.x_reserve), 0x2::balance::value<T1>(&arg0.y_reserve), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun lp_lock<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = LPLockOwner<T0, T1>{
            id           : 0x2::object::new(arg4),
            pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
            lock_amount  : v0,
            lock_time    : arg2,
            expired_time : arg3,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.lp_lock_data, 0x2::object::id<LPLockOwner<T0, T1>>(&v1));
        0x2::balance::join<LP<T0, T1>>(&mut arg0.lp_locked, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        0x2::transfer::public_transfer<LPLockOwner<T0, T1>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun lp_lock_delay<T0, T1>(arg0: &mut LPLockOwner<T0, T1>, arg1: u64) : u64 {
        assert!(arg1 > arg0.expired_time, 541);
        arg0.expired_time = arg1;
        arg0.expired_time
    }

    public fun lp_unlock<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Pool<T0, T1>, arg2: LPLockOwner<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2.expired_time <= 0x2::clock::timestamp_ms(arg0), 540);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::take<LP<T0, T1>>(&mut arg1.lp_locked, arg2.lock_amount, arg3), 0x2::tx_context::sender(arg3));
        let v0 = 0x2::object::id<LPLockOwner<T0, T1>>(&arg2);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg1.lp_lock_data, &v0);
        if (v1) {
            0x1::vector::remove<0x2::object::ID>(&mut arg1.lp_lock_data, v2);
        };
        let LPLockOwner {
            id           : v3,
            pool_id      : _,
            lock_amount  : _,
            lock_time    : _,
            expired_time : _,
        } = arg2;
        0x2::object::delete(v3);
        arg2.lock_amount
    }

    fun pre_check<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.trading_time > 0) {
            assert!(arg0.trading_time <= 0x2::clock::timestamp_ms(arg1), 513);
        };
        if (arg0.can_blacklist) {
            assert!(!0x2::table::contains<address, bool>(&arg0.blacklist, 0x2::tx_context::sender(arg2)), 531);
        };
    }

    public fun remove_liqudity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0);
        let v4 = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::maths::mul_div(v1, v0, v3);
        let v5 = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::maths::mul_div(v2, v0, v3);
        assert!(v4 > 0 && v5 > 0, 508);
        (0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1)), 0x2::coin::take<T0>(&mut arg0.x_reserve, v4, arg2), 0x2::coin::take<T1>(&mut arg0.y_reserve, v5, arg2), arg0.tx_count)
    }

    public fun set_blacklist<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u8, arg2: address) {
        assert!(arg0.can_blacklist, 533);
        let v0 = &mut arg0.blacklist;
        set_table_list(v0, arg1, arg2);
    }

    fun set_table_list(arg0: &mut 0x2::table::Table<address, bool>, arg1: u8, arg2: address) {
        if (arg1 == 1) {
            if (!0x2::table::contains<address, bool>(arg0, arg2)) {
                0x2::table::add<address, bool>(arg0, arg2, true);
            };
        } else if (arg1 == 2) {
            if (0x2::table::contains<address, bool>(arg0, arg2)) {
                0x2::table::remove<address, bool>(arg0, arg2);
            };
        };
    }

    public fun set_trading_time<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) {
        assert!(arg0.trading_time == 0 || arg0.trading_time > 0x2::clock::timestamp_ms(arg1), 520);
        arg0.trading_time = arg2;
    }

    public fun set_whilelist<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u8, arg2: address) {
        assert!(arg0.can_whitelist, 532);
        let v0 = &mut arg0.whitelist;
        set_table_list(v0, arg1, arg2);
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        pre_check<T0, T1>(arg0, arg1, arg4);
        let (v0, v1, _) = get_reserves_size<T0, T1>(arg0);
        assert!(v0 > 0 && v1 > 0, 509);
        let v3 = 0x2::coin::value<T0>(&arg2);
        let v4 = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::tools::get_fee(v3, 20, 10000);
        let v5 = if (arg0.x_pool_rate > 0) {
            0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::tools::get_fee(v3, arg0.x_pool_rate, 10000)
        } else {
            0
        };
        let v6 = v5;
        if (v5 > 0 && arg0.can_whitelist) {
            if (0x2::table::contains<address, bool>(&arg0.whitelist, 0x2::tx_context::sender(arg4))) {
                v6 = 0;
            };
        };
        let v7 = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::tools::calculate_amount_out(v0, v1, v3 - v4 - v6);
        assert!(v7 >= arg3, 510);
        let v8 = 0x2::coin::into_balance<T0>(arg2);
        if (v4 > 0) {
            0x2::balance::join<T0>(&mut arg0.x_transaction_fee, 0x2::balance::split<T0>(&mut v8, v4));
        };
        if (v6 > 0) {
            0x2::balance::join<T0>(&mut arg0.x_pool_fee, 0x2::balance::split<T0>(&mut v8, v6));
        };
        0x2::balance::join<T0>(&mut arg0.x_reserve, v8);
        let v9 = 0x2::coin::take<T1>(&mut arg0.y_reserve, v7, arg4);
        let (v10, v11, _) = get_reserves_size<T0, T1>(arg0);
        0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::tools::check_reserve_is_increased(v0, v1, v10, v11);
        if (arg0.trading_time == 0) {
            arg0.trading_time = 0x2::clock::timestamp_ms(arg1);
        };
        arg0.tx_count = arg0.tx_count + 1;
        (v9, arg0.tx_count)
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        pre_check<T0, T1>(arg0, arg1, arg4);
        let (v0, v1, _) = get_reserves_size<T0, T1>(arg0);
        assert!(v0 > 0 && v1 > 0, 509);
        let v3 = 0x2::coin::value<T1>(&arg2);
        let v4 = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::tools::get_fee(v3, 20, 10000);
        let v5 = if (arg0.y_pool_rate > 0) {
            0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::tools::get_fee(v3, arg0.x_pool_rate, 10000)
        } else {
            0
        };
        let v6 = v5;
        if (v5 > 0 && arg0.can_whitelist) {
            if (0x2::table::contains<address, bool>(&arg0.whitelist, 0x2::tx_context::sender(arg4))) {
                v6 = 0;
            };
        };
        let v7 = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::tools::calculate_amount_out(v1, v0, v3 - v4 - v6);
        assert!(v7 >= arg3, 510);
        let v8 = 0x2::coin::into_balance<T1>(arg2);
        if (v4 > 0) {
            0x2::balance::join<T1>(&mut arg0.y_transaction_fee, 0x2::balance::split<T1>(&mut v8, v4));
        };
        if (v6 > 0) {
            0x2::balance::join<T1>(&mut arg0.y_pool_fee, 0x2::balance::split<T1>(&mut v8, v6));
        };
        0x2::balance::join<T1>(&mut arg0.y_reserve, v8);
        let v9 = 0x2::coin::take<T0>(&mut arg0.x_reserve, v7, arg4);
        let (v10, v11, _) = get_reserves_size<T0, T1>(arg0);
        0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::tools::check_reserve_is_increased(v0, v1, v10, v11);
        if (arg0.trading_time == 0) {
            arg0.trading_time = 0x2::clock::timestamp_ms(arg1);
        };
        arg0.tx_count = arg0.tx_count + 1;
        (v9, arg0.tx_count)
    }

    public fun update_pool_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u32, arg2: u32) : (u32, u32, u32, u32) {
        assert!(arg0.can_change_fee, 530);
        assert!(arg1 < 1000, 512);
        assert!(arg2 < 1000, 512);
        arg0.x_pool_rate = arg1;
        arg0.y_pool_rate = arg2;
        (arg0.x_pool_rate, arg0.y_pool_rate, arg1, arg2)
    }

    public fun withdraw_pool_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg0.x_pool_fee);
        let v1 = 0x2::balance::value<T1>(&arg0.y_pool_fee);
        assert!(v0 > 0 && v1 > 0, 511);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.x_pool_fee, v0), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.y_pool_fee, v1), arg1))
    }

    public fun withdraw_transaction_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg0.x_transaction_fee);
        let v1 = 0x2::balance::value<T1>(&arg0.y_transaction_fee);
        assert!(v0 > 0 && v1 > 0, 511);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.x_transaction_fee, v0), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.y_transaction_fee, v1), arg1))
    }

    // decompiled from Move bytecode v6
}

