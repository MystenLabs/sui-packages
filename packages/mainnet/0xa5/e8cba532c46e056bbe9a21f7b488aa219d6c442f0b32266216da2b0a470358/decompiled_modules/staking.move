module 0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::staking {
    struct VeARCA has key {
        id: 0x2::object::UID,
        staked_amount: u64,
        initial: u64,
        start_time: u64,
        end_time: u64,
        locking_period_sec: u64,
        decimals: u64,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        liquidity: 0x2::balance::Balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>,
        rewards: 0x2::balance::Balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>,
        veARCA_holders: 0x2::linked_table::LinkedTable<address, vector<u64>>,
        vip_level_veARCA: vector<u64>,
        week_reward_table: 0x2::table::Table<0x1::string::String, bool>,
        version: u64,
    }

    struct WeekReward has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        merkle_root: vector<u8>,
        total_reward: u64,
        claimed: u64,
        claimed_address: 0x2::table::Table<address, bool>,
    }

    struct Leaf has drop {
        week_reward_name: 0x1::string::String,
        user: address,
        amount: u64,
    }

    struct WithdrawRewardRequest has store, key {
        id: 0x2::object::UID,
        to: address,
        amount: u64,
    }

    struct ArcaStake has copy, drop {
        user: address,
        amount: u64,
        start_time: u64,
        end_time: u64,
        veARCA_id: 0x2::object::ID,
    }

    struct AppendArca has copy, drop {
        user: address,
        amount: u64,
        current_time: u64,
        veARCA_id: 0x2::object::ID,
    }

    struct AppendTime has copy, drop {
        user: address,
        append_time: u64,
        current_time: u64,
        veARCA_id: 0x2::object::ID,
    }

    struct UnStake has copy, drop {
        user: address,
        veARCA_id: 0x2::object::ID,
    }

    struct WeekFinished has copy, drop {
        name: 0x1::string::String,
        total_reward: u64,
        current_time: u64,
    }

    struct WeekRewardCreated has copy, drop {
        name: 0x1::string::String,
        merkle_root: vector<u8>,
        total_reward: u64,
        week_reward_id: 0x2::object::ID,
    }

    struct WeekRewardUpdated has copy, drop {
        new_merkle_root: vector<u8>,
        new_total_reward: u64,
        week_reward_id: 0x2::object::ID,
    }

    struct Claimed has copy, drop {
        user: address,
        amount: u64,
        week_reward_id: 0x2::object::ID,
    }

    public entry fun append(arg0: &mut StakingPool, arg1: &mut VeARCA, arg2: 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 8);
        let v0 = 0x2::coin::value<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&arg2);
        assert!(v0 > 0, 0);
        arg1.staked_amount = arg1.staked_amount + v0;
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(arg1.end_time > v1, 6);
        assert!(arg1.end_time - v1 >= 1, 5);
        let v2 = calc_initial_veARCA(v0, arg1.locking_period_sec, 31536000);
        assert!(v2 > 0, 0);
        0x2::balance::join<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg0.liquidity, 0x2::coin::into_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg2));
        arg1.initial = arg1.initial + v2;
        let v3 = *0x2::linked_table::borrow<address, vector<u64>>(&arg0.veARCA_holders, 0x2::tx_context::sender(arg4));
        *0x1::vector::borrow_mut<u64>(&mut v3, 0) = arg1.initial;
        *0x2::linked_table::borrow_mut<address, vector<u64>>(&mut arg0.veARCA_holders, 0x2::tx_context::sender(arg4)) = v3;
        let v4 = AppendArca{
            user         : 0x2::tx_context::sender(arg4),
            amount       : v0,
            current_time : v1,
            veARCA_id    : 0x2::object::id<VeARCA>(arg1),
        };
        0x2::event::emit<AppendArca>(v4);
    }

    public fun append_rewards(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: &mut StakingPool, arg2: 0x2::balance::Balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg3: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        assert!(1 == arg1.version, 8);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg3);
        0x2::balance::join<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg1.rewards, arg2);
    }

    public entry fun append_time(arg0: &mut StakingPool, arg1: &mut VeARCA, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 8);
        assert!(arg2 >= 604800, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = arg1.end_time - v0 + arg2;
        let v2 = v1;
        if (v1 > 31536000) {
            v2 = 31536000;
            arg2 = 31536000 - arg1.end_time - v0;
        };
        assert!(arg1.end_time > v0, 6);
        let v3 = calc_initial_veARCA(arg1.staked_amount, v2, 31536000);
        assert!(v3 > 0, 0);
        arg1.start_time = v0;
        arg1.end_time = v0 + v2;
        arg1.initial = v3;
        arg1.locking_period_sec = v2;
        let v4 = *0x2::linked_table::borrow<address, vector<u64>>(&arg0.veARCA_holders, 0x2::tx_context::sender(arg4));
        *0x1::vector::borrow_mut<u64>(&mut v4, 0) = arg1.initial;
        *0x1::vector::borrow_mut<u64>(&mut v4, 1) = arg1.end_time;
        *0x1::vector::borrow_mut<u64>(&mut v4, 2) = arg1.locking_period_sec;
        *0x2::linked_table::borrow_mut<address, vector<u64>>(&mut arg0.veARCA_holders, 0x2::tx_context::sender(arg4)) = v4;
        let v5 = AppendTime{
            user         : 0x2::tx_context::sender(arg4),
            append_time  : arg2,
            current_time : v0,
            veARCA_id    : 0x2::object::id<VeARCA>(arg1),
        };
        0x2::event::emit<AppendTime>(v5);
    }

    fun burn_veARCA(arg0: VeARCA) {
        let VeARCA {
            id                 : v0,
            staked_amount      : _,
            initial            : _,
            start_time         : _,
            end_time           : _,
            locking_period_sec : _,
            decimals           : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun calc_initial_veARCA(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 3);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun calc_veARCA(arg0: u64, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg2 as u128);
        let v1 = (arg3 as u128);
        let v2 = ((0x2::clock::timestamp_ms(arg1) / 1000) as u128);
        let v3 = v2;
        assert!(v1 != 0, 3);
        if (v2 > v0) {
            v3 = v0;
        };
        (((arg0 as u128) * (v0 - v3) / v1) as u64)
    }

    public fun calc_vip_level(arg0: &StakingPool, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        assert!(1 == arg0.version, 8);
        if (!0x2::linked_table::contains<address, vector<u64>>(&arg0.veARCA_holders, arg1)) {
            0
        } else {
            let v1 = 0x2::linked_table::borrow<address, vector<u64>>(&arg0.veARCA_holders, arg1);
            calc_vip_level_veARCA(calc_veARCA(*0x1::vector::borrow<u64>(v1, 0), arg2, *0x1::vector::borrow<u64>(v1, 1), *0x1::vector::borrow<u64>(v1, 2)), &arg0.vip_level_veARCA)
        }
    }

    public fun calc_vip_level_veARCA(arg0: u64, arg1: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(arg1) - 1;
        if (arg0 >= *0x1::vector::borrow<u64>(arg1, v1)) {
            return 0x1::vector::length<u64>(arg1)
        };
        if (arg0 < *0x1::vector::borrow<u64>(arg1, 0)) {
            return 0
        };
        let v2 = v1 - 1;
        while (v2 >= 0) {
            if (arg0 >= *0x1::vector::borrow<u64>(arg1, v2) && arg0 < *0x1::vector::borrow<u64>(arg1, v2 + 1)) {
                v0 = v2 + 1;
                break
            };
            if (v2 == 0) {
                break
            };
            v2 = v2 - 1;
        };
        v0
    }

    public entry fun claim(arg0: &mut StakingPool, arg1: &mut WeekReward, arg2: 0x1::string::String, arg3: u64, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 8);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, bool>(&arg1.claimed_address, v0), 11);
        if (0x1::vector::length<u8>(&arg1.merkle_root) > 0) {
            let v1 = Leaf{
                week_reward_name : arg2,
                user             : v0,
                amount           : arg3,
            };
            let v2 = 0x2::bcs::to_bytes<Leaf>(&v1);
            assert!(0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::merkle_proof::verify(&arg4, arg1.merkle_root, 0x2::hash::keccak256(&v2)), 9);
        };
        assert!(arg3 + arg1.claimed <= arg1.total_reward, 7);
        arg1.claimed = arg1.claimed + arg3;
        0x2::table::add<address, bool>(&mut arg1.claimed_address, v0, true);
        let v3 = Claimed{
            user           : v0,
            amount         : arg3,
            week_reward_id : 0x2::object::id<WeekReward>(arg1),
        };
        0x2::event::emit<Claimed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>>(0x2::coin::take<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg0.rewards, arg3, arg5), v0);
    }

    public entry fun create_week_reward(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: 0x1::string::String, arg2: vector<u8>, arg3: u64, arg4: &mut StakingPool, arg5: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg4.version, 8);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg4.week_reward_table, arg1), 12);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 14);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg5);
        let v0 = WeekReward{
            id              : 0x2::object::new(arg6),
            name            : arg1,
            merkle_root     : arg2,
            total_reward    : arg3,
            claimed         : 0,
            claimed_address : 0x2::table::new<address, bool>(arg6),
        };
        let v1 = WeekRewardCreated{
            name           : arg1,
            merkle_root    : arg2,
            total_reward   : arg3,
            week_reward_id : 0x2::object::id<WeekReward>(&v0),
        };
        0x2::event::emit<WeekRewardCreated>(v1);
        0x2::table::add<0x1::string::String, bool>(&mut arg4.week_reward_table, arg1, true);
        0x2::transfer::public_share_object<WeekReward>(v0);
    }

    public entry fun finish_week(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg4);
        let v0 = WeekFinished{
            name         : arg1,
            total_reward : arg2,
            current_time : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<WeekFinished>(v0);
    }

    public fun get_amount_VeARCA(arg0: &VeARCA, arg1: &0x2::clock::Clock) : u64 {
        calc_veARCA(arg0.initial, arg1, arg0.end_time, arg0.locking_period_sec)
    }

    public fun get_decimals_VeARCA(arg0: &VeARCA) : u64 {
        arg0.decimals
    }

    public fun get_end_time_VeARCA(arg0: &VeARCA) : u64 {
        arg0.end_time
    }

    public fun get_holders_number(arg0: &StakingPool) : u64 {
        0x2::linked_table::length<address, vector<u64>>(&arg0.veARCA_holders)
    }

    public fun get_initial_VeARCA(arg0: &VeARCA) : u64 {
        arg0.initial
    }

    public fun get_locking_period_sec_VeARCA(arg0: &VeARCA) : u64 {
        arg0.locking_period_sec
    }

    public fun get_rewards_value(arg0: &StakingPool) : u64 {
        0x2::balance::value<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&arg0.rewards)
    }

    public fun get_staked_amount_VeARCA(arg0: &VeARCA) : u64 {
        arg0.staked_amount
    }

    public fun get_start_time_VeARCA(arg0: &VeARCA) : u64 {
        arg0.start_time
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                : 0x2::object::new(arg0),
            liquidity         : 0x2::balance::zero<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(),
            rewards           : 0x2::balance::zero<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(),
            veARCA_holders    : 0x2::linked_table::new<address, vector<u64>>(arg0),
            vip_level_veARCA  : 0x1::vector::empty<u64>(),
            week_reward_table : 0x2::table::new<0x1::string::String, bool>(arg0),
            version           : 1,
        };
        let v1 = &mut v0;
        populate_vip_level_veARCA(v1);
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>>(&mut v0.id, 0x1::string::utf8(b"to_burn"), 0x2::balance::zero<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>());
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public(friend) fun marketplace_add_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>) {
        assert!(1 == arg0.version, 8);
        0x2::balance::join<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg0.rewards, 0x2::coin::into_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg1));
    }

    public(friend) fun marketplace_add_to_burn(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>) {
        assert!(1 == arg0.version, 8);
        0x2::balance::join<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>>(&mut arg0.id, 0x1::string::utf8(b"to_burn")), 0x2::coin::into_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg1));
    }

    entry fun migrate(arg0: &mut StakingPool, arg1: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg2: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        assert!(arg0.version < 1, 13);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg1, arg2);
        arg0.version = 1;
    }

    fun mint_ve(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : VeARCA {
        VeARCA{
            id                 : 0x2::object::new(arg5),
            staked_amount      : arg0,
            initial            : arg1,
            start_time         : arg2,
            end_time           : arg3,
            locking_period_sec : arg4,
            decimals           : 1000000000,
        }
    }

    fun populate_vip_level_veARCA(arg0: &mut StakingPool) {
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 3 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 35 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 170 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 670 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 1400 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 2700 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 4700 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 6700 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 14000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 17000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 20000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 27000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 34000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 67000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 140000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 270000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 400000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 670000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 1700000 * 1000000000);
        0x1::vector::push_back<u64>(&mut arg0.vip_level_veARCA, 3400000 * 1000000000);
    }

    public fun public_calc_veARCA(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        calc_veARCA(arg0, arg3, arg1, arg2)
    }

    public entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 8);
        assert!(!0x2::linked_table::contains<address, vector<u64>>(&arg0.veARCA_holders, 0x2::tx_context::sender(arg4)), 2);
        assert!(arg3 >= 604800 && arg3 <= 31536000, 4);
        let v0 = 0x2::coin::value<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v2 = v1 + arg3;
        let v3 = 0x1::vector::empty<u64>();
        let v4 = calc_initial_veARCA(v0, arg3, 31536000);
        assert!(v4 > 0, 0);
        0x2::balance::join<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg0.liquidity, 0x2::coin::into_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(arg1));
        0x1::vector::push_back<u64>(&mut v3, v4);
        0x1::vector::push_back<u64>(&mut v3, v2);
        0x1::vector::push_back<u64>(&mut v3, arg3);
        0x2::linked_table::push_back<address, vector<u64>>(&mut arg0.veARCA_holders, 0x2::tx_context::sender(arg4), v3);
        let v5 = mint_ve(v0, v4, v1, v2, arg3, arg4);
        let v6 = ArcaStake{
            user       : 0x2::tx_context::sender(arg4),
            amount     : v0,
            start_time : v1,
            end_time   : v2,
            veARCA_id  : 0x2::object::id<VeARCA>(&v5),
        };
        0x2::event::emit<ArcaStake>(v6);
        0x2::transfer::transfer<VeARCA>(v5, 0x2::tx_context::sender(arg4));
    }

    public fun unstake(arg0: VeARCA, arg1: &mut StakingPool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA> {
        assert!(1 == arg1.version, 8);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= arg0.end_time, 1);
        let v0 = UnStake{
            user      : 0x2::tx_context::sender(arg3),
            veARCA_id : 0x2::object::id<VeARCA>(&arg0),
        };
        0x2::event::emit<UnStake>(v0);
        burn_veARCA(arg0);
        0x2::linked_table::remove<address, vector<u64>>(&mut arg1.veARCA_holders, 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(0x2::balance::split<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg1.liquidity, arg0.staked_amount), arg3)
    }

    public fun update_vip_veARCA_vector(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: &mut StakingPool, arg2: u64, arg3: u64, arg4: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        assert!(1 == arg1.version, 8);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg4);
        if (arg2 >= 0x1::vector::length<u64>(&arg1.vip_level_veARCA)) {
            0x1::vector::push_back<u64>(&mut arg1.vip_level_veARCA, arg3);
        } else {
            *0x1::vector::borrow_mut<u64>(&mut arg1.vip_level_veARCA, arg2) = arg3;
        };
    }

    public entry fun update_week_reward(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameCap, arg1: vector<u8>, arg2: u64, arg3: &mut WeekReward, arg4: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 14);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::check_game_cap(arg0, arg4);
        arg3.merkle_root = arg1;
        arg3.total_reward = arg2;
        let v0 = WeekRewardUpdated{
            new_merkle_root  : arg1,
            new_total_reward : arg2,
            week_reward_id   : 0x2::object::id<WeekReward>(arg3),
        };
        0x2::event::emit<WeekRewardUpdated>(v0);
    }

    fun withdraw_rewards(arg0: &mut StakingPool, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>>(0x2::coin::take<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca::ARCA>(&mut arg0.rewards, arg2, arg3), arg1);
    }

    public entry fun withdraw_rewards_execute(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: u256, arg3: bool, arg4: &mut StakingPool, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(1 == arg4.version, 8);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_multi_sig_scope(arg1, arg0);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_participant(arg1, arg5);
        if (arg3) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg2);
            if (v0) {
                let v2 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::borrow_proposal_request<WithdrawRewardRequest>(arg1, &arg2, arg5);
                withdraw_rewards(arg4, v2.to, v2.amount, arg5);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        } else {
            let (v3, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg2);
            if (v3) {
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg2, arg5);
                return true
            };
        };
        abort 10
    }

    public entry fun withdraw_rewards_request(arg0: &0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::GameConfig, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_multi_sig_scope(arg1, arg0);
        0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::game::only_participant(arg1, arg4);
        let v0 = WithdrawRewardRequest{
            id     : 0x2::object::new(arg4),
            to     : arg2,
            amount : arg3,
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<WithdrawRewardRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<WithdrawRewardRequest>(arg1, *0x1::string::bytes(&v1), 6, v0, arg4);
    }

    // decompiled from Move bytecode v6
}

