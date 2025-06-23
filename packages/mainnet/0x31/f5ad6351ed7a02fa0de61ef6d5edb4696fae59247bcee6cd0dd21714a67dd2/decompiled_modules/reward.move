module 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward {
    struct RewardManagerCreated has copy, drop {
        vault_id: address,
        reward_manager_id: address,
    }

    struct RewardManagerUpgraded has copy, drop {
        reward_manager_id: address,
        version: u64,
    }

    struct RewardTypeAdded has copy, drop {
        reward_manager_id: address,
        reward_type: 0x1::type_name::TypeName,
    }

    struct RewardAdded has copy, drop {
        reward_manager_id: address,
        reward_type: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct RewardDistributed has copy, drop {
        reward_manager_id: address,
        reward_type: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct RewardRateSet has copy, drop {
        reward_manager_id: address,
        reward_type: 0x1::type_name::TypeName,
        rate: u64,
    }

    struct RewardDistributionUpdated has copy, drop {
        reward_manager_id: address,
        reward_type: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct RewardIndicesUpdated has copy, drop {
        reward_manager_id: address,
        reward_type: 0x1::type_name::TypeName,
        new_reward_index: u256,
    }

    struct NftRewardUpdated has copy, drop {
        reward_manager_id: address,
        nft_id: address,
        reward_type: 0x1::type_name::TypeName,
        new_reward: u64,
    }

    struct RewardClaimed has copy, drop {
        reward_manager_id: address,
        reward_type: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct RewardManager has store, key {
        id: 0x2::object::UID,
        version: u64,
        vault_id: address,
        reward_balances: 0x2::bag::Bag,
        available_reward_amounts: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        reward_amounts: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        reward_indices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        distributions: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Distribution>,
        nft_reward_indices: 0x2::table::Table<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>,
        nft_unclaimed_rewards: 0x2::table::Table<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>,
    }

    struct Distribution has copy, drop, store {
        rate: u64,
        last_update_time: u64,
    }

    public(friend) fun add_new_reward_type<T0>(arg0: &mut RewardManager, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.reward_balances, v0), 1004);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reward_balances, v0, 0x2::balance::zero<T0>());
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.available_reward_amounts, v0, 0);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.reward_amounts, v0, 0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.reward_indices, v0, 0);
        let v1 = Distribution{
            rate             : 0,
            last_update_time : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, Distribution>(&mut arg0.distributions, v0, v1);
        let v2 = RewardTypeAdded{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            reward_type       : v0,
        };
        0x2::event::emit<RewardTypeAdded>(v2);
    }

    public(friend) fun add_reward<T0>(arg0: &mut RewardManager, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = RewardAdded{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            reward_type       : v0,
            reward_amount     : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<RewardAdded>(v1);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.available_reward_amounts, v0) = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.available_reward_amounts, v0) + 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reward_balances, v0), arg1);
    }

    public fun available_reward_amounts(arg0: &RewardManager, arg1: 0x1::type_name::TypeName) : u64 {
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.available_reward_amounts, arg1)
    }

    public(friend) fun check_version(arg0: &RewardManager) {
        assert!(arg0.version == 1, 1003);
    }

    public fun claim_reward<T0, T1>(arg0: &mut RewardManager, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg2: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        update_nft_reward<T0>(arg0, arg2, arg1, arg3, arg4);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.nft_unclaimed_rewards, 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::nft_id<T0>(arg2));
        let v2 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(v1, v0);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(v1, v0) = 0;
        assert!(0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.reward_balances, v0)) >= v2, 1002);
        let v3 = RewardClaimed{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            reward_type       : v0,
            reward_amount     : v2,
        };
        0x2::event::emit<RewardClaimed>(v3);
        0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), v2)
    }

    public(friend) fun create_reward_manager<T0>(arg0: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::vault_id<T0>(arg0);
        let v1 = RewardManager{
            id                       : 0x2::object::new(arg1),
            version                  : 1,
            vault_id                 : v0,
            reward_balances          : 0x2::bag::new(arg1),
            available_reward_amounts : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            reward_amounts           : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            reward_indices           : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            distributions            : 0x2::vec_map::empty<0x1::type_name::TypeName, Distribution>(),
            nft_reward_indices       : 0x2::table::new<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>(arg1),
            nft_unclaimed_rewards    : 0x2::table::new<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(arg1),
        };
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::set_reward_manager<T0>(arg0, 0x2::object::uid_to_address(&v1.id));
        let v2 = RewardManagerCreated{
            vault_id          : v0,
            reward_manager_id : 0x2::object::uid_to_address(&v1.id),
        };
        0x2::event::emit<RewardManagerCreated>(v2);
        0x2::transfer::share_object<RewardManager>(v1);
    }

    public(friend) fun distribute_reward<T0, T1>(arg0: &mut RewardManager, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T1>();
        update_reward_distribution<T0>(arg0, arg1, arg3, v0);
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.available_reward_amounts, v0) >= arg2, 1001);
        let v1 = RewardDistributed{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            reward_type       : v0,
            reward_amount     : arg2,
        };
        0x2::event::emit<RewardDistributed>(v1);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.reward_amounts, v0) = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_amounts, v0) + arg2;
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.available_reward_amounts, v0) = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.available_reward_amounts, v0) - arg2;
    }

    public fun distribution_last_update_time(arg0: &Distribution) : u64 {
        arg0.last_update_time
    }

    public fun distribution_rate(arg0: &Distribution) : u64 {
        arg0.rate
    }

    public fun distributions(arg0: &RewardManager, arg1: 0x1::type_name::TypeName) : Distribution {
        *0x2::vec_map::get<0x1::type_name::TypeName, Distribution>(&arg0.distributions, &arg1)
    }

    fun finish_update_nft_reward(arg0: &mut RewardManager, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, Distribution>(&arg0.distributions);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            let v3 = 0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2);
            let v4 = *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.reward_indices, v3);
            if (!0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>(&arg0.nft_reward_indices, arg1)) {
                0x2::table::add<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>(&mut arg0.nft_reward_indices, arg1, 0x2::table::new<0x1::type_name::TypeName, u256>(arg3));
            };
            if (!0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.nft_unclaimed_rewards, arg1)) {
                0x2::table::add<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.nft_unclaimed_rewards, arg1, 0x2::table::new<0x1::type_name::TypeName, u64>(arg3));
            };
            let v5 = !0x2::table::contains<0x1::type_name::TypeName, u256>(0x2::table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>(&arg0.nft_reward_indices, arg1), *v3);
            let v6 = if (v5) {
                0
            } else {
                *0x2::table::borrow<0x1::type_name::TypeName, u256>(0x2::table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>(&arg0.nft_reward_indices, arg1), *v3)
            };
            if (v5) {
                0x2::table::add<0x1::type_name::TypeName, u256>(0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>(&mut arg0.nft_reward_indices, arg1), *v3, 0);
                0x2::table::add<0x1::type_name::TypeName, u64>(0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.nft_unclaimed_rewards, arg1), *v3, 0);
            };
            let v7 = (v4 - v6) * (arg2 as u256) / 1000000000;
            let v8 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.nft_unclaimed_rewards, arg1);
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u256>(0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>(&mut arg0.nft_reward_indices, arg1), *v3) = v4;
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(v8, *v3) = *0x2::table::borrow<0x1::type_name::TypeName, u64>(v8, *v3) + (v7 as u64);
            let v9 = NftRewardUpdated{
                reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
                nft_id            : arg1,
                reward_type       : *v3,
                new_reward        : (v7 as u64),
            };
            0x2::event::emit<NftRewardUpdated>(v9);
            v2 = v2 + 1;
        };
    }

    public(friend) fun init_update_nft_reward<T0>(arg0: &mut RewardManager, arg1: &0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg2: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        update_reward_distributions<T0>(arg0, arg2, arg3);
        finish_update_nft_reward(arg0, 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::nft_id<T0>(arg1), 0, arg4);
    }

    public fun nft_reward_indices(arg0: &RewardManager, arg1: address, arg2: 0x1::type_name::TypeName) : u256 {
        *0x2::table::borrow<0x1::type_name::TypeName, u256>(0x2::table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>(&arg0.nft_reward_indices, arg1), arg2)
    }

    public fun nft_unclaimed_rewards(arg0: &RewardManager, arg1: address, arg2: 0x1::type_name::TypeName) : u64 {
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(0x2::table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.nft_unclaimed_rewards, arg1), arg2)
    }

    public fun reward_amounts(arg0: &RewardManager, arg1: 0x1::type_name::TypeName) : u64 {
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_amounts, arg1)
    }

    public fun reward_balances<T0>(arg0: &RewardManager, arg1: 0x1::type_name::TypeName) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.reward_balances, arg1))
    }

    public fun reward_indices(arg0: &RewardManager, arg1: 0x1::type_name::TypeName) : u256 {
        *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.reward_indices, &arg1)
    }

    public fun reward_manager_id(arg0: &RewardManager) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun set_reward_rate<T0, T1>(arg0: &mut RewardManager, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T1>();
        update_reward_distribution<T0>(arg0, arg1, arg3, v0);
        0x2::vec_map::get_mut<0x1::type_name::TypeName, Distribution>(&mut arg0.distributions, &v0).rate = arg2;
        let v1 = RewardRateSet{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            reward_type       : v0,
            rate              : arg2,
        };
        0x2::event::emit<RewardRateSet>(v1);
    }

    public fun update_nft_reward<T0>(arg0: &mut RewardManager, arg1: &0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg2: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        update_reward_distributions<T0>(arg0, arg2, arg3);
        let v0 = if (0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::nft_is_active<T0>(arg1)) {
            0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::nft_locked_amount<T0>(arg1)
        } else {
            0
        };
        finish_update_nft_reward(arg0, 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::nft_id<T0>(arg1), v0, arg4);
    }

    public fun update_reward_distribution<T0>(arg0: &mut RewardManager, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::type_name::TypeName) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Distribution>(&mut arg0.distributions, &arg3);
        let v2 = v1.rate * (v0 - v1.last_update_time);
        let v3 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_amounts, arg3);
        v1.last_update_time = v0;
        let v4 = 0x1::u64::min(v3, v2);
        let v5 = (0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::vault_total_locked_balance<T0>(arg1) as u256);
        if (v3 > 0 && v5 > 0) {
            update_reward_indices(arg0, arg3, v4, v5);
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.reward_amounts, arg3) = v3 - v4;
        };
        let v6 = RewardDistributionUpdated{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            reward_type       : arg3,
            reward_amount     : v4,
        };
        0x2::event::emit<RewardDistributionUpdated>(v6);
    }

    public fun update_reward_distributions<T0>(arg0: &mut RewardManager, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, Distribution>(&arg0.distributions);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            update_reward_distribution<T0>(arg0, arg1, arg2, *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2));
            v2 = v2 + 1;
        };
    }

    public(friend) fun update_reward_indices(arg0: &mut RewardManager, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u256) {
        let v0 = *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.reward_indices, &arg1) + (arg2 as u256) * 1000000000 / arg3;
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.reward_indices, &arg1) = v0;
        let v1 = RewardIndicesUpdated{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            reward_type       : arg1,
            new_reward_index  : v0,
        };
        0x2::event::emit<RewardIndicesUpdated>(v1);
    }

    public(friend) fun upgrade_reward_manager(arg0: &mut RewardManager) {
        assert!(arg0.version < 1, 1003);
        arg0.version = 1;
        let v0 = RewardManagerUpgraded{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            version           : 1,
        };
        0x2::event::emit<RewardManagerUpgraded>(v0);
    }

    public fun vault_id(arg0: &RewardManager) : address {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

