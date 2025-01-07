module 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::staking {
    struct StakePool<phantom T0> has key {
        id: 0x2::object::UID,
        total_staked: u64,
        distributed_reward_amount: u64,
        max_reward_amount: u64,
        reward: 0x2::balance::Balance<T0>,
        stake_models: 0x2::table::Table<0x2::object::ID, 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::StakeModel>,
    }

    struct StakePoolCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct Stake<phantom T0> has key {
        id: 0x2::object::UID,
        underlying_asset: 0x2::balance::Balance<T0>,
        reward_amount: u64,
        stake_model_id: 0x2::object::ID,
        staked_at: u64,
    }

    struct StakePoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
    }

    struct StakeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        stake_model_id: 0x2::object::ID,
        stake_amount: u64,
        lock_period_in_days: u64,
        apr_numerator: u64,
        apr_denominator: u64,
    }

    struct UnstakeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        stake_model_id: 0x2::object::ID,
        unstake_amount: u64,
        reward_amount: u64,
    }

    struct StakeModelAddedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        stake_model_id: 0x2::object::ID,
        lock_period_in_days: u64,
        apr_numerator: u64,
        apr_denominator: u64,
    }

    struct StakeModelActiveStatusChangedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        stake_model_id: 0x2::object::ID,
        is_active: bool,
    }

    public fun add_stake_model<T0>(arg0: &StakePoolCap, arg1: &mut StakePool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_stake_cap<T0>(arg0, arg1);
        let v0 = 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::new(arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::StakeModel>(&v0);
        0x2::table::add<0x2::object::ID, 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::StakeModel>(&mut arg1.stake_models, v1, v0);
        let v2 = StakeModelAddedEvent{
            pool_id             : 0x2::object::id<StakePool<T0>>(arg1),
            asset_type          : 0x1::type_name::get<T0>(),
            stake_model_id      : v1,
            lock_period_in_days : arg2,
            apr_numerator       : arg3,
            apr_denominator     : arg4,
        };
        0x2::event::emit<StakeModelAddedEvent>(v2);
    }

    public fun assert_stake_cap<T0>(arg0: &StakePoolCap, arg1: &StakePool<T0>) {
        assert!(0x2::object::id<StakePool<T0>>(arg1) == arg0.for, 101);
    }

    public fun create_stake_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) : (StakePool<T0>, StakePoolCap) {
        let v0 = StakePool<T0>{
            id                        : 0x2::object::new(arg0),
            total_staked              : 0,
            distributed_reward_amount : 0,
            max_reward_amount         : 0,
            reward                    : 0x2::balance::zero<T0>(),
            stake_models              : 0x2::table::new<0x2::object::ID, 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::StakeModel>(arg0),
        };
        let v1 = StakePoolCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<StakePool<T0>>(&v0),
        };
        (v0, v1)
    }

    public entry fun create_stake_pool_entry<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_stake_pool<T0>(arg0);
        0x2::transfer::share_object<StakePool<T0>>(v0);
        0x2::transfer::transfer<StakePoolCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun deposit_reward<T0>(arg0: &mut StakePool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun set_max_reward_amount<T0>(arg0: &StakePoolCap, arg1: &mut StakePool<T0>, arg2: u64) {
        assert_stake_cap<T0>(arg0, arg1);
        arg1.max_reward_amount = arg2;
    }

    public fun set_stake_model_active_status<T0>(arg0: &StakePoolCap, arg1: &mut StakePool<T0>, arg2: 0x2::object::ID, arg3: bool) {
        assert_stake_cap<T0>(arg0, arg1);
        0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::set_active_status(0x2::table::borrow_mut<0x2::object::ID, 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::StakeModel>(&mut arg1.stake_models, arg2), arg3);
        let v0 = StakeModelActiveStatusChangedEvent{
            pool_id        : 0x2::object::id<StakePool<T0>>(arg1),
            asset_type     : 0x1::type_name::get<T0>(),
            stake_model_id : arg2,
            is_active      : arg3,
        };
        0x2::event::emit<StakeModelActiveStatusChangedEvent>(v0);
    }

    public fun stake<T0>(arg0: &mut StakePool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Stake<T0> {
        let v0 = 0x2::table::borrow<0x2::object::ID, 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::StakeModel>(&arg0.stake_models, arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::assert_is_active(v0);
        let v2 = 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::calculate_reward(v0, v1);
        arg0.total_staked = arg0.total_staked + v1;
        arg0.distributed_reward_amount = arg0.distributed_reward_amount + v2;
        assert!(arg0.distributed_reward_amount <= arg0.max_reward_amount, 102);
        let v3 = Stake<T0>{
            id               : 0x2::object::new(arg4),
            underlying_asset : 0x2::coin::into_balance<T0>(arg1),
            reward_amount    : v2,
            stake_model_id   : arg2,
            staked_at        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        let v4 = StakeEvent{
            pool_id             : 0x2::object::id<StakePool<T0>>(arg0),
            asset_type          : 0x1::type_name::get<T0>(),
            stake_model_id      : arg2,
            stake_amount        : v1,
            lock_period_in_days : 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::lock_period_in_days(v0),
            apr_numerator       : 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::apr_numerator(v0),
            apr_denominator     : 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::apr_denominator(v0),
        };
        0x2::event::emit<StakeEvent>(v4);
        v3
    }

    public fun unstake<T0>(arg0: &mut StakePool<T0>, arg1: Stake<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg1.underlying_asset);
        0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::assert_is_unlocked(0x2::table::borrow<0x2::object::ID, 0x21b786ef3d4eeea87c42f4e6dcaa6692225c0a1f38bdba0f006d25ef7ab7c93e::stake_model::StakeModel>(&arg0.stake_models, arg1.stake_model_id), arg1.staked_at, arg2);
        arg0.total_staked = arg0.total_staked - v0;
        let Stake {
            id               : v1,
            underlying_asset : v2,
            reward_amount    : v3,
            stake_model_id   : v4,
            staked_at        : _,
        } = arg1;
        let v6 = v2;
        0x2::object::delete(v1);
        0x2::balance::join<T0>(&mut v6, 0x2::balance::split<T0>(&mut arg0.reward, v3));
        let v7 = UnstakeEvent{
            pool_id        : 0x2::object::id<StakePool<T0>>(arg0),
            asset_type     : 0x1::type_name::get<T0>(),
            stake_model_id : v4,
            unstake_amount : v0,
            reward_amount  : v3,
        };
        0x2::event::emit<UnstakeEvent>(v7);
        0x2::coin::from_balance<T0>(v6, arg3)
    }

    public fun withdraw_reward<T0>(arg0: &StakePoolCap, arg1: &mut StakePool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_stake_cap<T0>(arg0, arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.reward, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

