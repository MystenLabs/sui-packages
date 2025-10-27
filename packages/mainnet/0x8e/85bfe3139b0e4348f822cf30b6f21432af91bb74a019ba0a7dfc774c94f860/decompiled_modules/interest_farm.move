module 0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm {
    struct RewardBalance has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct Decimals has copy, drop, store {
        pos0: u8,
    }

    struct RewardData has copy, drop, store {
        end: u64,
        rewards: u64,
        rewards_per_second: u64,
        last_reward_timestamp: u64,
        accrued_rewards_per_share: u256,
    }

    struct InterestFarmAccount<phantom T0> has store, key {
        id: 0x2::object::UID,
        farm: address,
        balance: 0x2::balance::Balance<T0>,
        reward_debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct NewFarmRequest<phantom T0> {
        farm: InterestFarm<T0>,
    }

    struct InterestFarm<phantom T0> has store, key {
        id: 0x2::object::UID,
        rewards: vector<0x1::type_name::TypeName>,
        reward_data: 0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardData>,
        total_stake_amount: u64,
        precision: u256,
        paused: bool,
        admin_type: 0x1::type_name::TypeName,
    }

    fun balance<T0, T1>(arg0: &InterestFarm<T0>, arg1: 0x1::type_name::TypeName) : &0x2::balance::Balance<T1> {
        let v0 = RewardBalance{pos0: arg1};
        0x2::dynamic_field::borrow<RewardBalance, 0x2::balance::Balance<T1>>(&arg0.id, v0)
    }

    public fun add_reward<T0, T1>(arg0: &mut InterestFarm<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        update_farm<T0>(arg0, arg1);
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardData>(&mut arg0.reward_data, &v0);
        let v2 = 0x2::coin::value<T1>(&arg2);
        v1.rewards = v1.rewards + v2;
        0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events::emit_add_reward(0x2::object::uid_to_address(&arg0.id), v0, v2);
        0x2::balance::join<T1>(balance_mut<T0, T1>(arg0, v0), 0x2::coin::into_balance<T1>(arg2));
    }

    fun assert_belongs_to_farm<T0>(arg0: &InterestFarmAccount<T0>, arg1: &InterestFarm<T0>) {
        assert!(0x2::object::uid_to_address(&arg1.id) == arg0.farm, 1);
    }

    fun assert_is_admin<T0, T1>(arg0: &InterestFarm<T0>) {
        assert!(arg0.admin_type == 0x1::type_name::with_defining_ids<T1>(), 5);
    }

    fun assert_is_live<T0>(arg0: &InterestFarm<T0>) {
        assert!(!arg0.paused, 3);
    }

    fun balance_mut<T0, T1>(arg0: &mut InterestFarm<T0>, arg1: 0x1::type_name::TypeName) : &mut 0x2::balance::Balance<T1> {
        let v0 = RewardBalance{pos0: arg1};
        0x2::dynamic_field::borrow_mut<RewardBalance, 0x2::balance::Balance<T1>>(&mut arg0.id, v0)
    }

    fun calculate_accrued_rewards(arg0: u64, arg1: u256, arg2: u64, arg3: u64, arg4: u256, arg5: u64) : (u256, u256) {
        let v0 = 0x1::u256::min((arg3 as u256), (arg0 as u256) * (arg5 as u256));
        (arg1 + v0 * arg4 / (arg2 as u256), v0)
    }

    fun calculate_pending_rewards<T0>(arg0: &InterestFarmAccount<T0>, arg1: 0x1::type_name::TypeName, arg2: u256, arg3: u256) : u64 {
        (((0x2::balance::value<T0>(&arg0.balance) as u256) * arg3 / arg2 - *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.reward_debts, &arg1)) as u64)
    }

    fun calculate_reward_debt_impl(arg0: u64, arg1: u256, arg2: u256) : u256 {
        (arg0 as u256) * arg2 / arg1
    }

    public fun coin_metadata_decimals<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : Decimals {
        Decimals{pos0: 0x2::coin::get_decimals<T0>(arg0)}
    }

    public fun currency_decimals<T0>(arg0: &0x2::coin_registry::Currency<T0>) : Decimals {
        Decimals{pos0: 0x2::coin_registry::decimals<T0>(arg0)}
    }

    fun default_reward_data() : RewardData {
        RewardData{
            end                       : 0,
            rewards                   : 0,
            rewards_per_second        : 0,
            last_reward_timestamp     : 0,
            accrued_rewards_per_share : 0,
        }
    }

    public fun destroy_account<T0>(arg0: InterestFarmAccount<T0>) {
        let InterestFarmAccount {
            id           : v0,
            farm         : _,
            balance      : v2,
            reward_debts : _,
            rewards      : v4,
        } = arg0;
        let v5 = v0;
        let (_, v7) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, u64>(v4);
        let v8 = v7;
        let v9 = &v8;
        let v10 = 0;
        let v11;
        while (v10 < 0x1::vector::length<u64>(v9)) {
            let v12 = 0;
            if (!(0x1::vector::borrow<u64>(v9, v10) == &v12)) {
                v11 = false;
                /* label 6 */
                assert!(v11, 4);
                0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events::emit_destroy_account(0x2::object::uid_to_address(&v5));
                0x2::balance::destroy_zero<T0>(v2);
                0x2::object::delete(v5);
                return
            };
            v10 = v10 + 1;
        };
        v11 = true;
        /* goto 6 */
    }

    public fun harvest<T0, T1>(arg0: &mut InterestFarmAccount<T0>, arg1: &mut InterestFarm<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_is_live<T0>(arg1);
        assert_belongs_to_farm<T0>(arg0, arg1);
        update_with_account<T0>(arg1, arg2, arg0);
        update_reward_debt<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.rewards, &v0);
        let v2 = *v1;
        assert!(v2 != 0, 2);
        *v1 = 0;
        let v3 = balance_mut<T0, T1>(arg1, v0);
        let v4 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v3, 0x1::u64::min(v2, 0x2::balance::value<T1>(v3))), arg3);
        0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events::emit_harvest(0x2::object::uid_to_address(&arg1.id), 0x2::object::uid_to_address(&arg0.id), 0x2::coin::value<T1>(&v4), v0, 0x2::balance::value<T0>(&arg0.balance), arg0.reward_debts, arg0.rewards);
        v4
    }

    public fun new_account<T0>(arg0: &InterestFarm<T0>, arg1: &mut 0x2::tx_context::TxContext) : InterestFarmAccount<T0> {
        assert_is_live<T0>(arg0);
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
        let v1 = arg0.rewards;
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = v0;
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v3, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1), 0);
            v0 = v3;
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v1);
        let v4 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v5 = arg0.rewards;
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = v4;
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v7, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v5), 0);
            v4 = v7;
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v5);
        let v8 = InterestFarmAccount<T0>{
            id           : 0x2::object::new(arg1),
            farm         : 0x2::object::uid_to_address(&arg0.id),
            balance      : 0x2::balance::zero<T0>(),
            reward_debts : v0,
            rewards      : v4,
        };
        0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events::emit_new_account(0x2::object::uid_to_address(&arg0.id), 0x2::object::uid_to_address(&v8.id));
        v8
    }

    public fun new_farm<T0>(arg0: NewFarmRequest<T0>, arg1: &mut 0x2::tx_context::TxContext) : InterestFarm<T0> {
        let NewFarmRequest { farm: v0 } = arg0;
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v0.rewards) != 0, 0);
        0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events::emit_new_farm(0x2::object::uid_to_address(&v0.id), v0.rewards, v0.admin_type);
        v0
    }

    public fun pause<T0, T1>(arg0: &mut InterestFarm<T0>, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<T1>) {
        assert_is_admin<T0, T1>(arg0);
        arg0.paused = true;
    }

    fun pending_rewards<T0, T1>(arg0: &InterestFarmAccount<T0>, arg1: &InterestFarm<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardData>(&arg1.reward_data, &v0);
        let v2 = 0x1::u64::min(v1.end, timestamp_s(arg2));
        let v3 = if (arg1.total_stake_amount == 0 || v1.last_reward_timestamp >= v2) {
            v1.accrued_rewards_per_share
        } else {
            let (v4, _) = calculate_accrued_rewards(v1.rewards_per_second, v1.accrued_rewards_per_share, arg1.total_stake_amount, v1.rewards, arg1.precision, v2 - v1.last_reward_timestamp);
            v4
        };
        0x1::u64::min(calculate_pending_rewards<T0>(arg0, v0, arg1.precision, v3) + *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.rewards, &v0), 0x2::balance::value<T1>(balance<T0, T1>(arg1, v0)))
    }

    public fun register_reward<T0, T1>(arg0: &mut NewFarmRequest<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = RewardBalance{pos0: v0};
        0x2::dynamic_field::add<RewardBalance, 0x2::balance::Balance<T1>>(&mut arg0.farm.id, v1, 0x2::balance::zero<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.farm.rewards, v0);
        0x2::vec_map::insert<0x1::type_name::TypeName, RewardData>(&mut arg0.farm.reward_data, v0, default_reward_data());
    }

    public fun request_new_farm<T0, T1>(arg0: Decimals, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<T1>, arg2: &mut 0x2::tx_context::TxContext) : NewFarmRequest<T0> {
        let v0 = InterestFarm<T0>{
            id                 : 0x2::object::new(arg2),
            rewards            : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reward_data        : 0x2::vec_map::empty<0x1::type_name::TypeName, RewardData>(),
            total_stake_amount : 0,
            precision          : 0x1::u256::pow(10, arg0.pos0) * 1000000000,
            paused             : false,
            admin_type         : 0x1::type_name::with_defining_ids<T1>(),
        };
        NewFarmRequest<T0>{farm: v0}
    }

    public fun set_end_time<T0, T1, T2>(arg0: &mut InterestFarm<T0>, arg1: &0x2::clock::Clock, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<T2>, arg3: u64) {
        assert_is_admin<T0, T2>(arg0);
        update_farm<T0>(arg0, arg1);
        assert!(arg3 > timestamp_s(arg1), 6);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardData>(&mut arg0.reward_data, &v0).end = arg3;
        0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events::emit_set_end_time(0x2::object::uid_to_address(&arg0.id), 0x1::type_name::with_defining_ids<T1>(), arg3);
    }

    public fun set_rewards_per_second<T0, T1, T2>(arg0: &mut InterestFarm<T0>, arg1: &0x2::clock::Clock, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<T2>, arg3: u64) {
        assert_is_admin<T0, T2>(arg0);
        update_farm<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardData>(&mut arg0.reward_data, &v0);
        v1.rewards_per_second = arg3;
        0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events::emit_set_rewards_per_second(0x2::object::uid_to_address(&arg0.id), 0x1::type_name::with_defining_ids<T1>(), v1.rewards_per_second, arg3);
    }

    public fun stake<T0>(arg0: &mut InterestFarmAccount<T0>, arg1: &mut InterestFarm<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_live<T0>(arg1);
        assert_belongs_to_farm<T0>(arg0, arg1);
        update_with_account<T0>(arg1, arg2, arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg3));
        update_reward_debt<T0>(arg0, arg1);
        arg1.total_stake_amount = arg1.total_stake_amount + v0;
        0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events::emit_stake(0x2::object::uid_to_address(&arg1.id), 0x2::object::uid_to_address(&arg0.id), v0, arg1.total_stake_amount, 0x1::type_name::with_defining_ids<T0>(), 0x2::balance::value<T0>(&arg0.balance), arg0.reward_debts, arg0.rewards);
    }

    fun timestamp_s(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun unpause<T0, T1>(arg0: &mut InterestFarm<T0>, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<T1>) {
        assert_is_admin<T0, T1>(arg0);
        arg0.paused = false;
    }

    public fun unstake<T0>(arg0: &mut InterestFarmAccount<T0>, arg1: &mut InterestFarm<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_belongs_to_farm<T0>(arg0, arg1);
        update_with_account<T0>(arg1, arg2, arg0);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg3), arg4);
        update_reward_debt<T0>(arg0, arg1);
        arg1.total_stake_amount = arg1.total_stake_amount - arg3;
        0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events::emit_unstake(0x2::object::uid_to_address(&arg1.id), 0x2::object::uid_to_address(&arg0.id), arg3, arg1.total_stake_amount, 0x1::type_name::with_defining_ids<T0>(), 0x2::balance::value<T0>(&arg0.balance), arg0.reward_debts, arg0.rewards);
        v0
    }

    fun update_farm<T0>(arg0: &mut InterestFarm<T0>, arg1: &0x2::clock::Clock) {
        let v0 = arg0.rewards;
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            update_impl<T0>(arg0, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v0), timestamp_s(arg1));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v0);
    }

    fun update_impl<T0>(arg0: &mut InterestFarm<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardData>(&mut arg0.reward_data, &arg1);
        let v1 = 0x1::u64::min(v0.end, arg2);
        let v2 = v0.last_reward_timestamp;
        v0.last_reward_timestamp = v1;
        let v3 = if (arg0.total_stake_amount != 0) {
            if (v2 < v1) {
                if (v0.rewards_per_second != 0) {
                    v0.rewards != 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            let (v4, v5) = calculate_accrued_rewards(v0.rewards_per_second, v0.accrued_rewards_per_share, arg0.total_stake_amount, v0.rewards, arg0.precision, v1 - v2);
            v0.accrued_rewards_per_share = v4;
            v0.rewards = v0.rewards - (v5 as u64);
            if (v0.rewards == 0) {
                v0.rewards_per_second = 0;
            };
        };
        0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events::emit_update_reward(0x2::object::uid_to_address(&arg0.id), arg1, v0.rewards, v0.rewards_per_second, v0.last_reward_timestamp, v0.accrued_rewards_per_share);
    }

    fun update_reward_debt<T0>(arg0: &mut InterestFarmAccount<T0>, arg1: &InterestFarm<T0>) {
        let v0 = &arg1.rewards;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v2 = 0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1);
            let v3 = *0x2::vec_map::get<0x1::type_name::TypeName, RewardData>(&arg1.reward_data, v2);
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.reward_debts, v2) = calculate_reward_debt_impl(0x2::balance::value<T0>(&arg0.balance), arg1.precision, v3.accrued_rewards_per_share);
            v1 = v1 + 1;
        };
    }

    fun update_with_account<T0>(arg0: &mut InterestFarm<T0>, arg1: &0x2::clock::Clock, arg2: &mut InterestFarmAccount<T0>) {
        let v0 = arg0.rewards;
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v0);
            update_impl<T0>(arg0, v2, timestamp_s(arg1));
            if (0x2::balance::value<T0>(&arg2.balance) != 0) {
                let v3 = calculate_pending_rewards<T0>(arg2, v2, arg0.precision, 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardData>(&mut arg0.reward_data, &v2).accrued_rewards_per_share);
                if (v3 != 0) {
                    let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg2.rewards, &v2);
                    *v4 = *v4 + v3;
                };
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v0);
    }

    // decompiled from Move bytecode v6
}

