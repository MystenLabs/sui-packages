module 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::farm {
    struct FARM has drop {
        dummy_field: bool,
    }

    struct Farm<phantom T0> has store, key {
        id: 0x2::object::UID,
        reward_infos: 0x2::table::Table<0x1::type_name::TypeName, RewardInfo>,
        reward_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        last_update_time: u64,
        reward_balances: 0x2::bag::Bag,
        total_weight: u64,
        staked_balance: 0x2::balance::Balance<T0>,
        points_info: PointsInfo,
    }

    struct RewardInfo has store {
        total_rewards: u64,
        harvested_rewards: u64,
        end_timestamp: u64,
        cumulative_index: u128,
        is_claimable: bool,
    }

    struct PointsInfo has store {
        total_accumulated_points: u64,
        total_claimed_points: u64,
        index: u128,
        updated_at: u64,
        start_time: u64,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        shares: u64,
        reward_infos: 0x2::table::Table<0x1::type_name::TypeName, UserRewardInfo>,
        user_points_info: UserPointsInfo,
    }

    struct UserRewardInfo has drop, store {
        cumulative_index: u128,
        harvested_rewards: u64,
    }

    struct UserPointsInfo has store {
        updated_at: u64,
        claimed_points: u64,
        index: u128,
    }

    public(friend) fun add_reward<T0, T1>(arg0: &mut Farm<T0>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::error::invalid_reward_type());
        harvest<T0>(arg0, arg5);
        let v1 = RewardInfo{
            total_rewards     : arg2,
            harvested_rewards : 0,
            end_timestamp     : arg3,
            cumulative_index  : 0,
            is_claimable      : arg4,
        };
        0x2::table::add<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, v0, v1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0, arg1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.reward_types, v0);
    }

    public(friend) fun add_reward_balance<T0, T1>(arg0: &mut Farm<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::error::invalid_reward_type());
        harvest<T0>(arg0, arg2);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, v0);
        v1.total_rewards = v1.total_rewards + 0x2::balance::value<T1>(&arg1);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), arg1);
    }

    fun assert_farm_id<T0>(arg0: &Farm<T0>, arg1: &StakeReceipt) {
        assert!(arg1.farm_id == 0x2::object::id<Farm<T0>>(arg0), 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::error::invalid_stake_receipt_for_farm());
    }

    public(friend) fun claim_reward<T0, T1>(arg0: &mut Farm<T0>, arg1: &mut StakeReceipt, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        assert_farm_id<T0>(arg0, arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::error::invalid_reward_type());
        harvest<T0>(arg0, arg2);
        harvest_for_user<T0>(arg0, arg1, arg2);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, v0);
        assert!(v1.is_claimable, 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::error::reward_not_claimable());
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserRewardInfo>(&mut arg1.reward_infos, v0);
        let v3 = v2.harvested_rewards;
        v2.harvested_rewards = 0;
        v1.harvested_rewards = v1.harvested_rewards - v3;
        let v4 = 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.reward_balances, v0));
        let v5 = if (v4 > v3) {
            v3
        } else {
            v4
        };
        0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), v5)
    }

    public(friend) fun harvest<T0>(arg0: &mut Farm<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = &mut arg0.last_update_time;
        if (v0 == *v1) {
            return
        };
        if (arg0.total_weight == 0) {
            return
        };
        let v2 = v0 - *v1;
        let v3 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.reward_types);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(v3)) {
            let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, *0x1::vector::borrow<0x1::type_name::TypeName>(v3, v4));
            if (v0 > v5.end_timestamp) {
                continue
            };
            let v6 = v5.end_timestamp - *v1;
            if (v6 == 0) {
                v4 = v4 + 1;
                continue
            };
            let v7 = 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::utils::mul_factor(v2, v5.total_rewards, v6);
            if (v5.total_rewards > v7) {
                v5.total_rewards = v5.total_rewards - v7;
            } else {
                v5.total_rewards = 0;
            };
            v5.harvested_rewards = v5.harvested_rewards + v7;
            v5.cumulative_index = v5.cumulative_index + 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::utils::mul_factor_u128((v7 as u128), 18446744073709551616, (arg0.total_weight as u128));
            v4 = v4 + 1;
        };
        *v1 = v0;
    }

    public(friend) fun harvest_for_user<T0>(arg0: &mut Farm<T0>, arg1: &mut StakeReceipt, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.reward_types);
        if (arg1.shares == 0) {
            return
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1);
            let v3 = 0x2::table::borrow<0x1::type_name::TypeName, RewardInfo>(&arg0.reward_infos, v2);
            if (0x2::table::contains<0x1::type_name::TypeName, UserRewardInfo>(&arg1.reward_infos, v2)) {
                let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserRewardInfo>(&mut arg1.reward_infos, v2);
                if (v4.cumulative_index == v3.cumulative_index) {
                    v1 = v1 + 1;
                    continue
                };
                v4.harvested_rewards = v4.harvested_rewards + (0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::utils::mul_factor_u128((arg1.shares as u128), v3.cumulative_index - v4.cumulative_index, 18446744073709551616) as u64);
                v4.cumulative_index = v3.cumulative_index;
            } else {
                let v5 = UserRewardInfo{
                    cumulative_index  : v3.cumulative_index,
                    harvested_rewards : (0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::utils::mul_factor_u128((arg1.shares as u128), v3.cumulative_index, 18446744073709551616) as u64),
                };
                0x2::table::add<0x1::type_name::TypeName, UserRewardInfo>(&mut arg1.reward_infos, v2, v5);
            };
            v1 = v1 + 1;
        };
        harvest_points_for_user<T0>(arg0, arg1, arg2);
    }

    fun harvest_points_for_user<T0>(arg0: &mut Farm<T0>, arg1: &mut StakeReceipt, arg2: &0x2::clock::Clock) {
        assert_farm_id<T0>(arg0, arg1);
        if (arg1.user_points_info.index >= arg0.points_info.index) {
            return
        };
        let v0 = (0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::utils::mul_factor_u128((arg1.shares as u128), arg0.points_info.index - arg1.user_points_info.index, 18446744073709551616) as u64);
        arg0.points_info.total_claimed_points = arg0.points_info.total_claimed_points + v0;
        arg1.user_points_info.claimed_points = arg1.user_points_info.claimed_points + v0;
        arg1.user_points_info.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun increase_stake<T0>(arg0: &mut Farm<T0>, arg1: &mut StakeReceipt, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        assert_farm_id<T0>(arg0, arg1);
        harvest<T0>(arg0, arg3);
        harvest_for_user<T0>(arg0, arg1, arg3);
        let v0 = 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.staked_balance, arg2);
        arg0.total_weight = arg0.total_weight + v0;
        arg1.shares = arg1.shares + v0;
    }

    fun init(arg0: FARM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Kriya Farm Stake Receipt"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://kriya-assets.s3.ap-southeast-1.amazonaws.com/assets/{farm_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Stake Receipt issued by Kriya Farms"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.kriya.finance"));
        let v4 = 0x2::package::claim<FARM>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<StakeReceipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<StakeReceipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<StakeReceipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun initialize<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Farm<T0> {
        let v0 = PointsInfo{
            total_accumulated_points : 0,
            total_claimed_points     : 0,
            index                    : 0,
            updated_at               : 0x2::clock::timestamp_ms(arg1),
            start_time               : 0x2::clock::timestamp_ms(arg1),
        };
        Farm<T0>{
            id               : 0x2::object::new(arg2),
            reward_infos     : 0x2::table::new<0x1::type_name::TypeName, RewardInfo>(arg2),
            reward_types     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            last_update_time : 0x2::clock::timestamp_ms(arg1),
            reward_balances  : 0x2::bag::new(arg2),
            total_weight     : 0,
            staked_balance   : arg0,
            points_info      : v0,
        }
    }

    public fun last_update_time<T0>(arg0: &Farm<T0>) : u64 {
        arg0.last_update_time
    }

    public fun points_info<T0>(arg0: &Farm<T0>) : (u64, u64, u128) {
        (arg0.points_info.total_accumulated_points, arg0.points_info.total_claimed_points, arg0.points_info.index)
    }

    public fun reward_info<T0, T1>(arg0: &Farm<T0>) : (u64, u64, u64, u64, bool) {
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, RewardInfo>(&arg0.reward_infos, 0x1::type_name::get<T1>());
        (v0.total_rewards, v0.harvested_rewards, 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.reward_balances, 0x1::type_name::get<T1>())), v0.end_timestamp, v0.is_claimable)
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
            0x1::vector::push_back<u64>(&mut v6, v5.total_rewards);
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

    public fun simulate_current_points<T0>(arg0: &Farm<T0>, arg1: &StakeReceipt) : u64 {
        assert_farm_id<T0>(arg0, arg1);
        if (arg1.user_points_info.index >= arg0.points_info.index) {
            return arg1.user_points_info.claimed_points
        };
        arg0.points_info.total_claimed_points + (0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::utils::mul_factor_u128((arg1.shares as u128), arg0.points_info.index - arg1.user_points_info.index, 18446744073709551616) as u64)
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
                    v3 = v3 + 1;
                    continue
                };
                0x1::vector::push_back<u64>(&mut v2, v6.harvested_rewards + (0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::utils::mul_factor_u128((arg1.shares as u128), v5.cumulative_index - v6.cumulative_index, 18446744073709551616) as u64));
            } else {
                0x1::vector::push_back<u64>(&mut v2, (0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::utils::mul_factor_u128((arg1.shares as u128), v5.cumulative_index, 18446744073709551616) as u64));
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public(friend) fun stake<T0>(arg0: &mut Farm<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : StakeReceipt {
        harvest<T0>(arg0, arg2);
        let v0 = 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.staked_balance, arg1);
        arg0.total_weight = arg0.total_weight + v0;
        let v1 = 0x2::table::new<0x1::type_name::TypeName, UserRewardInfo>(arg3);
        let v2 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.reward_types);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
            let v4 = 0x1::vector::borrow<0x1::type_name::TypeName>(v2, v3);
            let v5 = UserRewardInfo{
                cumulative_index  : 0x2::table::borrow<0x1::type_name::TypeName, RewardInfo>(&arg0.reward_infos, *v4).cumulative_index,
                harvested_rewards : 0,
            };
            0x2::table::add<0x1::type_name::TypeName, UserRewardInfo>(&mut v1, *v4, v5);
            v3 = v3 + 1;
        };
        let v6 = UserPointsInfo{
            updated_at     : 0x2::clock::timestamp_ms(arg2),
            claimed_points : 0,
            index          : arg0.points_info.index,
        };
        StakeReceipt{
            id               : 0x2::object::new(arg3),
            farm_id          : 0x2::object::id<Farm<T0>>(arg0),
            shares           : v0,
            reward_infos     : v1,
            user_points_info : v6,
        }
    }

    public fun stake_receipt_info(arg0: &StakeReceipt) : (0x2::object::ID, u64) {
        (arg0.farm_id, arg0.shares)
    }

    public fun stake_receipt_points_info(arg0: &StakeReceipt) : u64 {
        arg0.user_points_info.claimed_points
    }

    public fun stake_receipt_reward_info<T0>(arg0: &StakeReceipt) : u64 {
        0x2::table::borrow<0x1::type_name::TypeName, UserRewardInfo>(&arg0.reward_infos, 0x1::type_name::get<T0>()).harvested_rewards
    }

    public fun total_staked<T0>(arg0: &Farm<T0>) : u64 {
        arg0.total_weight
    }

    public(friend) fun unstake<T0>(arg0: &mut Farm<T0>, arg1: &mut StakeReceipt, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        assert_farm_id<T0>(arg0, arg1);
        harvest<T0>(arg0, arg3);
        harvest_for_user<T0>(arg0, arg1, arg3);
        assert!(arg2 <= arg1.shares, 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::error::unstake_amount_too_much());
        arg1.shares = arg1.shares - arg2;
        arg0.total_weight = arg0.total_weight - arg2;
        0x2::balance::split<T0>(&mut arg0.staked_balance, arg2)
    }

    public(friend) fun update_points<T0>(arg0: &mut Farm<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        arg0.points_info.index = arg0.points_info.index + 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::utils::mul_factor_u128(((arg1 - arg0.points_info.total_accumulated_points) as u128), 18446744073709551616, (arg0.total_weight as u128));
        arg0.points_info.total_accumulated_points = arg1;
        arg0.points_info.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun update_reward_end_timestamp<T0, T1>(arg0: &mut Farm<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::error::invalid_reward_type());
        harvest<T0>(arg0, arg2);
        0x2::table::borrow_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, v0).end_timestamp = arg1;
    }

    public(friend) fun update_reward_is_claimable<T0, T1>(arg0: &mut Farm<T0>, arg1: bool, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::error::invalid_reward_type());
        harvest<T0>(arg0, arg2);
        0x2::table::borrow_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, v0).is_claimable = arg1;
    }

    public(friend) fun withdraw_unharvested<T0, T1>(arg0: &mut Farm<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::error::invalid_reward_type());
        harvest<T0>(arg0, arg1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RewardInfo>(&mut arg0.reward_infos, v0);
        v1.total_rewards = 0;
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0);
        let v3 = 0x2::balance::value<T1>(v2);
        assert!(v1.harvested_rewards < v3, 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::error::no_unharvested_rewards());
        0x2::balance::split<T1>(v2, v3 - v1.harvested_rewards)
    }

    // decompiled from Move bytecode v6
}

