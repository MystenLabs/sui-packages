module 0xec0f8b4a8f6d5cd15c006a250c474623101525d8320823ddd5e133b404de5434::vault {
    struct DbgBal has copy, drop {
        tag: u64,
        a: u64,
        b: u64,
        c: u64,
        d: u64,
    }

    struct Dbg2 has copy, drop {
        tag: u64,
        a: u64,
        b: u64,
    }

    struct PoolCfg has copy, drop, store {
        pool_obj_addr: address,
        coin_a: 0x1::string::String,
        coin_b: 0x1::string::String,
        tick_spacing: u32,
        active: bool,
    }

    struct PoolStat has drop, store {
        deployed_sui: u64,
        pos_count: u64,
        out_of_range: bool,
        out_since_ms: u64,
        last_tick: u32,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        keeper: address,
        paused: bool,
        total_shares: u64,
        total_cash: u64,
        total_deployed: u64,
        pools: 0x2::table::Table<u64, PoolCfg>,
        stats: 0x2::table::Table<u64, PoolStat>,
        pool_index: 0x2::table::Table<address, u64>,
        pool_count: u64,
        shares_of: 0x2::table::Table<address, u64>,
        deposited_of: 0x2::table::Table<address, u64>,
        withdrawn_of: 0x2::table::Table<address, u64>,
        position_pool: 0x2::table::Table<0x2::object::ID, u64>,
        pending_build: 0x2::table::Table<u64, u64>,
        withdraw_fee_bps: u64,
        min_deposit: u64,
        range_mult_bps: u64,
        amp_days: u64,
        slippage_bps: u64,
    }

    struct WusdcReceived has copy, drop {
        from: address,
        amount: u64,
    }

    struct PoolAdded has copy, drop {
        idx: u64,
        pool: address,
        tick_spacing: u32,
    }

    struct PoolRemoved has copy, drop {
        idx: u64,
        pool: address,
    }

    struct Built has copy, drop {
        idx: u64,
        pos_id: 0x2::object::ID,
        sui_in: u64,
    }

    struct CashTaken has copy, drop {
        to: address,
        amount: u64,
    }

    struct ValueReported has copy, drop {
        idx: u64,
        value_sui: u64,
    }

    struct FeesReported has copy, drop {
        idx: u64,
        amount_sui: u64,
    }

    struct FeeCollected has copy, drop {
        idx: u64,
        amount_a: u64,
        amount_b: u64,
    }

    struct ForceClearOut has copy, drop {
        idx: u64,
        by: address,
    }

    struct SharesBurned has copy, drop {
        who: address,
        shares: u64,
        net_sui: u64,
        fee_sui: u64,
    }

    struct OwnerChanged has copy, drop {
        prev: address,
        next: address,
    }

    struct KeeperChanged has copy, drop {
        prev: address,
        next: address,
    }

    fun a_to_b(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * (arg1 >> 32) / 4294967296 * (arg1 >> 32) / 4294967296) as u64)
    }

    public fun accepting_pool_at(arg0: &Vault, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg0.pool_count) {
            if (pool_accepts_funds(arg0, v1)) {
                if (v0 == arg1) {
                    return v1
                };
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        arg0.pool_count
    }

    public fun accepting_pool_count(arg0: &Vault) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg0.pool_count) {
            if (pool_accepts_funds(arg0, v1)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun accepting_pools(arg0: &Vault) : u64 {
        accepting_pool_count(arg0)
    }

    public fun active_pool_count(arg0: &Vault) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg0.pool_count) {
            if (0x2::table::contains<u64, PoolCfg>(&arg0.pools, v1) && 0x2::table::borrow<u64, PoolCfg>(&arg0.pools, v1).active) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun active_pools(arg0: &Vault) : u64 {
        active_pool_count(arg0)
    }

    public fun add_pool<T0, T1>(arg0: &mut Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg4);
        let v0 = 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        assert!(!0x2::table::contains<address, u64>(&arg0.pool_index, v0), 6);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1);
        assert!(v1 > 0, 10);
        let v2 = arg0.pool_count;
        let v3 = PoolCfg{
            pool_obj_addr : v0,
            coin_a        : arg2,
            coin_b        : arg3,
            tick_spacing  : v1,
            active        : true,
        };
        0x2::table::add<u64, PoolCfg>(&mut arg0.pools, v2, v3);
        let v4 = PoolStat{
            deployed_sui : 0,
            pos_count    : 0,
            out_of_range : false,
            out_since_ms : 0,
            last_tick    : 0,
        };
        0x2::table::add<u64, PoolStat>(&mut arg0.stats, v2, v4);
        0x2::table::add<address, u64>(&mut arg0.pool_index, v0, v2);
        arg0.pool_count = v2 + 1;
        let v5 = PoolAdded{
            idx          : v2,
            pool         : v0,
            tick_spacing : v1,
        };
        0x2::event::emit<PoolAdded>(v5);
    }

    fun align_tick_i32(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1));
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            arg0
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, v0)
        }
    }

    public fun alloc_for(arg0: &Vault, arg1: u64) : u64 {
        let (v0, v1) = split_average(arg0);
        if (arg1 < v1) {
            v0 + 1
        } else {
            v0
        }
    }

    public fun amp_days(arg0: &Vault) : u64 {
        arg0.amp_days
    }

    public fun append_anchor_is_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut Vault, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_keeper(arg2, arg7);
        assert!(has_dyn(arg2, arg3, b"ppos"), 8);
        let v0 = get_dyn_id(arg2, arg3, b"ppos");
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.id, v0);
        let v2 = 0x2::coin::value<T0>(&arg4);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(get_dyn_u32(arg2, arg3, b"plo"));
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(get_dyn_u32(arg2, arg3, b"phi"));
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (_, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v3, v4, v5, v6, v2, true);
        let (v10, _) = plan_split(v3, v4, v5, v6, v2, false);
        let v12 = v10 + v10 / 50;
        let v13 = v12;
        let v14 = v2 - v2 / 20;
        if (v12 > v14) {
            v13 = v14;
        };
        let v15 = 0x2::coin::into_balance<T0>(arg4);
        let v16 = 0x2::balance::value<T0>(&v15);
        let v17 = if (v13 < v16) {
            v16 - v13
        } else {
            0
        };
        let v18 = if (v16 >= v17) {
            0x2::balance::split<T0>(&mut v15, v16 - v17)
        } else {
            0x2::balance::zero<T0>()
        };
        let v19 = v18;
        let (v20, v21) = if (0x2::balance::value<T0>(&v19) > 0) {
            let v22 = 0x2::coin::from_balance<T0>(v19, arg7);
            let (v23, v24) = swap_a_to_b<T0, T1>(arg0, arg1, v22, 0x2::coin::value<T0>(&v22), arg5, arg6, arg7);
            (0x2::coin::into_balance<T1>(v23), 0x2::coin::into_balance<T0>(v24))
        } else {
            (0x2::balance::zero<T1>(), v19)
        };
        let v25 = v21;
        let v26 = v20;
        let v27 = 0x2::balance::value<T0>(&v15) + 0x2::balance::value<T0>(&v25);
        let v28 = if (v27 == 0) {
            0
        } else {
            let (v29, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v3, v4, v5, v6, v27, true);
            v29
        };
        let v32 = if (0x2::balance::value<T1>(&v26) == 0) {
            0
        } else {
            let (v33, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v3, v4, v5, v6, 0x2::balance::value<T1>(&v26), false);
            v33
        };
        let v36 = if (v28 < v32) {
            v28
        } else {
            v32
        };
        assert!(v36 > 0, 16);
        0x2::balance::join<T0>(&mut v15, v25);
        let v37 = v36;
        let v38 = 0;
        let (v39, v40) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v3, v4, v5, v6, v36, true);
        let v41 = v40;
        let v42 = v39;
        while ((v42 > 0x2::balance::value<T0>(&v15) || v41 > 0x2::balance::value<T1>(&v26)) && v37 > 0) {
            let v43 = v37 - v37 / 1000 - 1;
            v37 = v43;
            let (v44, v45) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v3, v4, v5, v6, v43, true);
            v42 = v44;
            v41 = v45;
            let v46 = v38 + 1;
            v38 = v46;
            assert!(v46 < 2000, 16);
        };
        let v47 = v37 - v37 / 250;
        v37 = v47;
        if (v47 == 0) {
            v37 = 1;
        };
        let v48 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg1, &mut v1, v37, arg6);
        let (v49, v50) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v48);
        let v51 = &mut v15;
        let v52 = &mut v26;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, take_exact<T0>(v51, v49), take_exact<T1>(v52, v50), v48);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.id, v0, v1);
        (0x2::coin::from_balance<T0>(v15, arg7), 0x2::coin::from_balance<T1>(v26, arg7))
    }

    public fun append_anchor_is_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut Vault, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert_keeper(arg2, arg7);
        assert!(has_dyn(arg2, arg3, b"ppos"), 8);
        let v0 = get_dyn_id(arg2, arg3, b"ppos");
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.id, v0);
        let v2 = 0x2::coin::value<T1>(&arg4);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(get_dyn_u32(arg2, arg3, b"plo"));
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(get_dyn_u32(arg2, arg3, b"phi"));
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (_, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v3, v4, v5, v6, v2, false);
        let (v10, _) = plan_split(v3, v4, v5, v6, v2, true);
        let v12 = v10 + v10 / 50;
        let v13 = v12;
        let v14 = v2 - v2 / 20;
        if (v12 > v14) {
            v13 = v14;
        };
        let v15 = 0x2::coin::into_balance<T1>(arg4);
        let v16 = 0x2::balance::value<T1>(&v15);
        let v17 = if (v13 < v16) {
            v16 - v13
        } else {
            0
        };
        let v18 = if (v16 >= v17) {
            0x2::balance::split<T1>(&mut v15, v16 - v17)
        } else {
            0x2::balance::zero<T1>()
        };
        let v19 = v18;
        let (v20, v21) = if (0x2::balance::value<T1>(&v19) > 0) {
            let v22 = 0x2::coin::from_balance<T1>(v19, arg7);
            let (v23, v24) = swap_b_to_a<T0, T1>(arg0, arg1, v22, 0x2::coin::value<T1>(&v22), arg5, arg6, arg7);
            (0x2::coin::into_balance<T0>(v23), 0x2::coin::into_balance<T1>(v24))
        } else {
            (0x2::balance::zero<T0>(), v19)
        };
        let v25 = v21;
        let v26 = v20;
        let v27 = 0x2::balance::value<T1>(&v15) + 0x2::balance::value<T1>(&v25);
        let v28 = if (0x2::balance::value<T0>(&v26) == 0) {
            0
        } else {
            let (v29, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v3, v4, v5, v6, 0x2::balance::value<T0>(&v26), true);
            v29
        };
        let v32 = if (v27 == 0) {
            0
        } else {
            let (v33, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v3, v4, v5, v6, v27, false);
            v33
        };
        let v36 = if (v28 < v32) {
            v28
        } else {
            v32
        };
        assert!(v36 > 0, 16);
        0x2::balance::join<T1>(&mut v15, v25);
        let v37 = v36;
        let v38 = 0;
        let (v39, v40) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v3, v4, v5, v6, v36, true);
        let v41 = v40;
        let v42 = v39;
        while ((v42 > 0x2::balance::value<T0>(&v26) || v41 > 0x2::balance::value<T1>(&v15)) && v37 > 0) {
            let v43 = v37 - v37 / 1000 - 1;
            v37 = v43;
            let (v44, v45) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v3, v4, v5, v6, v43, true);
            v42 = v44;
            v41 = v45;
            let v46 = v38 + 1;
            v38 = v46;
            assert!(v46 < 2000, 16);
        };
        let v47 = v37 - v37 / 250;
        v37 = v47;
        if (v47 == 0) {
            v37 = 1;
        };
        let v48 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg1, &mut v1, v37, arg6);
        let (v49, v50) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v48);
        let v51 = &mut v26;
        let v52 = &mut v15;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, take_exact<T0>(v51, v49), take_exact<T1>(v52, v50), v48);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.id, v0, v1);
        (0x2::coin::from_balance<T1>(v15, arg7), 0x2::coin::from_balance<T0>(v26, arg7))
    }

    fun assert_keeper(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.keeper || v0 == arg0.owner, 2);
    }

    fun assert_owner(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
    }

    fun assert_owner_or_keeper(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner || v0 == arg0.keeper, 1);
    }

    public fun assert_rebalance_ready(arg0: &Vault, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg1 < arg0.pool_count, 8);
        let v0 = 0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1);
        assert!(v0.out_since_ms != 0, 13);
        let v1 = 0x2::clock::timestamp_ms(arg2) - v0.out_since_ms;
        assert!(v1 >= 86400000, 14);
        v1
    }

    fun b_to_a(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * 4294967296 / (arg1 >> 32) * 4294967296 / (arg1 >> 32)) as u64)
    }

    public fun build_lp_anchor_is_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u32, arg4: u32, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg3, arg4, arg7);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (_, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v2, v3, v4, v5, v1, true);
        let (v9, _) = plan_split(v2, v3, v4, v5, v1, false);
        let v11 = v9 + v9 / 50;
        let v12 = v11;
        let v13 = v1 - v1 / 20;
        if (v11 > v13) {
            v12 = v13;
        };
        let v14 = 0x2::coin::into_balance<T0>(arg2);
        let v15 = 0x2::balance::value<T0>(&v14);
        let v16 = if (v12 < v15) {
            v15 - v12
        } else {
            0
        };
        let v17 = if (v15 >= v16) {
            0x2::balance::split<T0>(&mut v14, v15 - v16)
        } else {
            0x2::balance::zero<T0>()
        };
        let v18 = v17;
        let (v19, v20) = if (0x2::balance::value<T0>(&v18) > 0) {
            let v21 = 0x2::coin::from_balance<T0>(v18, arg7);
            let (v22, v23) = swap_a_to_b<T0, T1>(arg0, arg1, v21, 0x2::coin::value<T0>(&v21), arg5, arg6, arg7);
            (0x2::coin::into_balance<T1>(v22), 0x2::coin::into_balance<T0>(v23))
        } else {
            (0x2::balance::zero<T1>(), v18)
        };
        let v24 = v20;
        let v25 = v19;
        let v26 = 0x2::balance::value<T0>(&v14) + 0x2::balance::value<T0>(&v24);
        let v27 = if (v26 == 0) {
            0
        } else {
            let (v28, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v2, v3, v4, v5, v26, true);
            v28
        };
        let v31 = if (0x2::balance::value<T1>(&v25) == 0) {
            0
        } else {
            let (v32, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v2, v3, v4, v5, 0x2::balance::value<T1>(&v25), false);
            v32
        };
        let v35 = if (v27 < v31) {
            v27
        } else {
            v31
        };
        assert!(v35 > 0, 16);
        0x2::balance::join<T0>(&mut v14, v24);
        let v36 = v35;
        let v37 = 0;
        let (v38, v39) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v2, v3, v4, v5, v35, true);
        let v40 = v39;
        let v41 = v38;
        while ((v41 > 0x2::balance::value<T0>(&v14) || v40 > 0x2::balance::value<T1>(&v25)) && v36 > 0) {
            let v42 = v36 - v36 / 1000 - 1;
            v36 = v42;
            let (v43, v44) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v2, v3, v4, v5, v42, true);
            v41 = v43;
            v40 = v44;
            let v45 = v37 + 1;
            v37 = v45;
            assert!(v45 < 2000, 16);
        };
        let v46 = v36 - v36 / 250;
        v36 = v46;
        if (v46 == 0) {
            v36 = 1;
        };
        let v47 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg1, &mut v0, v36, arg6);
        let (v48, v49) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v47);
        let v50 = &mut v14;
        let v51 = &mut v25;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, take_exact<T0>(v50, v48), take_exact<T1>(v51, v49), v47);
        (v0, 0x2::coin::from_balance<T0>(v14, arg7), 0x2::coin::from_balance<T1>(v25, arg7))
    }

    public fun build_lp_anchor_is_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u32, arg4: u32, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg3, arg4, arg7);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (_, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v2, v3, v4, v5, v1, false);
        let (v9, _) = plan_split(v2, v3, v4, v5, v1, true);
        let v11 = v9 + v9 / 50;
        let v12 = v11;
        let v13 = v1 - v1 / 20;
        if (v11 > v13) {
            v12 = v13;
        };
        let v14 = 0x2::coin::into_balance<T1>(arg2);
        let v15 = 0x2::balance::value<T1>(&v14);
        let v16 = if (v12 < v15) {
            v15 - v12
        } else {
            0
        };
        let v17 = if (v15 >= v16) {
            0x2::balance::split<T1>(&mut v14, v15 - v16)
        } else {
            0x2::balance::zero<T1>()
        };
        let v18 = v17;
        let (v19, v20) = if (0x2::balance::value<T1>(&v18) > 0) {
            let v21 = 0x2::coin::from_balance<T1>(v18, arg7);
            let (v22, v23) = swap_b_to_a<T0, T1>(arg0, arg1, v21, 0x2::coin::value<T1>(&v21), arg5, arg6, arg7);
            (0x2::coin::into_balance<T0>(v22), 0x2::coin::into_balance<T1>(v23))
        } else {
            (0x2::balance::zero<T0>(), v18)
        };
        let v24 = v20;
        let v25 = v19;
        let v26 = 0x2::balance::value<T1>(&v14) + 0x2::balance::value<T1>(&v24);
        let v27 = if (0x2::balance::value<T0>(&v25) == 0) {
            0
        } else {
            let (v28, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v2, v3, v4, v5, 0x2::balance::value<T0>(&v25), true);
            v28
        };
        let v31 = if (v26 == 0) {
            0
        } else {
            let (v32, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v2, v3, v4, v5, v26, false);
            v32
        };
        let v35 = if (v27 < v31) {
            v27
        } else {
            v31
        };
        assert!(v35 > 0, 16);
        0x2::balance::join<T1>(&mut v14, v24);
        let v36 = v35;
        let v37 = 0;
        let (v38, v39) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v2, v3, v4, v5, v35, true);
        let v40 = v39;
        let v41 = v38;
        while ((v41 > 0x2::balance::value<T0>(&v25) || v40 > 0x2::balance::value<T1>(&v14)) && v36 > 0) {
            let v42 = v36 - v36 / 1000 - 1;
            v36 = v42;
            let (v43, v44) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v2, v3, v4, v5, v42, true);
            v41 = v43;
            v40 = v44;
            let v45 = v37 + 1;
            v37 = v45;
            assert!(v45 < 2000, 16);
        };
        let v46 = v36 - v36 / 250;
        v36 = v46;
        if (v46 == 0) {
            v36 = 1;
        };
        let v47 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg1, &mut v0, v36, arg6);
        let (v48, v49) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v47);
        let v50 = &mut v25;
        let v51 = &mut v14;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, take_exact<T0>(v50, v48), take_exact<T1>(v51, v49), v47);
        (v0, 0x2::coin::from_balance<T1>(v14, arg7), 0x2::coin::from_balance<T0>(v25, arg7))
    }

    public fun burn_shares(arg0: &mut Vault, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) : (u64, u64) {
        assert_keeper(arg0, arg3);
        let v0 = get_u64(&arg0.shares_of, arg1);
        assert!(v0 >= arg2, 7);
        let v1 = arg2 * arg0.withdraw_fee_bps / 10000;
        let v2 = arg2 - v1;
        let v3 = &mut arg0.shares_of;
        set_u64(v3, arg1, v0 - arg2);
        arg0.total_shares = arg0.total_shares - arg2;
        let v4 = &mut arg0.withdrawn_of;
        set_u64(v4, arg1, get_u64(&arg0.withdrawn_of, arg1) + v2);
        let v5 = SharesBurned{
            who     : arg1,
            shares  : arg2,
            net_sui : v2,
            fee_sui : v1,
        };
        0x2::event::emit<SharesBurned>(v5);
        (v2, v1)
    }

    fun cash_join_generic<T0>(arg0: &mut Vault, arg1: vector<u8>, arg2: 0x2::balance::Balance<T0>) {
        if (direct_exists<T0>(arg0, arg1)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1), arg2);
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1, arg2);
        };
    }

    fun cash_take<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(direct_exists<T0>(arg0, b"cash_sui") && arg0.total_cash >= arg1, 9);
        arg0.total_cash = arg0.total_cash - arg1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"cash_sui"), arg1), arg2)
    }

    public fun clear_out(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg2);
        assert!(arg1 < arg0.pool_count, 8);
        abort 14
    }

    public fun clear_out_gated(arg0: &mut Vault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg3);
        assert!(arg1 < arg0.pool_count && 0x2::table::contains<u64, PoolStat>(&arg0.stats, arg1), 8);
        let v0 = 0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1);
        if (v0.out_since_ms != 0) {
            assert!(0x2::clock::timestamp_ms(arg2) - v0.out_since_ms >= 86400000, 14);
        };
        let v1 = 0x2::table::borrow_mut<u64, PoolStat>(&mut arg0.stats, arg1);
        v1.out_of_range = false;
        v1.out_since_ms = 0;
    }

    public fun collect_pos_fee<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut Vault, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_keeper(arg2, arg4);
        assert!(has_dyn(arg2, arg3, b"ppos"), 8);
        let v0 = get_dyn_id(arg2, arg3, b"ppos");
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.id, v0);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, &v1, true);
        let v4 = v3;
        let v5 = v2;
        0x2::dynamic_object_field::add<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.id, v0, v1);
        let v6 = FeeCollected{
            idx      : arg3,
            amount_a : 0x2::balance::value<T0>(&v5),
            amount_b : 0x2::balance::value<T1>(&v4),
        };
        0x2::event::emit<FeeCollected>(v6);
        (0x2::coin::from_balance<T0>(v5, arg4), 0x2::coin::from_balance<T1>(v4, arg4))
    }

    public fun compute_range(arg0: &Vault, arg1: u64, arg2: u32, arg3: u64) : (u32, u32) {
        assert!(arg1 < arg0.pool_count, 8);
        let v0 = 0x2::table::borrow<u64, PoolCfg>(&arg0.pools, arg1).tick_spacing;
        let v1 = arg3 * arg0.range_mult_bps / 10000;
        assert!(v1 <= 4294967295, 17);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32((v1 as u32));
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(align_tick_i32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v3), v0)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(align_tick_i32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v2, v3), v0)))
    }

    public fun dbg_plan<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u64) : (u64, u64, u64) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, v2, v3, arg3, false);
        let (v7, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v0, v1, v2, v3, v4, false);
        (v5, v6, v7)
    }

    fun del_dyn(arg0: &mut Vault, arg1: u64, arg2: vector<u8>) {
        let v0 = key_idx(arg2, arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<vector<u8>, 0x2::object::ID>(&mut arg0.id, v0);
        };
    }

    fun del_dyn_u32(arg0: &mut Vault, arg1: u64, arg2: vector<u8>) {
        let v0 = key_idx(arg2, arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<vector<u8>, u32>(&mut arg0.id, v0);
        };
    }

    public fun deposited_of(arg0: &Vault, arg1: address) : u64 {
        get_u64(&arg0.deposited_of, arg1)
    }

    fun direct_exists<T0>(arg0: &Vault, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_with_type<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, arg1)
    }

    fun do_force_clear_out(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner_or_keeper(arg0, arg2);
        assert!(arg1 < arg0.pool_count && 0x2::table::contains<u64, PoolStat>(&arg0.stats, arg1), 8);
        let v0 = 0x2::table::borrow_mut<u64, PoolStat>(&mut arg0.stats, arg1);
        v0.out_of_range = false;
        v0.out_since_ms = 0;
        remove_dyn(arg0, arg1, b"waso");
        remove_dyn(arg0, arg1, b"rbok");
        let v1 = ForceClearOut{
            idx : arg1,
            by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ForceClearOut>(v1);
    }

    public fun drop_pool(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 < arg0.pool_count, 8);
        let v0 = *0x2::table::borrow<u64, PoolCfg>(&arg0.pools, arg1);
        assert!(!v0.active, 5);
        let v1 = 0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1);
        assert!(v1.pos_count == 0 && v1.deployed_sui == 0, 5);
        0x2::table::remove<u64, PoolCfg>(&mut arg0.pools, arg1);
        0x2::table::remove<u64, PoolStat>(&mut arg0.stats, arg1);
        0x2::table::remove<address, u64>(&mut arg0.pool_index, v0.pool_obj_addr);
    }

    public fun force_clear_out(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        do_force_clear_out(arg0, arg1, arg2);
    }

    fun get_dyn_id(arg0: &Vault, arg1: u64, arg2: vector<u8>) : 0x2::object::ID {
        let v0 = key_idx(arg2, arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(&arg0.id, v0)
        } else {
            0x2::object::id_from_address(@0x0)
        }
    }

    fun get_dyn_u32(arg0: &Vault, arg1: u64, arg2: vector<u8>) : u32 {
        let v0 = key_idx(arg2, arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<vector<u8>, u32>(&arg0.id, v0)
        } else {
            0
        }
    }

    fun get_u64(arg0: &0x2::table::Table<address, u64>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            *0x2::table::borrow<address, u64>(arg0, arg1)
        } else {
            0
        }
    }

    fun get_u64k(arg0: &0x2::table::Table<u64, u64>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(arg0, arg1)) {
            *0x2::table::borrow<u64, u64>(arg0, arg1)
        } else {
            0
        }
    }

    fun has_dyn(arg0: &Vault, arg1: u64, arg2: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, key_idx(arg2, arg1))
    }

    public fun has_pool(arg0: &Vault, arg1: u64) : bool {
        0x2::table::contains<u64, PoolCfg>(&arg0.pools, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Vault{
            id               : 0x2::object::new(arg0),
            owner            : v0,
            keeper           : v0,
            paused           : false,
            total_shares     : 0,
            total_cash       : 0,
            total_deployed   : 0,
            pools            : 0x2::table::new<u64, PoolCfg>(arg0),
            stats            : 0x2::table::new<u64, PoolStat>(arg0),
            pool_index       : 0x2::table::new<address, u64>(arg0),
            pool_count       : 0,
            shares_of        : 0x2::table::new<address, u64>(arg0),
            deposited_of     : 0x2::table::new<address, u64>(arg0),
            withdrawn_of     : 0x2::table::new<address, u64>(arg0),
            position_pool    : 0x2::table::new<0x2::object::ID, u64>(arg0),
            pending_build    : 0x2::table::new<u64, u64>(arg0),
            withdraw_fee_bps : 100,
            min_deposit      : 1000,
            range_mult_bps   : 20000,
            amp_days         : 7,
            slippage_bps     : 300,
        };
        0x2::transfer::share_object<Vault>(v1);
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun keeper_of(arg0: &Vault) : address {
        arg0.keeper
    }

    fun key_idx(arg0: vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0;
        while (v0 < 8) {
            0x1::vector::push_back<u8>(&mut arg0, ((arg1 % 256) as u8));
            arg1 = arg1 / 256;
            v0 = v0 + 1;
        };
        arg0
    }

    public fun mark_out_of_range(arg0: &mut Vault, arg1: u64, arg2: u32, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg4);
        assert!(arg1 < arg0.pool_count && 0x2::table::contains<u64, PoolStat>(&arg0.stats, arg1), 8);
        let v0 = 0x2::table::borrow_mut<u64, PoolStat>(&mut arg0.stats, arg1);
        if (!v0.out_of_range || v0.out_since_ms == 0) {
            v0.out_since_ms = 0x2::clock::timestamp_ms(arg3);
        };
        v0.out_of_range = true;
        v0.last_tick = arg2;
    }

    public fun note_append(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg2);
        assert!(arg1 < arg0.pool_count && 0x2::table::contains<u64, PoolStat>(&arg0.stats, arg1), 8);
        let v0 = get_u64k(&arg0.pending_build, arg1);
        let v1 = &mut arg0.pending_build;
        set_u64k(v1, arg1, 0);
        let v2 = 0x2::table::borrow_mut<u64, PoolStat>(&mut arg0.stats, arg1);
        v2.deployed_sui = v2.deployed_sui + v0;
        arg0.total_deployed = arg0.total_deployed + v0;
    }

    public entry fun note_pool_pos(arg0: &mut Vault, arg1: u64, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg5);
        set_dyn_id(arg0, arg1, b"ppos", arg2);
        set_dyn_u32(arg0, arg1, b"plo", arg3);
        set_dyn_u32(arg0, arg1, b"phi", arg4);
    }

    public fun note_pos_cref<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: &T0, arg3: u32, arg4: u32, arg5: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg5);
        set_dyn_id(arg0, arg1, b"ppos", 0x2::object::id<T0>(arg2));
        set_dyn_u32(arg0, arg1, b"plo", arg3);
        set_dyn_u32(arg0, arg1, b"phi", arg4);
    }

    public fun owner_force_clear_out(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 < arg0.pool_count && 0x2::table::contains<u64, PoolStat>(&arg0.stats, arg1), 8);
        let v0 = 0x2::table::borrow_mut<u64, PoolStat>(&mut arg0.stats, arg1);
        v0.out_of_range = false;
        v0.out_since_ms = 0;
        remove_dyn(arg0, arg1, b"waso");
        remove_dyn(arg0, arg1, b"rbok");
        let v1 = ForceClearOut{
            idx : arg1,
            by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ForceClearOut>(v1);
    }

    public fun owner_of(arg0: &Vault) : address {
        arg0.owner
    }

    fun plan_split(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u64, arg5: bool) : (u64, u64) {
        if (arg4 == 0) {
            return (0, 0)
        };
        let (v0, v1, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(arg0, arg1, arg2, arg3, arg4, !arg5);
        let v3 = if (arg5) {
            a_to_b(v1, arg3)
        } else {
            b_to_a(v1, arg3)
        };
        let v4 = (v3 as u128) + (arg4 as u128);
        let v5 = if (v4 == 0) {
            0
        } else {
            v0 * (arg4 as u128) / v4
        };
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(arg0, arg1, arg2, arg3, v5, true);
        let v8 = if (arg5) {
            v6
        } else {
            v7
        };
        let v9 = if (arg5) {
            a_to_b(v8, arg3)
        } else {
            b_to_a(v8, arg3)
        };
        let v10 = if (arg4 >= v9) {
            arg4 - v9
        } else {
            0
        };
        (v9, v10)
    }

    public fun pool_accepts(arg0: &Vault, arg1: u64) : bool {
        pool_accepts_funds(arg0, arg1)
    }

    public fun pool_accepts_funds(arg0: &Vault, arg1: u64) : bool {
        if (!0x2::table::contains<u64, PoolCfg>(&arg0.pools, arg1) || !0x2::table::contains<u64, PoolStat>(&arg0.stats, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1);
        0x2::table::borrow<u64, PoolCfg>(&arg0.pools, arg1).active && !v0.out_of_range
    }

    public fun pool_active(arg0: &Vault, arg1: u64) : bool {
        0x2::table::borrow<u64, PoolCfg>(&arg0.pools, arg1).active
    }

    public fun pool_active_includes(arg0: &Vault, arg1: u64, arg2: u32) : bool {
        if (!has_dyn(arg0, arg1, b"ppos")) {
            return false
        };
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(get_dyn_u32(arg0, arg1, b"plo"))) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(get_dyn_u32(arg0, arg1, b"phi")))
    }

    public fun pool_active_lower(arg0: &Vault, arg1: u64) : u32 {
        get_dyn_u32(arg0, arg1, b"plo")
    }

    public fun pool_active_pos(arg0: &Vault, arg1: u64) : 0x2::object::ID {
        get_dyn_id(arg0, arg1, b"ppos")
    }

    public fun pool_active_upper(arg0: &Vault, arg1: u64) : u32 {
        get_dyn_u32(arg0, arg1, b"phi")
    }

    public fun pool_addr(arg0: &Vault, arg1: u64) : address {
        0x2::table::borrow<u64, PoolCfg>(&arg0.pools, arg1).pool_obj_addr
    }

    public fun pool_count(arg0: &Vault) : u64 {
        arg0.pool_count
    }

    public fun pool_deployed(arg0: &Vault, arg1: u64) : u64 {
        0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1).deployed_sui
    }

    public fun pool_out_of_range(arg0: &Vault, arg1: u64) : bool {
        0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1).out_of_range
    }

    public fun pool_out_since_ms(arg0: &Vault, arg1: u64) : u64 {
        0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1).out_since_ms
    }

    public fun pool_pending_build(arg0: &Vault, arg1: u64) : u64 {
        get_u64k(&arg0.pending_build, arg1)
    }

    public fun pool_pos_count(arg0: &Vault, arg1: u64) : u64 {
        0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1).pos_count
    }

    public fun pool_rebuild_ok(arg0: &Vault, arg1: u64) : bool {
        !0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1).out_of_range
    }

    public fun pool_tick_spacing(arg0: &Vault, arg1: u64) : u32 {
        0x2::table::borrow<u64, PoolCfg>(&arg0.pools, arg1).tick_spacing
    }

    public fun range_mult_bps(arg0: &Vault) : u64 {
        arg0.range_mult_bps
    }

    public fun rebalance_delay_ms() : u64 {
        86400000
    }

    public fun receive_wusdc<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg2);
        assert!(!arg0.paused, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg0.min_deposit, 4);
        arg0.total_cash = arg0.total_cash + v0;
        cash_join_generic<T0>(arg0, b"cash_sui", 0x2::coin::into_balance<T0>(arg1));
        let v1 = WusdcReceived{
            from   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<WusdcReceived>(v1);
    }

    public fun register_build<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg3);
        assert!(arg1 < arg0.pool_count && 0x2::table::contains<u64, PoolStat>(&arg0.stats, arg1), 8);
        assert!(0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1).pos_count == 0, 19);
        assert!(!0x2::table::borrow<u64, PoolStat>(&arg0.stats, arg1).out_of_range, 20);
        let v0 = get_u64k(&arg0.pending_build, arg1);
        let v1 = &mut arg0.pending_build;
        set_u64k(v1, arg1, 0);
        let v2 = 0x2::object::id<T0>(&arg2);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v2, arg2);
        set_dyn_id(arg0, arg1, b"ppos", v2);
        let v3 = 0x2::table::borrow_mut<u64, PoolStat>(&mut arg0.stats, arg1);
        v3.deployed_sui = v3.deployed_sui + v0;
        v3.pos_count = v3.pos_count + 1;
        arg0.total_deployed = arg0.total_deployed + v0;
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.position_pool, v2, arg1);
        let v4 = Built{
            idx    : arg1,
            pos_id : v2,
            sui_in : v0,
        };
        0x2::event::emit<Built>(v4);
    }

    fun remove_dyn(arg0: &mut Vault, arg1: u64, arg2: vector<u8>) {
        let v0 = key_idx(arg2, arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<vector<u8>, u32>(&mut arg0.id, v0);
        };
    }

    public fun remove_pool(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 < arg0.pool_count, 8);
        let v0 = 0x2::table::borrow_mut<u64, PoolCfg>(&mut arg0.pools, arg1);
        v0.active = false;
        let v1 = PoolRemoved{
            idx  : arg1,
            pool : v0.pool_obj_addr,
        };
        0x2::event::emit<PoolRemoved>(v1);
    }

    public fun report_fee(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg3);
        assert!(arg1 < arg0.pool_count, 8);
        let v0 = FeesReported{
            idx        : arg1,
            amount_sui : arg2,
        };
        0x2::event::emit<FeesReported>(v0);
    }

    public fun report_value(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg3);
        assert!(arg1 < arg0.pool_count, 8);
        let v0 = ValueReported{
            idx       : arg1,
            value_sui : arg2,
        };
        0x2::event::emit<ValueReported>(v0);
    }

    public fun set_amp_days(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 > 0, 11);
        arg0.amp_days = arg1;
    }

    fun set_dyn_id(arg0: &mut Vault, arg1: u64, arg2: vector<u8>, arg3: 0x2::object::ID) {
        let v0 = key_idx(arg2, arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::object::ID>(&mut arg0.id, v0) = arg3;
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(&mut arg0.id, v0, arg3);
        };
    }

    fun set_dyn_u32(arg0: &mut Vault, arg1: u64, arg2: vector<u8>, arg3: u32) {
        let v0 = key_idx(arg2, arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u32>(&mut arg0.id, v0) = arg3;
        } else {
            0x2::dynamic_field::add<vector<u8>, u32>(&mut arg0.id, v0, arg3);
        };
    }

    public fun set_keeper(arg0: &mut Vault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.keeper = arg1;
        let v0 = KeeperChanged{
            prev : arg0.keeper,
            next : arg1,
        };
        0x2::event::emit<KeeperChanged>(v0);
    }

    public fun set_min_deposit(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.min_deposit = arg1;
    }

    public fun set_owner(arg0: &mut Vault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.owner = arg1;
        let v0 = OwnerChanged{
            prev : arg0.owner,
            next : arg1,
        };
        0x2::event::emit<OwnerChanged>(v0);
    }

    public fun set_paused(arg0: &mut Vault, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.paused = arg1;
    }

    public fun set_pool_active(arg0: &mut Vault, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        assert!(arg1 < arg0.pool_count, 8);
        0x2::table::borrow_mut<u64, PoolCfg>(&mut arg0.pools, arg1).active = arg2;
    }

    public fun set_range_mult(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.range_mult_bps = arg1;
    }

    public fun set_slippage(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 <= 10000, 11);
        arg0.slippage_bps = arg1;
    }

    fun set_u64(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            *0x2::table::borrow_mut<address, u64>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(arg0, arg1, arg2);
        };
    }

    fun set_u64k(arg0: &mut 0x2::table::Table<u64, u64>, arg1: u64, arg2: u64) {
        if (0x2::table::contains<u64, u64>(arg0, arg1)) {
            *0x2::table::borrow_mut<u64, u64>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<u64, u64>(arg0, arg1, arg2);
        };
    }

    public fun set_withdraw_fee(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 <= 10000, 11);
        arg0.withdraw_fee_bps = arg1;
    }

    public fun share_ratio_bps(arg0: &Vault, arg1: u64) : u64 {
        if (arg0.total_shares == 0) {
            0
        } else {
            arg1 * 10000 / arg0.total_shares
        }
    }

    public fun shares_of(arg0: &Vault, arg1: address) : u64 {
        get_u64(&arg0.shares_of, arg1)
    }

    public fun slippage_bps(arg0: &Vault) : u64 {
        arg0.slippage_bps
    }

    public fun split_average(arg0: &Vault) : (u64, u64) {
        let v0 = accepting_pool_count(arg0);
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = arg0.total_cash;
        let v2 = v1 / v0;
        (v2, v1 - v2 * v0)
    }

    public fun swap_a_to_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg3, 4295048016, arg5);
        let v3 = 0x2::coin::from_balance<T1>(v1, arg6);
        assert!(0x2::coin::value<T1>(&v3) >= arg4, 15);
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::join<T0>(&mut v4, v0);
        assert!(0x2::balance::value<T0>(&v4) >= arg3, 16);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v4, arg3), 0x2::balance::zero<T1>(), v2);
        (v3, 0x2::coin::from_balance<T0>(v4, arg6))
    }

    public fun swap_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, 79226673515401279992447579055, arg5);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg6);
        assert!(0x2::coin::value<T0>(&v3) >= arg4, 15);
        let v4 = 0x2::coin::into_balance<T1>(arg2);
        0x2::balance::join<T1>(&mut v4, v1);
        assert!(0x2::balance::value<T1>(&v4) >= arg3, 16);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, arg3), v2);
        (v3, 0x2::coin::from_balance<T1>(v4, arg6))
    }

    public fun take_build<T0: store + key>(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        assert_keeper(arg0, arg2);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.position_pool, arg1), 8);
        let v0 = 0x2::table::borrow_mut<u64, PoolStat>(&mut arg0.stats, *0x2::table::borrow<0x2::object::ID, u64>(&arg0.position_pool, arg1));
        if (v0.pos_count > 0) {
            v0.pos_count = v0.pos_count - 1;
        };
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.position_pool, arg1);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    public fun take_cash_wusdc<T0>(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_keeper(arg0, arg3);
        assert!(!arg0.paused, 3);
        assert!(arg2 < arg0.pool_count, 8);
        let v0 = &mut arg0.pending_build;
        set_u64k(v0, arg2, get_u64k(&arg0.pending_build, arg2) + arg1);
        let v1 = CashTaken{
            to     : 0x2::tx_context::sender(arg3),
            amount : arg1,
        };
        0x2::event::emit<CashTaken>(v1);
        cash_take<T0>(arg0, arg1, arg3)
    }

    fun take_exact<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 16);
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun total_cash(arg0: &Vault) : u64 {
        arg0.total_cash
    }

    public fun total_deployed(arg0: &Vault) : u64 {
        arg0.total_deployed
    }

    public fun total_shares(arg0: &Vault) : u64 {
        arg0.total_shares
    }

    public fun unregister_build(arg0: &mut Vault, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg4);
        assert!(arg1 < arg0.pool_count, 8);
        assert!(arg3 <= 10000, 11);
        let v0 = 0x2::table::borrow_mut<u64, PoolStat>(&mut arg0.stats, arg1);
        let v1 = v0.deployed_sui * arg3 / 10000;
        v0.deployed_sui = v0.deployed_sui - v1;
        let v2 = if (arg0.total_deployed >= v1) {
            arg0.total_deployed - v1
        } else {
            0
        };
        arg0.total_deployed = v2;
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.position_pool, arg2)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.position_pool, arg2);
        };
        if (v0.pos_count == 0) {
            if (get_dyn_id(arg0, arg1, b"ppos") == arg2) {
                del_dyn(arg0, arg1, b"ppos");
                del_dyn_u32(arg0, arg1, b"plo");
                del_dyn_u32(arg0, arg1, b"phi");
            };
        };
    }

    public fun withdraw_fee_bps(arg0: &Vault) : u64 {
        arg0.withdraw_fee_bps
    }

    public fun withdraw_lp<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut Vault, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_keeper(arg2, arg6);
        assert!(arg4 > 0 && arg4 <= 10000, 11);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg2.position_pool, arg3), 8);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.id, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0) * (arg4 as u128) / (10000 as u128);
        assert!(v1 > 0, 18);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut v0, v1, arg5);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.id, arg3, v0);
        (0x2::coin::from_balance<T0>(v2, arg6), 0x2::coin::from_balance<T1>(v3, arg6))
    }

    public fun withdraw_plan(arg0: &mut Vault, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert_keeper(arg0, arg3);
        let v0 = get_u64(&arg0.shares_of, arg1);
        assert!(v0 >= arg2, 7);
        assert!(arg0.total_shares > 0, 11);
        let v1 = arg2 * arg0.withdraw_fee_bps / 10000;
        let v2 = arg2 - v1;
        let v3 = &mut arg0.shares_of;
        set_u64(v3, arg1, v0 - arg2);
        arg0.total_shares = arg0.total_shares - arg2;
        let v4 = &mut arg0.withdrawn_of;
        set_u64(v4, arg1, get_u64(&arg0.withdrawn_of, arg1) + v2);
        let v5 = SharesBurned{
            who     : arg1,
            shares  : arg2,
            net_sui : v2,
            fee_sui : v1,
        };
        0x2::event::emit<SharesBurned>(v5);
        (arg2 * 10000 / arg0.total_shares, v2, v1)
    }

    public fun withdrawn_of(arg0: &Vault, arg1: address) : u64 {
        get_u64(&arg0.withdrawn_of, arg1)
    }

    // decompiled from Move bytecode v7
}

