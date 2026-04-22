module 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve {
    struct SwapEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        x2y: bool,
        in_amount: u64,
        out_amount: u64,
        fee_amount: u64,
        ts: u64,
    }

    struct PriceUpdateEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        norm_multiplier_x: u64,
        norm_multiplier_y: u64,
        ts: u64,
    }

    struct PoolLockedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    struct SATURATION_CURVE has drop {
        dummy_field: bool,
    }

    struct LiquidityProviderCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        pools: vector<address>,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        price_feeder: address,
        concentration: u64,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        norm_multiplier_x: u64,
        x_retain_decimals: u8,
        norm_multiplier_y: u64,
        y_retain_decimals: u8,
        virtual_liquidity_x: u64,
        virtual_liquidity_y_reference: u64,
        locked: bool,
        fee_millionth: u64,
        fee_x: 0x2::balance::Balance<T0>,
        fee_y: 0x2::balance::Balance<T1>,
        last_update_at: u64,
        price_feed_life: u64,
    }

    fun address_is_price_feeder<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : bool {
        arg0.price_feeder == arg1
    }

    fun check_and_update_lock<T0, T1>(arg0: &mut Pool<T0, T1>) {
        let v0 = get_virtual_liquidity_y<T0, T1>(arg0);
        if (arg0.virtual_liquidity_y_reference == 0) {
            if (v0 > 0) {
                arg0.virtual_liquidity_y_reference = v0;
            };
            return
        };
        if (v0 >= arg0.virtual_liquidity_y_reference) {
            if (v0 > arg0.virtual_liquidity_y_reference) {
                arg0.virtual_liquidity_y_reference = v0;
            };
            return
        };
        let v1 = (arg0.virtual_liquidity_y_reference as u128);
        if ((v1 - (v0 as u128)) * (10000 as u128) / v1 > (500 as u128)) {
            arg0.locked = true;
            let v2 = PoolLockedEvent{pool_id: 0x2::object::id<Pool<T0, T1>>(arg0)};
            0x2::event::emit<PoolLockedEvent>(v2);
        };
    }

    public fun create_pool<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut PoolRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        assert!(0x2::package::from_module<SATURATION_CURVE>(arg0), 13906834565185404927);
        assert!(arg2 >= arg3 && arg2 >= arg4, 13906834569480372223);
        assert!(arg5 < 1000000, 13906834573775339519);
        let v0 = 0x2::object::new(arg8);
        0x1::vector::push_back<address>(&mut arg1.pools, 0x2::object::uid_to_address(&v0));
        Pool<T0, T1>{
            id                            : v0,
            price_feeder                  : arg6,
            concentration                 : 0,
            reserve_x                     : 0x2::balance::zero<T0>(),
            reserve_y                     : 0x2::balance::zero<T1>(),
            norm_multiplier_x             : 0,
            x_retain_decimals             : arg2 - arg3,
            norm_multiplier_y             : 0,
            y_retain_decimals             : arg2 - arg4,
            virtual_liquidity_x           : 0,
            virtual_liquidity_y_reference : 0,
            locked                        : false,
            fee_millionth                 : arg5,
            fee_x                         : 0x2::balance::zero<T0>(),
            fee_y                         : 0x2::balance::zero<T1>(),
            last_update_at                : 0x2::clock::timestamp_ms(arg7),
            price_feed_life               : 30000,
        }
    }

    public fun create_pool_shared<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut PoolRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Pool<T0, T1>>(create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool, 13906835759186313215);
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
        } else {
            arg0.virtual_liquidity_x = arg0.virtual_liquidity_x + 0x2::balance::value<T0>(&arg2);
            0x2::balance::join<T0>(&mut arg0.reserve_x, arg2);
        };
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            0x2::balance::join<T1>(&mut arg0.reserve_y, arg3);
        };
    }

    fun get_virtual_liquidity_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        let v0 = (arg0.norm_multiplier_x as u256);
        let v1 = (arg0.norm_multiplier_y as u256);
        ((((0x2::balance::value<T0>(&arg0.reserve_x) as u256) * v0 + (0x2::balance::value<T1>(&arg0.reserve_y) as u256) * v1 - (arg0.virtual_liquidity_x as u256) * v0) / v1) as u64)
    }

    public fun grant_lp_cap<T0, T1>(arg0: &0x2::package::Publisher, arg1: &Pool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<SATURATION_CURVE>(arg0), 13906834771343835135);
        let v0 = LiquidityProviderCap{
            id   : 0x2::object::new(arg3),
            pool : 0x2::object::id<Pool<T0, T1>>(arg1),
        };
        0x2::transfer::transfer<LiquidityProviderCap>(v0, arg2);
    }

    fun init(arg0: SATURATION_CURVE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SATURATION_CURVE>(arg0, arg1);
        let v0 = PoolRegistry{
            id    : 0x2::object::new(arg1),
            pools : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    fun is_locked<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.locked
    }

    public fun quote_x_2_y<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64) {
        if (is_locked<T0, T1>(arg0)) {
            (0, 0)
        } else {
            quote_x_2_y_((arg1 as u128), (arg0.virtual_liquidity_x as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, (arg0.norm_multiplier_x as u128), (arg0.norm_multiplier_y as u128))
        }
    }

    fun quote_x_2_y_(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u128, arg7: u128) : (u64, u64) {
        let v0 = arg1 * arg2;
        let v1 = (v0 as u256) * (v0 as u256) * (arg6 as u256) / (arg7 as u256);
        let v2 = ((v0 + arg3 - arg1) as u256);
        let v3 = ((v1 / v2 - v1 / (v2 + (arg0 as u256))) as u64);
        assert!((v3 as u128) < arg4, 3);
        let v4 = (((v3 as u128) * (arg5 as u128) / 1000000) as u64);
        (v3 - v4, v4)
    }

    public fun quote_y_2_x<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64) {
        if (is_locked<T0, T1>(arg0)) {
            (0, 0)
        } else {
            quote_y_to_x_((arg1 as u128), (arg0.virtual_liquidity_x as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, (arg0.norm_multiplier_x as u128), (arg0.norm_multiplier_y as u128))
        }
    }

    fun quote_y_to_x_(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u128, arg7: u128) : (u64, u64) {
        let v0 = arg1 * arg2;
        let v1 = (v0 as u256) * (v0 as u256) * (arg6 as u256) / (arg7 as u256);
        let v2 = ((v0 + arg3 - arg1) as u256);
        let v3 = v1 / (v1 / v2 + (arg0 as u256));
        let v4 = if (v3 >= v2) {
            0
        } else {
            v2 - v3
        };
        let v5 = (v4 as u64);
        assert!((v5 as u128) < arg3, 2);
        let v6 = (((v5 as u128) * (arg5 as u128) / 1000000) as u64);
        (v5 - v6, v6)
    }

    public fun set_price_feeder<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: address) {
        assert!(0x2::package::from_module<SATURATION_CURVE>(arg1), 13906835965344743423);
        arg0.price_feeder = arg2;
    }

    public fun swap_x_2_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg0.last_update_at < arg0.price_feed_life, 13906835226610368511);
        assert!(!arg0.locked, 13906835235200303103);
        check_and_update_lock<T0, T1>(arg0);
        assert!(!arg0.locked, 13906835243790237695);
        let v1 = if (arg1 == 0) {
            0x2::balance::value<T0>(&arg2)
        } else {
            arg1
        };
        let (v2, v3) = quote_x_2_y_((v1 as u128), (arg0.virtual_liquidity_x as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, (arg0.norm_multiplier_x as u128), (arg0.norm_multiplier_y as u128));
        assert!(v2 > 0, 13906835321099649023);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::balance::split<T0>(&mut arg2, v1));
        let v4 = 0x2::balance::split<T1>(&mut arg0.reserve_y, v2 + v3);
        0x2::balance::join<T1>(&mut arg0.fee_y, 0x2::balance::split<T1>(&mut v4, v3));
        let v5 = SwapEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            x2y        : true,
            in_amount  : v1,
            out_amount : v2,
            fee_amount : v3,
            ts         : v0,
        };
        0x2::event::emit<SwapEvent>(v5);
        (arg2, v4)
    }

    entry fun swap_x_2_y_aggregator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap_x_2_y<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
        let v2 = v0;
        if (0x2::balance::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun swap_y_2_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg0.last_update_at < arg0.price_feed_life, 13906835424178864127);
        assert!(!arg0.locked, 13906835428473831423);
        check_and_update_lock<T0, T1>(arg0);
        assert!(!arg0.locked, 13906835437063766015);
        let v1 = if (arg1 == 0) {
            0x2::balance::value<T1>(&arg2)
        } else {
            arg1
        };
        let (v2, v3) = quote_y_to_x_((v1 as u128), (arg0.virtual_liquidity_x as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, (arg0.norm_multiplier_x as u128), (arg0.norm_multiplier_y as u128));
        assert!(v2 > 0, 13906835505783242751);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::balance::split<T1>(&mut arg2, v1));
        let v4 = 0x2::balance::split<T0>(&mut arg0.reserve_x, v2 + v3);
        0x2::balance::join<T0>(&mut arg0.fee_x, 0x2::balance::split<T0>(&mut v4, v3));
        let v5 = SwapEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            x2y        : false,
            in_amount  : v1,
            out_amount : v2,
            fee_amount : v3,
            ts         : v0,
        };
        0x2::event::emit<SwapEvent>(v5);
        (v4, arg2)
    }

    entry fun swap_y_2_x_aggregator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap_y_2_x<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2), arg3, arg4);
        let v2 = v1;
        if (0x2::balance::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun unlock<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<SATURATION_CURVE>(arg1), 13906836360481734655);
        unlock_internal<T0, T1>(arg0);
    }

    public fun unlock_by_lp<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap) {
        assert!(arg1.pool == 0x2::object::id<Pool<T0, T1>>(arg0), 13906836381956571135);
        unlock_internal<T0, T1>(arg0);
    }

    fun unlock_internal<T0, T1>(arg0: &mut Pool<T0, T1>) {
        arg0.locked = false;
        arg0.virtual_liquidity_y_reference = 0;
    }

    public fun update_concentration<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: u64) {
        assert!(0x2::package::from_module<SATURATION_CURVE>(arg1), 13906834797113638911);
        assert!(arg2 < 20000, 0);
        assert!(arg2 >= 1, 0);
        arg0.concentration = arg2;
        arg0.virtual_liquidity_y_reference = 0;
    }

    public fun update_fee_millionth<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: u64) {
        assert!(0x2::package::from_module<SATURATION_CURVE>(arg1), 13906834865833115647);
        assert!(arg2 < 1000000, 13906834870128082943);
        arg0.fee_millionth = arg2;
    }

    public fun update_price_feed_life<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: u64) {
        assert!(0x2::package::from_module<SATURATION_CURVE>(arg1), 13906834840063311871);
        assert!(arg2 > 0, 13906834844358279167);
        arg0.price_feed_life = arg2;
    }

    public fun update_prices<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg2 > 0, 13906836016884350975);
        assert!(arg0.last_update_at < arg3, 13906836021179318271);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (v0 <= arg3 || v0 > arg3 + arg0.price_feed_life) {
            abort v0
        };
        assert!(address_is_price_feeder<T0, T1>(arg0, 0x2::tx_context::sender(arg5)), 2);
        arg0.norm_multiplier_x = arg1;
        arg0.norm_multiplier_y = arg2;
        arg0.last_update_at = arg3;
        let v1 = PriceUpdateEvent{
            pool_id           : 0x2::object::id<Pool<T0, T1>>(arg0),
            norm_multiplier_x : arg1,
            norm_multiplier_y : arg2,
            ts                : arg3,
        };
        0x2::event::emit<PriceUpdateEvent>(v1);
    }

    public fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool, 13906835845085659135);
        let v0 = if (arg2 == 0) {
            0x2::balance::zero<T0>()
        } else {
            let v1 = if (arg2 >= arg0.virtual_liquidity_x) {
                0
            } else {
                arg0.virtual_liquidity_x - arg2
            };
            arg0.virtual_liquidity_x = v1;
            0x2::balance::split<T0>(&mut arg0.reserve_x, arg2)
        };
        let v2 = if (arg3 == 0) {
            0x2::balance::zero<T1>()
        } else {
            0x2::balance::split<T1>(&mut arg0.reserve_y, arg3)
        };
        (v0, v2)
    }

    public fun withdraw_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::package::from_module<SATURATION_CURVE>(arg1), 13906836330416963583);
        (0x2::balance::withdraw_all<T0>(&mut arg0.fee_x), 0x2::balance::withdraw_all<T1>(&mut arg0.fee_y))
    }

    // decompiled from Move bytecode v7
}

