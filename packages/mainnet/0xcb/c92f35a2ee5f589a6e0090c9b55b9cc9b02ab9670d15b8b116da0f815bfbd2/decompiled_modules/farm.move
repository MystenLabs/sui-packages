module 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm {
    struct Farm<phantom T0> has store, key {
        id: 0x2::object::UID,
        reward_infos: 0x2::table::Table<0x1::type_name::TypeName, RewardInfo>,
        reward_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        last_update_time: u64,
        reward_balances: 0x2::bag::Bag,
        staked_balance: 0x2::balance::Balance<T0>,
    }

    struct RewardInfo has store {
        rewards_per_sec: u64,
        cumulative_index: u64,
        harvested_rewards: u64,
        is_claimable: bool,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        shares: u64,
        reward_infos: 0x2::table::Table<0x1::type_name::TypeName, UserRewardInfo>,
    }

    struct UserRewardInfo has store {
        cumulative_index: u64,
        harvested_rewards: u64,
    }

    public(friend) fun add_reward<T0, T1>(arg0: &mut Farm<T0>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::error::invalid_reward_type());
        harvest<T0>(arg0, arg4);
        let v1 = RewardInfo{
            rewards_per_sec   : arg2,
            cumulative_index  : 0x2::math::pow(10, 9),
            harvested_rewards : 0,
            is_claimable      : arg3,
        };
        0x2::table::add<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, v0, v1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0, arg1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.reward_types, v0);
    }

    fun assert_farm_id<T0>(arg0: &Farm<T0>, arg1: &StakeReceipt) {
        assert!(arg1.farm_id == 0x2::object::id<Farm<T0>>(arg0), 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::error::invalid_stake_receipt_for_farm());
    }

    public(friend) fun claim_reward<T0, T1>(arg0: &mut Farm<T0>, arg1: &mut StakeReceipt, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        assert_farm_id<T0>(arg0, arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::error::invalid_reward_type());
        harvest<T0>(arg0, arg2);
        harvest_for_user<T0>(arg0, arg1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, v0);
        assert!(v1.is_claimable, 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::error::reward_not_claimable());
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserRewardInfo>(&mut arg1.reward_infos, v0);
        let v3 = v2.harvested_rewards;
        v2.harvested_rewards = 0;
        v1.harvested_rewards = v1.harvested_rewards - v3;
        0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), v3)
    }

    public(friend) fun harvest<T0>(arg0: &mut Farm<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = &mut arg0.last_update_time;
        if (v0 == *v1) {
            return
        };
        let v2 = v0 - *v1;
        let v3 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.reward_types);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(v3)) {
            let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, *0x1::vector::borrow<0x1::type_name::TypeName>(v3, v4));
            let v6 = (((v2 as u128) * (v5.rewards_per_sec as u128)) as u64);
            v5.harvested_rewards = v5.harvested_rewards + v6;
            v5.cumulative_index = 0x1::fixed_point32::get_raw_value(0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::utils::sum_f32(0x1::fixed_point32::create_from_raw_value(v5.cumulative_index), 0x1::fixed_point32::create_from_rational(v6, 0x2::balance::value<T0>(&arg0.staked_balance))));
            v4 = v4 + 1;
        };
        *v1 = v0;
    }

    public(friend) fun harvest_for_user<T0>(arg0: &Farm<T0>, arg1: &mut StakeReceipt) {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.reward_types);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1);
            let v3 = 0x2::table::borrow<0x1::type_name::TypeName, RewardInfo>(&arg0.reward_infos, v2);
            if (0x2::table::contains<0x1::type_name::TypeName, UserRewardInfo>(&arg1.reward_infos, v2)) {
                let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserRewardInfo>(&mut arg1.reward_infos, v2);
                if (v4.cumulative_index == v3.cumulative_index) {
                    continue
                };
                v4.harvested_rewards = v4.harvested_rewards + ((((v3.cumulative_index - v4.cumulative_index) as u256) * (arg1.shares as u256)) as u64);
                v4.cumulative_index = v3.cumulative_index;
            } else {
                let v5 = UserRewardInfo{
                    cumulative_index  : v3.cumulative_index,
                    harvested_rewards : (((v3.cumulative_index as u256) * (arg1.shares as u256)) as u64),
                };
                0x2::table::add<0x1::type_name::TypeName, UserRewardInfo>(&mut arg1.reward_infos, v2, v5);
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun increase_stake<T0>(arg0: &mut Farm<T0>, arg1: &mut StakeReceipt, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        assert_farm_id<T0>(arg0, arg1);
        harvest<T0>(arg0, arg3);
        harvest_for_user<T0>(arg0, arg1);
        0x2::balance::join<T0>(&mut arg0.staked_balance, arg2);
        arg1.shares = arg1.shares + 0x2::balance::value<T0>(&arg2);
    }

    public(friend) fun initialize<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : Farm<T0> {
        Farm<T0>{
            id               : 0x2::object::new(arg1),
            reward_infos     : 0x2::table::new<0x1::type_name::TypeName, RewardInfo>(arg1),
            reward_types     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            last_update_time : 0x2::clock::timestamp_ms(arg0) / 1000,
            reward_balances  : 0x2::bag::new(arg1),
            staked_balance   : 0x2::balance::zero<T0>(),
        }
    }

    public fun last_update_time<T0>(arg0: &Farm<T0>) : u64 {
        arg0.last_update_time
    }

    public fun reward_infos<T0>(arg0: &Farm<T0>) : (vector<0x1::ascii::String>, vector<vector<u64>>) {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.reward_types);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<vector<u64>>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(v0, v3);
            let v5 = 0x2::table::borrow<0x1::type_name::TypeName, RewardInfo>(&arg0.reward_infos, v4);
            let v6 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::type_name::into_string(v4));
            0x1::vector::push_back<u64>(&mut v6, v5.rewards_per_sec);
            0x1::vector::push_back<u64>(&mut v6, v5.cumulative_index);
            0x1::vector::push_back<u64>(&mut v6, v5.harvested_rewards);
            0x1::vector::push_back<vector<u64>>(&mut v2, v6);
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun reward_types<T0>(arg0: &Farm<T0>) : vector<0x1::ascii::String> {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.reward_types);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::type_name::into_string(*0x1::vector::borrow<0x1::type_name::TypeName>(v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun simulate_current_rewards<T0>(arg0: &Farm<T0>, arg1: &StakeReceipt) : (vector<0x1::ascii::String>, vector<u64>) {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.reward_types);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(v0, v3);
            let v5 = 0x2::table::borrow<0x1::type_name::TypeName, RewardInfo>(&arg0.reward_infos, v4);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::type_name::into_string(v4));
            if (0x2::table::contains<0x1::type_name::TypeName, UserRewardInfo>(&arg1.reward_infos, v4)) {
                let v6 = 0x2::table::borrow<0x1::type_name::TypeName, UserRewardInfo>(&arg1.reward_infos, v4);
                if (v6.cumulative_index == v5.cumulative_index) {
                    continue
                };
                0x1::vector::push_back<u64>(&mut v2, v6.harvested_rewards + ((((v5.cumulative_index - v6.cumulative_index) as u256) * (arg1.shares as u256)) as u64));
            } else {
                0x1::vector::push_back<u64>(&mut v2, (((v5.cumulative_index as u256) * (arg1.shares as u256)) as u64));
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public(friend) fun stake<T0>(arg0: &mut Farm<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : StakeReceipt {
        harvest<T0>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.staked_balance, arg1);
        let v0 = 0x2::table::new<0x1::type_name::TypeName, UserRewardInfo>(arg3);
        let v1 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.reward_types);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            let v3 = 0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2);
            let v4 = UserRewardInfo{
                cumulative_index  : 0x2::table::borrow<0x1::type_name::TypeName, RewardInfo>(&arg0.reward_infos, *v3).cumulative_index,
                harvested_rewards : 0,
            };
            0x2::table::add<0x1::type_name::TypeName, UserRewardInfo>(&mut v0, *v3, v4);
            v2 = v2 + 1;
        };
        StakeReceipt{
            id           : 0x2::object::new(arg3),
            farm_id      : 0x2::object::id<Farm<T0>>(arg0),
            shares       : 0x2::balance::value<T0>(&arg1),
            reward_infos : v0,
        }
    }

    public fun total_staked<T0>(arg0: &Farm<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.staked_balance)
    }

    public(friend) fun unstake<T0>(arg0: &mut Farm<T0>, arg1: &mut StakeReceipt, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        assert_farm_id<T0>(arg0, arg1);
        harvest<T0>(arg0, arg3);
        harvest_for_user<T0>(arg0, arg1);
        assert!(arg2 <= arg1.shares, 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::error::unstake_amount_too_much());
        arg1.shares = arg1.shares - arg2;
        0x2::balance::split<T0>(&mut arg0.staked_balance, arg2)
    }

    public(friend) fun update_reward<T0, T1>(arg0: &mut Farm<T0>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::error::invalid_reward_type());
        harvest<T0>(arg0, arg4);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, v0);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), arg1);
        v1.rewards_per_sec = arg2;
        v1.is_claimable = arg3;
    }

    public fun user_shares(arg0: &StakeReceipt) : u64 {
        arg0.shares
    }

    public(friend) fun withdraw_unharvested<T0, T1>(arg0: &mut Farm<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::error::invalid_reward_type());
        harvest<T0>(arg0, arg1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, v0);
        v1.rewards_per_sec = 0;
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0);
        let v3 = 0x2::balance::value<T1>(v2);
        assert!(v1.harvested_rewards < v3, 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::error::no_unharvested_rewards());
        0x2::balance::split<T1>(v2, v3 - v1.harvested_rewards)
    }

    // decompiled from Move bytecode v6
}

