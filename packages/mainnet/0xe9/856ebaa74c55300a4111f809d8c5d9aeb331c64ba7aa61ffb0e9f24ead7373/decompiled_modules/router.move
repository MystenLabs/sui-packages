module 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::router {
    entry fun add_liquidity<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg0);
        assert!(0x2::coin::value<T0>(&arg2) > 0 && 0x2::coin::value<T1>(&arg4) > 0, 600);
        let (v0, v1, v2, v3) = 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::add_liquidity<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v4 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::LP<T0, T1>>>(v4, 0x2::tx_context::sender(arg6));
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_liqudity_added(0x2::object::id<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>>(arg1), v1, v2, 0x2::coin::value<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::LP<T0, T1>>(&v4), v3);
    }

    entry fun create_pool<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg1: &0x2::clock::Clock, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u32, arg4: &0x2::coin::CoinMetadata<T1>, arg5: u32, arg6: u64, arg7: bool, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg0);
        assert!(is_type_sorted<T0, T1>(), 602);
        assert!(!0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::exist<T0, T1>(arg0), 601);
        let v0 = 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::create_pool<T0, T1>(arg1, 0x2::coin::get_symbol<T0>(arg2), 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg2)), arg3, 0x2::coin::get_symbol<T1>(arg4), 0x2::math::pow(10, 0x2::coin::get_decimals<T1>(arg4)), arg5, arg6, arg7, arg8, arg9, arg10);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::add<T0, T1>(arg0, v0);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_pool_created(v0, 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::get_name<T0>(), 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::get_name<T1>());
    }

    entry fun set_blacklist<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::PoolOwner<T0, T1>, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg2: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg3: u8, arg4: address) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg1);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::set_blacklist<T0, T1>(arg2, arg3, arg4);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_pool_blacklist_set(0x2::object::id<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>>(arg2), arg3, arg4);
    }

    entry fun swap_x_to_y<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 604);
        let (v1, v2) = 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::swap_x_to_y<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg5));
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_swap(0x2::object::id<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>>(arg1), 0x2::tx_context::sender(arg5), v0, 0, 0, 0x2::coin::value<T1>(&v3), v2);
    }

    entry fun swap_y_to_x<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg0);
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0, 604);
        let (v1, v2) = 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::swap_y_to_x<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg5));
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_swap(0x2::object::id<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>>(arg1), 0x2::tx_context::sender(arg5), 0, 0x2::coin::value<T0>(&v3), v0, 0, v2);
    }

    entry fun update_pool_fee<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::PoolOwner<T0, T1>, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg2: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u32, arg5: u32) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg1);
        let (v0, v1, v2, v3) = 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::update_pool_fee<T0, T1>(arg2, arg4, arg5);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_pool_fee_config_updated(0x2::object::id<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>>(arg2), v0, v1, v2, v3, 0x2::clock::timestamp_ms(arg3));
    }

    fun is_type_sorted<T0, T1>() : bool {
        let v0 = 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::comparator::compare_u8_vector(0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::get_name_u8array<T0>(), 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::get_name_u8array<T1>());
        assert!(!0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::comparator::is_equal(&v0), 605);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::comparator::is_smaller_than(&v0)
    }

    entry fun lock_lp<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::LP<T0, T1>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg0);
        assert!(arg4 > 0 && arg4 > 0x2::clock::timestamp_ms(arg2), 608);
        let v0 = 0x2::coin::value<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::LP<T0, T1>>(&arg3);
        assert!(v0 > 0, 609);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::lp_lock<T0, T1>(arg1, arg3, 0x2::clock::timestamp_ms(arg2), arg4, arg5);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_lp_locked(0x2::tx_context::sender(arg5), v0, arg4);
    }

    entry fun remove_liquidity<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::LP<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg0);
        assert!(0x2::coin::value<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::LP<T0, T1>>(&arg2) > 0, 603);
        let (v0, v1, v2, v3) = 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::remove_liqudity<T0, T1>(arg1, arg2, arg3);
        let v4 = v2;
        let v5 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg3));
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_liqudity_removed(0x2::object::id<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>>(arg1), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), v0, v3);
    }

    entry fun set_whitelist<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::PoolOwner<T0, T1>, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg2: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg3: u8, arg4: address) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg1);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::set_whilelist<T0, T1>(arg2, arg3, arg4);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_pool_whitelist_set(0x2::object::id<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>>(arg2), arg3, arg4);
    }

    entry fun unlock_delay<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::LPLockOwner<T0, T1>, arg2: u64) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg0);
        assert!(arg2 > 0, 610);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_lp_unlock_delay(0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::lp_lock_delay<T0, T1>(arg1, arg2));
    }

    entry fun unlock_lp<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg2: 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::LPLockOwner<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg0);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_lp_unlocked(0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::lp_unlock<T0, T1>(arg3, arg1, arg2, arg4));
    }

    entry fun update_trading_time<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::PoolOwner<T0, T1>, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg2: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg1);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::set_trading_time<T0, T1>(arg2, arg3, arg4);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_pool_tradingtime_change(0x2::object::id<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>>(arg2), arg4);
    }

    entry fun withdraw<T0, T1>(arg0: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::PoolOwner<T0, T1>, arg1: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::Store, arg2: &mut 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::control::check_version(arg1);
        let (v0, v1) = 0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::withdraw_pool_fee<T0, T1>(arg2, arg4);
        let v2 = v1;
        let v3 = v0;
        if (arg3 == @0x0) {
            arg3 = 0x2::tx_context::sender(arg4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, arg3);
        0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::events::emit_pool_fee_withdraw(0x2::object::id<0xe9856ebaa74c55300a4111f809d8c5d9aeb331c64ba7aa61ffb0e9f24ead7373::pool::Pool<T0, T1>>(arg2), 0x2::coin::value<T0>(&v3), 0x2::coin::value<T1>(&v2), arg3);
    }

    // decompiled from Move bytecode v6
}

