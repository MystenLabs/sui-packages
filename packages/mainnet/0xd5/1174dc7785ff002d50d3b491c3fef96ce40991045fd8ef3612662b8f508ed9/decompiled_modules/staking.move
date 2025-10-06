module 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingPoolRegistry has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        managers: 0x2::vec_set::VecSet<address>,
    }

    struct StakingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        staked_balance: 0x2::balance::Balance<T0>,
        lock_time: u64,
        deposits_pool_reward_manager: 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::PoolRewardManager,
        user_table: 0x2::table::Table<address, UserStakeManager>,
    }

    struct UserStakeManager has store, key {
        id: 0x2::object::UID,
        staking_pool_id: 0x2::object::ID,
        stake_proofs: vector<StakeProof>,
        user_reward_manager: 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::UserRewardManager,
    }

    struct StakeProof has drop, store {
        stake_amount: u64,
        stake_weight: u64,
        lock_until: u64,
    }

    struct StakedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        stake_amount: u64,
        stake_weight: u64,
        lock_until: u64,
        sender: address,
    }

    struct UnstakedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        unstaked_amount: u64,
        unstaked_weight: u64,
        sender: address,
    }

    struct ClaimedRewardsEvent has copy, drop {
        reward_type: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct STAKING has drop {
        dummy_field: bool,
    }

    public fun id<T0>(arg0: &StakingPool<T0>) : 0x2::object::ID {
        0x2::object::id<StakingPool<T0>>(arg0)
    }

    public fun add_pool_reward<T0, T1>(arg0: &mut StakingPoolRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg6);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::add_pool_reward<T1>(&mut borrow_mut_staking_pool<T0>(arg0, arg1).deposits_pool_reward_manager, 0x2::coin::into_balance<T1>(arg2), arg3, arg4, arg5, arg6);
    }

    public fun cancel_pool_reward<T0, T1>(arg0: &mut StakingPoolRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg4);
        0x2::coin::from_balance<T1>(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::cancel_pool_reward<T1>(&mut borrow_mut_staking_pool<T0>(arg0, arg1).deposits_pool_reward_manager, arg2, arg3), arg4)
    }

    public fun claim_rewards<T0, T1>(arg0: &mut StakingPoolRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_package_version(arg0);
        let v0 = borrow_mut_staking_pool<T0>(arg0, arg1);
        let v1 = 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::claim_rewards<T1>(&mut v0.deposits_pool_reward_manager, &mut 0x2::table::borrow_mut<address, UserStakeManager>(&mut v0.user_table, 0x2::tx_context::sender(arg4)).user_reward_manager, arg2, arg3);
        let v2 = ClaimedRewardsEvent{
            reward_type : 0x1::type_name::get<T1>(),
            pool_id     : arg1,
            amount      : 0x2::balance::value<T1>(&v1),
            sender      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ClaimedRewardsEvent>(v2);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun close_pool_reward<T0, T1>(arg0: &mut StakingPoolRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg4);
        0x2::coin::from_balance<T1>(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::close_pool_reward<T1>(&mut borrow_mut_staking_pool<T0>(arg0, arg1).deposits_pool_reward_manager, arg2, arg3), arg4)
    }

    public fun add_manager(arg0: &mut StakingPoolRegistry, arg1: &AdminCap, arg2: address) {
        assert_valid_package_version(arg0);
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_version(arg0: &mut StakingPoolRegistry, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.version_set, arg2);
    }

    fun assert_sender_is_manager(arg0: &StakingPoolRegistry, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(managers(arg0), &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun assert_valid_package_version(arg0: &StakingPoolRegistry) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(version_set(arg0), &v0)) {
            err_invalid_package_version();
        };
    }

    fun borrow_mut_staking_pool<T0>(arg0: &mut StakingPoolRegistry, arg1: 0x2::object::ID) : &mut StakingPool<T0> {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, StakingPool<T0>>(&mut arg0.id, arg1)
    }

    public fun borrow_staking_pool<T0>(arg0: &StakingPoolRegistry, arg1: 0x2::object::ID) : &StakingPool<T0> {
        0x2::dynamic_object_field::borrow<0x2::object::ID, StakingPool<T0>>(&arg0.id, arg1)
    }

    public fun create_staking_pool<T0>(arg0: &mut StakingPoolRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg2);
        let v0 = StakingPool<T0>{
            id                           : 0x2::object::new(arg2),
            staked_balance               : 0x2::balance::zero<T0>(),
            lock_time                    : arg1,
            deposits_pool_reward_manager : 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::new_pool_reward_manager(arg2),
            user_table                   : 0x2::table::new<address, UserStakeManager>(arg2),
        };
        let v1 = 0x2::object::id<StakingPool<T0>>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, StakingPool<T0>>(&mut arg0.id, v1, v0);
        v1
    }

    public fun create_staking_pool_registry(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPoolRegistry{
            id          : 0x2::object::new(arg1),
            version_set : 0x2::vec_set::singleton<u64>(package_version()),
            managers    : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::transfer::public_share_object<StakingPoolRegistry>(v0);
    }

    fun err_invalid_package_version() : u64 {
        2
    }

    fun err_not_enough_stake() : u64 {
        1
    }

    fun err_not_unlocked() : u64 {
        0
    }

    fun err_sender_is_not_manager() : u64 {
        3
    }

    fun init(arg0: STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<STAKING>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun managers(arg0: &StakingPoolRegistry) : &0x2::vec_set::VecSet<address> {
        &arg0.managers
    }

    fun mul_and_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_manager(arg0: &mut StakingPoolRegistry, arg1: &AdminCap, arg2: address) {
        assert_valid_package_version(arg0);
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_version(arg0: &mut StakingPoolRegistry, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg2);
    }

    public fun set_lock_time<T0>(arg0: &mut StakingPoolRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg3);
        borrow_mut_staking_pool<T0>(arg0, arg1).lock_time = arg2;
    }

    public fun stake<T0>(arg0: &mut StakingPoolRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let v0 = borrow_mut_staking_pool<T0>(arg0, arg1);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let v3 = StakeProof{
            stake_amount : v2,
            stake_weight : v1,
            lock_until   : v0.lock_time + 0x2::clock::timestamp_ms(arg3),
        };
        0x2::balance::join<T0>(&mut v0.staked_balance, 0x2::coin::into_balance<T0>(arg2));
        let v4 = StakedEvent{
            pool_id      : arg1,
            stake_amount : v2,
            stake_weight : v1,
            lock_until   : v0.lock_time + 0x2::clock::timestamp_ms(arg3),
            sender       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<StakedEvent>(v4);
        if (0x2::table::contains<address, UserStakeManager>(&v0.user_table, 0x2::tx_context::sender(arg4))) {
            let v5 = 0x2::table::borrow_mut<address, UserStakeManager>(&mut v0.user_table, 0x2::tx_context::sender(arg4));
            0x1::vector::push_back<StakeProof>(&mut v5.stake_proofs, v3);
            0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::change_user_reward_manager_share(&mut v0.deposits_pool_reward_manager, &mut v5.user_reward_manager, 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::shares(&v5.user_reward_manager) + v1, arg3);
        } else {
            let v6 = 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::new_user_reward_manager(&mut v0.deposits_pool_reward_manager, arg3);
            0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::change_user_reward_manager_share(&mut v0.deposits_pool_reward_manager, &mut v6, v1, arg3);
            let v7 = UserStakeManager{
                id                  : 0x2::object::new(arg4),
                staking_pool_id     : 0x2::object::id<StakingPool<T0>>(v0),
                stake_proofs        : 0x1::vector::empty<StakeProof>(),
                user_reward_manager : v6,
            };
            0x1::vector::push_back<StakeProof>(&mut v7.stake_proofs, v3);
            0x2::table::add<address, UserStakeManager>(&mut v0.user_table, 0x2::tx_context::sender(arg4), v7);
        };
    }

    public fun unstake<T0>(arg0: &mut StakingPoolRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg0);
        let v0 = borrow_mut_staking_pool<T0>(arg0, arg1);
        let v1 = 0x2::table::borrow_mut<address, UserStakeManager>(&mut v0.user_table, 0x2::tx_context::sender(arg5));
        let v2 = 0x1::vector::borrow_mut<StakeProof>(&mut v1.stake_proofs, arg2);
        if (0x2::clock::timestamp_ms(arg4) < v2.lock_until) {
            err_not_unlocked();
        };
        if (arg3 > v2.stake_amount) {
            err_not_enough_stake();
        };
        let v3 = mul_and_div(v2.stake_weight, arg3, v2.stake_amount);
        v2.stake_amount = v2.stake_amount - arg3;
        v2.stake_weight = v2.stake_weight - v3;
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::change_user_reward_manager_share(&mut v0.deposits_pool_reward_manager, &mut v1.user_reward_manager, 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::liquidity_mining::shares(&v1.user_reward_manager) - v3, arg4);
        if (v2.stake_amount == 0) {
            0x1::vector::remove<StakeProof>(&mut v1.stake_proofs, arg2);
        };
        let v4 = UnstakedEvent{
            pool_id         : arg1,
            unstaked_amount : arg3,
            unstaked_weight : v3,
            sender          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UnstakedEvent>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.staked_balance, arg3), arg5)
    }

    public fun version_set(arg0: &StakingPoolRegistry) : &0x2::vec_set::VecSet<u64> {
        &arg0.version_set
    }

    // decompiled from Move bytecode v6
}

