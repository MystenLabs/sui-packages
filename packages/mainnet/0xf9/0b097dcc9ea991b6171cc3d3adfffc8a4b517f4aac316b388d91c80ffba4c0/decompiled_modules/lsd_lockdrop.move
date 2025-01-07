module 0xf90b097dcc9ea991b6171cc3d3adfffc8a4b517f4aac316b388d91c80ffba4c0::lsd_lockdrop {
    struct LsdLockdropVault has key {
        id: 0x2::object::UID,
        user_profile_access_cap: 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::ProfileDofOwnershipCapability,
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
        hive_incentives_balance: 0x2::balance::Balance<0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive::HIVE>,
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

    struct SuiStakedForHiveSui has copy, drop {
        cur_timestamp: u64,
        total_sui_locked: u64,
        sui_to_stake: u64,
        total_hsui_krafted: u64,
    }

    public fun add_hive_incentives(arg0: &0x2::clock::Clock, arg1: &mut LsdLockdropVault, arg2: 0x2::coin::Coin<0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive::HIVE>(arg2);
        0x2::balance::join<0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive::HIVE>(&mut arg1.hive_incentives_balance, 0x2::balance::split<0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive::HIVE>(&mut v0, arg3));
        arg1.total_hive_incentives = arg1.total_hive_incentives + arg3;
        0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::destroy_or_transfer_balance<0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive::HIVE>(v0, 0x2::tx_context::sender(arg4), arg4);
        let v1 = HiveRewardsAddedToLsdVault{
            hive_incentives_added : arg3,
            total_hive_incentives : arg1.total_hive_incentives,
        };
        0x2::event::emit<HiveRewardsAddedToLsdVault>(v1);
        arg1.total_hive_incentives
    }

    public fun add_to_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::HiveEntryCap, arg2: &mut LsdLockdropVault, arg3: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let (v0, v1, _, v3) = 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::get_profile_meta_info(arg3);
        let v4 = if (0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::exists_for_profile(arg3, 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::get_profile_dof_capability_identifier(&arg2.user_profile_access_cap))) {
            0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::entry_remove_from_profile<UserLsdLockdropPosition>(&arg2.user_profile_access_cap, arg3, arg7)
        } else {
            kraft_new_lsd_lockup_position(arg7)
        };
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let v6 = calculate_weighted_units(arg5, arg6, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.sui_locked_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v5, arg5));
        arg2.total_sui_weighted_units = arg2.total_sui_weighted_units + v6;
        arg2.total_sui_locked = arg2.total_sui_locked + arg5;
        let v7 = arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window + arg6 * 1800000;
        if (!0x1::vector::contains<u64>(&v4.lockup_weeks, &arg6)) {
            0x1::vector::push_back<u64>(&mut v4.lockup_weeks, arg6);
            0x2::table::add<u64, u64>(&mut v4.sui_locked_per_position, arg6, arg5);
            0x2::table::add<u64, u128>(&mut v4.weighted_units_per_position, arg6, v6);
            0x2::table::add<u64, u64>(&mut v4.unlock_timestamps, arg6, v7);
            0x2::table::add<u64, bool>(&mut v4.withdrawl_window_flag, arg6, false);
        } else {
            0x2::table::add<u64, u64>(&mut v4.sui_locked_per_position, arg6, 0x2::table::remove<u64, u64>(&mut v4.sui_locked_per_position, arg6) + arg5);
            0x2::table::add<u64, u128>(&mut v4.weighted_units_per_position, arg6, 0x2::table::remove<u64, u128>(&mut v4.weighted_units_per_position, arg6) + v6);
        };
        v4.total_sui_weighted_units = v4.total_sui_weighted_units + v6;
        v4.total_sui_locked = v4.total_sui_locked + arg5;
        let v8 = SuiDepositedForLockdrop{
            user_profile                   : v0,
            username                       : v1,
            user_addr                      : v3,
            lockup_weeks                   : arg6,
            liquidity_locked               : arg5,
            unlock_timestamp               : v7,
            total_sui_deposited_by_user    : (v4.total_sui_locked as u128),
            increase_in_weighted_units     : v6,
            total_user_weighted_units      : v4.total_sui_weighted_units,
            expected_hive_rewards_increase : calculate_hive_rewards(v6, arg2.total_sui_weighted_units, arg2.total_hive_incentives),
            total_user_exp_hive_rewards    : calculate_hive_rewards(v4.total_sui_weighted_units, arg2.total_sui_weighted_units, arg2.total_hive_incentives),
        };
        0x2::event::emit<SuiDepositedForLockdrop>(v8);
        0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::entry_add_to_profile<UserLsdLockdropPosition>(&arg2.user_profile_access_cap, arg3, v4, arg7);
        0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v5, 0x2::tx_context::sender(arg7), arg7);
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
            (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256(((arg2 / 2) as u256), ((v2 - arg1) as u256), ((v2 - v1) as u256)) as u64)
        } else {
            0
        }
    }

    fun calculate_hive_rewards(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((arg2 as u256), (arg0 as u256), (arg1 as u256)) as u64)
        }
    }

    fun calculate_weighted_units(arg0: u64, arg1: u64, arg2: &LsdLockdropVault) : u128 {
        (((arg0 as u256) * ((1000000000 as u256) + 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256(((arg1 - 1) as u256) * (arg2.weekly_multiplier as u256), (1000000000 as u256), (arg2.weekly_divider as u256)))) as u128)
    }

    public fun destroy_user_position(arg0: &0x2::clock::Clock, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::HiveEntryCap, arg2: &LsdLockdropVault, arg3: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HiveProfile, arg4: &mut 0x2::tx_context::TxContext) : (vector<u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u128>, 0x2::table::Table<u64, u64>, u128, u128) {
        0x2::clock::timestamp_ms(arg0);
        if (!0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::exists_for_profile(arg3, 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::get_profile_dof_capability_identifier(&arg2.user_profile_access_cap))) {
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
        } = 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::entry_remove_from_profile<UserLsdLockdropPosition>(&arg2.user_profile_access_cap, arg3, arg4);
        0x2::object::delete(v0);
        0x2::table::drop<u64, bool>(v5);
        (v1, v2, v3, v4, (v6 as u128), v7)
    }

    public fun does_user_have_position(arg0: &0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HiveProfile, arg1: &LsdLockdropVault) : bool {
        0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::exists_for_profile(arg0, 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap))
    }

    public fun get_user_position(arg0: &0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HiveProfile, arg1: &LsdLockdropVault) : (vector<u64>, vector<u64>, vector<u64>, vector<u128>, vector<bool>, vector<u64>, u64, u64) {
        let v0 = 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap);
        if (!0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::exists_for_profile(arg0, v0)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u128>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<u64>(), 0, 0)
        };
        let v1 = 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::borrow_from_profile<UserLsdLockdropPosition>(arg0, v0);
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

    public fun infuse_sui_hsui_pool(arg0: &0x2::clock::Clock, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::HiveEntryCap, arg2: &mut LsdLockdropVault, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, 0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive::HIVE>, u64, u128) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2.sui_locked_balance) / 2;
        let v1 = 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::stake_sui_request(arg3, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut arg2.sui_locked_balance, v0), 0x1::option::none<address>(), arg5);
        let v2 = SuiStakedForHiveSui{
            cur_timestamp      : 0x2::clock::timestamp_ms(arg0),
            total_sui_locked   : arg2.total_sui_locked,
            sui_to_stake       : v0,
            total_hsui_krafted : 0x2::balance::value<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>(&v1),
        };
        0x2::event::emit<SuiStakedForHiveSui>(v2);
        (v1, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.sui_locked_balance), 0x2::balance::withdraw_all<0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive::HIVE>(&mut arg2.hive_incentives_balance), arg2.total_sui_locked, arg2.total_sui_weighted_units)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_global_lsd_lockdrop(arg0: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::HiveEntryCap, arg1: 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::ProfileDofOwnershipCapability, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : address {
        let v0 = LsdLockdropVault{
            id                       : 0x2::object::new(arg10),
            user_profile_access_cap  : arg1,
            max_positions            : arg2,
            init_timestamp           : arg3,
            deposit_window           : arg4,
            withdrawal_window        : arg5,
            min_lock_duration        : arg6,
            max_lock_duration        : arg7,
            weekly_multiplier        : arg8,
            weekly_divider           : arg9,
            sui_locked_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            total_sui_locked         : 0,
            total_sui_weighted_units : 0,
            total_hive_incentives    : 0,
            hive_incentives_balance  : 0x2::balance::zero<0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive::HIVE>(),
        };
        let v1 = LsdLockdropVaultInitialized{
            id                : 0x2::object::uid_to_address(&v0.id),
            init_timestamp    : arg3,
            deposit_window    : arg4,
            withdrawal_window : arg5,
            min_lock_duration : arg6,
            max_lock_duration : arg7,
            weekly_multiplier : arg8,
            weekly_divider    : arg9,
            max_positions     : arg2,
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

    public fun simulate_withdraw_from_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &LsdLockdropVault, arg2: &0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HiveProfile, arg3: u64, arg4: u64) : (u64, u64, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 < arg1.init_timestamp || v0 > arg1.init_timestamp + arg1.deposit_window + arg1.withdrawal_window) {
            return (0, 0, false)
        };
        let v1 = 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap);
        if (!0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::exists_for_profile(arg2, v1)) {
            return (0, 0, false)
        };
        let v2 = 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::borrow_from_profile<UserLsdLockdropPosition>(arg2, v1);
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

    public fun withdraw_from_lsd_lockup_position(arg0: &0x2::clock::Clock, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::HiveEntryCap, arg2: &mut LsdLockdropVault, arg3: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HiveProfile, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2, _, v4) = 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::get_profile_meta_info(arg3);
        0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::get_profile_dof_capability_identifier(&arg2.user_profile_access_cap);
        let v5 = 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::entry_remove_from_profile<UserLsdLockdropPosition>(&arg2.user_profile_access_cap, arg3, arg6);
        let (_, v7) = 0x1::vector::index_of<u64>(&v5.lockup_weeks, &arg5);
        let v8 = *0x2::table::borrow<u64, u64>(&v5.sui_locked_per_position, arg5);
        allowed_withdrawal_amount(arg2, v0, v8);
        let v9 = false;
        if (v0 > arg2.init_timestamp + arg2.deposit_window) {
            0x2::table::remove<u64, bool>(&mut v5.withdrawl_window_flag, arg5);
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
        0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::entry_add_to_profile<UserLsdLockdropPosition>(&arg2.user_profile_access_cap, arg3, v5, arg6);
        0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.sui_locked_balance, arg4), v4, arg6);
    }

    // decompiled from Move bytecode v6
}

