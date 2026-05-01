module 0x9478c754d6c3a1332383cc5b342f332560f112ac0723e4383d9a51aa5d9e156f::staking {
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
        owner_positions: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct StakePosition<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
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
        start_time: u64,
        unlock_time: u64,
    }

    struct Unstaked has copy, drop {
        position_id: 0x2::object::ID,
        staker: address,
        original_amount: u64,
        amount_returned: u64,
        rewards_paid: u64,
        penalty: u64,
        lock_days: u64,
        unlock_time: u64,
        timestamp: u64,
        early: bool,
    }

    struct RewardClaimed has copy, drop {
        position_id: 0x2::object::ID,
        staker: address,
        pans_amount: u64,
        timestamp: u64,
    }

    struct PositionTransferred has copy, drop {
        position_id: 0x2::object::ID,
        from: address,
        to: address,
        amount: u64,
        unlock_time: u64,
    }

    struct EpochAdded has copy, drop {
        amount: u64,
        duration_days: u64,
        rate: u128,
        end_time: u64,
        active_epochs: u64,
        injector: address,
    }

    struct PenaltyRecipientUpdated has copy, drop {
        old_recipient: address,
        new_recipient: address,
    }

    struct MaxPenaltyUpdated has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct Slashed has copy, drop {
        position_id: 0x2::object::ID,
        original_owner: address,
        recipient: address,
        amount: u64,
        rewards: u64,
        lock_days: u64,
        unlock_time: u64,
        timestamp: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        penalty_recipient: address,
        timestamp: u64,
    }

    struct RewardsRecovered has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    public entry fun add_reward<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &AdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 1000, 7);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        assert!(arg0.total_weight > 0, 14);
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
            injector      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<EpochAdded>(v6);
    }

    fun calc_pending<T0>(arg0: &StakingPool<T0>, arg1: &StakePosition<T0>) : u64 {
        pending_from_rps(arg1.weight, arg0.reward_per_share, arg1.reward_debt)
    }

    public entry fun claim_reward<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakePosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 13);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        update_pool_inner<T0>(arg0, v0);
        let v1 = calc_pending<T0>(arg0, arg1);
        assert!(v1 > 0, 5);
        arg1.reward_debt = arg1.weight * arg0.reward_per_share;
        let v2 = 0x2::tx_context::sender(arg3);
        payout<T0>(arg0, v1, v2, arg3);
        let v3 = RewardClaimed{
            position_id : 0x2::object::id<StakePosition<T0>>(arg1),
            staker      : v2,
            pans_amount : v1,
            timestamp   : v0,
        };
        0x2::event::emit<RewardClaimed>(v3);
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
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = StakingPool<T0>{
            id                : 0x2::object::new(arg3),
            total_staked      : 0x2::balance::zero<T0>(),
            reward_pool       : 0x2::balance::zero<T0>(),
            reward_per_share  : 0,
            emissions         : 0x1::vector::empty<Emission>(),
            total_weight      : 0,
            last_update_time  : v0,
            max_penalty_bps   : 10000,
            penalty_recipient : arg1,
            owner_positions   : 0x2::table::new<address, vector<0x2::object::ID>>(arg3),
        };
        0x2::transfer::share_object<StakingPool<T0>>(v1);
        let v2 = PoolCreated{
            pool_id           : 0x2::object::id<StakingPool<T0>>(&v1),
            creator           : 0x2::tx_context::sender(arg3),
            penalty_recipient : arg1,
            timestamp         : v0,
        };
        0x2::event::emit<PoolCreated>(v2);
    }

    fun deregister_position(arg0: &mut 0x2::table::Table<address, vector<0x2::object::ID>>, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(arg0, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(arg0, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                0x1::vector::swap_remove<0x2::object::ID>(v0, v1);
                return
            };
            v1 = v1 + 1;
        };
    }

    public entry fun early_unstake<T0>(arg0: &mut StakingPool<T0>, arg1: StakePosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v1 == arg1.owner, 13);
        assert!(v0 < arg1.unlock_time, 4);
        update_pool_inner<T0>(arg0, v0);
        let v2 = calc_pending<T0>(arg0, &arg1);
        let v3 = 0x2::object::id<StakePosition<T0>>(&arg1);
        let v4 = (arg1.lock_days as u128) * (86400000 as u128) * (10000 as u128);
        let v5 = ((arg1.amount as u128) * (arg0.max_penalty_bps as u128) * ((arg1.unlock_time - v0) as u128) + v4 - 1) / v4;
        let v6 = if (v5 >= (arg1.amount as u128)) {
            arg1.amount
        } else {
            (v5 as u64)
        };
        let v7 = arg1.amount - v6;
        let v8 = arg0.penalty_recipient;
        let StakePosition {
            id          : v9,
            owner       : _,
            amount      : v11,
            lock_days   : _,
            start_time  : _,
            unlock_time : _,
            weight      : v15,
            reward_debt : _,
        } = arg1;
        0x2::object::delete(v9);
        let v17 = &mut arg0.owner_positions;
        deregister_position(v17, v1, v3);
        arg0.total_weight = arg0.total_weight - v15;
        if (v2 > 0) {
            payout<T0>(arg0, v2, v1, arg3);
        };
        let v18 = 0x2::balance::split<T0>(&mut arg0.total_staked, v11);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v18, v6), arg3), v8);
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg3), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v18);
        };
        let v19 = Unstaked{
            position_id     : v3,
            staker          : v1,
            original_amount : v11,
            amount_returned : v7,
            rewards_paid    : v2,
            penalty         : v6,
            lock_days       : arg1.lock_days,
            unlock_time     : arg1.unlock_time,
            timestamp       : v0,
            early           : true,
        };
        0x2::event::emit<Unstaked>(v19);
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

    public fun position_info<T0>(arg0: &StakePosition<T0>) : (address, u64, u64, u64, u64, u128) {
        (arg0.owner, arg0.amount, arg0.lock_days, arg0.start_time, arg0.unlock_time, arg0.weight)
    }

    public fun positions_of<T0>(arg0: &StakingPool<T0>, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owner_positions, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.owner_positions, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public entry fun recover_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock, arg2: address, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 10);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        update_pool_inner<T0>(arg0, v0);
        assert!(0x1::vector::is_empty<Emission>(&arg0.emissions), 9);
        let v1 = 0x2::balance::value<T0>(&arg0.reward_pool);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool, v1), arg4), arg2);
            let v2 = RewardsRecovered{
                amount    : v1,
                recipient : arg2,
                timestamp : v0,
            };
            0x2::event::emit<RewardsRecovered>(v2);
        };
    }

    fun register_position(arg0: &mut 0x2::table::Table<address, vector<0x2::object::ID>>, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(arg0, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(arg0, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(arg0, arg1), arg2);
    }

    public entry fun set_max_penalty<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 <= 10000, 6);
        let v0 = arg0.max_penalty_bps;
        if (v0 == arg1) {
            return
        };
        arg0.max_penalty_bps = arg1;
        let v1 = MaxPenaltyUpdated{
            old_bps : v0,
            new_bps : arg1,
        };
        0x2::event::emit<MaxPenaltyUpdated>(v1);
    }

    public entry fun set_penalty_recipient<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: &AdminCap) {
        assert!(arg1 != @0x0, 10);
        let v0 = arg0.penalty_recipient;
        if (v0 == arg1) {
            return
        };
        arg0.penalty_recipient = arg1;
        let v1 = PenaltyRecipientUpdated{
            old_recipient : v0,
            new_recipient : arg1,
        };
        0x2::event::emit<PenaltyRecipientUpdated>(v1);
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
                let v4 = v2.rate * ((v3 - arg3) as u128) / arg2;
                let v5 = if (v0 + v4 > 34028236692093846346) {
                    34028236692093846346
                } else {
                    v0 + v4
                };
                v0 = v5;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun slash<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: StakePosition<T0>, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 != @0x0, 10);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        update_pool_inner<T0>(arg1, v0);
        let v1 = calc_pending<T0>(arg1, &arg2);
        let v2 = 0x2::object::id<StakePosition<T0>>(&arg2);
        let StakePosition {
            id          : v3,
            owner       : v4,
            amount      : v5,
            lock_days   : _,
            start_time  : _,
            unlock_time : _,
            weight      : v9,
            reward_debt : _,
        } = arg2;
        0x2::object::delete(v3);
        let v11 = &mut arg1.owner_positions;
        deregister_position(v11, v4, v2);
        arg1.total_weight = arg1.total_weight - v9;
        if (v1 > 0) {
            payout<T0>(arg1, v1, arg4, arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.total_staked, v5), arg5), arg4);
        let v12 = Slashed{
            position_id    : v2,
            original_owner : v4,
            recipient      : arg4,
            amount         : v5,
            rewards        : v1,
            lock_days      : arg2.lock_days,
            unlock_time    : arg2.unlock_time,
            timestamp      : v0,
        };
        0x2::event::emit<Slashed>(v12);
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
            owner       : 0x2::tx_context::sender(arg4),
            amount      : v0,
            lock_days   : arg2,
            start_time  : v1,
            unlock_time : v3,
            weight      : v2,
            reward_debt : v2 * arg0.reward_per_share,
        };
        let v5 = 0x2::object::id<StakePosition<T0>>(&v4);
        let v6 = 0x2::tx_context::sender(arg4);
        let v7 = &mut arg0.owner_positions;
        register_position(v7, v6, v5);
        let v8 = Staked{
            position_id : v5,
            staker      : v6,
            amount      : v0,
            lock_days   : arg2,
            weight      : v2,
            start_time  : v1,
            unlock_time : v3,
        };
        0x2::event::emit<Staked>(v8);
        0x2::transfer::share_object<StakePosition<T0>>(v4);
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
            let v4 = v2.rate * ((v3 - arg3) as u128) / arg2;
            let v5 = if (v0 + v4 > 34028236692093846346) {
                34028236692093846346
            } else {
                v0 + v4
            };
            v0 = v5;
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun transfer_position<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakePosition<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.owner, 13);
        assert!(arg2 != @0x0, 10);
        let v1 = 0x2::object::id<StakePosition<T0>>(arg1);
        let v2 = &mut arg0.owner_positions;
        deregister_position(v2, v0, v1);
        let v3 = &mut arg0.owner_positions;
        register_position(v3, arg2, v1);
        arg1.owner = arg2;
        let v4 = PositionTransferred{
            position_id : v1,
            from        : v0,
            to          : arg2,
            amount      : arg1.amount,
            unlock_time : arg1.unlock_time,
        };
        0x2::event::emit<PositionTransferred>(v4);
    }

    public entry fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: StakePosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v1 == arg1.owner, 13);
        assert!(v0 >= arg1.unlock_time, 3);
        update_pool_inner<T0>(arg0, v0);
        let v2 = calc_pending<T0>(arg0, &arg1);
        let v3 = 0x2::object::id<StakePosition<T0>>(&arg1);
        let StakePosition {
            id          : v4,
            owner       : _,
            amount      : v6,
            lock_days   : _,
            start_time  : _,
            unlock_time : _,
            weight      : v10,
            reward_debt : _,
        } = arg1;
        0x2::object::delete(v4);
        let v12 = &mut arg0.owner_positions;
        deregister_position(v12, v1, v3);
        arg0.total_weight = arg0.total_weight - v10;
        if (v2 > 0) {
            payout<T0>(arg0, v2, v1, arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v6), arg3), v1);
        let v13 = Unstaked{
            position_id     : v3,
            staker          : v1,
            original_amount : v6,
            amount_returned : v6,
            rewards_paid    : v2,
            penalty         : 0,
            lock_days       : arg1.lock_days,
            unlock_time     : arg1.unlock_time,
            timestamp       : v0,
            early           : false,
        };
        0x2::event::emit<Unstaked>(v13);
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

    // decompiled from Move bytecode v7
}

