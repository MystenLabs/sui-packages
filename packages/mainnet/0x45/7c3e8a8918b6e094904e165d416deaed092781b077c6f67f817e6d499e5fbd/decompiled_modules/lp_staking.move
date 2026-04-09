module 0xe1b3941adf6810f20163fe3e29f0d35b466c152cd2bcc3c18970d8bc4e65c0d::lp_staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingPool<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        admin: address,
        target_pool: 0x2::object::ID,
        reward_pool_a: 0x2::balance::Balance<T0>,
        reward_pool_b: 0x2::balance::Balance<T1>,
        reward_pool_c: 0x2::balance::Balance<T2>,
        redist_pool_a: 0x2::balance::Balance<T0>,
        redist_pool_b: 0x2::balance::Balance<T1>,
        redist_pool_c: 0x2::balance::Balance<T2>,
        rate_per_ms_a: u64,
        rate_per_ms_b: u64,
        rate_per_ms_c: u64,
        rpt_rate_a: u128,
        rpt_rate_b: u128,
        rpt_rate_c: u128,
        rpt_redist_a: u128,
        rpt_redist_b: u128,
        rpt_redist_c: u128,
        last_update_time: u64,
        total_liquidity: u128,
        staked_positions: 0x2::table::Table<0x2::object::ID, StakedPosition>,
        player_stakes: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_distributed_a: u64,
        total_distributed_b: u64,
        total_distributed_c: u64,
        total_burned_b: u64,
        total_burned_c: u64,
        paused: bool,
    }

    struct StakedPosition has store {
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        owner: address,
        liquidity: u128,
        stake_timestamp: u64,
        rpt_rate_paid_a: u128,
        rpt_rate_paid_b: u128,
        rpt_rate_paid_c: u128,
        rpt_redist_paid_a: u128,
        rpt_redist_paid_b: u128,
        rpt_redist_paid_c: u128,
        unclaimed_a: u64,
        unclaimed_b: u64,
        unclaimed_c: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        target_pool: 0x2::object::ID,
    }

    struct PositionStaked has copy, drop {
        player: address,
        position_id: 0x2::object::ID,
        liquidity: u128,
    }

    struct PositionUnstaked has copy, drop {
        player: address,
        position_id: 0x2::object::ID,
        net_a: u64,
        net_b: u64,
        net_c: u64,
    }

    struct RewardsClaimed has copy, drop {
        player: address,
        net_a: u64,
        net_b: u64,
        net_c: u64,
        fee_bps: u64,
    }

    struct RewardsAdded has copy, drop {
        token: u8,
        amount: u64,
        new_rate: u64,
    }

    struct FeesProcessed has copy, drop {
        fee_bps: u64,
        sui_redist: u64,
        sui_to_pool: u64,
        b_burned: u64,
        b_redist: u64,
        b_to_pool: u64,
        c_burned: u64,
        c_redist: u64,
        c_to_pool: u64,
    }

    fun calc_current_rpt(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u128 {
        if (arg0 == 0) {
            return arg1
        };
        let v0 = if (arg5 > arg4) {
            arg5 - arg4
        } else {
            0
        };
        let v1 = (v0 as u128) * (arg2 as u128) / 1000000000000;
        let v2 = (arg3 as u128);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        arg1 + v3 * 1000000000000000000 / arg0
    }

    fun calculate_fee_bps(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            0
        };
        if (v0 >= 2592000000) {
            return 1000
        };
        7500 - (((v0 as u128) * ((7500 - 1000) as u128) / (2592000000 as u128)) as u64)
    }

    entry fun claim_rewards<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.player_stakes, v0), 2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        update_rate_rpt<T0, T1, T2>(arg0, v1);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = v1;
        let v6 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.player_stakes, v0);
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
            let v8 = 0x2::table::borrow_mut<0x2::object::ID, StakedPosition>(&mut arg0.staked_positions, *0x1::vector::borrow<0x2::object::ID>(v6, v7));
            snapshot_position(arg0.rpt_rate_a, arg0.rpt_rate_b, arg0.rpt_rate_c, arg0.rpt_redist_a, arg0.rpt_redist_b, arg0.rpt_redist_c, v8);
            v2 = v2 + v8.unclaimed_a;
            v3 = v3 + v8.unclaimed_b;
            v4 = v4 + v8.unclaimed_c;
            if (v8.stake_timestamp < v5) {
                v5 = v8.stake_timestamp;
            };
            v8.unclaimed_a = 0;
            v8.unclaimed_b = 0;
            v8.unclaimed_c = 0;
            v8.stake_timestamp = v1;
            v7 = v7 + 1;
        };
        let v9 = if (v2 > 0) {
            true
        } else if (v3 > 0) {
            true
        } else {
            v4 > 0
        };
        assert!(v9, 5);
        let v10 = calculate_fee_bps(v5, v1);
        let v11 = (((v2 as u128) * (v10 as u128) / (10000 as u128)) as u64);
        let v12 = (((v11 as u128) * (5000 as u128) / (10000 as u128)) as u64);
        if (v12 > 0 && 0x2::balance::value<T0>(&arg0.reward_pool_a) >= v12) {
            0x2::balance::join<T0>(&mut arg0.redist_pool_a, 0x2::balance::split<T0>(&mut arg0.reward_pool_a, v12));
            if (arg0.total_liquidity > 0) {
                arg0.rpt_redist_a = arg0.rpt_redist_a + (v12 as u128) * 1000000000000000000 / arg0.total_liquidity;
            };
        };
        let v13 = (((v3 as u128) * (v10 as u128) / (10000 as u128)) as u64);
        let v14 = (((v13 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        let v15 = (((v13 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        if (v14 > 0 && 0x2::balance::value<T1>(&arg0.reward_pool_b) >= v14) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_pool_b, v14), arg2), @0x0);
            arg0.total_burned_b = arg0.total_burned_b + v14;
        };
        if (v15 > 0 && 0x2::balance::value<T1>(&arg0.reward_pool_b) >= v15) {
            0x2::balance::join<T1>(&mut arg0.redist_pool_b, 0x2::balance::split<T1>(&mut arg0.reward_pool_b, v15));
            if (arg0.total_liquidity > 0) {
                arg0.rpt_redist_b = arg0.rpt_redist_b + (v15 as u128) * 1000000000000000000 / arg0.total_liquidity;
            };
        };
        let v16 = (((v4 as u128) * (v10 as u128) / (10000 as u128)) as u64);
        let v17 = (((v16 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        let v18 = (((v16 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        if (v17 > 0 && 0x2::balance::value<T2>(&arg0.reward_pool_c) >= v17) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.reward_pool_c, v17), arg2), @0x0);
            arg0.total_burned_c = arg0.total_burned_c + v17;
        };
        if (v18 > 0 && 0x2::balance::value<T2>(&arg0.reward_pool_c) >= v18) {
            0x2::balance::join<T2>(&mut arg0.redist_pool_c, 0x2::balance::split<T2>(&mut arg0.reward_pool_c, v18));
            if (arg0.total_liquidity > 0) {
                arg0.rpt_redist_c = arg0.rpt_redist_c + (v18 as u128) * 1000000000000000000 / arg0.total_liquidity;
            };
        };
        let v19 = &mut arg0.redist_pool_a;
        let v20 = &mut arg0.reward_pool_a;
        let v21 = payout_dual<T0>(v19, v20, v2 - v11, v0, arg2);
        let v22 = &mut arg0.redist_pool_b;
        let v23 = &mut arg0.reward_pool_b;
        let v24 = payout_dual<T1>(v22, v23, v3 - v13, v0, arg2);
        let v25 = &mut arg0.redist_pool_c;
        let v26 = &mut arg0.reward_pool_c;
        let v27 = payout_dual<T2>(v25, v26, v4 - v16, v0, arg2);
        arg0.total_distributed_a = arg0.total_distributed_a + v21;
        arg0.total_distributed_b = arg0.total_distributed_b + v24;
        arg0.total_distributed_c = arg0.total_distributed_c + v27;
        let v28 = FeesProcessed{
            fee_bps     : v10,
            sui_redist  : v12,
            sui_to_pool : v11 - v12,
            b_burned    : v14,
            b_redist    : v15,
            b_to_pool   : v13 - v14 - v15,
            c_burned    : v17,
            c_redist    : v18,
            c_to_pool   : v16 - v17 - v18,
        };
        0x2::event::emit<FeesProcessed>(v28);
        let v29 = RewardsClaimed{
            player  : v0,
            net_a   : v21,
            net_b   : v24,
            net_c   : v27,
            fee_bps : v10,
        };
        0x2::event::emit<RewardsClaimed>(v29);
    }

    entry fun create_pool<T0, T1, T2>(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0, T1, T2>{
            id                  : 0x2::object::new(arg3),
            admin               : 0x2::tx_context::sender(arg3),
            target_pool         : arg1,
            reward_pool_a       : 0x2::balance::zero<T0>(),
            reward_pool_b       : 0x2::balance::zero<T1>(),
            reward_pool_c       : 0x2::balance::zero<T2>(),
            redist_pool_a       : 0x2::balance::zero<T0>(),
            redist_pool_b       : 0x2::balance::zero<T1>(),
            redist_pool_c       : 0x2::balance::zero<T2>(),
            rate_per_ms_a       : 0,
            rate_per_ms_b       : 0,
            rate_per_ms_c       : 0,
            rpt_rate_a          : 0,
            rpt_rate_b          : 0,
            rpt_rate_c          : 0,
            rpt_redist_a        : 0,
            rpt_redist_b        : 0,
            rpt_redist_c        : 0,
            last_update_time    : 0x2::clock::timestamp_ms(arg2),
            total_liquidity     : 0,
            staked_positions    : 0x2::table::new<0x2::object::ID, StakedPosition>(arg3),
            player_stakes       : 0x2::table::new<address, vector<0x2::object::ID>>(arg3),
            total_distributed_a : 0,
            total_distributed_b : 0,
            total_distributed_c : 0,
            total_burned_b      : 0,
            total_burned_c      : 0,
            paused              : false,
        };
        let v1 = PoolCreated{
            pool_id     : 0x2::object::id<StakingPool<T0, T1, T2>>(&v0),
            target_pool : arg1,
        };
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<StakingPool<T0, T1, T2>>(v0);
    }

    entry fun emergency_withdraw<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        update_rate_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1));
        let v0 = arg0.admin;
        let v1 = 0x2::balance::value<T0>(&arg0.reward_pool_a);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool_a, v1), arg2), v0);
        };
        let v2 = 0x2::balance::value<T1>(&arg0.reward_pool_b);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_pool_b, v2), arg2), v0);
        };
        let v3 = 0x2::balance::value<T2>(&arg0.reward_pool_c);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.reward_pool_c, v3), arg2), v0);
        };
        let v4 = 0x2::balance::value<T0>(&arg0.redist_pool_a);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.redist_pool_a, v4), arg2), v0);
        };
        let v5 = 0x2::balance::value<T1>(&arg0.redist_pool_b);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.redist_pool_b, v5), arg2), v0);
        };
        let v6 = 0x2::balance::value<T2>(&arg0.redist_pool_c);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.redist_pool_c, v6), arg2), v0);
        };
        arg0.rate_per_ms_a = 0;
        arg0.rate_per_ms_b = 0;
        arg0.rate_per_ms_c = 0;
        arg0.paused = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun payout_dual<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = arg2;
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::value<T0>(arg0);
        if (v2 > 0 && arg2 > 0) {
            let v3 = if (arg2 > v2) {
                v2
            } else {
                arg2
            };
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(arg0, v3));
            v0 = arg2 - v3;
        };
        if (v0 > 0) {
            let v4 = 0x2::balance::value<T0>(arg1);
            if (v4 > 0) {
                let v5 = if (v0 > v4) {
                    v4
                } else {
                    v0
                };
                0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(arg1, v5));
            };
        };
        let v6 = 0x2::balance::value<T0>(&v1);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4), arg3);
        } else {
            0x2::balance::destroy_zero<T0>(v1);
        };
        v6
    }

    fun recalc_rate(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        (((arg0 as u128) * 1000000000000 / (arg1 as u128)) as u64)
    }

    entry fun set_paused<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.paused = arg1;
    }

    entry fun set_rates<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 6);
        update_rate_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg4));
        arg0.rate_per_ms_a = arg1;
        arg0.rate_per_ms_b = arg2;
        arg0.rate_per_ms_c = arg3;
    }

    fun snapshot_position(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: &mut StakedPosition) {
        if (arg6.liquidity == 0) {
            return
        };
        let v0 = arg6.liquidity;
        arg6.unclaimed_a = arg6.unclaimed_a + (((arg0 - arg6.rpt_rate_paid_a) * v0 / 1000000000000000000) as u64);
        arg6.unclaimed_b = arg6.unclaimed_b + (((arg1 - arg6.rpt_rate_paid_b) * v0 / 1000000000000000000) as u64);
        arg6.unclaimed_c = arg6.unclaimed_c + (((arg2 - arg6.rpt_rate_paid_c) * v0 / 1000000000000000000) as u64);
        arg6.rpt_rate_paid_a = arg0;
        arg6.rpt_rate_paid_b = arg1;
        arg6.rpt_rate_paid_c = arg2;
        arg6.unclaimed_a = arg6.unclaimed_a + (((arg3 - arg6.rpt_redist_paid_a) * v0 / 1000000000000000000) as u64);
        arg6.unclaimed_b = arg6.unclaimed_b + (((arg4 - arg6.rpt_redist_paid_b) * v0 / 1000000000000000000) as u64);
        arg6.unclaimed_c = arg6.unclaimed_c + (((arg5 - arg6.rpt_redist_paid_c) * v0 / 1000000000000000000) as u64);
        arg6.rpt_redist_paid_a = arg3;
        arg6.rpt_redist_paid_b = arg4;
        arg6.rpt_redist_paid_c = arg5;
    }

    entry fun stake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg1) == arg0.target_pool, 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&arg1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(4294523696)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(443600)), 7);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg1);
        assert!(v2 > 0, 8);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1);
        update_rate_rpt<T0, T1, T2>(arg0, v3);
        let v6 = StakedPosition{
            position          : arg1,
            owner             : v4,
            liquidity         : v2,
            stake_timestamp   : v3,
            rpt_rate_paid_a   : arg0.rpt_rate_a,
            rpt_rate_paid_b   : arg0.rpt_rate_b,
            rpt_rate_paid_c   : arg0.rpt_rate_c,
            rpt_redist_paid_a : arg0.rpt_redist_a,
            rpt_redist_paid_b : arg0.rpt_redist_b,
            rpt_redist_paid_c : arg0.rpt_redist_c,
            unclaimed_a       : 0,
            unclaimed_b       : 0,
            unclaimed_c       : 0,
        };
        0x2::table::add<0x2::object::ID, StakedPosition>(&mut arg0.staked_positions, v5, v6);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.player_stakes, v4)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.player_stakes, v4, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.player_stakes, v4), v5);
        arg0.total_liquidity = arg0.total_liquidity + v2;
        let v7 = PositionStaked{
            player      : v4,
            position_id : v5,
            liquidity   : v2,
        };
        0x2::event::emit<PositionStaked>(v7);
    }

    entry fun top_up_a<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        update_rate_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::join<T0>(&mut arg0.reward_pool_a, 0x2::coin::into_balance<T0>(arg1));
        let v0 = 0x2::balance::value<T0>(&arg0.reward_pool_a);
        arg0.rate_per_ms_a = recalc_rate(v0, 604800000);
        let v1 = RewardsAdded{
            token    : 0,
            amount   : v0,
            new_rate : arg0.rate_per_ms_a,
        };
        0x2::event::emit<RewardsAdded>(v1);
    }

    entry fun top_up_b<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        update_rate_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::join<T1>(&mut arg0.reward_pool_b, 0x2::coin::into_balance<T1>(arg1));
        let v0 = 0x2::balance::value<T1>(&arg0.reward_pool_b);
        arg0.rate_per_ms_b = recalc_rate(v0, 604800000);
        let v1 = RewardsAdded{
            token    : 1,
            amount   : v0,
            new_rate : arg0.rate_per_ms_b,
        };
        0x2::event::emit<RewardsAdded>(v1);
    }

    entry fun top_up_c<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        update_rate_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::join<T2>(&mut arg0.reward_pool_c, 0x2::coin::into_balance<T2>(arg1));
        let v0 = 0x2::balance::value<T2>(&arg0.reward_pool_c);
        arg0.rate_per_ms_c = recalc_rate(v0, 604800000);
        let v1 = RewardsAdded{
            token    : 2,
            amount   : v0,
            new_rate : arg0.rate_per_ms_c,
        };
        0x2::event::emit<RewardsAdded>(v1);
    }

    entry fun unstake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, StakedPosition>(&arg0.staked_positions, arg1), 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        update_rate_rpt<T0, T1, T2>(arg0, v1);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, StakedPosition>(&mut arg0.staked_positions, arg1);
        assert!(v2.owner == v0, 3);
        snapshot_position(arg0.rpt_rate_a, arg0.rpt_rate_b, arg0.rpt_rate_c, arg0.rpt_redist_a, arg0.rpt_redist_b, arg0.rpt_redist_c, v2);
        let v3 = v2.unclaimed_a;
        let v4 = v2.unclaimed_b;
        let v5 = v2.unclaimed_c;
        let v6 = v2.stake_timestamp;
        let StakedPosition {
            position          : v7,
            owner             : _,
            liquidity         : v9,
            stake_timestamp   : _,
            rpt_rate_paid_a   : _,
            rpt_rate_paid_b   : _,
            rpt_rate_paid_c   : _,
            rpt_redist_paid_a : _,
            rpt_redist_paid_b : _,
            rpt_redist_paid_c : _,
            unclaimed_a       : _,
            unclaimed_b       : _,
            unclaimed_c       : _,
        } = 0x2::table::remove<0x2::object::ID, StakedPosition>(&mut arg0.staked_positions, arg1);
        arg0.total_liquidity = arg0.total_liquidity - v9;
        let v20 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.player_stakes, v0);
        let v21 = 0;
        while (v21 < 0x1::vector::length<0x2::object::ID>(v20)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v20, v21) == arg1) {
                0x1::vector::swap_remove<0x2::object::ID>(v20, v21);
                break
            };
            v21 = v21 + 1;
        };
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v7, v0);
        let v22 = calculate_fee_bps(v6, v1);
        let v23 = (((v3 as u128) * (v22 as u128) / (10000 as u128)) as u64);
        let v24 = (((v23 as u128) * (5000 as u128) / (10000 as u128)) as u64);
        if (v24 > 0 && 0x2::balance::value<T0>(&arg0.reward_pool_a) >= v24) {
            0x2::balance::join<T0>(&mut arg0.redist_pool_a, 0x2::balance::split<T0>(&mut arg0.reward_pool_a, v24));
            if (arg0.total_liquidity > 0) {
                arg0.rpt_redist_a = arg0.rpt_redist_a + (v24 as u128) * 1000000000000000000 / arg0.total_liquidity;
            };
        };
        let v25 = (((v4 as u128) * (v22 as u128) / (10000 as u128)) as u64);
        let v26 = (((v25 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        let v27 = (((v25 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        if (v26 > 0 && 0x2::balance::value<T1>(&arg0.reward_pool_b) >= v26) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_pool_b, v26), arg3), @0x0);
            arg0.total_burned_b = arg0.total_burned_b + v26;
        };
        if (v27 > 0 && 0x2::balance::value<T1>(&arg0.reward_pool_b) >= v27) {
            0x2::balance::join<T1>(&mut arg0.redist_pool_b, 0x2::balance::split<T1>(&mut arg0.reward_pool_b, v27));
            if (arg0.total_liquidity > 0) {
                arg0.rpt_redist_b = arg0.rpt_redist_b + (v27 as u128) * 1000000000000000000 / arg0.total_liquidity;
            };
        };
        let v28 = (((v5 as u128) * (v22 as u128) / (10000 as u128)) as u64);
        let v29 = (((v28 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        let v30 = (((v28 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        if (v29 > 0 && 0x2::balance::value<T2>(&arg0.reward_pool_c) >= v29) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.reward_pool_c, v29), arg3), @0x0);
            arg0.total_burned_c = arg0.total_burned_c + v29;
        };
        if (v30 > 0 && 0x2::balance::value<T2>(&arg0.reward_pool_c) >= v30) {
            0x2::balance::join<T2>(&mut arg0.redist_pool_c, 0x2::balance::split<T2>(&mut arg0.reward_pool_c, v30));
            if (arg0.total_liquidity > 0) {
                arg0.rpt_redist_c = arg0.rpt_redist_c + (v30 as u128) * 1000000000000000000 / arg0.total_liquidity;
            };
        };
        let v31 = &mut arg0.redist_pool_a;
        let v32 = &mut arg0.reward_pool_a;
        let v33 = payout_dual<T0>(v31, v32, v3 - v23, v0, arg3);
        let v34 = &mut arg0.redist_pool_b;
        let v35 = &mut arg0.reward_pool_b;
        let v36 = payout_dual<T1>(v34, v35, v4 - v25, v0, arg3);
        let v37 = &mut arg0.redist_pool_c;
        let v38 = &mut arg0.reward_pool_c;
        let v39 = payout_dual<T2>(v37, v38, v5 - v28, v0, arg3);
        arg0.total_distributed_a = arg0.total_distributed_a + v33;
        arg0.total_distributed_b = arg0.total_distributed_b + v36;
        arg0.total_distributed_c = arg0.total_distributed_c + v39;
        let v40 = PositionUnstaked{
            player      : v0,
            position_id : arg1,
            net_a       : v33,
            net_b       : v36,
            net_c       : v39,
        };
        0x2::event::emit<PositionUnstaked>(v40);
    }

    fun update_rate_rpt<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: u64) {
        arg0.rpt_rate_a = calc_current_rpt(arg0.total_liquidity, arg0.rpt_rate_a, arg0.rate_per_ms_a, 0x2::balance::value<T0>(&arg0.reward_pool_a), arg0.last_update_time, arg1);
        arg0.rpt_rate_b = calc_current_rpt(arg0.total_liquidity, arg0.rpt_rate_b, arg0.rate_per_ms_b, 0x2::balance::value<T1>(&arg0.reward_pool_b), arg0.last_update_time, arg1);
        arg0.rpt_rate_c = calc_current_rpt(arg0.total_liquidity, arg0.rpt_rate_c, arg0.rate_per_ms_c, 0x2::balance::value<T2>(&arg0.reward_pool_c), arg0.last_update_time, arg1);
        arg0.last_update_time = arg1;
    }

    // decompiled from Move bytecode v7
}

