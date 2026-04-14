module 0x12b843d5322953a53c689975664a22e9ba5db52876a7d89c4b79dfc51babe774::staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Emission has drop, store {
        rate: u128,
        end_time: u64,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<T0>,
        reward_pool: 0x2::balance::Balance<T0>,
        reward_per_share: u128,
        emissions: vector<Emission>,
        total_weight: u128,
        last_update_time: u64,
        max_penalty_bps: u64,
        penalty_recipient: address,
    }

    struct StakePosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        lock_days: u64,
        start_time: u64,
        unlock_time: u64,
        weight: u128,
        reward_debt: u128,
    }

    struct Staked has copy, drop {
        position_id: 0x2::object::ID,
        staker: address,
        amount: u64,
        lock_days: u64,
        weight: u128,
        unlock_time: u64,
    }

    struct Unstaked has copy, drop {
        staker: address,
        amount_returned: u64,
        penalty: u64,
        early: bool,
    }

    struct RewardClaimed has copy, drop {
        staker: address,
        pans_amount: u64,
    }

    struct EpochAdded has copy, drop {
        amount: u64,
        duration_days: u64,
        rate: u128,
        end_time: u64,
        active_epochs: u64,
    }

    struct PenaltyRecipientUpdated has copy, drop {
        old_recipient: address,
        new_recipient: address,
    }

    struct MaxPenaltyUpdated has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    public entry fun add_reward<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &AdminCap) {
        assert!(arg2 >= 1 && arg2 <= 1000, 7);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = (arg2 as u128) * (86400000 as u128);
        update_pool_inner<T0>(arg0, v1);
        assert!((0x1::vector::length<Emission>(&arg0.emissions) as u64) < 100, 12);
        let v3 = (v0 as u128) * 1000000000000000000 / v2;
        let v4 = v1 + (v2 as u64);
        let v5 = Emission{
            rate     : v3,
            end_time : v4,
        };
        0x1::vector::push_back<Emission>(&mut arg0.emissions, v5);
        0x2::balance::join<T0>(&mut arg0.reward_pool, 0x2::coin::into_balance<T0>(arg1));
        let v6 = EpochAdded{
            amount        : v0,
            duration_days : arg2,
            rate          : v3,
            end_time      : v4,
            active_epochs : (0x1::vector::length<Emission>(&arg0.emissions) as u64),
        };
        0x2::event::emit<EpochAdded>(v6);
    }

    fun calc_pending<T0>(arg0: &StakingPool<T0>, arg1: &StakePosition<T0>) : u64 {
        pending_from_rps(arg1.weight, arg0.reward_per_share, arg1.reward_debt)
    }

    public entry fun claim_reward<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakePosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        update_pool_inner<T0>(arg0, 0x2::clock::timestamp_ms(arg2));
        let v0 = calc_pending<T0>(arg0, arg1);
        assert!(v0 > 0, 5);
        arg1.reward_debt = arg1.weight * arg0.reward_per_share;
        let v1 = 0x2::tx_context::sender(arg3);
        payout<T0>(arg0, v0, v1, arg3);
        let v2 = RewardClaimed{
            staker      : v1,
            pans_amount : v0,
        };
        0x2::event::emit<RewardClaimed>(v2);
    }

    fun cleanup_expired(arg0: &mut vector<Emission>, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Emission>(arg0)) {
            if (0x1::vector::borrow<Emission>(arg0, v0).end_time <= arg1) {
                0x1::vector::swap_remove<Emission>(arg0, v0);
                continue
            };
            v0 = v0 + 1;
        };
    }

    public entry fun create_pool<T0>(arg0: &AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 10);
        let v0 = StakingPool<T0>{
            id                : 0x2::object::new(arg3),
            total_staked      : 0x2::balance::zero<T0>(),
            reward_pool       : 0x2::balance::zero<T0>(),
            reward_per_share  : 0,
            emissions         : 0x1::vector::empty<Emission>(),
            total_weight      : 0,
            last_update_time  : 0x2::clock::timestamp_ms(arg2),
            max_penalty_bps   : 10000,
            penalty_recipient : arg1,
        };
        0x2::transfer::share_object<StakingPool<T0>>(v0);
    }

    public entry fun early_unstake<T0>(arg0: &mut StakingPool<T0>, arg1: StakePosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0 < arg1.unlock_time, 4);
        update_pool_inner<T0>(arg0, v0);
        let v2 = calc_pending<T0>(arg0, &arg1);
        let v3 = (arg1.lock_days as u128) * (86400000 as u128) * (10000 as u128);
        let v4 = ((arg1.amount as u128) * (arg0.max_penalty_bps as u128) * ((arg1.unlock_time - v0) as u128) + v3 - 1) / v3;
        let v5 = if (v4 >= (arg1.amount as u128)) {
            arg1.amount
        } else {
            (v4 as u64)
        };
        let v6 = arg1.amount - v5;
        let v7 = arg0.penalty_recipient;
        let StakePosition {
            id          : v8,
            amount      : v9,
            lock_days   : _,
            start_time  : _,
            unlock_time : _,
            weight      : v13,
            reward_debt : _,
        } = arg1;
        0x2::object::delete(v8);
        arg0.total_weight = arg0.total_weight - v13;
        if (v2 > 0) {
            payout<T0>(arg0, v2, v1, arg3);
        };
        let v15 = 0x2::balance::split<T0>(&mut arg0.total_staked, v9);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v15, v5), arg3), v7);
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v15, arg3), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v15);
        };
        let v16 = Unstaked{
            staker          : v1,
            amount_returned : v6,
            penalty         : v5,
            early           : true,
        };
        0x2::event::emit<Unstaked>(v16);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun isqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    fun payout<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool, arg1), arg3), arg2);
    }

    fun pending_from_rps(arg0: u128, arg1: u128, arg2: u128) : u64 {
        let v0 = arg0 * arg1;
        if (v0 > arg2) {
            (((v0 - arg2) / 1000000000000000000) as u64)
        } else {
            0
        }
    }

    public fun pending_rewards<T0>(arg0: &StakingPool<T0>, arg1: &StakePosition<T0>) : u64 {
        calc_pending<T0>(arg0, arg1)
    }

    public fun pending_rewards_now<T0>(arg0: &StakingPool<T0>, arg1: &StakePosition<T0>, arg2: &0x2::clock::Clock) : u64 {
        pending_from_rps(arg1.weight, simulate_rps(&arg0.emissions, arg0.reward_per_share, arg0.total_weight, arg0.last_update_time, 0x2::clock::timestamp_ms(arg2)), arg1.reward_debt)
    }

    public fun pool_info<T0>(arg0: &StakingPool<T0>) : (u64, u64, u128, u64, u64, address) {
        (0x2::balance::value<T0>(&arg0.total_staked), 0x2::balance::value<T0>(&arg0.reward_pool), arg0.total_weight, (0x1::vector::length<Emission>(&arg0.emissions) as u64), arg0.max_penalty_bps, arg0.penalty_recipient)
    }

    public fun position_info<T0>(arg0: &StakePosition<T0>) : (u64, u64, u64, u64, u128) {
        (arg0.amount, arg0.lock_days, arg0.start_time, arg0.unlock_time, arg0.weight)
    }

    public entry fun recover_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock, arg2: address, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        update_pool_inner<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        assert!(0x1::vector::is_empty<Emission>(&arg0.emissions), 9);
        let v0 = 0x2::balance::value<T0>(&arg0.reward_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool, v0), arg4), arg2);
        };
    }

    public entry fun set_max_penalty<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 <= 10000, 6);
        arg0.max_penalty_bps = arg1;
        let v0 = MaxPenaltyUpdated{
            old_bps : arg0.max_penalty_bps,
            new_bps : arg1,
        };
        0x2::event::emit<MaxPenaltyUpdated>(v0);
    }

    public entry fun set_penalty_recipient<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: &AdminCap) {
        assert!(arg1 != @0x0, 10);
        arg0.penalty_recipient = arg1;
        let v0 = PenaltyRecipientUpdated{
            old_recipient : arg0.penalty_recipient,
            new_recipient : arg1,
        };
        0x2::event::emit<PenaltyRecipientUpdated>(v0);
    }

    fun simulate_rps(arg0: &vector<Emission>, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        let v0 = arg1;
        if (arg2 == 0 || arg3 >= arg4) {
            return arg1
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<Emission>(arg0)) {
            let v2 = 0x1::vector::borrow<Emission>(arg0, v1);
            if (v2.end_time > arg3) {
                let v3 = if (arg4 < v2.end_time) {
                    arg4
                } else {
                    v2.end_time
                };
                v0 = v0 + v2.rate * ((v3 - arg3) as u128) / arg2;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 1000, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        update_pool_inner<T0>(arg0, v1);
        let v2 = (v0 as u128) * (arg2 as u128) * isqrt((arg2 as u128)) / 100;
        assert!(v2 > 0, 11);
        assert!(v2 <= 10000000000000000000, 8);
        arg0.total_weight = arg0.total_weight + v2;
        0x2::balance::join<T0>(&mut arg0.total_staked, 0x2::coin::into_balance<T0>(arg1));
        let v3 = v1 + arg2 * 86400000;
        let v4 = StakePosition<T0>{
            id          : 0x2::object::new(arg4),
            amount      : v0,
            lock_days   : arg2,
            start_time  : v1,
            unlock_time : v3,
            weight      : v2,
            reward_debt : v2 * arg0.reward_per_share,
        };
        let v5 = Staked{
            position_id : 0x2::object::id<StakePosition<T0>>(&v4),
            staker      : 0x2::tx_context::sender(arg4),
            amount      : v0,
            lock_days   : arg2,
            weight      : v2,
            unlock_time : v3,
        };
        0x2::event::emit<Staked>(v5);
        0x2::transfer::transfer<StakePosition<T0>>(v4, 0x2::tx_context::sender(arg4));
    }

    fun tick_rps(arg0: &mut vector<Emission>, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Emission>(arg0)) {
            let v2 = 0x1::vector::borrow<Emission>(arg0, v1);
            if (v2.end_time <= arg3) {
                0x1::vector::swap_remove<Emission>(arg0, v1);
                continue
            };
            let v3 = if (arg4 < v2.end_time) {
                arg4
            } else {
                v2.end_time
            };
            v0 = v0 + v2.rate * ((v3 - arg3) as u128) / arg2;
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: StakePosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0 >= arg1.unlock_time, 3);
        update_pool_inner<T0>(arg0, v0);
        let v2 = calc_pending<T0>(arg0, &arg1);
        let StakePosition {
            id          : v3,
            amount      : v4,
            lock_days   : _,
            start_time  : _,
            unlock_time : _,
            weight      : v8,
            reward_debt : _,
        } = arg1;
        0x2::object::delete(v3);
        arg0.total_weight = arg0.total_weight - v8;
        if (v2 > 0) {
            payout<T0>(arg0, v2, v1, arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v4), arg3), v1);
        let v10 = Unstaked{
            staker          : v1,
            amount_returned : v4,
            penalty         : 0,
            early           : false,
        };
        0x2::event::emit<Unstaked>(v10);
    }

    fun update_pool_inner<T0>(arg0: &mut StakingPool<T0>, arg1: u64) {
        let v0 = arg0.last_update_time;
        if (v0 >= arg1) {
            return
        };
        if (arg0.total_weight > 0) {
            let v1 = &mut arg0.emissions;
            arg0.reward_per_share = tick_rps(v1, arg0.reward_per_share, arg0.total_weight, v0, arg1);
        } else {
            let v2 = &mut arg0.emissions;
            cleanup_expired(v2, arg1);
        };
        arg0.last_update_time = arg1;
    }

    // decompiled from Move bytecode v6
}

