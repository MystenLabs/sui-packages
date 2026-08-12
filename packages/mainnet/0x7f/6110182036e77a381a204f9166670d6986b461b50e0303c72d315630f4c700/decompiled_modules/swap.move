module 0x7f6110182036e77a381a204f9166670d6986b461b50e0303c72d315630f4c700::swap {
    struct SwapAdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
    }

    struct SwapPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        paused: bool,
        ast_decimals: u8,
        usdc_decimals: u8,
        ast_unit: u64,
        usdc_unit: u64,
        price_e8: u64,
        price_version: u64,
        ast_reserve: 0x2::balance::Balance<T0>,
        usdc_reserve: 0x2::balance::Balance<T1>,
        total_usdc_in: u128,
        total_ast_out: u128,
        total_ast_in: u128,
        total_usdc_out: u128,
    }

    struct SwapPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        ast_decimals: u8,
        usdc_decimals: u8,
        price_e8: u64,
        initial_ast_reserve: u64,
        initial_usdc_reserve: u64,
        timestamp_ms: u64,
    }

    struct SwapExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        direction: u8,
        amount_in: u64,
        amount_out: u64,
        price_e8: u64,
        price_version: u64,
        timestamp_ms: u64,
    }

    struct SwapPriceUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_price_e8: u64,
        new_price_e8: u64,
        price_version: u64,
        timestamp_ms: u64,
    }

    struct SwapPauseUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        timestamp_ms: u64,
    }

    struct SwapReserveUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        asset: u8,
        deposited: bool,
        amount: u64,
        reserve_after: u64,
        timestamp_ms: u64,
    }

    fun assert_admin<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>) {
        assert!(arg1.pool_id == 0x2::object::id<SwapPool<T0, T1>>(arg0), 10);
    }

    fun assert_trade_ready<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(!arg0.paused, 3);
        assert!(arg0.price_e8 == arg1, 4);
        assert!(arg0.price_version == arg2, 5);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 6);
    }

    fun checked_output(arg0: u128) : u64 {
        assert!(arg0 > 0, 12);
        assert!(arg0 <= 18446744073709551615, 11);
        (arg0 as u64)
    }

    entry fun create_empty_pool<T0, T1>(arg0: u8, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg4);
        let v1 = 0x2::coin::zero<T1>(arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        create_pool_internal<T0, T1>(v0, v1, arg0, arg1, arg2, v2, arg3, arg4);
    }

    entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u8, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6);
    }

    fun create_pool_internal<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u8, arg3: u8, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 1);
        assert!(arg2 <= 9, 2);
        assert!(arg3 <= 9, 2);
        let v0 = SwapPool<T0, T1>{
            id             : 0x2::object::new(arg7),
            schema_version : 1,
            paused         : false,
            ast_decimals   : arg2,
            usdc_decimals  : arg3,
            ast_unit       : pow10(arg2),
            usdc_unit      : pow10(arg3),
            price_e8       : arg4,
            price_version  : 1,
            ast_reserve    : 0x2::coin::into_balance<T0>(arg0),
            usdc_reserve   : 0x2::coin::into_balance<T1>(arg1),
            total_usdc_in  : 0,
            total_ast_out  : 0,
            total_ast_in   : 0,
            total_usdc_out : 0,
        };
        let v1 = 0x2::object::id<SwapPool<T0, T1>>(&v0);
        let v2 = SwapAdminCap<T0, T1>{
            id             : 0x2::object::new(arg7),
            schema_version : 1,
            pool_id        : v1,
        };
        let v3 = SwapPoolCreated{
            pool_id              : v1,
            admin                : arg5,
            ast_decimals         : arg2,
            usdc_decimals        : arg3,
            price_e8             : arg4,
            initial_ast_reserve  : 0x2::coin::value<T0>(&arg0),
            initial_usdc_reserve : 0x2::coin::value<T1>(&arg1),
            timestamp_ms         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<SwapPoolCreated>(v3);
        0x2::transfer::share_object<SwapPool<T0, T1>>(v0);
        0x2::transfer::transfer<SwapAdminCap<T0, T1>>(v2, arg5);
    }

    fun emit_reserve<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u8, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = SwapReserveUpdated{
            pool_id       : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            asset         : arg1,
            deposited     : arg2,
            amount        : arg3,
            reserve_after : arg4,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<SwapReserveUpdated>(v0);
    }

    fun emit_swap<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = SwapExecuted{
            pool_id       : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            trader        : 0x2::tx_context::sender(arg5),
            direction     : arg1,
            amount_in     : arg2,
            amount_out    : arg3,
            price_e8      : arg0.price_e8,
            price_version : arg0.price_version,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SwapExecuted>(v0);
    }

    public fun fund_ast<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 13);
        0x2::balance::join<T0>(&mut arg0.ast_reserve, 0x2::coin::into_balance<T0>(arg2));
        emit_reserve<T0, T1>(arg0, 1, true, v0, 0x2::balance::value<T0>(&arg0.ast_reserve), arg3);
    }

    public fun fund_usdc<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 13);
        0x2::balance::join<T1>(&mut arg0.usdc_reserve, 0x2::coin::into_balance<T1>(arg2));
        emit_reserve<T0, T1>(arg0, 2, true, v0, 0x2::balance::value<T1>(&arg0.usdc_reserve), arg3);
    }

    public fun get_pool_info<T0, T1>(arg0: &SwapPool<T0, T1>) : (u64, bool, u8, u8, u64, u64, u64, u64, u128, u128, u128, u128) {
        (arg0.schema_version, arg0.paused, arg0.ast_decimals, arg0.usdc_decimals, arg0.price_e8, arg0.price_version, 0x2::balance::value<T0>(&arg0.ast_reserve), 0x2::balance::value<T1>(&arg0.usdc_reserve), arg0.total_usdc_in, arg0.total_ast_out, arg0.total_ast_in, arg0.total_usdc_out)
    }

    fun pow10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun quote_ast_out<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : u64 {
        quote_ast_out_internal<T0, T1>(arg0, arg1)
    }

    fun quote_ast_out_internal<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : u64 {
        checked_output((arg1 as u128) * (arg0.ast_unit as u128) * (100000000 as u128) / (arg0.price_e8 as u128) * (arg0.usdc_unit as u128))
    }

    public fun quote_usdc_out<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : u64 {
        quote_usdc_out_internal<T0, T1>(arg0, arg1)
    }

    fun quote_usdc_out_internal<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : u64 {
        checked_output((arg1 as u128) * (arg0.price_e8 as u128) * (arg0.usdc_unit as u128) / (arg0.ast_unit as u128) * (100000000 as u128))
    }

    public fun set_paused<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        arg0.paused = arg2;
        let v0 = SwapPauseUpdated{
            pool_id      : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            paused       : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SwapPauseUpdated>(v0);
    }

    public fun set_price<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        assert!(arg2 > 0, 1);
        arg0.price_e8 = arg2;
        arg0.price_version = arg0.price_version + 1;
        let v0 = SwapPriceUpdated{
            pool_id       : 0x2::object::id<SwapPool<T0, T1>>(arg0),
            old_price_e8  : arg0.price_e8,
            new_price_e8  : arg2,
            price_version : arg0.price_version,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SwapPriceUpdated>(v0);
    }

    entry fun swap_ast_for_usdc<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_trade_ready<T0, T1>(arg0, arg2, arg3, arg5, arg6);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = quote_usdc_out_internal<T0, T1>(arg0, v0);
        assert!(v1 >= arg4, 7);
        assert!(0x2::balance::value<T1>(&arg0.usdc_reserve) >= v1, 9);
        0x2::balance::join<T0>(&mut arg0.ast_reserve, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_ast_in = arg0.total_ast_in + (v0 as u128);
        arg0.total_usdc_out = arg0.total_usdc_out + (v1 as u128);
        emit_swap<T0, T1>(arg0, 2, v0, v1, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.usdc_reserve, v1), arg7), 0x2::tx_context::sender(arg7));
    }

    entry fun swap_usdc_for_ast<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_trade_ready<T0, T1>(arg0, arg2, arg3, arg5, arg6);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = quote_ast_out_internal<T0, T1>(arg0, v0);
        assert!(v1 >= arg4, 7);
        assert!(0x2::balance::value<T0>(&arg0.ast_reserve) >= v1, 8);
        0x2::balance::join<T1>(&mut arg0.usdc_reserve, 0x2::coin::into_balance<T1>(arg1));
        arg0.total_usdc_in = arg0.total_usdc_in + (v0 as u128);
        arg0.total_ast_out = arg0.total_ast_out + (v1 as u128);
        emit_swap<T0, T1>(arg0, 1, v0, v1, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.ast_reserve, v1), arg7), 0x2::tx_context::sender(arg7));
    }

    public fun withdraw_ast<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1);
        assert!(arg2 > 0, 13);
        assert!(arg3 != @0x0, 14);
        assert!(0x2::balance::value<T0>(&arg0.ast_reserve) >= arg2, 8);
        emit_reserve<T0, T1>(arg0, 1, false, arg2, 0x2::balance::value<T0>(&arg0.ast_reserve), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.ast_reserve, arg2), arg5), arg3);
    }

    public fun withdraw_usdc<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &SwapAdminCap<T0, T1>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1);
        assert!(arg2 > 0, 13);
        assert!(arg3 != @0x0, 14);
        assert!(0x2::balance::value<T1>(&arg0.usdc_reserve) >= arg2, 9);
        emit_reserve<T0, T1>(arg0, 2, false, arg2, 0x2::balance::value<T1>(&arg0.usdc_reserve), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.usdc_reserve, arg2), arg5), arg3);
    }

    // decompiled from Move bytecode v7
}

