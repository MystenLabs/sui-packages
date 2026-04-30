module 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::creator_pool {
    struct CreatorPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        started_at_ms: u64,
        ends_at_ms: u64,
        duration_ms: u64,
        agent_reward_balance: 0x2::balance::Balance<T0>,
        meme_reward_balance: 0x2::balance::Balance<T1>,
        total_agent_reward: u64,
        total_meme_reward: u64,
        staked_meme: 0x2::balance::Balance<T1>,
        total_staked_meme: u64,
        total_stakers: u64,
        agent_acc: u128,
        meme_acc: u128,
        last_accrual_ms: u64,
    }

    struct PoolReceipt<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        owner: address,
        staked_meme: u64,
        joined_at_ms: u64,
        claimed_agent_acc: u128,
        claimed_meme_acc: u128,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        creator: address,
        agent_total_raw: u64,
        agent_skim_raw: u64,
        agent_reward_raw: u64,
        meme_total_raw: u64,
        duration_ms: u64,
        started_at_ms: u64,
        ends_at_ms: u64,
    }

    struct PoolJoined has copy, drop {
        pool_id: address,
        receipt_id: address,
        staker: address,
        staked_meme: u64,
        timestamp_ms: u64,
    }

    struct PoolClaimed has copy, drop {
        pool_id: address,
        receipt_id: address,
        staker: address,
        agent_amount: u64,
        meme_amount: u64,
        timestamp_ms: u64,
    }

    struct PoolUnstaked has copy, drop {
        pool_id: address,
        receipt_id: address,
        staker: address,
        meme_returned: u64,
        final_agent: u64,
        final_meme: u64,
        timestamp_ms: u64,
    }

    struct PoolClosed has copy, drop {
        pool_id: address,
        creator: address,
        agent_swept: u64,
        meme_swept: u64,
        timestamp_ms: u64,
    }

    fun accrue<T0, T1>(arg0: &mut CreatorPool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 > arg0.ends_at_ms) {
            arg0.ends_at_ms
        } else {
            v0
        };
        if (v1 <= arg0.last_accrual_ms) {
            return
        };
        let v2 = v1 - arg0.last_accrual_ms;
        if (arg0.total_staked_meme > 0 && arg0.duration_ms > 0) {
            let v3 = 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::acc_scale();
            let v4 = (arg0.total_staked_meme as u128);
            let v5 = (arg0.duration_ms as u128);
            let v6 = (arg0.total_agent_reward as u128) * (v2 as u128) / v5;
            let v7 = (arg0.total_meme_reward as u128) * (v2 as u128) / v5;
            if (v6 > 0) {
                arg0.agent_acc = arg0.agent_acc + v6 * v3 / v4;
            };
            if (v7 > 0) {
                arg0.meme_acc = arg0.meme_acc + v7 * v3 / v4;
            };
        };
        arg0.last_accrual_ms = v1;
    }

    public fun agent_acc<T0, T1>(arg0: &CreatorPool<T0, T1>) : u128 {
        arg0.agent_acc
    }

    public fun agent_reward_left<T0, T1>(arg0: &CreatorPool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.agent_reward_balance)
    }

    public entry fun claim_pool<T0, T1>(arg0: &mut CreatorPool<T0, T1>, arg1: &mut PoolReceipt<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<CreatorPool<T0, T1>>(arg0), 4);
        accrue<T0, T1>(arg0, arg2);
        let (v0, v1) = compute_pending<T0, T1>(arg0, arg1);
        let v2 = 0x2::tx_context::sender(arg3);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.agent_reward_balance, v0, arg3), v2);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.meme_reward_balance, v1, arg3), v2);
        };
        arg1.claimed_agent_acc = arg0.agent_acc;
        arg1.claimed_meme_acc = arg0.meme_acc;
        let v3 = PoolClaimed{
            pool_id      : 0x2::object::uid_to_address(&arg0.id),
            receipt_id   : 0x2::object::uid_to_address(&arg1.id),
            staker       : v2,
            agent_amount : v0,
            meme_amount  : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolClaimed>(v3);
    }

    fun compute_pending<T0, T1>(arg0: &CreatorPool<T0, T1>, arg1: &PoolReceipt<T0, T1>) : (u64, u64) {
        let v0 = 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::acc_scale();
        let v1 = (arg1.staked_meme as u128);
        let v2 = if (arg0.agent_acc > arg1.claimed_agent_acc) {
            (((arg0.agent_acc - arg1.claimed_agent_acc) * v1 / v0) as u64)
        } else {
            0
        };
        let v3 = if (arg0.meme_acc > arg1.claimed_meme_acc) {
            (((arg0.meme_acc - arg1.claimed_meme_acc) * v1 / v0) as u64)
        } else {
            0
        };
        (v2, v3)
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(arg3 >= 86400000, 3);
        assert!(v0 >= 500000000000, 1);
        let v2 = (v0 as u128) * 3;
        let v3 = if (v2 > (1000000000000 as u128)) {
            v2
        } else {
            (1000000000000 as u128)
        };
        assert!((v1 as u128) >= v3, 2);
        let v4 = (((v0 as u128) * (200 as u128) / (10000 as u128)) as u64);
        let v5 = v0 - v4;
        0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::deposit_external_skim<T0>(arg0, 0x2::coin::split<T0>(&mut arg1, v4, arg5), arg4, arg5);
        let v6 = 0x2::clock::timestamp_ms(arg4);
        let v7 = v6 + arg3;
        let v8 = 0x2::tx_context::sender(arg5);
        let v9 = CreatorPool<T0, T1>{
            id                   : 0x2::object::new(arg5),
            creator              : v8,
            started_at_ms        : v6,
            ends_at_ms           : v7,
            duration_ms          : arg3,
            agent_reward_balance : 0x2::coin::into_balance<T0>(arg1),
            meme_reward_balance  : 0x2::coin::into_balance<T1>(arg2),
            total_agent_reward   : v5,
            total_meme_reward    : v1,
            staked_meme          : 0x2::balance::zero<T1>(),
            total_staked_meme    : 0,
            total_stakers        : 0,
            agent_acc            : 0,
            meme_acc             : 0,
            last_accrual_ms      : v6,
        };
        let v10 = PoolCreated{
            pool_id          : 0x2::object::uid_to_address(&v9.id),
            creator          : v8,
            agent_total_raw  : v0,
            agent_skim_raw   : v4,
            agent_reward_raw : v5,
            meme_total_raw   : v1,
            duration_ms      : arg3,
            started_at_ms    : v6,
            ends_at_ms       : v7,
        };
        0x2::event::emit<PoolCreated>(v10);
        0x2::transfer::share_object<CreatorPool<T0, T1>>(v9);
    }

    public fun creator<T0, T1>(arg0: &CreatorPool<T0, T1>) : address {
        arg0.creator
    }

    public entry fun creator_close<T0, T1>(arg0: &mut CreatorPool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.creator, 8);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= arg0.ends_at_ms, 5);
        assert!(arg0.total_stakers == 0, 9);
        let v2 = 0x2::balance::value<T0>(&arg0.agent_reward_balance);
        let v3 = 0x2::balance::value<T1>(&arg0.meme_reward_balance);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.agent_reward_balance, v2, arg2), v0);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.meme_reward_balance, v3, arg2), v0);
        };
        let v4 = PoolClosed{
            pool_id      : 0x2::object::uid_to_address(&arg0.id),
            creator      : v0,
            agent_swept  : v2,
            meme_swept   : v3,
            timestamp_ms : v1,
        };
        0x2::event::emit<PoolClosed>(v4);
    }

    public fun duration_ms<T0, T1>(arg0: &CreatorPool<T0, T1>) : u64 {
        arg0.duration_ms
    }

    public fun ends_at_ms<T0, T1>(arg0: &CreatorPool<T0, T1>) : u64 {
        arg0.ends_at_ms
    }

    public entry fun join_pool<T0, T1>(arg0: &mut CreatorPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg0.ends_at_ms, 6);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v1 > 0, 7);
        assert!(v1 >= 1000000, 10);
        accrue<T0, T1>(arg0, arg2);
        0x2::balance::join<T1>(&mut arg0.staked_meme, 0x2::coin::into_balance<T1>(arg1));
        arg0.total_staked_meme = arg0.total_staked_meme + v1;
        arg0.total_stakers = arg0.total_stakers + 1;
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = PoolReceipt<T0, T1>{
            id                : 0x2::object::new(arg3),
            pool_id           : 0x2::object::id<CreatorPool<T0, T1>>(arg0),
            owner             : v2,
            staked_meme       : v1,
            joined_at_ms      : v0,
            claimed_agent_acc : arg0.agent_acc,
            claimed_meme_acc  : arg0.meme_acc,
        };
        let v4 = PoolJoined{
            pool_id      : 0x2::object::uid_to_address(&arg0.id),
            receipt_id   : 0x2::object::uid_to_address(&v3.id),
            staker       : v2,
            staked_meme  : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<PoolJoined>(v4);
        0x2::transfer::transfer<PoolReceipt<T0, T1>>(v3, v2);
    }

    public fun last_accrual_ms<T0, T1>(arg0: &CreatorPool<T0, T1>) : u64 {
        arg0.last_accrual_ms
    }

    public fun meme_acc<T0, T1>(arg0: &CreatorPool<T0, T1>) : u128 {
        arg0.meme_acc
    }

    public fun meme_reward_left<T0, T1>(arg0: &CreatorPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.meme_reward_balance)
    }

    public fun min_agent_raw() : u64 {
        500000000000
    }

    public fun min_duration_ms() : u64 {
        86400000
    }

    public fun min_meme_raw_floor() : u64 {
        1000000000000
    }

    public fun min_pool_stake_raw() : u64 {
        1000000
    }

    public fun pending_for<T0, T1>(arg0: &CreatorPool<T0, T1>, arg1: &PoolReceipt<T0, T1>) : (u64, u64) {
        compute_pending<T0, T1>(arg0, arg1)
    }

    public fun receipt_joined_at_ms<T0, T1>(arg0: &PoolReceipt<T0, T1>) : u64 {
        arg0.joined_at_ms
    }

    public fun receipt_owner<T0, T1>(arg0: &PoolReceipt<T0, T1>) : address {
        arg0.owner
    }

    public fun receipt_pool_id<T0, T1>(arg0: &PoolReceipt<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun receipt_staked_meme<T0, T1>(arg0: &PoolReceipt<T0, T1>) : u64 {
        arg0.staked_meme
    }

    public fun skim_bps() : u64 {
        200
    }

    public fun started_at_ms<T0, T1>(arg0: &CreatorPool<T0, T1>) : u64 {
        arg0.started_at_ms
    }

    public fun total_agent_reward<T0, T1>(arg0: &CreatorPool<T0, T1>) : u64 {
        arg0.total_agent_reward
    }

    public fun total_meme_reward<T0, T1>(arg0: &CreatorPool<T0, T1>) : u64 {
        arg0.total_meme_reward
    }

    public fun total_staked_meme<T0, T1>(arg0: &CreatorPool<T0, T1>) : u64 {
        arg0.total_staked_meme
    }

    public fun total_stakers<T0, T1>(arg0: &CreatorPool<T0, T1>) : u64 {
        arg0.total_stakers
    }

    public entry fun unstake_pool<T0, T1>(arg0: &mut CreatorPool<T0, T1>, arg1: PoolReceipt<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.ends_at_ms, 5);
        assert!(arg1.pool_id == 0x2::object::id<CreatorPool<T0, T1>>(arg0), 4);
        accrue<T0, T1>(arg0, arg2);
        let (v1, v2) = compute_pending<T0, T1>(arg0, &arg1);
        let v3 = 0x2::tx_context::sender(arg3);
        let PoolReceipt {
            id                : v4,
            pool_id           : _,
            owner             : _,
            staked_meme       : v7,
            joined_at_ms      : _,
            claimed_agent_acc : _,
            claimed_meme_acc  : _,
        } = arg1;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.agent_reward_balance, v1, arg3), v3);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.meme_reward_balance, v2, arg3), v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.staked_meme, v7), arg3), v3);
        if (arg0.total_staked_meme >= v7) {
            arg0.total_staked_meme = arg0.total_staked_meme - v7;
        } else {
            arg0.total_staked_meme = 0;
        };
        if (arg0.total_stakers > 0) {
            arg0.total_stakers = arg0.total_stakers - 1;
        };
        0x2::object::delete(v4);
        let v11 = PoolUnstaked{
            pool_id       : 0x2::object::uid_to_address(&arg0.id),
            receipt_id    : 0x2::object::uid_to_address(&arg1.id),
            staker        : v3,
            meme_returned : v7,
            final_agent   : v1,
            final_meme    : v2,
            timestamp_ms  : v0,
        };
        0x2::event::emit<PoolUnstaked>(v11);
    }

    // decompiled from Move bytecode v7
}

