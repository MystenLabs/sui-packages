module 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder {
    struct StrategyRewarderInfo has store {
        allocate_point: u64,
        acc_per_share: u128,
        last_reward_time: u64,
    }

    struct Rewarder has store {
        reward_coin: 0x1::type_name::TypeName,
        total_allocate_point: u64,
        emission_per_second: u64,
        last_reward_time: u64,
        total_reward_released: u128,
        total_reward_harvested: u64,
        strategys: 0x2::linked_table::LinkedTable<0x2::object::ID, StrategyRewarderInfo>,
    }

    struct RewarderManager has store, key {
        id: 0x2::object::UID,
        vault: 0x2::bag::Bag,
        strategy_shares: 0x2::linked_table::LinkedTable<0x2::object::ID, u128>,
        rewarders: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, Rewarder>,
        black_list: vector<address>,
    }

    struct InitRewarderManagerEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct CreateRewarderEvent has copy, drop {
        reward_coin: 0x1::type_name::TypeName,
        emission_per_second: u64,
    }

    struct UpdateRewarderEvent has copy, drop {
        reward_coin: 0x1::type_name::TypeName,
        emission_per_second: u64,
    }

    struct DepositEvent has copy, drop {
        reward_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        after_amount: u64,
    }

    public(friend) fun accumulate_rewarder_released(arg0: &mut Rewarder, arg1: u64) {
        if (arg0.last_reward_time < arg1) {
            if (arg0.emission_per_second > 0) {
                arg0.total_reward_released = arg0.total_reward_released + ((arg0.emission_per_second * (arg1 - arg0.last_reward_time)) as u128);
            };
            arg0.last_reward_time = arg1;
        };
    }

    public(friend) fun accumulate_strategy_reward(arg0: &mut Rewarder, arg1: 0x2::object::ID, arg2: u128, arg3: u64) : u128 {
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, StrategyRewarderInfo>(&mut arg0.strategys, arg1);
        if (arg3 > v0.last_reward_time && arg0.emission_per_second > 0) {
            if (arg2 > 0) {
                v0.acc_per_share = v0.acc_per_share + 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(((arg0.emission_per_second * (arg3 - v0.last_reward_time) * v0.allocate_point / arg0.total_allocate_point) as u128), 1000000000, arg2);
            } else {
                v0.acc_per_share = 0;
            };
        };
        v0.last_reward_time = arg3;
        v0.acc_per_share
    }

    public(friend) fun accumulate_strategys_reward<T0>(arg0: &mut RewarderManager, arg1: u64) {
        let v0 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, 0x1::type_name::get<T0>());
        let v1 = 0x2::linked_table::front<0x2::object::ID, StrategyRewarderInfo>(&v0.strategys);
        while (0x1::option::is_some<0x2::object::ID>(v1)) {
            let v2 = *0x1::option::borrow<0x2::object::ID>(v1);
            accumulate_strategy_reward(v0, v2, *0x2::linked_table::borrow<0x2::object::ID, u128>(&arg0.strategy_shares, v2), arg1);
            v1 = 0x2::linked_table::next<0x2::object::ID, StrategyRewarderInfo>(&v0.strategys, v2);
        };
        v0.last_reward_time = arg1;
    }

    public fun add_reward_black_list(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut RewarderManager, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_reward_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        while (0x1::vector::length<address>(&arg3) > 0) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg3);
            if (!0x1::vector::contains<address>(&arg2.black_list, &v0)) {
                0x1::vector::push_back<address>(&mut arg2.black_list, v0);
            };
        };
    }

    public(friend) fun add_strategy<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(is_strategy_registered(arg0, arg1), 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!is_strategy_in_rewarder(arg0, v0, arg1), 2);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        accumulate_strategys_reward<T0>(arg0, v1);
        let v2 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, v0);
        accumulate_rewarder_released(v2, v1);
        let v3 = StrategyRewarderInfo{
            allocate_point   : arg2,
            acc_per_share    : 0,
            last_reward_time : v1,
        };
        0x2::linked_table::push_back<0x2::object::ID, StrategyRewarderInfo>(&mut v2.strategys, arg1, v3);
        v2.total_allocate_point = v2.total_allocate_point + arg2;
    }

    public fun create_rewarder<T0>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut RewarderManager, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_reward_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::linked_table::contains<0x1::type_name::TypeName, Rewarder>(&arg2.rewarders, v0), 1);
        let v1 = Rewarder{
            reward_coin            : v0,
            total_allocate_point   : 0,
            emission_per_second    : arg3,
            last_reward_time       : 0x2::clock::timestamp_ms(arg4) / 1000,
            total_reward_released  : 0,
            total_reward_harvested : 0,
            strategys              : 0x2::linked_table::new<0x2::object::ID, StrategyRewarderInfo>(arg5),
        };
        0x2::linked_table::push_back<0x1::type_name::TypeName, Rewarder>(&mut arg2.rewarders, v0, v1);
        let v2 = CreateRewarderEvent{
            reward_coin         : v0,
            emission_per_second : arg3,
        };
        0x2::event::emit<CreateRewarderEvent>(v2);
    }

    public fun deposit_rewarder<T0>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut RewarderManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg0);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 6);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vault, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vault, v0, 0x2::balance::zero<T0>());
        };
        let v1 = DepositEvent{
            reward_type    : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg2),
            after_amount   : 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vault, v0), 0x2::coin::into_balance<T0>(arg2)),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewarderManager{
            id              : 0x2::object::new(arg0),
            vault           : 0x2::bag::new(arg0),
            strategy_shares : 0x2::linked_table::new<0x2::object::ID, u128>(arg0),
            rewarders       : 0x2::linked_table::new<0x1::type_name::TypeName, Rewarder>(arg0),
            black_list      : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<RewarderManager>(v0);
        let v1 = InitRewarderManagerEvent{id: 0x2::object::id<RewarderManager>(&v0)};
        0x2::event::emit<InitRewarderManagerEvent>(v1);
    }

    public(friend) fun is_in_black_list(arg0: &RewarderManager, arg1: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.black_list, &arg1);
        v0
    }

    fun is_strategy_in_rewarder(arg0: &RewarderManager, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, StrategyRewarderInfo>(&0x2::linked_table::borrow<0x1::type_name::TypeName, Rewarder>(&arg0.rewarders, arg1).strategys, arg2)
    }

    public fun is_strategy_registered(arg0: &RewarderManager, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, u128>(&arg0.strategy_shares, arg1)
    }

    public(friend) fun register_strategy(arg0: &mut RewarderManager, arg1: 0x2::object::ID) {
        assert!(!is_strategy_registered(arg0, arg1), 3);
        0x2::linked_table::push_back<0x2::object::ID, u128>(&mut arg0.strategy_shares, arg1, 0);
    }

    public fun remove_reward_black_list(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut RewarderManager, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_reward_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        while (0x1::vector::length<address>(&arg3) > 0) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg3);
            let (v1, v2) = 0x1::vector::index_of<address>(&arg2.black_list, &v0);
            if (v1) {
                0x1::vector::remove<address>(&mut arg2.black_list, v2);
            };
        };
    }

    public(friend) fun set_strategy_share(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u128) {
        *0x2::linked_table::borrow_mut<0x2::object::ID, u128>(&mut arg0.strategy_shares, arg1) = arg2;
    }

    public(friend) fun strategy_rewards_settle(arg0: &mut RewarderManager, arg1: vector<0x1::type_name::TypeName>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128> {
        assert!(is_strategy_registered(arg0, arg2), 2);
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, u128>(&arg0.strategy_shares, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u128>();
        while (0x1::vector::length<0x1::type_name::TypeName>(&arg1) > 0) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg1);
            let v4 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, v3);
            let v5 = accumulate_strategy_reward(v4, arg2, *v0, v1);
            accumulate_rewarder_released(v4, v1);
            0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut v2, v3, v5);
        };
        v2
    }

    public fun update_rewarder<T0>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut RewarderManager, arg3: u64, arg4: &0x2::clock::Clock) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_reward_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::linked_table::contains<0x1::type_name::TypeName, Rewarder>(&arg2.rewarders, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg4) / 1000;
        accumulate_strategys_reward<T0>(arg2, v1);
        let v2 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg2.rewarders, v0);
        accumulate_rewarder_released(v2, v1);
        v2.emission_per_second = arg3;
        let v3 = UpdateRewarderEvent{
            reward_coin         : v0,
            emission_per_second : arg3,
        };
        0x2::event::emit<UpdateRewarderEvent>(v3);
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(is_strategy_registered(arg0, arg1), 2);
        assert!(is_strategy_in_rewarder(arg0, v0, arg1), 4);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 5);
        let v2 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, v0);
        v2.total_reward_harvested = v2.total_reward_harvested + arg2;
        0x2::balance::split<T0>(v1, arg2)
    }

    // decompiled from Move bytecode v6
}

