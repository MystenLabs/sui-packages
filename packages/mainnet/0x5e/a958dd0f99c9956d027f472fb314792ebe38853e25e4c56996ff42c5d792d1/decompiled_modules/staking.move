module 0x5ea958dd0f99c9956d027f472fb314792ebe38853e25e4c56996ff42c5d792d1::staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Emission has drop, store {
        rate: u128,
        end_time: u64,
    }

    struct StakingPool<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<T0>,
        lumo_reward_pool: 0x2::balance::Balance<T0>,
        reward_per_share_lumo: u128,
        emissions_lumo: vector<Emission>,
        sui_reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        reward_per_share_sui: u128,
        emissions_sui: vector<Emission>,
        pans_reward_pool: 0x2::balance::Balance<T1>,
        reward_per_share_pans: u128,
        emissions_pans: vector<Emission>,
        usdc_reward_pool: 0x2::balance::Balance<T2>,
        reward_per_share_usdc: u128,
        emissions_usdc: vector<Emission>,
        total_weight: u128,
        last_update_time: u64,
        max_penalty_bps: u64,
        penalty_recipient: address,
    }

    struct StakePosition<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        lock_days: u64,
        start_time: u64,
        unlock_time: u64,
        weight: u128,
        reward_debt_lumo: u128,
        reward_debt_sui: u128,
        reward_debt_pans: u128,
        reward_debt_usdc: u128,
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
        lumo_amount: u64,
        sui_amount: u64,
        pans_amount: u64,
        usdc_amount: u64,
    }

    struct EpochAdded has copy, drop {
        token: u8,
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

    public entry fun add_lumo_reward<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &AdminCap) {
        assert!(arg2 >= 1 && arg2 <= 1000, 7);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = (arg2 as u128) * (86400000 as u128);
        update_pool_inner<T0, T1, T2>(arg0, v1);
        let v3 = (v0 as u128) * 1000000000000000000 / v2;
        let v4 = v1 + (v2 as u64);
        let v5 = Emission{
            rate     : v3,
            end_time : v4,
        };
        0x1::vector::push_back<Emission>(&mut arg0.emissions_lumo, v5);
        0x2::balance::join<T0>(&mut arg0.lumo_reward_pool, 0x2::coin::into_balance<T0>(arg1));
        let v6 = EpochAdded{
            token         : 0,
            amount        : v0,
            duration_days : arg2,
            rate          : v3,
            end_time      : v4,
            active_epochs : (0x1::vector::length<Emission>(&arg0.emissions_lumo) as u64),
        };
        0x2::event::emit<EpochAdded>(v6);
    }

    public entry fun add_pans_reward<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &AdminCap) {
        assert!(arg2 >= 1 && arg2 <= 1000, 7);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = (arg2 as u128) * (86400000 as u128);
        update_pool_inner<T0, T1, T2>(arg0, v1);
        let v3 = (v0 as u128) * 1000000000000000000 / v2;
        let v4 = v1 + (v2 as u64);
        let v5 = Emission{
            rate     : v3,
            end_time : v4,
        };
        0x1::vector::push_back<Emission>(&mut arg0.emissions_pans, v5);
        0x2::balance::join<T1>(&mut arg0.pans_reward_pool, 0x2::coin::into_balance<T1>(arg1));
        let v6 = EpochAdded{
            token         : 2,
            amount        : v0,
            duration_days : arg2,
            rate          : v3,
            end_time      : v4,
            active_epochs : (0x1::vector::length<Emission>(&arg0.emissions_pans) as u64),
        };
        0x2::event::emit<EpochAdded>(v6);
    }

    public entry fun add_sui_reward<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &AdminCap) {
        assert!(arg2 >= 1 && arg2 <= 1000, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = (arg2 as u128) * (86400000 as u128);
        update_pool_inner<T0, T1, T2>(arg0, v1);
        let v3 = (v0 as u128) * 1000000000000000000 / v2;
        let v4 = v1 + (v2 as u64);
        let v5 = Emission{
            rate     : v3,
            end_time : v4,
        };
        0x1::vector::push_back<Emission>(&mut arg0.emissions_sui, v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v6 = EpochAdded{
            token         : 1,
            amount        : v0,
            duration_days : arg2,
            rate          : v3,
            end_time      : v4,
            active_epochs : (0x1::vector::length<Emission>(&arg0.emissions_sui) as u64),
        };
        0x2::event::emit<EpochAdded>(v6);
    }

    public entry fun add_usdc_reward<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &AdminCap) {
        assert!(arg2 >= 1 && arg2 <= 1000, 7);
        let v0 = 0x2::coin::value<T2>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = (arg2 as u128) * (86400000 as u128);
        update_pool_inner<T0, T1, T2>(arg0, v1);
        let v3 = (v0 as u128) * 1000000000000000000 / v2;
        let v4 = v1 + (v2 as u64);
        let v5 = Emission{
            rate     : v3,
            end_time : v4,
        };
        0x1::vector::push_back<Emission>(&mut arg0.emissions_usdc, v5);
        0x2::balance::join<T2>(&mut arg0.usdc_reward_pool, 0x2::coin::into_balance<T2>(arg1));
        let v6 = EpochAdded{
            token         : 3,
            amount        : v0,
            duration_days : arg2,
            rate          : v3,
            end_time      : v4,
            active_epochs : (0x1::vector::length<Emission>(&arg0.emissions_usdc) as u64),
        };
        0x2::event::emit<EpochAdded>(v6);
    }

    fun calc_pending<T0, T1, T2>(arg0: &StakingPool<T0, T1, T2>, arg1: &StakePosition<T0, T1, T2>) : (u64, u64, u64, u64) {
        (pending_from_rps(arg1.weight, arg0.reward_per_share_lumo, arg1.reward_debt_lumo), pending_from_rps(arg1.weight, arg0.reward_per_share_sui, arg1.reward_debt_sui), pending_from_rps(arg1.weight, arg0.reward_per_share_pans, arg1.reward_debt_pans), pending_from_rps(arg1.weight, arg0.reward_per_share_usdc, arg1.reward_debt_usdc))
    }

    public entry fun claim_reward<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &mut StakePosition<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        update_pool_inner<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        let (v0, v1, v2, v3) = calc_pending<T0, T1, T2>(arg0, arg1);
        let v4 = if (v0 > 0) {
            true
        } else if (v1 > 0) {
            true
        } else if (v2 > 0) {
            true
        } else {
            v3 > 0
        };
        assert!(v4, 5);
        arg1.reward_debt_lumo = arg1.weight * arg0.reward_per_share_lumo;
        arg1.reward_debt_sui = arg1.weight * arg0.reward_per_share_sui;
        arg1.reward_debt_pans = arg1.weight * arg0.reward_per_share_pans;
        arg1.reward_debt_usdc = arg1.weight * arg0.reward_per_share_usdc;
        let v5 = 0x2::tx_context::sender(arg3);
        payout<T0, T1, T2>(arg0, v0, v1, v2, v3, v5, arg3);
        let v6 = RewardClaimed{
            staker      : v5,
            lumo_amount : v0,
            sui_amount  : v1,
            pans_amount : v2,
            usdc_amount : v3,
        };
        0x2::event::emit<RewardClaimed>(v6);
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

    fun compute_weight(arg0: u64, arg1: u64) : u128 {
        let v0 = (arg1 as u128);
        (arg0 as u128) * v0 * isqrt(v0 * 1000000) / 1000000
    }

    public entry fun create_pool<T0, T1, T2>(arg0: &AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 10);
        let v0 = StakingPool<T0, T1, T2>{
            id                    : 0x2::object::new(arg3),
            total_staked          : 0x2::balance::zero<T0>(),
            lumo_reward_pool      : 0x2::balance::zero<T0>(),
            reward_per_share_lumo : 0,
            emissions_lumo        : 0x1::vector::empty<Emission>(),
            sui_reward_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
            reward_per_share_sui  : 0,
            emissions_sui         : 0x1::vector::empty<Emission>(),
            pans_reward_pool      : 0x2::balance::zero<T1>(),
            reward_per_share_pans : 0,
            emissions_pans        : 0x1::vector::empty<Emission>(),
            usdc_reward_pool      : 0x2::balance::zero<T2>(),
            reward_per_share_usdc : 0,
            emissions_usdc        : 0x1::vector::empty<Emission>(),
            total_weight          : 0,
            last_update_time      : 0x2::clock::timestamp_ms(arg2),
            max_penalty_bps       : 10000,
            penalty_recipient     : arg1,
        };
        0x2::transfer::share_object<StakingPool<T0, T1, T2>>(v0);
    }

    public entry fun early_unstake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: StakePosition<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0 < arg1.unlock_time, 4);
        update_pool_inner<T0, T1, T2>(arg0, v0);
        let (v2, v3, v4, v5) = calc_pending<T0, T1, T2>(arg0, &arg1);
        let v6 = (arg1.lock_days as u128) * (86400000 as u128) * (10000 as u128);
        let v7 = ((arg1.amount as u128) * (arg0.max_penalty_bps as u128) * ((arg1.unlock_time - v0) as u128) + v6 - 1) / v6;
        let v8 = if (v7 >= (arg1.amount as u128)) {
            arg1.amount
        } else {
            (v7 as u64)
        };
        let v9 = arg1.amount - v8;
        let v10 = arg0.penalty_recipient;
        let StakePosition {
            id               : v11,
            amount           : v12,
            lock_days        : _,
            start_time       : _,
            unlock_time      : _,
            weight           : v16,
            reward_debt_lumo : _,
            reward_debt_sui  : _,
            reward_debt_pans : _,
            reward_debt_usdc : _,
        } = arg1;
        0x2::object::delete(v11);
        arg0.total_weight = arg0.total_weight - v16;
        payout<T0, T1, T2>(arg0, v2, v3, v4, v5, v1, arg3);
        let v21 = 0x2::balance::split<T0>(&mut arg0.total_staked, v12);
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v21, v8), arg3), v10);
        };
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg3), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v21);
        };
        let v22 = Unstaked{
            staker          : v1,
            amount_returned : v9,
            penalty         : v8,
            early           : true,
        };
        0x2::event::emit<Unstaked>(v22);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun isqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 < 4) {
            return 1
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    fun payout<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.lumo_reward_pool, arg1), arg6), arg5);
        };
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reward_pool, arg2), arg6), arg5);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pans_reward_pool, arg3), arg6), arg5);
        };
        if (arg4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.usdc_reward_pool, arg4), arg6), arg5);
        };
    }

    fun pending_from_rps(arg0: u128, arg1: u128, arg2: u128) : u64 {
        let v0 = arg0 * arg1;
        if (v0 > arg2) {
            (((v0 - arg2) / 1000000000000000000) as u64)
        } else {
            0
        }
    }

    public fun pending_rewards<T0, T1, T2>(arg0: &StakingPool<T0, T1, T2>, arg1: &StakePosition<T0, T1, T2>) : (u64, u64, u64, u64) {
        calc_pending<T0, T1, T2>(arg0, arg1)
    }

    public fun pending_rewards_now<T0, T1, T2>(arg0: &StakingPool<T0, T1, T2>, arg1: &StakePosition<T0, T1, T2>, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.last_update_time;
        (pending_from_rps(arg1.weight, simulate_rps(&arg0.emissions_lumo, arg0.reward_per_share_lumo, arg0.total_weight, v1, v0), arg1.reward_debt_lumo), pending_from_rps(arg1.weight, simulate_rps(&arg0.emissions_sui, arg0.reward_per_share_sui, arg0.total_weight, v1, v0), arg1.reward_debt_sui), pending_from_rps(arg1.weight, simulate_rps(&arg0.emissions_pans, arg0.reward_per_share_pans, arg0.total_weight, v1, v0), arg1.reward_debt_pans), pending_from_rps(arg1.weight, simulate_rps(&arg0.emissions_usdc, arg0.reward_per_share_usdc, arg0.total_weight, v1, v0), arg1.reward_debt_usdc))
    }

    public fun pool_info<T0, T1, T2>(arg0: &StakingPool<T0, T1, T2>) : (u64, u64, u64, u64, u64, u128, u64, u64, u64, u64, u64, address) {
        (0x2::balance::value<T0>(&arg0.total_staked), 0x2::balance::value<T0>(&arg0.lumo_reward_pool), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reward_pool), 0x2::balance::value<T1>(&arg0.pans_reward_pool), 0x2::balance::value<T2>(&arg0.usdc_reward_pool), arg0.total_weight, (0x1::vector::length<Emission>(&arg0.emissions_lumo) as u64), (0x1::vector::length<Emission>(&arg0.emissions_sui) as u64), (0x1::vector::length<Emission>(&arg0.emissions_pans) as u64), (0x1::vector::length<Emission>(&arg0.emissions_usdc) as u64), arg0.max_penalty_bps, arg0.penalty_recipient)
    }

    public fun position_info<T0, T1, T2>(arg0: &StakePosition<T0, T1, T2>) : (u64, u64, u64, u64, u128) {
        (arg0.amount, arg0.lock_days, arg0.start_time, arg0.unlock_time, arg0.weight)
    }

    public entry fun recover_lumo_rewards<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: address, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        update_pool_inner<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1));
        assert!(0x1::vector::is_empty<Emission>(&arg0.emissions_lumo), 9);
        let v0 = 0x2::balance::value<T0>(&arg0.lumo_reward_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.lumo_reward_pool, v0), arg4), arg2);
        };
    }

    public entry fun recover_pans_rewards<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: address, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        update_pool_inner<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1));
        assert!(0x1::vector::is_empty<Emission>(&arg0.emissions_pans), 9);
        let v0 = 0x2::balance::value<T1>(&arg0.pans_reward_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pans_reward_pool, v0), arg4), arg2);
        };
    }

    public entry fun recover_sui_rewards<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: address, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        update_pool_inner<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1));
        assert!(0x1::vector::is_empty<Emission>(&arg0.emissions_sui), 9);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reward_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reward_pool, v0), arg4), arg2);
        };
    }

    public entry fun recover_usdc_rewards<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: address, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        update_pool_inner<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1));
        assert!(0x1::vector::is_empty<Emission>(&arg0.emissions_usdc), 9);
        let v0 = 0x2::balance::value<T2>(&arg0.usdc_reward_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.usdc_reward_pool, v0), arg4), arg2);
        };
    }

    public entry fun set_max_penalty<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 <= 10000, 6);
        arg0.max_penalty_bps = arg1;
        let v0 = MaxPenaltyUpdated{
            old_bps : arg0.max_penalty_bps,
            new_bps : arg1,
        };
        0x2::event::emit<MaxPenaltyUpdated>(v0);
    }

    public entry fun set_penalty_recipient<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: address, arg2: &AdminCap) {
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

    public entry fun stake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 10 && arg2 <= 1000, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        update_pool_inner<T0, T1, T2>(arg0, v1);
        let v2 = compute_weight(v0, arg2);
        assert!(v2 > 0, 2);
        assert!(v2 <= 10000000000000000000, 8);
        arg0.total_weight = arg0.total_weight + v2;
        0x2::balance::join<T0>(&mut arg0.total_staked, 0x2::coin::into_balance<T0>(arg1));
        let v3 = v1 + arg2 * 86400000;
        let v4 = StakePosition<T0, T1, T2>{
            id               : 0x2::object::new(arg4),
            amount           : v0,
            lock_days        : arg2,
            start_time       : v1,
            unlock_time      : v3,
            weight           : v2,
            reward_debt_lumo : v2 * arg0.reward_per_share_lumo,
            reward_debt_sui  : v2 * arg0.reward_per_share_sui,
            reward_debt_pans : v2 * arg0.reward_per_share_pans,
            reward_debt_usdc : v2 * arg0.reward_per_share_usdc,
        };
        let v5 = Staked{
            position_id : 0x2::object::id<StakePosition<T0, T1, T2>>(&v4),
            staker      : 0x2::tx_context::sender(arg4),
            amount      : v0,
            lock_days   : arg2,
            weight      : v2,
            unlock_time : v3,
        };
        0x2::event::emit<Staked>(v5);
        0x2::transfer::transfer<StakePosition<T0, T1, T2>>(v4, 0x2::tx_context::sender(arg4));
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

    public entry fun unstake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: StakePosition<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0 >= arg1.unlock_time, 3);
        update_pool_inner<T0, T1, T2>(arg0, v0);
        let (v2, v3, v4, v5) = calc_pending<T0, T1, T2>(arg0, &arg1);
        let StakePosition {
            id               : v6,
            amount           : v7,
            lock_days        : _,
            start_time       : _,
            unlock_time      : _,
            weight           : v11,
            reward_debt_lumo : _,
            reward_debt_sui  : _,
            reward_debt_pans : _,
            reward_debt_usdc : _,
        } = arg1;
        0x2::object::delete(v6);
        arg0.total_weight = arg0.total_weight - v11;
        payout<T0, T1, T2>(arg0, v2, v3, v4, v5, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v7), arg3), v1);
        let v16 = Unstaked{
            staker          : v1,
            amount_returned : v7,
            penalty         : 0,
            early           : false,
        };
        0x2::event::emit<Unstaked>(v16);
    }

    fun update_pool_inner<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: u64) {
        let v0 = arg0.last_update_time;
        if (v0 >= arg1) {
            return
        };
        if (arg0.total_weight > 0) {
            let v1 = &mut arg0.emissions_lumo;
            arg0.reward_per_share_lumo = tick_rps(v1, arg0.reward_per_share_lumo, arg0.total_weight, v0, arg1);
            let v2 = &mut arg0.emissions_sui;
            arg0.reward_per_share_sui = tick_rps(v2, arg0.reward_per_share_sui, arg0.total_weight, v0, arg1);
            let v3 = &mut arg0.emissions_pans;
            arg0.reward_per_share_pans = tick_rps(v3, arg0.reward_per_share_pans, arg0.total_weight, v0, arg1);
            let v4 = &mut arg0.emissions_usdc;
            arg0.reward_per_share_usdc = tick_rps(v4, arg0.reward_per_share_usdc, arg0.total_weight, v0, arg1);
        } else {
            let v5 = &mut arg0.emissions_lumo;
            cleanup_expired(v5, arg1);
            let v6 = &mut arg0.emissions_sui;
            cleanup_expired(v6, arg1);
            let v7 = &mut arg0.emissions_pans;
            cleanup_expired(v7, arg1);
            let v8 = &mut arg0.emissions_usdc;
            cleanup_expired(v8, arg1);
        };
        arg0.last_update_time = arg1;
    }

    // decompiled from Move bytecode v7
}

