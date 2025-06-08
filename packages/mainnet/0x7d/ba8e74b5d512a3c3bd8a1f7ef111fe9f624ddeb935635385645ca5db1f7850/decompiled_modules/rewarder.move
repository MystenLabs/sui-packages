module 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder {
    struct PoolRewarderInfo has store {
        allocate_point: u64,
        acc_per_share: u128,
        last_reward_time: u64,
        reward_released: u128,
        reward_harvested: u64,
    }

    struct Rewarder has store {
        reward_coin: 0x1::type_name::TypeName,
        total_allocate_point: u64,
        emission_per_second: u128,
        last_reward_time: u64,
        total_reward_released: u128,
        total_reward_harvested: u64,
        pools: 0x2::linked_table::LinkedTable<0x2::object::ID, PoolRewarderInfo>,
    }

    struct RewarderManager has store, key {
        id: 0x2::object::UID,
        vault: 0x2::bag::Bag,
        pool_shares: 0x2::linked_table::LinkedTable<0x2::object::ID, u128>,
        rewarders: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, Rewarder>,
    }

    struct InitRewarderManagerEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct CreateRewarderEvent has copy, drop {
        reward_coin: 0x1::type_name::TypeName,
        emission_per_second: u128,
    }

    struct UpdateRewarderEvent has copy, drop {
        reward_coin: 0x1::type_name::TypeName,
        emission_per_second: u128,
    }

    struct DepositEvent has copy, drop {
        reward_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        after_amount: u64,
    }

    struct EmergentWithdrawEvent has copy, drop, store {
        reward_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        after_amount: u64,
    }

    fun accumulate_pool_reward(arg0: &mut Rewarder, arg1: 0x2::object::ID, arg2: u128, arg3: u64) : u128 {
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg0.pools, arg1);
        let v1 = v0.last_reward_time;
        v0.last_reward_time = arg3;
        let v2 = if (arg3 <= v1) {
            true
        } else if (v0.allocate_point == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v2) {
            return v0.acc_per_share
        };
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg0.emission_per_second, ((arg3 - v1) as u128)) * (v0.allocate_point as u256) / (arg0.total_allocate_point as u256);
        v0.reward_released = v0.reward_released + (v3 as u128);
        v0.acc_per_share = v0.acc_per_share + (v3 as u128) / arg2;
        v0.acc_per_share
    }

    fun accumulate_pools_reward<T0>(arg0: &mut RewarderManager, arg1: u64) {
        let v0 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, 0x1::type_name::get<T0>());
        if (v0.emission_per_second == 0) {
            return
        };
        let v1 = *0x2::linked_table::front<0x2::object::ID, PoolRewarderInfo>(&v0.pools);
        while (0x1::option::is_some<0x2::object::ID>(&v1)) {
            let v2 = *0x1::option::borrow<0x2::object::ID>(&v1);
            accumulate_pool_reward(v0, v2, *0x2::linked_table::borrow<0x2::object::ID, u128>(&arg0.pool_shares, v2), arg1);
            v1 = *0x2::linked_table::next<0x2::object::ID, PoolRewarderInfo>(&v0.pools, v2);
        };
    }

    fun accumulate_rewarder_released(arg0: &mut Rewarder, arg1: u64) {
        if (arg1 <= arg0.last_reward_time) {
            return
        };
        arg0.last_reward_time = arg1;
        if (arg0.emission_per_second == 0) {
            return
        };
        arg0.total_reward_released = arg0.total_reward_released + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg0.emission_per_second, ((arg1 - arg0.last_reward_time) as u128)) as u128);
    }

    public(friend) fun add_pool<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(is_pool_registered(arg0, arg1), 6);
        assert!(!is_pool_in_rewarder(arg0, 0x1::type_name::get<T0>(), arg1), 3);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        accumulate_pools_reward<T0>(arg0, v0);
        let v1 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, 0x1::type_name::get<T0>());
        accumulate_rewarder_released(v1, v0);
        let v2 = PoolRewarderInfo{
            allocate_point   : arg2,
            acc_per_share    : 0,
            last_reward_time : v0,
            reward_released  : 0,
            reward_harvested : 0,
        };
        0x2::linked_table::push_back<0x2::object::ID, PoolRewarderInfo>(&mut v1.pools, arg1, v2);
        v1.total_allocate_point = v1.total_allocate_point + arg2;
    }

    public fun borrow_pool_allocate_point(arg0: &RewarderManager, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::linked_table::contains<0x1::type_name::TypeName, Rewarder>(&arg0.rewarders, arg1), 2);
        let v0 = 0x2::linked_table::borrow<0x1::type_name::TypeName, Rewarder>(&arg0.rewarders, arg1);
        assert!(is_pool_in_rewarder(arg0, arg1, arg2), 8);
        0x2::linked_table::borrow<0x2::object::ID, PoolRewarderInfo>(&v0.pools, arg2).allocate_point
    }

    public fun borrow_pool_rewarder_info(arg0: &Rewarder, arg1: 0x2::object::ID) : &PoolRewarderInfo {
        0x2::linked_table::borrow<0x2::object::ID, PoolRewarderInfo>(&arg0.pools, arg1)
    }

    public fun borrow_pool_share(arg0: &RewarderManager, arg1: 0x2::object::ID) : u128 {
        *0x2::linked_table::borrow<0x2::object::ID, u128>(&arg0.pool_shares, arg1)
    }

    public fun borrow_rewarder<T0>(arg0: &RewarderManager) : &Rewarder {
        0x2::linked_table::borrow<0x1::type_name::TypeName, Rewarder>(&arg0.rewarders, 0x1::type_name::get<T0>())
    }

    public fun create_rewarder<T0>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut RewarderManager, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg1);
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::check_rewarder_manager_role(arg1, 0x2::object::id_address<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap>(arg0));
        let v0 = 0x1::type_name::get<T0>();
        let v1 = Rewarder{
            reward_coin            : v0,
            total_allocate_point   : 0,
            emission_per_second    : arg3,
            last_reward_time       : 0x2::clock::timestamp_ms(arg4) / 1000,
            total_reward_released  : 0,
            total_reward_harvested : 0,
            pools                  : 0x2::linked_table::new<0x2::object::ID, PoolRewarderInfo>(arg5),
        };
        assert!(!0x2::linked_table::contains<0x1::type_name::TypeName, Rewarder>(&arg2.rewarders, v0), 1);
        0x2::linked_table::push_back<0x1::type_name::TypeName, Rewarder>(&mut arg2.rewarders, v0, v1);
        let v2 = CreateRewarderEvent{
            reward_coin         : v0,
            emission_per_second : arg3,
        };
        0x2::event::emit<CreateRewarderEvent>(v2);
    }

    public fun deposit_rewarder<T0>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &mut RewarderManager, arg2: 0x2::balance::Balance<T0>) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::linked_table::contains<0x1::type_name::TypeName, Rewarder>(&arg1.rewarders, v0), 2);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vault, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vault, v0, 0x2::balance::zero<T0>());
        };
        let v1 = DepositEvent{
            reward_type    : 0x1::type_name::get<T0>(),
            deposit_amount : 0x2::balance::value<T0>(&arg2),
            after_amount   : 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vault, 0x1::type_name::get<T0>()), arg2),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun emergent_withdraw<T0>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::AdminCap, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut RewarderManager, arg3: u64) : 0x2::balance::Balance<T0> {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg2.vault, v0), 5);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.vault, v0);
        assert!(0x2::balance::value<T0>(v1) > arg3, 5);
        let v2 = EmergentWithdrawEvent{
            reward_type     : v0,
            withdraw_amount : arg3,
            after_amount    : 0x2::balance::value<T0>(v1),
        };
        0x2::event::emit<EmergentWithdrawEvent>(v2);
        0x2::balance::split<T0>(v1, arg3)
    }

    public fun emission_per_second(arg0: &Rewarder) : u128 {
        arg0.emission_per_second
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewarderManager{
            id          : 0x2::object::new(arg0),
            vault       : 0x2::bag::new(arg0),
            pool_shares : 0x2::linked_table::new<0x2::object::ID, u128>(arg0),
            rewarders   : 0x2::linked_table::new<0x1::type_name::TypeName, Rewarder>(arg0),
        };
        0x2::transfer::share_object<RewarderManager>(v0);
        let v1 = InitRewarderManagerEvent{id: 0x2::object::id<RewarderManager>(&v0)};
        0x2::event::emit<InitRewarderManagerEvent>(v1);
    }

    fun is_pool_in_rewarder(arg0: &RewarderManager, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, PoolRewarderInfo>(&0x2::linked_table::borrow<0x1::type_name::TypeName, Rewarder>(&arg0.rewarders, arg1).pools, arg2)
    }

    fun is_pool_registered(arg0: &RewarderManager, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, u128>(&arg0.pool_shares, arg1)
    }

    public fun last_reward_time(arg0: &Rewarder) : u64 {
        arg0.last_reward_time
    }

    public fun pool_acc_per_share(arg0: &PoolRewarderInfo) : u128 {
        arg0.acc_per_share
    }

    public fun pool_allocate_point(arg0: &PoolRewarderInfo) : u64 {
        arg0.allocate_point
    }

    public fun pool_last_reward_time(arg0: &PoolRewarderInfo) : u64 {
        arg0.last_reward_time
    }

    public fun pool_reward_harvested(arg0: &PoolRewarderInfo) : u64 {
        arg0.reward_harvested
    }

    public fun pool_reward_released(arg0: &PoolRewarderInfo) : u128 {
        arg0.reward_released
    }

    public(friend) fun pool_rewards_settle(arg0: &mut RewarderManager, arg1: vector<0x1::type_name::TypeName>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128> {
        assert!(0x2::linked_table::contains<0x2::object::ID, u128>(&arg0.pool_shares, arg2), 4);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0;
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u128>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1, v1);
            let v4 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, v3);
            let v5 = accumulate_pool_reward(v4, arg2, *0x2::linked_table::borrow<0x2::object::ID, u128>(&arg0.pool_shares, arg2), v0);
            accumulate_rewarder_released(v4, v0);
            0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut v2, v3, v5);
            v1 = v1 + 1;
        };
        v2
    }

    public fun pool_share(arg0: &RewarderManager, arg1: 0x2::object::ID) : u128 {
        *0x2::linked_table::borrow<0x2::object::ID, u128>(&arg0.pool_shares, arg1)
    }

    public(friend) fun register_pool(arg0: &mut RewarderManager, arg1: 0x2::object::ID) {
        assert!(!is_pool_registered(arg0, arg1), 7);
        0x2::linked_table::push_back<0x2::object::ID, u128>(&mut arg0.pool_shares, arg1, 0);
    }

    public(friend) fun set_pool<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) : u128 {
        assert!(is_pool_registered(arg0, arg1), 6);
        assert!(is_pool_in_rewarder(arg0, 0x1::type_name::get<T0>(), arg1), 8);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        accumulate_pools_reward<T0>(arg0, v0);
        let v1 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, 0x1::type_name::get<T0>());
        accumulate_rewarder_released(v1, v0);
        let v2 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewarderInfo>(&mut v1.pools, arg1);
        v1.total_allocate_point = v1.total_allocate_point - v2.allocate_point + arg2;
        v2.allocate_point = arg2;
        v2.acc_per_share
    }

    public(friend) fun set_pool_share(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u128) {
        *0x2::linked_table::borrow_mut<0x2::object::ID, u128>(&mut arg0.pool_shares, arg1) = arg2;
    }

    public fun total_allocate_point(arg0: &Rewarder) : u64 {
        arg0.total_allocate_point
    }

    public fun total_reward_harvested(arg0: &Rewarder) : u64 {
        arg0.total_reward_harvested
    }

    public fun total_reward_released(arg0: &Rewarder) : u128 {
        arg0.total_reward_released
    }

    public fun update_rewarder<T0>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut RewarderManager, arg3: u128, arg4: &0x2::clock::Clock) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg1);
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::check_rewarder_manager_role(arg1, 0x2::object::id_address<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap>(arg0));
        assert!(0x2::linked_table::contains<0x1::type_name::TypeName, Rewarder>(&arg2.rewarders, 0x1::type_name::get<T0>()), 2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::clock::timestamp_ms(arg4) / 1000;
        accumulate_pools_reward<T0>(arg2, v1);
        let v2 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg2.rewarders, v0);
        accumulate_rewarder_released(v2, v1);
        v2.emission_per_second = arg3;
        let v3 = UpdateRewarderEvent{
            reward_coin         : v0,
            emission_per_second : arg3,
        };
        0x2::event::emit<UpdateRewarderEvent>(v3);
    }

    public fun vault_balance<T0>(arg0: &RewarderManager) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.vault, 0x1::type_name::get<T0>()))
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(is_pool_registered(arg0, arg1), 6);
        assert!(is_pool_in_rewarder(arg0, 0x1::type_name::get<T0>(), arg1), 4);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, 0x1::type_name::get<T0>()), 5);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, 0x1::type_name::get<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg2, 5);
        let v1 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, 0x1::type_name::get<T0>());
        v1.total_reward_harvested = v1.total_reward_harvested + arg2;
        let v2 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewarderInfo>(&mut v1.pools, arg1);
        v2.reward_harvested = v2.reward_harvested + arg2;
        assert!(((v2.reward_released / 1000000000000) as u64) >= v2.reward_harvested, 0);
        assert!(v1.total_reward_harvested >= v2.reward_harvested, 0);
        0x2::balance::split<T0>(v0, arg2)
    }

    // decompiled from Move bytecode v6
}

