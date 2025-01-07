module 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PoolLiquidityCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        coin_a_admin: 0x2::balance::Balance<T0>,
        coin_b_admin: 0x2::balance::Balance<T1>,
        lp_locked: 0x2::balance::Balance<PoolLiquidityCoin<T0, T1>>,
        lp_supply: 0x2::balance::Supply<PoolLiquidityCoin<T0, T1>>,
        trade_fee_numerator: u64,
        trade_fee_denominator: u64,
        protocol_fee_numerator: u64,
        protocol_fee_denominator: u64,
    }

    struct InitEvent has copy, drop {
        sender: address,
        global_paulse_status_id: 0x2::object::ID,
        pair_store_id: 0x2::object::ID,
    }

    struct InitPoolEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        trade_fee_numerator: u64,
        trade_fee_denominator: u64,
        protocol_fee_numerator: u64,
        protocol_fee_denominator: u64,
    }

    struct LiquidityEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        is_add_liquidity: bool,
        liquidity: u64,
        amount_a: u64,
        amount_b: u64,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_a_in: u64,
        amount_a_out: u64,
        amount_b_in: u64,
        amount_b_out: u64,
    }

    struct SetFeeEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        trade_fee_numerator: u64,
        trade_fee_denominator: u64,
        protocol_fee_numerator: u64,
        protocol_fee_denominator: u64,
    }

    struct ClaimFeeEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        pay_amount: u64,
        protocol_fee_amount: u64,
    }

    fun swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x2::balance::Balance<T1>, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::balance::value<T1>(&arg3);
        assert!(v0 > 0 || v1 > 0, 0);
        let (v2, v3) = get_reserves<T0, T1>(arg0);
        0x2::balance::join<T0>(&mut arg0.coin_a, arg1);
        0x2::balance::join<T1>(&mut arg0.coin_b, arg3);
        let (v4, v5) = get_trade_fee<T0, T1>(arg0);
        let (v6, v7) = new_reserves_adjusted(0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b), v0, v1, v4, v5);
        assert_lp_value_incr(v2, v3, v6, v7, v5);
        let (v8, v9) = calc_swap_protocol_fee_rate<T0, T1>(arg0);
        (0x2::balance::split<T0>(&mut arg0.coin_a, arg4), 0x2::balance::split<T1>(&mut arg0.coin_b, arg2), 0x2::balance::split<T0>(&mut arg0.coin_a, 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_math::safe_mul_div_u64(v0, v8, v9)), 0x2::balance::split<T1>(&mut arg0.coin_b, 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_math::safe_mul_div_u64(v1, v8, v9)))
    }

    fun assert_lp_value_incr(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_math::safe_compare_mul_u64(arg2, arg3, arg0 * arg4, arg1 * arg4), 1);
    }

    fun burn<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<PoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::balance::value<PoolLiquidityCoin<T0, T1>>(&arg1);
        let (v1, v2) = get_reserves<T0, T1>(arg0);
        let v3 = 0x2::balance::supply_value<PoolLiquidityCoin<T0, T1>>(&arg0.lp_supply);
        let v4 = 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_math::safe_mul_div_u64(v0, v1, v3);
        let v5 = 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_math::safe_mul_div_u64(v0, v2, v3);
        assert!(v4 > 0 && v5 > 0, 3);
        0x2::balance::decrease_supply<PoolLiquidityCoin<T0, T1>>(&mut arg0.lp_supply, arg1);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, v4), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, v5), arg2))
    }

    public(friend) fun burn_and_emit_event<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<PoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = burn<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = LiquidityEvent{
            sender           : 0x2::tx_context::sender(arg2),
            pool_id          : 0x2::object::id<Pool<T0, T1>>(arg0),
            is_add_liquidity : false,
            liquidity        : 0x2::balance::value<PoolLiquidityCoin<T0, T1>>(&arg1),
            amount_a         : 0x2::coin::value<T0>(&v3),
            amount_b         : 0x2::coin::value<T1>(&v2),
        };
        0x2::event::emit<LiquidityEvent>(v4);
        (v3, v2)
    }

    fun calc_swap_protocol_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        let (v0, v1) = get_trade_fee<T0, T1>(arg0);
        let (v2, v3) = get_protocol_fee<T0, T1>(arg0);
        (0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_math::safe_mul_u64(v0, v2), 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_math::safe_mul_u64(v1, v3))
    }

    public(friend) fun claim_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.coin_a_admin);
        let v1 = 0x2::balance::value<T1>(&arg0.coin_b_admin);
        assert!(v0 > 0 || v1 > 0, 0);
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_admin, v0), arg1), arg1);
        0x2::pay::keep<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_admin, v1), arg1), arg1);
        let v2 = ClaimFeeEvent{
            sender   : 0x2::tx_context::sender(arg1),
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a : v0,
            amount_b : v1,
        };
        0x2::event::emit<ClaimFeeEvent>(v2);
    }

    public(friend) fun flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        assert!(arg1 > 0, 0);
        let (v0, v1) = get_reserves<T0, T1>(arg0);
        let (v2, v3) = get_trade_fee<T0, T1>(arg0);
        let v4 = 0x2::balance::zero<T0>();
        let v5 = 0x2::balance::zero<T1>();
        if (arg3) {
            0x2::balance::join<T1>(&mut v5, 0x2::balance::split<T1>(&mut arg0.coin_b, arg2));
            let (v6, v7) = new_reserves_adjusted(v0 + arg1, v1 - arg2, arg1, 0, v2, v3);
            assert_lp_value_incr(v0, v1, v6, v7, v3);
        } else {
            0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut arg0.coin_a, arg2));
            let (v8, v9) = new_reserves_adjusted(v0 - arg2, v1 + arg1, 0, arg1, v2, v3);
            assert_lp_value_incr(v0, v1, v8, v9, v3);
        };
        let (v10, v11) = calc_swap_protocol_fee_rate<T0, T1>(arg0);
        let v12 = FlashSwapReceipt<T0, T1>{
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg0),
            a2b                 : arg3,
            pay_amount          : arg1,
            protocol_fee_amount : 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_math::safe_mul_div_u64(arg1, v10, v11),
        };
        (v4, v5, v12)
    }

    public(friend) fun flash_swap_and_emit_event<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = flash_swap<T0, T1>(arg0, arg1, arg2, arg3);
        if (arg3) {
            let v3 = SwapEvent{
                sender       : 0x2::tx_context::sender(arg4),
                pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
                amount_a_in  : arg1,
                amount_a_out : 0,
                amount_b_in  : 0,
                amount_b_out : arg2,
            };
            0x2::event::emit<SwapEvent>(v3);
        } else {
            let v4 = SwapEvent{
                sender       : 0x2::tx_context::sender(arg4),
                pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
                amount_a_in  : 0,
                amount_a_out : arg2,
                amount_b_in  : arg1,
                amount_b_out : 0,
            };
            0x2::event::emit<SwapEvent>(v4);
        };
        (v0, v1, v2)
    }

    public fun get_protocol_fee<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.protocol_fee_numerator, arg0.protocol_fee_denominator)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
    }

    public fun get_trade_fee<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.trade_fee_numerator, arg0.trade_fee_denominator)
    }

    public(friend) fun handle_swap_protocol_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.coin_a_admin, arg1);
        0x2::balance::join<T1>(&mut arg0.coin_b_admin, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = InitEvent{
            sender                  : 0x2::tx_context::sender(arg0),
            global_paulse_status_id : 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::new_global_pause_status_and_shared(arg0),
            pair_store_id           : 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::new_pair_store_and_shared(arg0),
        };
        0x2::event::emit<InitEvent>(v1);
    }

    public(friend) fun init_pool<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = make_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v1 = InitPoolEvent{
            sender                   : 0x2::tx_context::sender(arg4),
            pool_id                  : 0x2::object::id<Pool<T0, T1>>(&v0),
            trade_fee_numerator      : arg0,
            trade_fee_denominator    : arg1,
            protocol_fee_numerator   : arg2,
            protocol_fee_denominator : arg3,
        };
        0x2::event::emit<InitPoolEvent>(v1);
        v0
    }

    fun make_pool<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = PoolLiquidityCoin<T0, T1>{dummy_field: false};
        Pool<T0, T1>{
            id                       : 0x2::object::new(arg4),
            coin_a                   : 0x2::balance::zero<T0>(),
            coin_b                   : 0x2::balance::zero<T1>(),
            coin_a_admin             : 0x2::balance::zero<T0>(),
            coin_b_admin             : 0x2::balance::zero<T1>(),
            lp_locked                : 0x2::balance::zero<PoolLiquidityCoin<T0, T1>>(),
            lp_supply                : 0x2::balance::create_supply<PoolLiquidityCoin<T0, T1>>(v0),
            trade_fee_numerator      : arg0,
            trade_fee_denominator    : arg1,
            protocol_fee_numerator   : arg2,
            protocol_fee_denominator : arg3,
        }
    }

    fun mint<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PoolLiquidityCoin<T0, T1>> {
        let (v0, v1) = get_reserves<T0, T1>(arg0);
        let v2 = 0x2::balance::supply_value<PoolLiquidityCoin<T0, T1>>(&arg0.lp_supply);
        let v3 = if (v2 == 0) {
            0x2::balance::join<PoolLiquidityCoin<T0, T1>>(&mut arg0.lp_locked, 0x2::balance::increase_supply<PoolLiquidityCoin<T0, T1>>(&mut arg0.lp_supply, 10));
            (0x2::math::sqrt_u128((0x2::balance::value<T0>(&arg1) as u128) * (0x2::balance::value<T1>(&arg2) as u128)) as u64) - 10
        } else {
            0x2::math::min(0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_math::safe_mul_div_u64(0x2::balance::value<T0>(&arg1), v2, v0), 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_math::safe_mul_div_u64(0x2::balance::value<T1>(&arg2), v2, v1))
        };
        assert!(v3 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.coin_a, arg1);
        0x2::balance::join<T1>(&mut arg0.coin_b, arg2);
        0x2::coin::from_balance<PoolLiquidityCoin<T0, T1>>(0x2::balance::increase_supply<PoolLiquidityCoin<T0, T1>>(&mut arg0.lp_supply, v3), arg3)
    }

    public(friend) fun mint_and_emit_event<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PoolLiquidityCoin<T0, T1>> {
        let v0 = mint<T0, T1>(arg0, arg1, arg2, arg5);
        let v1 = LiquidityEvent{
            sender           : 0x2::tx_context::sender(arg5),
            pool_id          : 0x2::object::id<Pool<T0, T1>>(arg0),
            is_add_liquidity : true,
            liquidity        : 0x2::coin::value<PoolLiquidityCoin<T0, T1>>(&v0),
            amount_a         : arg3,
            amount_b         : arg4,
        };
        0x2::event::emit<LiquidityEvent>(v1);
        v0
    }

    fun new_reserves_adjusted(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        (arg0 * arg5 - arg2 * arg4, arg1 * arg5 - arg3 * arg4)
    }

    public(friend) fun repay_flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: FlashSwapReceipt<T0, T1>) {
        let FlashSwapReceipt {
            pool_id             : v0,
            a2b                 : v1,
            pay_amount          : v2,
            protocol_fee_amount : v3,
        } = arg3;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg1) == v2, 5);
            0x2::balance::join<T0>(&mut arg0.coin_a, arg1);
            0x2::balance::join<T0>(&mut arg0.coin_a_admin, 0x2::balance::split<T0>(&mut arg1, v3));
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            assert!(0x2::balance::value<T1>(&arg2) == v2, 5);
            0x2::balance::join<T1>(&mut arg0.coin_b, arg2);
            0x2::balance::join<T1>(&mut arg0.coin_b_admin, 0x2::balance::split<T1>(&mut arg2, v3));
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public(friend) fun set_fee_and_emit_event<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.trade_fee_numerator = arg1;
        arg0.trade_fee_denominator = arg2;
        arg0.protocol_fee_numerator = arg3;
        arg0.protocol_fee_denominator = arg4;
        let v0 = SetFeeEvent{
            sender                   : 0x2::tx_context::sender(arg5),
            pool_id                  : 0x2::object::id<Pool<T0, T1>>(arg0),
            trade_fee_numerator      : arg1,
            trade_fee_denominator    : arg2,
            protocol_fee_numerator   : arg3,
            protocol_fee_denominator : arg4,
        };
        0x2::event::emit<SetFeeEvent>(v0);
    }

    public(friend) fun share_pool_object<T0, T1>(arg0: Pool<T0, T1>) {
        0x2::transfer::share_object<Pool<T0, T1>>(arg0);
    }

    public(friend) fun swap_and_emit_event<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2, v3) = swap<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v4 = v1;
        let v5 = v0;
        let v6 = SwapEvent{
            sender       : 0x2::tx_context::sender(arg5),
            pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a_in  : 0x2::balance::value<T0>(&arg1),
            amount_a_out : 0x2::balance::value<T0>(&v5),
            amount_b_in  : 0x2::balance::value<T1>(&arg3),
            amount_b_out : 0x2::balance::value<T1>(&v4),
        };
        0x2::event::emit<SwapEvent>(v6);
        (v5, v4, v2, v3)
    }

    public fun swap_pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    // decompiled from Move bytecode v6
}

