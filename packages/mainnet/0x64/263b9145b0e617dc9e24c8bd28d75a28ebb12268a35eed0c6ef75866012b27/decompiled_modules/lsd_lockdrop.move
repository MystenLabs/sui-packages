module 0x64263b9145b0e617dc9e24c8bd28d75a28ebb12268a35eed0c6ef75866012b27::lsd_lockdrop {
    struct LsdLockdropVault has key {
        id: 0x2::object::UID,
        user_profile_access_cap: 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::HiveAppAccessCapability,
        max_positions: u64,
        init_timestamp: u64,
        deposit_window: u64,
        withdrawal_window: u64,
        min_lock_duration: u64,
        max_lock_duration: u64,
        weekly_multiplier: u64,
        weekly_divider: u64,
        sui_locked_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_sui_locked: u64,
        total_sui_weighted_units: u128,
        total_hive_incentives: u64,
        hive_incentives_balance: 0x2::balance::Balance<0xbb57e28f61999516c68a99b87425e415b82c20b15ca7f23438019eac3f543fb0::hive::HIVE>,
    }

    struct UserLsdLockdropPosition has store, key {
        id: 0x2::object::UID,
        lockup_weeks: vector<u64>,
        sui_locked_per_position: 0x2::table::Table<u64, u64>,
        weighted_units_per_position: 0x2::table::Table<u64, u128>,
        unlock_timestamps: 0x2::table::Table<u64, u64>,
        withdrawl_window_flag: 0x2::table::Table<u64, bool>,
        total_sui_locked: u64,
        total_sui_weighted_units: u128,
    }

    struct LsdLockdropVaultInitialized has copy, drop {
        id: address,
        init_timestamp: u64,
        deposit_window: u64,
        withdrawal_window: u64,
        min_lock_duration: u64,
        max_lock_duration: u64,
        weekly_multiplier: u64,
        weekly_divider: u64,
        max_positions: u64,
    }

    struct HiveRewardsAddedToLsdVault has copy, drop {
        hive_incentives_added: u64,
        total_hive_incentives: u64,
    }

    struct SuiDepositedForLockdrop has copy, drop {
        user_profile: address,
        username: 0x1::string::String,
        user_addr: address,
        lockup_weeks: u64,
        liquidity_locked: u64,
        unlock_timestamp: u64,
        total_sui_deposited_by_user: u128,
        increase_in_weighted_units: u128,
        total_user_weighted_units: u128,
        expected_hive_rewards_increase: u64,
        total_user_exp_hive_rewards: u64,
    }

    struct SuiWithdrawnFromLockdrop has copy, drop {
        user_profile: address,
        username: 0x1::string::String,
        user_addr: address,
        lockup_weeks: u64,
        sui_withdrawn: u64,
        withdrawn_flag: bool,
        decrease_in_weighted_units: u128,
        total_sui_deposited_by_user: u64,
        total_user_weighted_units: u128,
        expected_hive_rewards_decrease: u64,
        total_user_exp_hive_rewards: u64,
    }

    struct SuiStakedForDegenSUI has copy, drop {
        cur_timestamp: u64,
        total_sui_locked: u64,
        sui_to_stake: u64,
        total_dsui_krafted: u64,
    }

    public fun add_hive_incentives(arg0: &0x2::clock::Clock, arg1: &mut LsdLockdropVault, arg2: 0x2::coin::Coin<0xbb57e28f61999516c68a99b87425e415b82c20b15ca7f23438019eac3f543fb0::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1.init_timestamp + arg1.deposit_window, 5100);
        let v0 = 0x2::coin::into_balance<0xbb57e28f61999516c68a99b87425e415b82c20b15ca7f23438019eac3f543fb0::hive::HIVE>(arg2);
        0x2::balance::join<0xbb57e28f61999516c68a99b87425e415b82c20b15ca7f23438019eac3f543fb0::hive::HIVE>(&mut arg1.hive_incentives_balance, 0x2::balance::split<0xbb57e28f61999516c68a99b87425e415b82c20b15ca7f23438019eac3f543fb0::hive::HIVE>(&mut v0, arg3));
        arg1.total_hive_incentives = arg1.total_hive_incentives + arg3;
        0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::coin_helper::destroy_or_transfer_balance<0xbb57e28f61999516c68a99b87425e415b82c20b15ca7f23438019eac3f543fb0::hive::HIVE>(v0, 0x2::tx_context::sender(arg4), arg4);
        let v1 = HiveRewardsAddedToLsdVault{
            hive_incentives_added : arg3,
            total_hive_incentives : arg1.total_hive_incentives,
        };
        0x2::event::emit<HiveRewardsAddedToLsdVault>(v1);
        arg1.total_hive_incentives
    }

    public fun add_to_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::config::HiveEntryCap, arg2: &mut LsdLockdropVault, arg3: &mut 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2, _, v4) = 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::get_profile_meta_info(arg3);
        assert!(v0 >= arg2.init_timestamp, 5101);
        assert!(v0 <= arg2.init_timestamp + arg2.deposit_window, 5100);
        assert!(arg6 >= arg2.min_lock_duration && arg6 <= arg2.max_lock_duration, 5102);
        let v5 = if (0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::exists_for_profile(arg3, 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::get_hive_app_name(&arg2.user_profile_access_cap))) {
            0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::remove_app_from_profile<UserLsdLockdropPosition>(&arg2.user_profile_access_cap, arg3, arg7)
        } else {
            kraft_new_lsd_lockup_position(arg7)
        };
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let v7 = calculate_weighted_units(arg5, arg6, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.sui_locked_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v6, arg5));
        arg2.total_sui_weighted_units = arg2.total_sui_weighted_units + v7;
        arg2.total_sui_locked = arg2.total_sui_locked + arg5;
        let v8 = arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window + arg6 * 0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::constants::week_multiplier();
        if (!0x1::vector::contains<u64>(&v5.lockup_weeks, &arg6)) {
            assert!(0x1::vector::length<u64>(&v5.lockup_weeks) <= arg2.max_positions, 5113);
            0x1::vector::push_back<u64>(&mut v5.lockup_weeks, arg6);
            0x2::table::add<u64, u64>(&mut v5.sui_locked_per_position, arg6, arg5);
            0x2::table::add<u64, u128>(&mut v5.weighted_units_per_position, arg6, v7);
            0x2::table::add<u64, u64>(&mut v5.unlock_timestamps, arg6, v8);
            0x2::table::add<u64, bool>(&mut v5.withdrawl_window_flag, arg6, false);
        } else {
            0x2::table::add<u64, u64>(&mut v5.sui_locked_per_position, arg6, 0x2::table::remove<u64, u64>(&mut v5.sui_locked_per_position, arg6) + arg5);
            0x2::table::add<u64, u128>(&mut v5.weighted_units_per_position, arg6, 0x2::table::remove<u64, u128>(&mut v5.weighted_units_per_position, arg6) + v7);
        };
        v5.total_sui_weighted_units = v5.total_sui_weighted_units + v7;
        v5.total_sui_locked = v5.total_sui_locked + arg5;
        let v9 = SuiDepositedForLockdrop{
            user_profile                   : v1,
            username                       : v2,
            user_addr                      : v4,
            lockup_weeks                   : arg6,
            liquidity_locked               : arg5,
            unlock_timestamp               : v8,
            total_sui_deposited_by_user    : (v5.total_sui_locked as u128),
            increase_in_weighted_units     : v7,
            total_user_weighted_units      : v5.total_sui_weighted_units,
            expected_hive_rewards_increase : calculate_hive_rewards(v7, arg2.total_sui_weighted_units, arg2.total_hive_incentives),
            total_user_exp_hive_rewards    : calculate_hive_rewards(v5.total_sui_weighted_units, arg2.total_sui_weighted_units, arg2.total_hive_incentives),
        };
        0x2::event::emit<SuiDepositedForLockdrop>(v9);
        0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::add_app_to_profile<UserLsdLockdropPosition>(&arg2.user_profile_access_cap, arg3, v5, arg7);
        0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v6, 0x2::tx_context::sender(arg7), arg7);
    }

    fun allowed_withdrawal_amount(arg0: &LsdLockdropVault, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0.init_timestamp + arg0.deposit_window;
        if (arg1 < v0) {
            return arg2
        };
        let v1 = v0 + arg0.withdrawal_window / 2;
        if (arg1 <= v1) {
            return arg2 / 2
        };
        let v2 = v0 + arg0.withdrawal_window;
        if (arg1 < v2) {
            (0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::math::mul_div_u256(((arg2 / 2) as u256), ((v2 - arg1) as u256), ((v2 - v1) as u256)) as u64)
        } else {
            0
        }
    }

    fun calculate_hive_rewards(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::math::mul_div_u256((arg2 as u256), (arg0 as u256), (arg1 as u256)) as u64)
        }
    }

    fun calculate_weighted_units(arg0: u64, arg1: u64, arg2: &LsdLockdropVault) : u128 {
        (((arg0 as u256) * ((1000000000 as u256) + 0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::math::mul_div_u256(((arg1 - 1) as u256) * (arg2.weekly_multiplier as u256), (1000000000 as u256), (arg2.weekly_divider as u256)))) as u128)
    }

    public fun destroy_user_position(arg0: &0x2::clock::Clock, arg1: &0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::config::HiveEntryCap, arg2: &LsdLockdropVault, arg3: &mut 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::HiveProfile, arg4: &mut 0x2::tx_context::TxContext) : (vector<u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u128>, 0x2::table::Table<u64, u64>, u128, u128) {
        assert!(0x2::clock::timestamp_ms(arg0) > arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window, 5114);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.sui_locked_balance) == 0, 5110);
        if (!0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::exists_for_profile(arg3, 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::get_hive_app_name(&arg2.user_profile_access_cap))) {
            return (0x1::vector::empty<u64>(), 0x2::table::new<u64, u64>(arg4), 0x2::table::new<u64, u128>(arg4), 0x2::table::new<u64, u64>(arg4), 0, 0)
        };
        let UserLsdLockdropPosition {
            id                          : v0,
            lockup_weeks                : v1,
            sui_locked_per_position     : v2,
            weighted_units_per_position : v3,
            unlock_timestamps           : v4,
            withdrawl_window_flag       : v5,
            total_sui_locked            : v6,
            total_sui_weighted_units    : v7,
        } = 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::remove_app_from_profile<UserLsdLockdropPosition>(&arg2.user_profile_access_cap, arg3, arg4);
        0x2::object::delete(v0);
        0x2::table::drop<u64, bool>(v5);
        (v1, v2, v3, v4, (v6 as u128), v7)
    }

    public fun does_user_have_position(arg0: &0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::HiveProfile, arg1: &LsdLockdropVault) : bool {
        0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::exists_for_profile(arg0, 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::get_hive_app_name(&arg1.user_profile_access_cap))
    }

    public fun get_user_position(arg0: &0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::HiveProfile, arg1: &LsdLockdropVault) : (vector<u64>, vector<u64>, vector<u64>, vector<u128>, vector<bool>, vector<u64>, u64, u64) {
        let v0 = 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::get_hive_app_name(&arg1.user_profile_access_cap);
        if (!0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::exists_for_profile(arg0, v0)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u128>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<u64>(), 0, 0)
        };
        let v1 = 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::borrow_from_profile<UserLsdLockdropPosition>(arg0, v0);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u128>();
        let v5 = 0x1::vector::empty<bool>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v1.lockup_weeks)) {
            let v8 = *0x1::vector::borrow<u64>(&v1.lockup_weeks, v7);
            0x1::vector::push_back<u64>(&mut v2, *0x2::table::borrow<u64, u64>(&v1.sui_locked_per_position, v8));
            0x1::vector::push_back<u64>(&mut v3, *0x2::table::borrow<u64, u64>(&v1.unlock_timestamps, v8));
            let v9 = *0x2::table::borrow<u64, u128>(&v1.weighted_units_per_position, v8);
            0x1::vector::push_back<u128>(&mut v4, v9);
            0x1::vector::push_back<bool>(&mut v5, *0x2::table::borrow<u64, bool>(&v1.withdrawl_window_flag, v8));
            0x1::vector::push_back<u64>(&mut v6, calculate_hive_rewards(v9, arg1.total_sui_weighted_units, arg1.total_hive_incentives));
            v7 = v7 + 1;
        };
        (v1.lockup_weeks, v2, v3, v4, v5, v6, v1.total_sui_locked, calculate_hive_rewards(v1.total_sui_weighted_units, arg1.total_sui_weighted_units, arg1.total_hive_incentives))
    }

    public fun infuse_sui_dsui_pool(arg0: &0x2::clock::Clock, arg1: &0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::config::HiveEntryCap, arg2: &mut LsdLockdropVault, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x650ec11b29c9ccf7e3a60ed7de3b2af2cd3005a28c9ff3b7858eba9d88e85998::dsui_vault::DSuiVault, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::dsui::DSUI>, 0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0xbb57e28f61999516c68a99b87425e415b82c20b15ca7f23438019eac3f543fb0::hive::HIVE>, u64, u128) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 >= arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window, 5108);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.sui_locked_balance) > 0, 5115);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg2.sui_locked_balance) / 2;
        let v2 = 0x650ec11b29c9ccf7e3a60ed7de3b2af2cd3005a28c9ff3b7858eba9d88e85998::dsui_vault::stake_sui_request(arg3, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut arg2.sui_locked_balance, v1), 0x1::option::none<address>(), arg5);
        let v3 = SuiStakedForDegenSUI{
            cur_timestamp      : v0,
            total_sui_locked   : arg2.total_sui_locked,
            sui_to_stake       : v1,
            total_dsui_krafted : 0x2::balance::value<0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::dsui::DSUI>(&v2),
        };
        0x2::event::emit<SuiStakedForDegenSUI>(v3);
        (v2, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.sui_locked_balance), 0x2::balance::withdraw_all<0xbb57e28f61999516c68a99b87425e415b82c20b15ca7f23438019eac3f543fb0::hive::HIVE>(&mut arg2.hive_incentives_balance), arg2.total_sui_locked, arg2.total_sui_weighted_units)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_global_lsd_lockdrop(arg0: &0x2::clock::Clock, arg1: &0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::config::HiveEntryCap, arg2: 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::HiveAppAccessCapability, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg4 > 0x2::clock::timestamp_ms(arg0) && arg5 > 0 && arg6 > 0, 5116);
        assert!(arg8 > arg7 && arg7 > 0, 5117);
        assert!(arg9 > 0 && arg10 > 0, 5118);
        let v0 = LsdLockdropVault{
            id                       : 0x2::object::new(arg11),
            user_profile_access_cap  : arg2,
            max_positions            : arg3,
            init_timestamp           : arg4,
            deposit_window           : arg5,
            withdrawal_window        : arg6,
            min_lock_duration        : arg7,
            max_lock_duration        : arg8,
            weekly_multiplier        : arg9,
            weekly_divider           : arg10,
            sui_locked_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            total_sui_locked         : 0,
            total_sui_weighted_units : 0,
            total_hive_incentives    : 0,
            hive_incentives_balance  : 0x2::balance::zero<0xbb57e28f61999516c68a99b87425e415b82c20b15ca7f23438019eac3f543fb0::hive::HIVE>(),
        };
        let v1 = LsdLockdropVaultInitialized{
            id                : 0x2::object::uid_to_address(&v0.id),
            init_timestamp    : arg4,
            deposit_window    : arg5,
            withdrawal_window : arg6,
            min_lock_duration : arg7,
            max_lock_duration : arg8,
            weekly_multiplier : arg9,
            weekly_divider    : arg10,
            max_positions     : arg3,
        };
        0x2::event::emit<LsdLockdropVaultInitialized>(v1);
        0x2::transfer::share_object<LsdLockdropVault>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    fun kraft_new_lsd_lockup_position(arg0: &mut 0x2::tx_context::TxContext) : UserLsdLockdropPosition {
        UserLsdLockdropPosition{
            id                          : 0x2::object::new(arg0),
            lockup_weeks                : 0x1::vector::empty<u64>(),
            sui_locked_per_position     : 0x2::table::new<u64, u64>(arg0),
            weighted_units_per_position : 0x2::table::new<u64, u128>(arg0),
            unlock_timestamps           : 0x2::table::new<u64, u64>(arg0),
            withdrawl_window_flag       : 0x2::table::new<u64, bool>(arg0),
            total_sui_locked            : 0,
            total_sui_weighted_units    : 0,
        }
    }

    public fun simulate_lock_lp_tokens(arg0: &0x2::clock::Clock, arg1: &LsdLockdropVault, arg2: u64, arg3: u64) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 < arg1.init_timestamp || v0 > arg1.init_timestamp + arg1.deposit_window) {
            return 0
        };
        if (arg3 < arg1.min_lock_duration || arg3 > arg1.max_lock_duration) {
            return 0
        };
        let v1 = calculate_weighted_units(arg2, arg3, arg1);
        calculate_hive_rewards(v1, arg1.total_sui_weighted_units + v1, arg1.total_hive_incentives)
    }

    public fun simulate_withdraw_from_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &LsdLockdropVault, arg2: &0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::HiveProfile, arg3: u64, arg4: u64) : (u64, u64, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 < arg1.init_timestamp || v0 > arg1.init_timestamp + arg1.deposit_window + arg1.withdrawal_window) {
            return (0, 0, false)
        };
        let v1 = 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::get_hive_app_name(&arg1.user_profile_access_cap);
        if (!0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::exists_for_profile(arg2, v1)) {
            return (0, 0, false)
        };
        let v2 = 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::borrow_from_profile<UserLsdLockdropPosition>(arg2, v1);
        let (v3, _) = 0x1::vector::index_of<u64>(&v2.lockup_weeks, &arg4);
        if (!v3) {
            return (0, 0, false)
        };
        let v5 = *0x2::table::borrow<u64, bool>(&v2.withdrawl_window_flag, arg4);
        if (v5) {
            return (allowed_withdrawal_amount(arg1, v0, *0x2::table::borrow<u64, u64>(&v2.sui_locked_per_position, arg4)), 0, v5)
        };
        let v6 = calculate_weighted_units(arg3, arg4, arg1);
        (allowed_withdrawal_amount(arg1, v0, *0x2::table::borrow<u64, u64>(&v2.sui_locked_per_position, arg4)), calculate_hive_rewards(v6, arg1.total_sui_weighted_units - v6, arg1.total_hive_incentives), v5)
    }

    public fun withdraw_from_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::config::HiveEntryCap, arg2: &mut LsdLockdropVault, arg3: &mut 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::HiveProfile, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2, _, v4) = 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::get_profile_meta_info(arg3);
        assert!(v0 >= arg2.init_timestamp, 5101);
        assert!(v0 < arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window, 5103);
        assert!(0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::exists_for_profile(arg3, 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::get_hive_app_name(&arg2.user_profile_access_cap)), 5104);
        let v5 = 0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::remove_app_from_profile<UserLsdLockdropPosition>(&arg2.user_profile_access_cap, arg3, arg6);
        let (v6, v7) = 0x1::vector::index_of<u64>(&v5.lockup_weeks, &arg5);
        assert!(v6, 5104);
        let v8 = *0x2::table::borrow<u64, u64>(&v5.sui_locked_per_position, arg5);
        assert!(arg4 <= allowed_withdrawal_amount(arg2, v0, v8), 5105);
        let v9 = false;
        if (v0 > arg2.init_timestamp + arg2.deposit_window) {
            assert!(!0x2::table::remove<u64, bool>(&mut v5.withdrawl_window_flag, arg5), 5106);
            0x2::table::add<u64, bool>(&mut v5.withdrawl_window_flag, arg5, true);
            v9 = true;
        };
        let v10 = calculate_weighted_units(arg4, arg5, arg2);
        arg2.total_sui_locked = arg2.total_sui_locked - arg4;
        arg2.total_sui_weighted_units = arg2.total_sui_weighted_units - v10;
        if (v8 == arg4) {
            0x1::vector::remove<u64>(&mut v5.lockup_weeks, v7);
            0x2::table::remove<u64, u64>(&mut v5.sui_locked_per_position, arg5);
            0x2::table::remove<u64, u64>(&mut v5.unlock_timestamps, arg5);
            0x2::table::remove<u64, u128>(&mut v5.weighted_units_per_position, arg5);
            0x2::table::remove<u64, bool>(&mut v5.withdrawl_window_flag, arg5);
        } else {
            0x2::table::add<u64, u64>(&mut v5.sui_locked_per_position, arg5, 0x2::table::remove<u64, u64>(&mut v5.sui_locked_per_position, arg5) - arg4);
            0x2::table::add<u64, u128>(&mut v5.weighted_units_per_position, arg5, 0x2::table::remove<u64, u128>(&mut v5.weighted_units_per_position, arg5) - v10);
        };
        v5.total_sui_weighted_units = v5.total_sui_weighted_units - v10;
        v5.total_sui_locked = v5.total_sui_locked - arg4;
        let v11 = SuiWithdrawnFromLockdrop{
            user_profile                   : v1,
            username                       : v2,
            user_addr                      : v4,
            lockup_weeks                   : arg5,
            sui_withdrawn                  : arg4,
            withdrawn_flag                 : v9,
            decrease_in_weighted_units     : v10,
            total_sui_deposited_by_user    : v5.total_sui_locked,
            total_user_weighted_units      : v5.total_sui_weighted_units,
            expected_hive_rewards_decrease : calculate_hive_rewards(v10, arg2.total_sui_weighted_units, arg2.total_hive_incentives),
            total_user_exp_hive_rewards    : calculate_hive_rewards(v5.total_sui_weighted_units, arg2.total_sui_weighted_units, arg2.total_hive_incentives),
        };
        0x2::event::emit<SuiWithdrawnFromLockdrop>(v11);
        0xc6ba9549789969ac871a1542bb3a3cbc825b0aeaca9ece9292016e95562856f4::hive_profile::add_app_to_profile<UserLsdLockdropPosition>(&arg2.user_profile_access_cap, arg3, v5, arg6);
        0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.sui_locked_balance, arg4), v4, arg6);
    }

    // decompiled from Move bytecode v6
}

