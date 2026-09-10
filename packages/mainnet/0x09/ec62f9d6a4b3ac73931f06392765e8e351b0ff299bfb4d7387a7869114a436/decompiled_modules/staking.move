module 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::staking {
    struct RewardBucket has copy, drop, store {
        start_ms: u64,
        kares: u64,
        sui: u64,
        released_kares: u64,
        released_sui: u64,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        active: bool,
        principal: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>,
        kares_rewards: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>,
        sui_rewards: 0x2::balance::Balance<0x2::sui::SUI>,
        last_wall_ms: u64,
        active_ms: u64,
        initial_released: u64,
        kares_index: u256,
        sui_index: u256,
        kares_remainder: u256,
        sui_remainder: u256,
        buckets: vector<RewardBucket>,
    }

    struct StakePosition has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        amount: u64,
        kares_index: u256,
        sui_index: u256,
        kares_accrued: u256,
        sui_accrued: u256,
    }

    struct RoyaltyFunded has copy, drop {
        pool: 0x2::object::ID,
        amount: u64,
        staking: u64,
    }

    public(friend) fun activate(arg0: &mut StakingPool, arg1: &0x2::clock::Clock) {
        assert!(!arg0.active, 4);
        arg0.active = true;
        arg0.last_wall_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun active_ms(arg0: &StakingPool) : u64 {
        arg0.active_ms
    }

    public fun add_stake(arg0: &mut StakingPool, arg1: &mut StakePosition, arg2: 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>, arg3: &0x2::clock::Clock) {
        update_position(arg0, arg1, arg3);
        let v0 = 0x2::coin::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg2);
        assert!(v0 > 0, 2);
        arg1.amount = arg1.amount + v0;
        0x2::balance::join<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.principal, 0x2::coin::into_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(arg2));
    }

    public fun bucket_values(arg0: &RewardBucket) : (u64, u64, u64, u64, u64) {
        (arg0.start_ms, arg0.kares, arg0.sui, arg0.released_kares, arg0.released_sui)
    }

    public fun buckets(arg0: &StakingPool) : &vector<RewardBucket> {
        &arg0.buckets
    }

    public fun claim(arg0: &mut StakingPool, arg1: &mut StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>, 0x2::coin::Coin<0x2::sui::SUI>) {
        update_position(arg0, arg1, arg2);
        arg1.kares_accrued = arg1.kares_accrued % 1000000000000000000000000000;
        arg1.sui_accrued = arg1.sui_accrued % 1000000000000000000000000000;
        (0x2::coin::from_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.kares_rewards, ((arg1.kares_accrued / 1000000000000000000000000000) as u64)), arg3), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_rewards, ((arg1.sui_accrued / 1000000000000000000000000000) as u64)), arg3))
    }

    public(friend) fun create(arg0: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>, arg1: &mut 0x2::tx_context::TxContext) : StakingPool {
        assert!(0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0) == 200000000000000, 5);
        let v0 = 0x1::vector::empty<RewardBucket>();
        let v1 = 0;
        while (v1 < 31) {
            0x1::vector::push_back<RewardBucket>(&mut v0, empty_bucket());
            v1 = v1 + 1;
        };
        StakingPool{
            id               : 0x2::object::new(arg1),
            active           : false,
            principal        : 0x2::balance::zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(),
            kares_rewards    : arg0,
            sui_rewards      : 0x2::balance::zero<0x2::sui::SUI>(),
            last_wall_ms     : 0,
            active_ms        : 0,
            initial_released : 0,
            kares_index      : 0,
            sui_index        : 0,
            kares_remainder  : 0,
            sui_remainder    : 0,
            buckets          : v0,
        }
    }

    fun empty_bucket() : RewardBucket {
        RewardBucket{
            start_ms       : 0,
            kares          : 0,
            sui            : 0,
            released_kares : 0,
            released_sui   : 0,
        }
    }

    public fun fund_kares(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>, arg2: &0x2::clock::Clock) {
        update(arg0, arg2);
        0x2::balance::join<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.kares_rewards, 0x2::coin::into_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(arg1));
        let v0 = funding_bucket(arg0);
        v0.kares = v0.kares + 0x2::coin::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg1);
    }

    public fun fund_royalties(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = v0 / 5;
        fund_sui(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg3), arg2);
        let v2 = RoyaltyFunded{
            pool    : 0x2::object::id<StakingPool>(arg0),
            amount  : v0,
            staking : v1,
        };
        0x2::event::emit<RoyaltyFunded>(v2);
        arg1
    }

    public fun fund_sui(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock) {
        update(arg0, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_rewards, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = funding_bucket(arg0);
        v0.sui = v0.sui + 0x2::coin::value<0x2::sui::SUI>(&arg1);
    }

    fun funding_bucket(arg0: &mut StakingPool) : &mut RewardBucket {
        let v0 = arg0.active_ms / 86400000 + 1;
        let v1 = v0 * 86400000;
        let v2 = 0x1::vector::borrow_mut<RewardBucket>(&mut arg0.buckets, v0 % 31);
        if (v2.start_ms != v1) {
            assert!(v2.kares == v2.released_kares && v2.sui == v2.released_sui, 5);
            *v2 = empty_bucket();
            v2.start_ms = v1;
        };
        v2
    }

    public fun indexes(arg0: &StakingPool) : (u256, u256) {
        (arg0.kares_index, arg0.sui_index)
    }

    public fun initial_released(arg0: &StakingPool) : u64 {
        arg0.initial_released
    }

    public fun is_active(arg0: &StakingPool) : bool {
        arg0.active
    }

    public fun kares_rewards(arg0: &StakingPool) : u64 {
        0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.kares_rewards)
    }

    public fun last_wall_ms(arg0: &StakingPool) : u64 {
        arg0.last_wall_ms
    }

    fun linear(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (0x1::u64::min(arg1, arg2) as u128) / (arg2 as u128)) as u64)
    }

    fun new_position(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : StakePosition {
        update(arg0, arg2);
        let v0 = 0x2::coin::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg1);
        assert!(v0 > 0, 2);
        0x2::balance::join<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.principal, 0x2::coin::into_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(arg1));
        StakePosition{
            id            : 0x2::object::new(arg3),
            pool          : 0x2::object::id<StakingPool>(arg0),
            amount        : v0,
            kares_index   : arg0.kares_index,
            sui_index     : arg0.sui_index,
            kares_accrued : 0,
            sui_accrued   : 0,
        }
    }

    public fun open_position(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new_position(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<StakePosition>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun position_accrued(arg0: &StakePosition) : (u256, u256) {
        (arg0.kares_accrued, arg0.sui_accrued)
    }

    public fun position_amount(arg0: &StakePosition) : u64 {
        arg0.amount
    }

    public fun position_indexes(arg0: &StakePosition) : (u256, u256) {
        (arg0.kares_index, arg0.sui_index)
    }

    public fun position_pool(arg0: &StakePosition) : 0x2::object::ID {
        arg0.pool
    }

    public fun principal(arg0: &StakingPool) : u64 {
        0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.principal)
    }

    public(friend) fun share(arg0: StakingPool) {
        0x2::transfer::share_object<StakingPool>(arg0);
    }

    public fun sui_rewards(arg0: &StakingPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_rewards)
    }

    fun update(arg0: &mut StakingPool, arg1: &0x2::clock::Clock) {
        assert!(arg0.active, 0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.last_wall_ms = v0;
        let v1 = 0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.principal);
        if (v1 == 0) {
            return
        };
        arg0.active_ms = arg0.active_ms + v0 - arg0.last_wall_ms;
        let v2 = linear(200000000000000, arg0.active_ms, 157680000000);
        let v3 = v2 - arg0.initial_released;
        let v4 = 0;
        arg0.initial_released = v2;
        let v5 = &mut arg0.buckets;
        let v6 = 0;
        while (v6 < 0x1::vector::length<RewardBucket>(v5)) {
            let v7 = 0x1::vector::borrow_mut<RewardBucket>(v5, v6);
            let v8 = if (arg0.active_ms > v7.start_ms) {
                arg0.active_ms - v7.start_ms
            } else {
                0
            };
            let v9 = linear(v7.kares, v8, 2592000000);
            let v10 = linear(v7.sui, v8, 2592000000);
            v3 = v3 + v9 - v7.released_kares;
            v4 = v4 + v10 - v7.released_sui;
            v7.released_kares = v9;
            v7.released_sui = v10;
            v6 = v6 + 1;
        };
        let v11 = (v3 as u256) * 1000000000000000000000000000 + arg0.kares_remainder;
        let v12 = (v4 as u256) * 1000000000000000000000000000 + arg0.sui_remainder;
        arg0.kares_index = arg0.kares_index + v11 / (v1 as u256);
        arg0.sui_index = arg0.sui_index + v12 / (v1 as u256);
        arg0.kares_remainder = v11 % (v1 as u256);
        arg0.sui_remainder = v12 % (v1 as u256);
    }

    fun update_position(arg0: &mut StakingPool, arg1: &mut StakePosition, arg2: &0x2::clock::Clock) {
        assert!(arg1.pool == 0x2::object::id<StakingPool>(arg0), 1);
        update(arg0, arg2);
        arg1.kares_accrued = arg1.kares_accrued + (arg1.amount as u256) * (arg0.kares_index - arg1.kares_index);
        arg1.sui_accrued = arg1.sui_accrued + (arg1.amount as u256) * (arg0.sui_index - arg1.sui_index);
        arg1.kares_index = arg0.kares_index;
        arg1.sui_index = arg0.sui_index;
    }

    public fun withdraw(arg0: &mut StakingPool, arg1: &mut StakePosition, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES> {
        update_position(arg0, arg1, arg3);
        assert!(arg2 > 0, 2);
        assert!(arg1.amount >= arg2, 3);
        arg1.amount = arg1.amount - arg2;
        0x2::coin::from_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.principal, arg2), arg4)
    }

    // decompiled from Move bytecode v7
}

