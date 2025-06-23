module 0xddcf924818cb755837991c10c85ad9830140e0d62b4282b0c856df937ca3cb9c::vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        pool_id: 0x2::object::ID,
        position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        protocol_fee_a: 0x2::balance::Balance<T0>,
        protocol_fee_b: 0x2::balance::Balance<T1>,
        total_shares: u64,
        tick_spacing: u32,
        fee_rate: u64,
        range_percentage: u32,
        rebalance_threshold: u32,
        created_at: u64,
        last_rebalanced_at: u64,
        is_paused: bool,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        version: u64,
        owner: address,
        pool_id: 0x2::object::ID,
        created_at: u64,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        shares_minted: u64,
        total_shares: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        shares_burned: u64,
        remaining_shares: u64,
    }

    struct Rebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        old_lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        old_upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        new_lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        new_upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        timestamp: u64,
    }

    struct RewardsCompounded has copy, drop {
        vault_id: 0x2::object::ID,
        sui_amount: u64,
        timestamp: u64,
    }

    struct FeesCollected has copy, drop {
        vault_id: 0x2::object::ID,
        fee_a: u64,
        fee_b: u64,
        timestamp: u64,
    }

    struct VaultPaused has copy, drop {
        vault_id: 0x2::object::ID,
        is_paused: bool,
        timestamp: u64,
    }

    fun add_liquidity_to_position<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Vault<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.position);
        let v1 = 0x2::balance::value<T0>(&arg1.balance_a);
        let v2 = 0x2::balance::value<T1>(&arg1.balance_b);
        if (v1 == 0 && v2 == 0) {
            return
        };
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v0);
        let v5 = calculate_liquidity_from_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v4), v1, v2);
        if (v5 > 1000) {
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg2, v0, v5, arg3);
            let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v6);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut arg1.balance_a, v7), 0x2::balance::split<T1>(&mut arg1.balance_b, v8), v6);
        };
    }

    fun calculate_initial_shares<T0, T1>(arg0: u64, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u64 {
        let v0 = sqrt_u128((arg0 as u128) * (arg1 as u128));
        if (v0 < (1000 as u128)) {
            0
        } else {
            (v0 as u64)
        }
    }

    public fun calculate_leverage<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u64 {
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)) {
            return 0
        };
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position));
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v1, v0));
        10000 / (arg0.range_percentage as u64)
    }

    fun calculate_liquidity_from_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        let v0 = if (arg0 < arg2) {
            let v1 = if (arg0 < arg1) {
                arg1
            } else {
                arg0
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(arg1, v1, arg3, false)
        } else {
            18446744073709551615
        };
        let v2 = if (arg0 > arg1) {
            let v3 = if (arg0 > arg2) {
                arg2
            } else {
                arg0
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(v3, arg2, arg4, false)
        } else {
            18446744073709551615
        };
        if (v0 < v2) {
            v0
        } else {
            v2
        }
    }

    fun calculate_new_tick_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32, arg2: u32) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = arg2 * 100 / 200;
        let v1 = arg1 * 2;
        let v2 = if (v0 < v1) {
            v1
        } else {
            v0
        };
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2));
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2));
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v3, v5);
        let v7 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v6)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v5, v6))
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v6, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v3, v6)
        } else {
            v3
        };
        let v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v4, v5);
        let v9 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v8)) {
            v4
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v8, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v5, v8))
        } else {
            v4
        };
        (v7, v9)
    }

    fun calculate_proportional_shares<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance_a);
        let v1 = 0x2::balance::value<T1>(&arg0.balance_b);
        let v2 = if (v0 > 0) {
            (arg0.total_shares as u128) * (arg1 as u128) / (v0 as u128)
        } else {
            18446744073709551615
        };
        let v3 = if (v1 > 0) {
            (arg0.total_shares as u128) * (arg2 as u128) / (v1 as u128)
        } else {
            18446744073709551615
        };
        let v4 = if (v2 < v3) {
            v2
        } else {
            v3
        };
        (v4 as u64)
    }

    fun collect_fees_internal<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Vault<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position)) {
            return
        };
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg2, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), true);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = 0x2::balance::value<T1>(&v2);
        0x2::balance::join<T0>(&mut arg1.balance_a, v3);
        0x2::balance::join<T1>(&mut arg1.balance_b, v2);
        if (v4 > 0 || v5 > 0) {
            let v6 = FeesCollected{
                vault_id  : 0x2::object::id<Vault<T0, T1>>(arg1),
                fee_a     : v4,
                fee_b     : v5,
                timestamp : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<FeesCollected>(v6);
        };
    }

    public entry fun compound_rewards<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Vault<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.owner, 1);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), 5);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg0, arg2, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), arg3, true, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x2::balance::join<T0>(&mut arg1.balance_a, v0);
        if (v1 > 0 && 0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position)) {
            add_liquidity_to_position<T0, T1>(arg0, arg1, arg2, arg4);
        };
        let v2 = RewardsCompounded{
            vault_id   : 0x2::object::id<Vault<T0, T1>>(arg1),
            sui_amount : v1,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RewardsCompounded>(v2);
    }

    fun create_initial_position<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Vault<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = calculate_new_tick_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg2), arg1.tick_spacing, arg1.range_percentage);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1), 9);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.position, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1), arg4));
        add_liquidity_to_position<T0, T1>(arg0, arg1, arg2, arg3);
        arg1.last_rebalanced_at = 0x2::clock::timestamp_ms(arg3);
    }

    public entry fun create_vault<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = Vault<T0, T1>{
            id                  : 0x2::object::new(arg2),
            version             : 1,
            owner               : 0x2::tx_context::sender(arg2),
            pool_id             : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            position            : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            balance_a           : 0x2::balance::zero<T0>(),
            balance_b           : 0x2::balance::zero<T1>(),
            protocol_fee_a      : 0x2::balance::zero<T0>(),
            protocol_fee_b      : 0x2::balance::zero<T1>(),
            total_shares        : 0,
            tick_spacing        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg0),
            fee_rate            : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0),
            range_percentage    : 50,
            rebalance_threshold : 100,
            created_at          : v0,
            last_rebalanced_at  : 0,
            is_paused           : false,
        };
        let v2 = VaultCreated{
            vault_id   : 0x2::object::id<Vault<T0, T1>>(&v1),
            version    : 1,
            owner      : v1.owner,
            pool_id    : v1.pool_id,
            created_at : v0,
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<Vault<T0, T1>>(v1);
    }

    public entry fun deposit<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Vault<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg1.owner, 1);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == arg1.pool_id, 8);
        assert!(!arg1.is_paused, 13);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::coin::value<T1>(&arg4);
        0x2::balance::join<T0>(&mut arg1.balance_a, 0x2::coin::into_balance<T0>(arg3));
        0x2::balance::join<T1>(&mut arg1.balance_b, 0x2::coin::into_balance<T1>(arg4));
        let v2 = if (arg1.total_shares == 0) {
            let v3 = calculate_initial_shares<T0, T1>(v0, v1, arg2);
            assert!(v3 >= 1000, 12);
            v3
        } else {
            let v4 = calculate_proportional_shares<T0, T1>(arg1, v0, v1);
            assert!(v4 > 0, 14);
            v4
        };
        arg1.total_shares = arg1.total_shares + v2;
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position)) {
            create_initial_position<T0, T1>(arg0, arg1, arg2, arg5, arg6);
        } else {
            add_liquidity_to_position<T0, T1>(arg0, arg1, arg2, arg5);
        };
        let v5 = Deposited{
            vault_id      : 0x2::object::id<Vault<T0, T1>>(arg1),
            amount_a      : v0,
            amount_b      : v1,
            shares_minted : v2,
            total_shares  : arg1.total_shares,
        };
        0x2::event::emit<Deposited>(v5);
    }

    public fun get_position_info<T0, T1>(arg0: &Vault<T0, T1>) : (u128, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)) {
            return (0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero(), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())
        };
        let v0 = 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v0);
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0), v1, v2)
    }

    public fun get_share_value<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : (u64, u64) {
        if (arg0.total_shares == 0 || arg1 == 0) {
            return (0, 0)
        };
        ((((0x2::balance::value<T0>(&arg0.balance_a) as u128) * (arg1 as u128) / (arg0.total_shares as u128)) as u64), (((0x2::balance::value<T1>(&arg0.balance_b) as u128) * (arg1 as u128) / (arg0.total_shares as u128)) as u64))
    }

    public fun get_vault_info<T0, T1>(arg0: &Vault<T0, T1>) : (address, 0x2::object::ID, u64, u64, u64, bool) {
        (arg0.owner, arg0.pool_id, 0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), arg0.total_shares, 0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position))
    }

    public fun get_vault_stats<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64, u32, u32) {
        (arg0.version, arg0.created_at, arg0.last_rebalanced_at, arg0.range_percentage, arg0.rebalance_threshold)
    }

    public fun get_vault_version<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.version
    }

    public fun is_paused<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.is_paused
    }

    fun needs_rebalance<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : bool {
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)) {
            return false
        };
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v0) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v2, v1)
    }

    public entry fun rebalance<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Vault<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 1);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), 5);
        if (!needs_rebalance<T0, T1>(arg1, arg2)) {
            return
        };
        collect_fees_internal<T0, T1>(arg0, arg1, arg2, arg3);
        let v0 = 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.position);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0);
        if (v1 > 0) {
            let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg2, v0, v1, arg3);
            0x2::balance::join<T0>(&mut arg1.balance_a, v2);
            0x2::balance::join<T1>(&mut arg1.balance_b, v3);
        };
        let v4 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.position);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg0, arg2, v4);
        let (v7, v8) = calculate_new_tick_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg2), arg1.tick_spacing, arg1.range_percentage);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.position, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v7), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v8), arg4));
        add_liquidity_to_position<T0, T1>(arg0, arg1, arg2, arg3);
        arg1.last_rebalanced_at = 0x2::clock::timestamp_ms(arg3);
        let v9 = Rebalanced{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg1),
            old_lower_tick : v5,
            old_upper_tick : v6,
            new_lower_tick : v7,
            new_upper_tick : v8,
            timestamp      : arg1.last_rebalanced_at,
        };
        0x2::event::emit<Rebalanced>(v9);
    }

    public entry fun set_pause<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.is_paused = arg1;
        let v0 = VaultPaused{
            vault_id  : 0x2::object::id<Vault<T0, T1>>(arg0),
            is_paused : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VaultPaused>(v0);
    }

    fun sqrt_u128(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 == 1) {
            return 1
        };
        let v0 = arg0 / 2;
        let v1 = (v0 + arg0 / v0) / 2;
        if (v1 < v0) {
            v1
        } else {
            v0
        }
    }

    public entry fun withdraw<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Vault<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.owner, 1);
        assert!(arg3 > 0, 14);
        assert!(arg3 <= arg1.total_shares, 2);
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position)) {
            collect_fees_internal<T0, T1>(arg0, arg1, arg2, arg4);
        };
        let v0 = if (arg3 == arg1.total_shares) {
            if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position)) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position))
            } else {
                0
            }
        } else if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position)) {
            (((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position)) as u256) * (arg3 as u256) / (arg1.total_shares as u256)) as u128)
        } else {
            0
        };
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position) && v0 > 0) {
            let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg2, 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.position), v0, arg4);
            0x2::balance::join<T0>(&mut arg1.balance_a, v1);
            0x2::balance::join<T1>(&mut arg1.balance_b, v2);
        };
        let v3 = (((0x2::balance::value<T0>(&arg1.balance_a) as u256) * (arg3 as u256) / (arg1.total_shares as u256)) as u64);
        let v4 = (((0x2::balance::value<T1>(&arg1.balance_b) as u256) * (arg3 as u256) / (arg1.total_shares as u256)) as u64);
        arg1.total_shares = arg1.total_shares - arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_a, v3), arg5), arg1.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_b, v4), arg5), arg1.owner);
        let v5 = Withdrawn{
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg1),
            amount_a         : v3,
            amount_b         : v4,
            shares_burned    : arg3,
            remaining_shares : arg1.total_shares,
        };
        0x2::event::emit<Withdrawn>(v5);
    }

    // decompiled from Move bytecode v6
}

