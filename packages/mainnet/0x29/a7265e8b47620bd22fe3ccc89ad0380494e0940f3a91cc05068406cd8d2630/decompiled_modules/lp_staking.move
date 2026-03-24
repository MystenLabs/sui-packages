module 0x29a7265e8b47620bd22fe3ccc89ad0380494e0940f3a91cc05068406cd8d2630::lp_staking {
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
        rate_per_ms_a: u64,
        rate_per_ms_b: u64,
        rate_per_ms_c: u64,
        rpt_stored_a: u128,
        rpt_stored_b: u128,
        rpt_stored_c: u128,
        last_update_time: u64,
        total_liquidity: u128,
        staked_positions: 0x2::table::Table<0x2::object::ID, StakedPosition>,
        player_stakes: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_distributed_a: u64,
        total_distributed_b: u64,
        total_distributed_c: u64,
        paused: bool,
    }

    struct StakedPosition has store {
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        owner: address,
        liquidity: u128,
        rpt_paid_a: u128,
        rpt_paid_b: u128,
        rpt_paid_c: u128,
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
        rewards_a: u64,
        rewards_b: u64,
        rewards_c: u64,
    }

    struct RewardsClaimed has copy, drop {
        player: address,
        amount_a: u64,
        amount_b: u64,
        amount_c: u64,
    }

    struct RewardsAdded has copy, drop {
        token: u8,
        amount: u64,
        new_rate: u64,
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

    entry fun claim_rewards<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.player_stakes, v0), 2);
        update_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1));
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.player_stakes, v0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
            let v6 = 0x2::table::borrow_mut<0x2::object::ID, StakedPosition>(&mut arg0.staked_positions, *0x1::vector::borrow<0x2::object::ID>(v4, v5));
            snapshot_position(arg0.rpt_stored_a, arg0.rpt_stored_b, arg0.rpt_stored_c, v6);
            v1 = v1 + v6.unclaimed_a;
            v2 = v2 + v6.unclaimed_b;
            v3 = v3 + v6.unclaimed_c;
            v6.unclaimed_a = 0;
            v6.unclaimed_b = 0;
            v6.unclaimed_c = 0;
            v5 = v5 + 1;
        };
        let v7 = if (v1 > 0) {
            true
        } else if (v2 > 0) {
            true
        } else {
            v3 > 0
        };
        assert!(v7, 5);
        if (v1 > 0) {
            let v8 = 0x2::balance::value<T0>(&arg0.reward_pool_a);
            let v9 = if (v1 > v8) {
                v8
            } else {
                v1
            };
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool_a, v9), arg2), v0);
                arg0.total_distributed_a = arg0.total_distributed_a + v9;
            };
        };
        if (v2 > 0) {
            let v10 = 0x2::balance::value<T1>(&arg0.reward_pool_b);
            let v11 = if (v2 > v10) {
                v10
            } else {
                v2
            };
            if (v11 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_pool_b, v11), arg2), v0);
                arg0.total_distributed_b = arg0.total_distributed_b + v11;
            };
        };
        if (v3 > 0) {
            let v12 = 0x2::balance::value<T2>(&arg0.reward_pool_c);
            let v13 = if (v3 > v12) {
                v12
            } else {
                v3
            };
            if (v13 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.reward_pool_c, v13), arg2), v0);
                arg0.total_distributed_c = arg0.total_distributed_c + v13;
            };
        };
        let v14 = RewardsClaimed{
            player   : v0,
            amount_a : v1,
            amount_b : v2,
            amount_c : v3,
        };
        0x2::event::emit<RewardsClaimed>(v14);
    }

    entry fun create_pool<T0, T1, T2>(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0, T1, T2>{
            id                  : 0x2::object::new(arg3),
            admin               : 0x2::tx_context::sender(arg3),
            target_pool         : arg1,
            reward_pool_a       : 0x2::balance::zero<T0>(),
            reward_pool_b       : 0x2::balance::zero<T1>(),
            reward_pool_c       : 0x2::balance::zero<T2>(),
            rate_per_ms_a       : 0,
            rate_per_ms_b       : 0,
            rate_per_ms_c       : 0,
            rpt_stored_a        : 0,
            rpt_stored_b        : 0,
            rpt_stored_c        : 0,
            last_update_time    : 0x2::clock::timestamp_ms(arg2),
            total_liquidity     : 0,
            staked_positions    : 0x2::table::new<0x2::object::ID, StakedPosition>(arg3),
            player_stakes       : 0x2::table::new<address, vector<0x2::object::ID>>(arg3),
            total_distributed_a : 0,
            total_distributed_b : 0,
            total_distributed_c : 0,
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
        update_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1));
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
        arg0.rate_per_ms_a = 0;
        arg0.rate_per_ms_b = 0;
        arg0.rate_per_ms_c = 0;
        arg0.paused = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
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

    fun snapshot_position(arg0: u128, arg1: u128, arg2: u128, arg3: &mut StakedPosition) {
        if (arg3.liquidity == 0) {
            return
        };
        arg3.unclaimed_a = arg3.unclaimed_a + (((arg0 - arg3.rpt_paid_a) * arg3.liquidity / 1000000000000000000) as u64);
        arg3.unclaimed_b = arg3.unclaimed_b + (((arg1 - arg3.rpt_paid_b) * arg3.liquidity / 1000000000000000000) as u64);
        arg3.unclaimed_c = arg3.unclaimed_c + (((arg2 - arg3.rpt_paid_c) * arg3.liquidity / 1000000000000000000) as u64);
        arg3.rpt_paid_a = arg0;
        arg3.rpt_paid_b = arg1;
        arg3.rpt_paid_c = arg2;
    }

    entry fun stake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg1) == arg0.target_pool, 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&arg1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(4294523696)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(443600)), 7);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg1);
        assert!(v2 > 0, 8);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1);
        update_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        let v5 = StakedPosition{
            position    : arg1,
            owner       : v3,
            liquidity   : v2,
            rpt_paid_a  : arg0.rpt_stored_a,
            rpt_paid_b  : arg0.rpt_stored_b,
            rpt_paid_c  : arg0.rpt_stored_c,
            unclaimed_a : 0,
            unclaimed_b : 0,
            unclaimed_c : 0,
        };
        0x2::table::add<0x2::object::ID, StakedPosition>(&mut arg0.staked_positions, v4, v5);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.player_stakes, v3)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.player_stakes, v3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.player_stakes, v3), v4);
        arg0.total_liquidity = arg0.total_liquidity + v2;
        let v6 = PositionStaked{
            player      : v3,
            position_id : v4,
            liquidity   : v2,
        };
        0x2::event::emit<PositionStaked>(v6);
    }

    entry fun top_up_a<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        update_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
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
        update_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
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
        update_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
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
        update_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, StakedPosition>(&mut arg0.staked_positions, arg1);
        assert!(v1.owner == v0, 3);
        snapshot_position(arg0.rpt_stored_a, arg0.rpt_stored_b, arg0.rpt_stored_c, v1);
        let v2 = v1.unclaimed_a;
        let v3 = v1.unclaimed_b;
        let v4 = v1.unclaimed_c;
        let StakedPosition {
            position    : v5,
            owner       : _,
            liquidity   : v7,
            rpt_paid_a  : _,
            rpt_paid_b  : _,
            rpt_paid_c  : _,
            unclaimed_a : _,
            unclaimed_b : _,
            unclaimed_c : _,
        } = 0x2::table::remove<0x2::object::ID, StakedPosition>(&mut arg0.staked_positions, arg1);
        arg0.total_liquidity = arg0.total_liquidity - v7;
        let v14 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.player_stakes, v0);
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x2::object::ID>(v14)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v14, v15) == arg1) {
                0x1::vector::swap_remove<0x2::object::ID>(v14, v15);
                break
            };
            v15 = v15 + 1;
        };
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v5, v0);
        if (v2 > 0) {
            let v16 = 0x2::balance::value<T0>(&arg0.reward_pool_a);
            let v17 = if (v2 > v16) {
                v16
            } else {
                v2
            };
            if (v17 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool_a, v17), arg3), v0);
                arg0.total_distributed_a = arg0.total_distributed_a + v17;
            };
        };
        if (v3 > 0) {
            let v18 = 0x2::balance::value<T1>(&arg0.reward_pool_b);
            let v19 = if (v3 > v18) {
                v18
            } else {
                v3
            };
            if (v19 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_pool_b, v19), arg3), v0);
                arg0.total_distributed_b = arg0.total_distributed_b + v19;
            };
        };
        if (v4 > 0) {
            let v20 = 0x2::balance::value<T2>(&arg0.reward_pool_c);
            let v21 = if (v4 > v20) {
                v20
            } else {
                v4
            };
            if (v21 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.reward_pool_c, v21), arg3), v0);
                arg0.total_distributed_c = arg0.total_distributed_c + v21;
            };
        };
        let v22 = PositionUnstaked{
            player      : v0,
            position_id : arg1,
            rewards_a   : v2,
            rewards_b   : v3,
            rewards_c   : v4,
        };
        0x2::event::emit<PositionUnstaked>(v22);
    }

    fun update_rpt<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: u64) {
        arg0.rpt_stored_a = calc_current_rpt(arg0.total_liquidity, arg0.rpt_stored_a, arg0.rate_per_ms_a, 0x2::balance::value<T0>(&arg0.reward_pool_a), arg0.last_update_time, arg1);
        arg0.rpt_stored_b = calc_current_rpt(arg0.total_liquidity, arg0.rpt_stored_b, arg0.rate_per_ms_b, 0x2::balance::value<T1>(&arg0.reward_pool_b), arg0.last_update_time, arg1);
        arg0.rpt_stored_c = calc_current_rpt(arg0.total_liquidity, arg0.rpt_stored_c, arg0.rate_per_ms_c, 0x2::balance::value<T2>(&arg0.reward_pool_c), arg0.last_update_time, arg1);
        arg0.last_update_time = arg1;
    }

    // decompiled from Move bytecode v6
}

