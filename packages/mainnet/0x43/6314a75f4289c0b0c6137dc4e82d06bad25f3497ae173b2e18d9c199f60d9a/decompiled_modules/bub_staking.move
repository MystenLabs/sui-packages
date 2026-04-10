module 0xe9700eeee69ea5b6a6296a6e5475ab7e8f51cf1929d95bcd5634d89894404c60::bub_staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingPool<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        admin: address,
        staked_balance: 0x2::balance::Balance<T0>,
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
        total_staked: u128,
        stakes: 0x2::table::Table<address, StakeInfo>,
        total_distributed_a: u64,
        total_distributed_b: u64,
        total_distributed_c: u64,
        total_burned_a: u64,
        total_burned_b: u64,
        paused: bool,
    }

    struct StakeInfo has store {
        amount: u64,
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
    }

    struct BubStaked has copy, drop {
        player: address,
        amount: u64,
        total_staked: u128,
    }

    struct BubUnstaked has copy, drop {
        player: address,
        amount: u64,
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
        a_burned: u64,
        a_redist: u64,
        a_to_pool: u64,
        b_burned: u64,
        b_redist: u64,
        b_to_pool: u64,
        sui_redist: u64,
        sui_to_pool: u64,
    }

    fun available_payout<T0>(arg0: &0x2::balance::Balance<T0>, arg1: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0) + 0x2::balance::value<T0>(arg1)
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

    fun calc_fee_bps(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            0
        };
        if (v0 >= 2592000000) {
            return 1000
        };
        7500 - ((((7500 - 1000) as u128) * (v0 as u128) / (2592000000 as u128)) as u64)
    }

    public entry fun claim_rewards<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakeInfo>(&arg0.stakes, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        update_rate_rpt<T0, T1, T2>(arg0, v1);
        let v2 = arg0.rpt_rate_a;
        let v3 = arg0.rpt_rate_b;
        let v4 = arg0.rpt_rate_c;
        let v5 = arg0.rpt_redist_a;
        let v6 = arg0.rpt_redist_b;
        let v7 = arg0.rpt_redist_c;
        let v8 = 0x2::table::borrow_mut<address, StakeInfo>(&mut arg0.stakes, v0);
        let v9 = (v8.amount as u128);
        v8.unclaimed_a = v8.unclaimed_a + (((v2 - v8.rpt_rate_paid_a) * v9 / 1000000000000000000) as u64) + (((v5 - v8.rpt_redist_paid_a) * v9 / 1000000000000000000) as u64);
        v8.unclaimed_b = v8.unclaimed_b + (((v3 - v8.rpt_rate_paid_b) * v9 / 1000000000000000000) as u64) + (((v6 - v8.rpt_redist_paid_b) * v9 / 1000000000000000000) as u64);
        v8.unclaimed_c = v8.unclaimed_c + (((v4 - v8.rpt_rate_paid_c) * v9 / 1000000000000000000) as u64) + (((v7 - v8.rpt_redist_paid_c) * v9 / 1000000000000000000) as u64);
        v8.rpt_rate_paid_a = v2;
        v8.rpt_rate_paid_b = v3;
        v8.rpt_rate_paid_c = v4;
        v8.rpt_redist_paid_a = v5;
        v8.rpt_redist_paid_b = v6;
        v8.rpt_redist_paid_c = v7;
        let v10 = v8.unclaimed_a;
        let v11 = v8.unclaimed_b;
        let v12 = v8.unclaimed_c;
        let v13 = if (v10 > 0) {
            true
        } else if (v11 > 0) {
            true
        } else {
            v12 > 0
        };
        assert!(v13, 4);
        v8.unclaimed_a = 0;
        v8.unclaimed_b = 0;
        v8.unclaimed_c = 0;
        let v14 = calc_fee_bps(v8.stake_timestamp, v1);
        v8.stake_timestamp = v1;
        let (v15, v16, v17) = process_fees_and_pay<T0, T1, T2>(arg0, v10, v11, v12, v14, v0, arg2);
        let v18 = RewardsClaimed{
            player  : v0,
            net_a   : v15,
            net_b   : v16,
            net_c   : v17,
            fee_bps : v14,
        };
        0x2::event::emit<RewardsClaimed>(v18);
    }

    public entry fun create_pool<T0, T1, T2>(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0, T1, T2>{
            id                  : 0x2::object::new(arg2),
            admin               : 0x2::tx_context::sender(arg2),
            staked_balance      : 0x2::balance::zero<T0>(),
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
            last_update_time    : 0x2::clock::timestamp_ms(arg1),
            total_staked        : 0,
            stakes              : 0x2::table::new<address, StakeInfo>(arg2),
            total_distributed_a : 0,
            total_distributed_b : 0,
            total_distributed_c : 0,
            total_burned_a      : 0,
            total_burned_b      : 0,
            paused              : false,
        };
        0x2::transfer::share_object<StakingPool<T0, T1, T2>>(v0);
        let v1 = PoolCreated{pool_id: 0x2::object::id<StakingPool<T0, T1, T2>>(&v0)};
        0x2::event::emit<PoolCreated>(v1);
    }

    public entry fun emergency_withdraw<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 5);
        update_rate_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1));
        let v0 = 0x2::balance::value<T0>(&arg0.reward_pool_a);
        let v1 = 0x2::balance::value<T1>(&arg0.reward_pool_b);
        let v2 = 0x2::balance::value<T2>(&arg0.reward_pool_c);
        let v3 = 0x2::tx_context::sender(arg2);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool_a, v0), arg2), v3);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_pool_b, v1), arg2), v3);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.reward_pool_c, v2), arg2), v3);
        };
        arg0.rate_per_ms_a = 0;
        arg0.rate_per_ms_b = 0;
        arg0.rate_per_ms_c = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun pause<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 5);
        arg0.paused = true;
    }

    fun payout_dual<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = 0x2::balance::value<T0>(arg0) + 0x2::balance::value<T0>(arg1);
        let v1 = if (arg2 <= v0) {
            arg2
        } else {
            v0
        };
        if (v1 == 0) {
            return (0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3), 0)
        };
        let v2 = 0x2::balance::value<T0>(arg0);
        if (v1 <= v2) {
            (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, v1), arg3), v1)
        } else {
            let v5 = if (v2 > 0) {
                0x2::balance::split<T0>(arg0, v2)
            } else {
                0x2::balance::zero<T0>()
            };
            let v6 = v5;
            let v7 = v1 - v2;
            let v8 = 0x2::balance::value<T0>(arg1);
            let v9 = if (v7 <= v8) {
                v7
            } else {
                v8
            };
            if (v9 > 0) {
                0x2::balance::join<T0>(&mut v6, 0x2::balance::split<T0>(arg1, v9));
            };
            (0x2::coin::from_balance<T0>(v6, arg3), 0x2::balance::value<T0>(&v6))
        }
    }

    fun process_fees_and_pay<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = (((arg1 as u128) * (arg4 as u128) / (10000 as u128)) as u64);
        let v1 = arg1 - v0;
        let v2 = (((v0 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        let v3 = (((v0 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        let v4 = 0;
        if (v2 > 0 && 0x2::balance::value<T0>(&arg0.reward_pool_a) >= v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool_a, v2), arg6), @0x0);
            v4 = v2;
            arg0.total_burned_a = arg0.total_burned_a + v2;
        };
        let v5 = 0;
        let v6 = if (v3 > 0) {
            if (0x2::balance::value<T0>(&arg0.reward_pool_a) >= v3) {
                arg0.total_staked > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v6) {
            0x2::balance::join<T0>(&mut arg0.redist_pool_a, 0x2::balance::split<T0>(&mut arg0.reward_pool_a, v3));
            arg0.rpt_redist_a = arg0.rpt_redist_a + (v3 as u128) * 1000000000000000000 / arg0.total_staked;
            v5 = v3;
        };
        let v7 = (((arg2 as u128) * (arg4 as u128) / (10000 as u128)) as u64);
        let v8 = arg2 - v7;
        let v9 = (((v7 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        let v10 = (((v7 as u128) * (3000 as u128) / (10000 as u128)) as u64);
        let v11 = 0;
        if (v9 > 0 && 0x2::balance::value<T1>(&arg0.reward_pool_b) >= v9) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_pool_b, v9), arg6), @0x0);
            v11 = v9;
            arg0.total_burned_b = arg0.total_burned_b + v9;
        };
        let v12 = 0;
        let v13 = if (v10 > 0) {
            if (0x2::balance::value<T1>(&arg0.reward_pool_b) >= v10) {
                arg0.total_staked > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v13) {
            0x2::balance::join<T1>(&mut arg0.redist_pool_b, 0x2::balance::split<T1>(&mut arg0.reward_pool_b, v10));
            arg0.rpt_redist_b = arg0.rpt_redist_b + (v10 as u128) * 1000000000000000000 / arg0.total_staked;
            v12 = v10;
        };
        let v14 = (((arg3 as u128) * (arg4 as u128) / (10000 as u128)) as u64);
        let v15 = arg3 - v14;
        let v16 = (((v14 as u128) * (5000 as u128) / (10000 as u128)) as u64);
        let v17 = 0;
        let v18 = if (v16 > 0) {
            if (0x2::balance::value<T2>(&arg0.reward_pool_c) >= v16) {
                arg0.total_staked > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v18) {
            0x2::balance::join<T2>(&mut arg0.redist_pool_c, 0x2::balance::split<T2>(&mut arg0.reward_pool_c, v16));
            arg0.rpt_redist_c = arg0.rpt_redist_c + (v16 as u128) * 1000000000000000000 / arg0.total_staked;
            v17 = v16;
        };
        let v19 = FeesProcessed{
            fee_bps     : arg4,
            a_burned    : v4,
            a_redist    : v5,
            a_to_pool   : v0 - v4 - v5,
            b_burned    : v11,
            b_redist    : v12,
            b_to_pool   : v7 - v11 - v12,
            sui_redist  : v17,
            sui_to_pool : v14 - v17,
        };
        0x2::event::emit<FeesProcessed>(v19);
        let v20 = 0;
        let v21 = 0;
        let v22 = 0;
        if (v1 > 0) {
            let v23 = &mut arg0.redist_pool_a;
            let v24 = &mut arg0.reward_pool_a;
            let (v25, v26) = payout_dual<T0>(v23, v24, v1, arg6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v25, arg5);
            v20 = v26;
        };
        if (v8 > 0) {
            let v27 = &mut arg0.redist_pool_b;
            let v28 = &mut arg0.reward_pool_b;
            let (v29, v30) = payout_dual<T1>(v27, v28, v8, arg6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v29, arg5);
            v21 = v30;
        };
        if (v15 > 0) {
            let v31 = &mut arg0.redist_pool_c;
            let v32 = &mut arg0.reward_pool_c;
            let (v33, v34) = payout_dual<T2>(v31, v32, v15, arg6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v33, arg5);
            v22 = v34;
        };
        arg0.total_distributed_a = arg0.total_distributed_a + v20;
        arg0.total_distributed_b = arg0.total_distributed_b + v21;
        arg0.total_distributed_c = arg0.total_distributed_c + v22;
        (v20, v21, v22)
    }

    public entry fun set_rates<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg5), 5);
        update_rate_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg4));
        arg0.rate_per_ms_a = arg1;
        arg0.rate_per_ms_b = arg2;
        arg0.rate_per_ms_c = arg3;
    }

    public entry fun stake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        update_rate_rpt<T0, T1, T2>(arg0, v1);
        let v2 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, StakeInfo>(&arg0.stakes, v2)) {
            let v3 = arg0.rpt_rate_a;
            let v4 = arg0.rpt_rate_b;
            let v5 = arg0.rpt_rate_c;
            let v6 = arg0.rpt_redist_a;
            let v7 = arg0.rpt_redist_b;
            let v8 = arg0.rpt_redist_c;
            let v9 = 0x2::table::borrow_mut<address, StakeInfo>(&mut arg0.stakes, v2);
            let v10 = v9.amount;
            let v11 = (v10 as u128);
            v9.unclaimed_a = v9.unclaimed_a + (((v3 - v9.rpt_rate_paid_a) * v11 / 1000000000000000000) as u64) + (((v6 - v9.rpt_redist_paid_a) * v11 / 1000000000000000000) as u64);
            v9.unclaimed_b = v9.unclaimed_b + (((v4 - v9.rpt_rate_paid_b) * v11 / 1000000000000000000) as u64) + (((v7 - v9.rpt_redist_paid_b) * v11 / 1000000000000000000) as u64);
            v9.unclaimed_c = v9.unclaimed_c + (((v5 - v9.rpt_rate_paid_c) * v11 / 1000000000000000000) as u64) + (((v8 - v9.rpt_redist_paid_c) * v11 / 1000000000000000000) as u64);
            v9.rpt_rate_paid_a = v3;
            v9.rpt_rate_paid_b = v4;
            v9.rpt_rate_paid_c = v5;
            v9.rpt_redist_paid_a = v6;
            v9.rpt_redist_paid_b = v7;
            v9.rpt_redist_paid_c = v8;
            v9.amount = v10 + v0;
            v9.stake_timestamp = ((((v9.stake_timestamp as u128) * (v10 as u128) + (v1 as u128) * (v0 as u128)) / ((v10 + v0) as u128)) as u64);
        } else {
            let v12 = StakeInfo{
                amount            : v0,
                stake_timestamp   : v1,
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
            0x2::table::add<address, StakeInfo>(&mut arg0.stakes, v2, v12);
        };
        0x2::balance::join<T0>(&mut arg0.staked_balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_staked = arg0.total_staked + (v0 as u128);
        let v13 = BubStaked{
            player       : v2,
            amount       : v0,
            total_staked : arg0.total_staked,
        };
        0x2::event::emit<BubStaked>(v13);
    }

    public entry fun top_up_a<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 5);
        update_rate_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::join<T0>(&mut arg0.reward_pool_a, 0x2::coin::into_balance<T0>(arg1));
        let v0 = 0x2::balance::value<T0>(&arg0.reward_pool_a);
        arg0.rate_per_ms_a = (((v0 as u128) * 1000000000000 / (604800000 as u128)) as u64);
        let v1 = RewardsAdded{
            token    : 0,
            amount   : v0,
            new_rate : arg0.rate_per_ms_a,
        };
        0x2::event::emit<RewardsAdded>(v1);
    }

    public entry fun top_up_b<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 5);
        update_rate_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::join<T1>(&mut arg0.reward_pool_b, 0x2::coin::into_balance<T1>(arg1));
        let v0 = 0x2::balance::value<T1>(&arg0.reward_pool_b);
        arg0.rate_per_ms_b = (((v0 as u128) * 1000000000000 / (604800000 as u128)) as u64);
        let v1 = RewardsAdded{
            token    : 1,
            amount   : v0,
            new_rate : arg0.rate_per_ms_b,
        };
        0x2::event::emit<RewardsAdded>(v1);
    }

    public entry fun top_up_c<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 5);
        update_rate_rpt<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::join<T2>(&mut arg0.reward_pool_c, 0x2::coin::into_balance<T2>(arg1));
        let v0 = 0x2::balance::value<T2>(&arg0.reward_pool_c);
        arg0.rate_per_ms_c = (((v0 as u128) * 1000000000000 / (604800000 as u128)) as u64);
        let v1 = RewardsAdded{
            token    : 2,
            amount   : v0,
            new_rate : arg0.rate_per_ms_c,
        };
        0x2::event::emit<RewardsAdded>(v1);
    }

    public entry fun unpause<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 5);
        arg0.paused = false;
    }

    public entry fun unstake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakeInfo>(&arg0.stakes, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        update_rate_rpt<T0, T1, T2>(arg0, v1);
        let StakeInfo {
            amount            : v2,
            stake_timestamp   : v3,
            rpt_rate_paid_a   : v4,
            rpt_rate_paid_b   : v5,
            rpt_rate_paid_c   : v6,
            rpt_redist_paid_a : v7,
            rpt_redist_paid_b : v8,
            rpt_redist_paid_c : v9,
            unclaimed_a       : v10,
            unclaimed_b       : v11,
            unclaimed_c       : v12,
        } = 0x2::table::remove<address, StakeInfo>(&mut arg0.stakes, v0);
        let v13 = (v2 as u128);
        let v14 = v10 + (((arg0.rpt_rate_a - v4) * v13 / 1000000000000000000) as u64) + (((arg0.rpt_redist_a - v7) * v13 / 1000000000000000000) as u64);
        let v15 = v11 + (((arg0.rpt_rate_b - v5) * v13 / 1000000000000000000) as u64) + (((arg0.rpt_redist_b - v8) * v13 / 1000000000000000000) as u64);
        let v16 = v12 + (((arg0.rpt_rate_c - v6) * v13 / 1000000000000000000) as u64) + (((arg0.rpt_redist_c - v9) * v13 / 1000000000000000000) as u64);
        let v17 = available_payout<T0>(&arg0.redist_pool_a, &arg0.reward_pool_a);
        let v18 = available_payout<T1>(&arg0.redist_pool_b, &arg0.reward_pool_b);
        let v19 = available_payout<T2>(&arg0.redist_pool_c, &arg0.reward_pool_c);
        let v20 = if (v14 > v17) {
            v17
        } else {
            v14
        };
        let v21 = if (v15 > v18) {
            v18
        } else {
            v15
        };
        let v22 = if (v16 > v19) {
            v19
        } else {
            v16
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked_balance, v2), arg2), v0);
        arg0.total_staked = arg0.total_staked - (v2 as u128);
        let (v23, v24, v25) = process_fees_and_pay<T0, T1, T2>(arg0, v20, v21, v22, calc_fee_bps(v3, v1), v0, arg2);
        let v26 = BubUnstaked{
            player : v0,
            amount : v2,
            net_a  : v23,
            net_b  : v24,
            net_c  : v25,
        };
        0x2::event::emit<BubUnstaked>(v26);
    }

    fun update_rate_rpt<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: u64) {
        arg0.rpt_rate_a = calc_current_rpt(arg0.total_staked, arg0.rpt_rate_a, arg0.rate_per_ms_a, 0x2::balance::value<T0>(&arg0.reward_pool_a), arg0.last_update_time, arg1);
        arg0.rpt_rate_b = calc_current_rpt(arg0.total_staked, arg0.rpt_rate_b, arg0.rate_per_ms_b, 0x2::balance::value<T1>(&arg0.reward_pool_b), arg0.last_update_time, arg1);
        arg0.rpt_rate_c = calc_current_rpt(arg0.total_staked, arg0.rpt_rate_c, arg0.rate_per_ms_c, 0x2::balance::value<T2>(&arg0.reward_pool_c), arg0.last_update_time, arg1);
        arg0.last_update_time = arg1;
    }

    // decompiled from Move bytecode v7
}

