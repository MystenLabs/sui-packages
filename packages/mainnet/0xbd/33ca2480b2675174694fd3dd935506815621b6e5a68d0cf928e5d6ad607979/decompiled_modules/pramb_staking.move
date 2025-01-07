module 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::pramb_staking {
    struct Config has store, key {
        id: 0x2::object::UID,
        admin: address,
        uid: u64,
        current_version: u64,
    }

    struct UserStore has store, key {
        id: 0x2::object::UID,
    }

    struct PoolInfo<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        total_staked_coins: 0x2::coin::Coin<T0>,
        total_reward_coins: 0x2::coin::Coin<T1>,
        total_staked_token: u64,
        staking_options: 0x2::table_vec::TableVec<StakingOption>,
        precision_factor: u128,
        paused: bool,
    }

    struct StakingOption has copy, drop, store {
        days: u64,
        fixed_yield: u64,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        user_staked_id: 0x2::vec_set::VecSet<u64>,
        user_staked: 0x2::table::Table<u64, UserInfoDetail>,
    }

    struct UserInfoDetail has store {
        stake_id: u64,
        amount: u64,
        reward_debt: u128,
        fixed_yield: u64,
        start_time: u64,
        end_time: u64,
        last_time_claimed: u64,
        stake_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
    }

    struct DepositEvent has copy, drop, store {
        stake_id: u64,
        user_addr: address,
        amount: u64,
        stake_token: 0x1::ascii::String,
        reward_token: 0x1::ascii::String,
        fixed_yield: u64,
        start_time: u64,
        end_time: u64,
        reward_debt: u128,
        last_time_claimed: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        stake_id: u64,
        amount: u64,
        stake_token: 0x1::ascii::String,
        reward_token: 0x1::ascii::String,
    }

    struct ClaimRewardEvent has copy, drop, store {
        stake_id: u64,
        user_addr: address,
        amount: u64,
        stake_token: 0x1::ascii::String,
        reward_token: 0x1::ascii::String,
        last_time_claimed: u64,
        fixed_yield: u64,
        reward_debt: u128,
        start_time: u64,
        end_time: u64,
    }

    struct EmergencyWithdrawRewardEvent<phantom T0, phantom T1> has copy, drop, store {
        admin: address,
        amount: u64,
    }

    struct NewPoolLimitEvent<phantom T0, phantom T1> has copy, drop, store {
        pool_limit_per_user: u64,
    }

    struct NewFixedYieldEvent<phantom T0, phantom T1> has copy, drop, store {
        new_fixed_yield: u64,
    }

    struct NewStartAndEndTimestampEvent<phantom T0, phantom T1> has copy, drop, store {
        start_timestamp: u64,
        end_timestamp: u64,
    }

    struct CreatePoolEvent has copy, drop, store {
        user: address,
        stake_token_info: 0x1::ascii::String,
        reward_token_info: 0x1::ascii::String,
    }

    public entry fun add_reward<T0, T1>(arg0: &mut Config, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0), 7);
        let v1 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v0).total_reward_coins;
        transfer_in<T1>(v1, arg1);
    }

    public entry fun add_staking_option<T0, T1>(arg0: &mut Config, arg1: vector<u64>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0), 7);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v0);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2), 100);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v3 = StakingOption{
                days        : *0x1::vector::borrow<u64>(&arg1, v2),
                fixed_yield : *0x1::vector::borrow<u64>(&arg2, v2),
            };
            0x2::table_vec::push_back<StakingOption>(&mut v1.staking_options, v3);
            v2 = v2 + 1;
        };
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 108);
    }

    fun cal_pending_reward(arg0: &0x2::clock::Clock, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u64) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        if (v0 >= arg7) {
            0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u64(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::sub(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::mul(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::mul(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg1), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg3)), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(10000)))), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(31536000)))), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg7 - arg6)), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(arg4)), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(arg2)))
        } else {
            let v2 = if (arg5 == 0) {
                v0 - arg6
            } else {
                v0 - arg5
            };
            0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u64(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::mul(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::mul(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg1), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg3)), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(10000)))), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(31536000)))), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(v2)), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(arg4)))
        }
    }

    public entry fun claim_reward<T0, T1>(arg0: &mut Config, arg1: &mut UserStore, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::string::from_ascii(v1);
        0x1::string::append(&mut v3, 0x1::string::from_ascii(v2));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v3), 7);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v3);
        assert_version(arg0.current_version);
        let v5 = 0x2::dynamic_object_field::borrow_mut<address, UserInfo>(&mut arg1.id, v0);
        assert!(0x2::vec_set::contains<u64>(&v5.user_staked_id, &arg2), 20);
        let v6 = 0x2::table::borrow_mut<u64, UserInfoDetail>(&mut v5.user_staked, arg2);
        assert!(v1 == v6.stake_type && v2 == v6.reward_type, 22);
        let v7 = cal_pending_reward(arg3, v6.amount, v6.reward_debt, v6.fixed_yield, v4.precision_factor, v6.last_time_claimed, v6.start_time, v6.end_time);
        let v8 = 0x2::clock::timestamp_ms(arg3) / 1000;
        if (v7 > 0) {
            let v9 = &mut v4.total_reward_coins;
            transfer_out<T1>(v9, v0, v7, arg4);
            v6.reward_debt = v6.reward_debt + (v7 as u128);
            v6.last_time_claimed = v8;
        };
        let v10 = ClaimRewardEvent{
            stake_id          : arg2,
            user_addr         : v0,
            amount            : v7,
            stake_token       : v1,
            reward_token      : v2,
            last_time_claimed : v8,
            fixed_yield       : v6.fixed_yield,
            reward_debt       : v6.reward_debt,
            start_time        : v6.start_time,
            end_time          : v6.end_time,
        };
        0x2::event::emit<ClaimRewardEvent>(v10);
    }

    public entry fun create_pool<T0, T1>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin, 0);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::string::from_ascii(v1);
        0x1::string::append(&mut v3, 0x1::string::from_ascii(v2));
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v3), 1);
        let v4 = PoolInfo<T0, T1>{
            id                 : 0x2::object::new(arg1),
            total_staked_coins : 0x2::coin::zero<T0>(arg1),
            total_reward_coins : 0x2::coin::zero<T1>(arg1),
            total_staked_token : 0,
            staking_options    : 0x2::table_vec::empty<StakingOption>(arg1),
            precision_factor   : 1,
            paused             : false,
        };
        0x2::dynamic_object_field::add<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v3, v4);
        let v5 = CreatePoolEvent{
            user              : v0,
            stake_token_info  : v1,
            reward_token_info : v2,
        };
        0x2::event::emit<CreatePoolEvent>(v5);
    }

    public entry fun deposit_pool<T0, T1>(arg0: &mut Config, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0), 7);
        let v1 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v0).total_staked_coins;
        transfer_in<T0>(v1, arg1);
    }

    public entry fun emergency_reward_withdraw<T0, T1>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin, 0);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v1), 7);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v1);
        let v3 = 0x2::coin::value<T1>(&v2.total_reward_coins);
        assert!(v3 > 0, 6);
        let v4 = &mut v2.total_reward_coins;
        transfer_out<T1>(v4, v0, v3, arg1);
        let v5 = EmergencyWithdrawRewardEvent<T0, T1>{
            admin  : v0,
            amount : v3,
        };
        0x2::event::emit<EmergencyWithdrawRewardEvent<T0, T1>>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id              : 0x2::object::new(arg0),
            admin           : @0x1937f2c5ce1cbab08893b63945c20cde349e4a7850eea317b965ff8da383c80e,
            uid             : 0,
            current_version : 1,
        };
        0x2::transfer::public_share_object<Config>(v0);
        let v1 = UserStore{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<UserStore>(v1);
    }

    fun migrate_version_contract(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 0);
        arg0.current_version = arg1;
    }

    fun reward_debt(arg0: u64, arg1: u64, arg2: u128, arg3: u64) : u128 {
        if (arg3 == 0) {
            0
        } else {
            0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::mul(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::mul(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg0), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg1)), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(10000)))), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(31536000)))), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg3)), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(arg2)))
        }
    }

    public entry fun set_admin(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 0);
        arg0.admin = arg1;
    }

    public entry fun stake_token<T0, T1>(arg0: &mut Config, arg1: &mut UserStore, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::string::from_ascii(v1);
        0x1::string::append(&mut v3, 0x1::string::from_ascii(v2));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v3), 7);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v3);
        let v5 = 0x2::table_vec::borrow<StakingOption>(&v4.staking_options, arg3);
        let v6 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v7 = v6 + v5.days * 86400;
        assert_version(arg0.current_version);
        if (!0x2::dynamic_object_field::exists_<address>(&arg1.id, v0)) {
            let v8 = UserInfo{
                id             : 0x2::object::new(arg5),
                user_staked_id : 0x2::vec_set::empty<u64>(),
                user_staked    : 0x2::table::new<u64, UserInfoDetail>(arg5),
            };
            0x2::dynamic_object_field::add<address, UserInfo>(&mut arg1.id, v0, v8);
        };
        let v9 = arg0.uid + 1;
        let v10 = 0x2::dynamic_object_field::borrow_mut<address, UserInfo>(&mut arg1.id, v0);
        let v11 = 0x2::coin::value<T0>(&arg2);
        let v12 = v5.fixed_yield;
        let v13 = &mut v4.total_staked_coins;
        transfer_in<T0>(v13, 0x2::coin::split<T0>(&mut arg2, total_can_claim_reward(v11, v12, v6, v7, v4.precision_factor), arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, @0x878520e777c712d91f3c431b72ecf2fd9cc8d7f033251e7e68743178cf72e3da);
        if (v11 > 0) {
            v4.total_staked_token = v4.total_staked_token + v11;
            0x2::vec_set::insert<u64>(&mut v10.user_staked_id, v9);
            let v14 = UserInfoDetail{
                stake_id          : v9,
                amount            : v11,
                reward_debt       : 0,
                fixed_yield       : v5.fixed_yield,
                start_time        : v6,
                end_time          : v7,
                last_time_claimed : 0,
                stake_type        : v1,
                reward_type       : v2,
            };
            0x2::table::add<u64, UserInfoDetail>(&mut v10.user_staked, v9, v14);
        };
        arg0.uid = v9;
        let v15 = DepositEvent{
            stake_id          : v9,
            user_addr         : v0,
            amount            : v11,
            stake_token       : v1,
            reward_token      : v2,
            fixed_yield       : v5.fixed_yield,
            start_time        : v6,
            end_time          : v7,
            reward_debt       : 0,
            last_time_claimed : 0,
        };
        0x2::event::emit<DepositEvent>(v15);
    }

    public entry fun stop_pool<T0, T1>(arg0: &mut Config, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0), 7);
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v0).paused = arg1;
    }

    fun total_can_claim_reward(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128) : u64 {
        0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u64(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::mul(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::as_u128(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::div(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::mul(0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg0), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg1)), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(10000)))), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(31536000)))), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u64(arg3 - arg2)), 0x55271cd50c8ca509273ae533bc38a23ff5712c4e8fb8a102fdeb6fd4c00bcb88::u256::from_u128(arg4)))
    }

    fun transfer_in<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::pay::join<T0>(arg0, arg1);
    }

    fun transfer_out<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg2, arg3), arg1);
    }

    public entry fun update_staking_option<T0, T1>(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0), 7);
        let v1 = 0x2::table_vec::borrow_mut<StakingOption>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v0).staking_options, arg1);
        v1.fixed_yield = arg2;
        v1.days = arg3;
        let v2 = NewFixedYieldEvent<T0, T1>{new_fixed_yield: arg2};
        0x2::event::emit<NewFixedYieldEvent<T0, T1>>(v2);
    }

    public entry fun update_staking_options<T0, T1>(arg0: &mut Config, arg1: vector<u64>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0), 7);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v0);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2), 200);
        while (0x2::table_vec::length<StakingOption>(&v1.staking_options) > 0) {
            0x2::table_vec::pop_back<StakingOption>(&mut v1.staking_options);
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v3 = StakingOption{
                days        : *0x1::vector::borrow<u64>(&arg2, v2),
                fixed_yield : *0x1::vector::borrow<u64>(&arg1, v2),
            };
            0x2::table_vec::push_back<StakingOption>(&mut v1.staking_options, v3);
            v2 = v2 + 1;
        };
    }

    public entry fun withdraw_token<T0, T1>(arg0: &mut Config, arg1: &mut UserStore, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::string::from_ascii(v1);
        0x1::string::append(&mut v3, 0x1::string::from_ascii(v2));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v3), 7);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v3);
        assert_version(arg0.current_version);
        let v5 = 0x2::dynamic_object_field::borrow_mut<address, UserInfo>(&mut arg1.id, v0);
        assert!(0x2::vec_set::contains<u64>(&v5.user_staked_id, &arg2), 20);
        let v6 = 0x2::table::borrow_mut<u64, UserInfoDetail>(&mut v5.user_staked, arg2);
        assert!(v1 == v6.stake_type && v2 == v6.reward_type, 22);
        assert!(v6.amount >= 0, 6);
        let v7 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v6.end_time < v7, 21);
        let v8 = cal_pending_reward(arg3, v6.amount, v6.reward_debt, v6.fixed_yield, v4.precision_factor, v6.last_time_claimed, v6.start_time, v6.end_time);
        v4.total_staked_token = v4.total_staked_token - v6.amount;
        let v9 = &mut v4.total_staked_coins;
        transfer_out<T0>(v9, v0, v6.amount, arg4);
        if (v8 > 0) {
            let v10 = &mut v4.total_reward_coins;
            transfer_out<T1>(v10, v0, v8, arg4);
            v6.last_time_claimed = v7;
        };
        v6.reward_debt = reward_debt(v6.amount, v6.fixed_yield, v4.precision_factor, v6.last_time_claimed);
        let v11 = WithdrawEvent{
            stake_id     : arg2,
            amount       : v6.amount,
            stake_token  : v1,
            reward_token : v2,
        };
        0x2::event::emit<WithdrawEvent>(v11);
    }

    public entry fun withdraw_treasure<T0, T1>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0, 0);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v1), 7);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInfo<T0, T1>>(&mut arg0.id, v1);
        let v3 = &mut v2.total_staked_coins;
        transfer_out<T0>(v3, v0, 0x2::coin::value<T0>(&v2.total_staked_coins), arg1);
    }

    // decompiled from Move bytecode v6
}

