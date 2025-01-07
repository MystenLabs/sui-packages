module 0x35a0740d1618f9f5612fceb29e53a80b727d19b7c4214724cca111132e6f179e::flowx_vampire_attack {
    struct FlowxAttackConfig has key {
        id: 0x2::object::UID,
        init_timestamp: u64,
        deposit_window: u64,
        withdrawal_window: u64,
        min_lock_duration: u64,
        max_lock_duration: u64,
        weekly_multiplier: u64,
        weekly_divider: u64,
        max_positions_per_user: u8,
        krafted_pools_map: 0x2::linked_table::LinkedTable<0x1::string::String, address>,
    }

    struct FlowxLockdropForPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        identifer: 0x1::string::String,
        user_profile_access_cap: 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::ProfileDofOwnershipCapability,
        total_hive_incentives: u64,
        available_hive_tokens: 0x2::balance::Balance<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>,
        flowx_lps_locked: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>,
        total_lp_locked: u128,
        total_weighted_units: u128,
        total_x_withdrawn: u64,
        total_y_withdrawn: u64,
    }

    struct UserFlowxHivePosition has store, key {
        id: 0x2::object::UID,
        lockup_weeks: vector<u64>,
        lp_tokens_locked: 0x2::table::Table<u64, u64>,
        unlock_timestamps: 0x2::table::Table<u64, u64>,
        lockup_weighted_units: 0x2::table::Table<u64, u128>,
        withdrawl_window_flag: 0x2::table::Table<u64, bool>,
        total_lp_locked: u64,
        total_weighted_units: u128,
    }

    struct FlowxAttackConfigInitialized has copy, drop {
        id: address,
        init_timestamp: u64,
        deposit_window: u64,
        withdrawal_window: u64,
        min_lock_duration: u64,
        max_lock_duration: u64,
        weekly_multiplier: u64,
        weekly_divider: u64,
        max_positions_per_user: u8,
    }

    struct FlowxLockdropPoolKrafted<phantom T0, phantom T1> has copy, drop {
        pool_addr: address,
        hive_incentives: u64,
    }

    struct HiveIncentivesAddedForFlowxPool<phantom T0, phantom T1> has copy, drop {
        pool_addr: address,
        hive_incentives_added: u64,
        total_incentives: u64,
    }

    struct FlowxLpTokensDeposited<phantom T0, phantom T1> has copy, drop {
        user_profile: address,
        username: 0x1::string::String,
        user_addr: address,
        lockup_weeks: u64,
        liquidity_locked: u64,
        unlock_timestamp: u64,
        total_lp_locked_by_user: u128,
        increase_in_weighted_units: u128,
        total_user_weighted_units: u128,
        expected_hive_rewards_increase: u64,
        total_user_exp_hive_rewards: u64,
    }

    struct FlowxLpTokensWithdrawn<phantom T0, phantom T1> has copy, drop {
        user_profile: address,
        username: 0x1::string::String,
        user_addr: address,
        lockup_weeks: u64,
        liquidity_withdrawn: u64,
        withdrawn_flag: bool,
        decrease_in_weighted_units: u128,
        expected_hive_rewards_decrease: u64,
        total_user_weighted_units: u128,
        total_lp_locked_by_user: u128,
        total_user_exp_hive_rewards: u64,
    }

    struct LiquidityExtractedFromFlowx<phantom T0, phantom T1> has copy, drop {
        total_lp_deposited: u128,
        x_balance_extracted: u64,
        y_balance_extracted: u64,
        total_weighted_units: u128,
    }

    public entry fun add_incentives_for_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut FlowxLockdropForPool<T0, T1>, arg2: &FlowxAttackConfig, arg3: 0x2::coin::Coin<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>(arg3);
        0x2::balance::join<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>(&mut arg1.available_hive_tokens, 0x2::balance::split<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>(&mut v0, arg4));
        arg1.total_hive_incentives = arg1.total_hive_incentives + arg4;
        let v1 = HiveIncentivesAddedForFlowxPool<T0, T1>{
            pool_addr             : 0x2::object::uid_to_address(&arg1.id),
            hive_incentives_added : arg4,
            total_incentives      : arg1.total_hive_incentives,
        };
        0x2::event::emit<HiveIncentivesAddedForFlowxPool<T0, T1>>(v1);
        0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::coin_helper::destroy_or_transfer_balance<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>(v0, 0x2::tx_context::sender(arg5), arg5);
        (arg1.total_hive_incentives, arg1.identifer)
    }

    fun allowed_withdrawal_amount(arg0: &FlowxAttackConfig, arg1: u64, arg2: u64) : u64 {
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
            (0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::math::mul_div_u256((arg2 as u256), ((v2 - arg1) as u256), ((v2 - v1) as u256)) as u64)
        } else {
            0
        }
    }

    fun calculate_hive_rewards(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::math::mul_div_u256((arg2 as u256), (arg0 as u256), (arg1 as u256)) as u64)
        }
    }

    fun calculate_weighted_units(arg0: u64, arg1: u64, arg2: &FlowxAttackConfig) : u128 {
        (((arg0 as u256) * ((1000000000 as u256) + 0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::math::mul_div_u256(((arg1 - 1) as u256) * (arg2.weekly_multiplier as u256), (1000000000 as u256), (arg2.weekly_divider as u256)))) as u128)
    }

    public fun destroy_user_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::config::HiveEntryCap, arg2: &FlowxAttackConfig, arg3: &FlowxLockdropForPool<T0, T1>, arg4: &mut 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::HiveProfile, arg5: &mut 0x2::tx_context::TxContext) : (vector<u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u128>, u128, u128) {
        0x2::clock::timestamp_ms(arg0);
        assert!(0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg3.flowx_lps_locked) == 0 && arg3.total_lp_locked > 0, 9816);
        if (!0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::exists_for_profile(arg4, 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::get_profile_dof_capability_identifier(&arg3.user_profile_access_cap))) {
            return (0x1::vector::empty<u64>(), 0x2::table::new<u64, u64>(arg5), 0x2::table::new<u64, u64>(arg5), 0x2::table::new<u64, u128>(arg5), 0, 0)
        };
        let UserFlowxHivePosition {
            id                    : v0,
            lockup_weeks          : v1,
            lp_tokens_locked      : v2,
            unlock_timestamps     : v3,
            lockup_weighted_units : v4,
            withdrawl_window_flag : v5,
            total_lp_locked       : v6,
            total_weighted_units  : v7,
        } = 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::entry_remove_from_profile<UserFlowxHivePosition>(&arg3.user_profile_access_cap, arg4, arg5);
        0x2::object::delete(v0);
        0x2::table::drop<u64, bool>(v5);
        (v1, v2, v3, v4, (v6 as u128), v7)
    }

    public fun does_user_have_position<T0, T1>(arg0: &0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::HiveProfile, arg1: &FlowxLockdropForPool<T0, T1>) : bool {
        0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::exists_for_profile(arg0, 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap))
    }

    public fun extract_liquidity_from_flowx<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::config::HiveEntryCap, arg2: &FlowxAttackConfig, arg3: &mut FlowxLockdropForPool<T0, T1>, arg4: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg5: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg3.flowx_lps_locked);
        arg3.total_lp_locked = (v0 as u128);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair_and_treasury<T0, T1>(arg4);
        let (v3, v4) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::burn<T0, T1>(v1, v2, 0x2::coin::from_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::balance::withdraw_all<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg3.flowx_lps_locked), arg5), arg5);
        let v5 = 0x2::coin::into_balance<T0>(v3);
        let v6 = 0x2::coin::into_balance<T1>(v4);
        arg3.total_x_withdrawn = arg3.total_x_withdrawn + 0x2::balance::value<T0>(&v5);
        arg3.total_y_withdrawn = arg3.total_y_withdrawn + 0x2::balance::value<T1>(&v6);
        let v7 = LiquidityExtractedFromFlowx<T0, T1>{
            total_lp_deposited   : (v0 as u128),
            x_balance_extracted  : arg3.total_x_withdrawn,
            y_balance_extracted  : arg3.total_y_withdrawn,
            total_weighted_units : arg3.total_weighted_units,
        };
        0x2::event::emit<LiquidityExtractedFromFlowx<T0, T1>>(v7);
        (arg3.total_lp_locked, arg3.total_weighted_units, arg3.total_hive_incentives, v5, v6, 0x2::balance::withdraw_all<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>(&mut arg3.available_hive_tokens))
    }

    public fun get_user_position<T0, T1>(arg0: &0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::HiveProfile, arg1: &FlowxLockdropForPool<T0, T1>) : (vector<u64>, vector<u64>, vector<u64>, vector<u128>, vector<bool>, vector<u64>, u64, u64) {
        let v0 = 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap);
        if (!0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::exists_for_profile(arg0, v0)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u128>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<u64>(), 0, 0)
        };
        let v1 = 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::borrow_from_profile<UserFlowxHivePosition>(arg0, v0);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u128>();
        let v5 = 0x1::vector::empty<bool>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v1.lockup_weeks)) {
            let v8 = *0x1::vector::borrow<u64>(&v1.lockup_weeks, v7);
            0x1::vector::push_back<u64>(&mut v2, *0x2::table::borrow<u64, u64>(&v1.lp_tokens_locked, v8));
            0x1::vector::push_back<u64>(&mut v3, *0x2::table::borrow<u64, u64>(&v1.unlock_timestamps, v8));
            let v9 = *0x2::table::borrow<u64, u128>(&v1.lockup_weighted_units, v8);
            0x1::vector::push_back<u128>(&mut v4, v9);
            0x1::vector::push_back<bool>(&mut v5, *0x2::table::borrow<u64, bool>(&v1.withdrawl_window_flag, v8));
            0x1::vector::push_back<u64>(&mut v6, calculate_hive_rewards(v9, arg1.total_weighted_units, arg1.total_hive_incentives));
            v7 = v7 + 1;
        };
        (v1.lockup_weeks, v2, v3, v4, v5, v6, v1.total_lp_locked, calculate_hive_rewards(v1.total_weighted_units, arg1.total_weighted_units, arg1.total_hive_incentives))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_attack_on_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::config::HiveEntryCap, arg2: 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::ProfileDofOwnershipCapability, arg3: &mut FlowxAttackConfig, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : address {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>(arg5);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = FlowxLockdropForPool<T0, T1>{
            id                      : v1,
            identifer               : arg4,
            user_profile_access_cap : arg2,
            total_hive_incentives   : arg6,
            available_hive_tokens   : 0x2::balance::split<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>(&mut v0, arg6),
            flowx_lps_locked        : 0x2::balance::zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(),
            total_lp_locked         : 0,
            total_weighted_units    : 0,
            total_x_withdrawn       : 0,
            total_y_withdrawn       : 0,
        };
        0x2::transfer::share_object<FlowxLockdropForPool<T0, T1>>(v3);
        let v4 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v4, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(!0x2::linked_table::contains<0x1::string::String, address>(&arg3.krafted_pools_map, v4), 9815);
        0x2::linked_table::push_back<0x1::string::String, address>(&mut arg3.krafted_pools_map, v4, v2);
        0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::coin_helper::destroy_or_transfer_balance<0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive::HIVE>(v0, 0x2::tx_context::sender(arg7), arg7);
        let v5 = FlowxLockdropPoolKrafted<T0, T1>{
            pool_addr       : v2,
            hive_incentives : arg6,
        };
        0x2::event::emit<FlowxLockdropPoolKrafted<T0, T1>>(v5);
        v2
    }

    public entry fun initialize_flowx_attack_config(arg0: &0x2::clock::Clock, arg1: &0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::config::HiveEntryCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : address {
        0x2::clock::timestamp_ms(arg0);
        assert!(arg6 > arg5 && arg5 > 0, 9801);
        assert!(arg7 > 0 && arg8 > 0, 9802);
        let v0 = FlowxAttackConfig{
            id                     : 0x2::object::new(arg10),
            init_timestamp         : arg2,
            deposit_window         : arg3,
            withdrawal_window      : arg4,
            min_lock_duration      : arg5,
            max_lock_duration      : arg6,
            weekly_multiplier      : arg7,
            weekly_divider         : arg8,
            max_positions_per_user : arg9,
            krafted_pools_map      : 0x2::linked_table::new<0x1::string::String, address>(arg10),
        };
        let v1 = 0x2::object::uid_to_address(&v0.id);
        let v2 = FlowxAttackConfigInitialized{
            id                     : v1,
            init_timestamp         : arg2,
            deposit_window         : arg3,
            withdrawal_window      : arg4,
            min_lock_duration      : arg5,
            max_lock_duration      : arg6,
            weekly_multiplier      : arg7,
            weekly_divider         : arg8,
            max_positions_per_user : arg9,
        };
        0x2::event::emit<FlowxAttackConfigInitialized>(v2);
        0x2::transfer::share_object<FlowxAttackConfig>(v0);
        v1
    }

    public entry fun lock_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::config::HiveEntryCap, arg2: &FlowxAttackConfig, arg3: &mut FlowxLockdropForPool<T0, T1>, arg4: &mut 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::HiveProfile, arg5: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0x2::clock::timestamp_ms(arg0);
        let (v0, v1, _, v3) = 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::get_profile_meta_info(arg4);
        assert!(arg7 >= arg2.min_lock_duration && arg7 <= arg2.max_lock_duration, 9806);
        let v4 = if (0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::exists_for_profile(arg4, 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::get_profile_dof_capability_identifier(&arg3.user_profile_access_cap))) {
            0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::entry_remove_from_profile<UserFlowxHivePosition>(&arg3.user_profile_access_cap, arg4, arg8)
        } else {
            UserFlowxHivePosition{id: 0x2::object::new(arg8), lockup_weeks: 0x1::vector::empty<u64>(), lp_tokens_locked: 0x2::table::new<u64, u64>(arg8), unlock_timestamps: 0x2::table::new<u64, u64>(arg8), lockup_weighted_units: 0x2::table::new<u64, u128>(arg8), withdrawl_window_flag: 0x2::table::new<u64, bool>(arg8), total_lp_locked: 0, total_weighted_units: 0}
        };
        assert!(arg6 <= 0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg5), 9812);
        let v5 = calculate_weighted_units(arg6, arg7, arg2);
        0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg3.flowx_lps_locked, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::coin::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg5, arg6, arg8)));
        arg3.total_weighted_units = arg3.total_weighted_units + v5;
        arg3.total_lp_locked = arg3.total_lp_locked + (arg6 as u128);
        let v6 = arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window + arg7 * 604800000;
        if (!0x1::vector::contains<u64>(&v4.lockup_weeks, &arg7)) {
            assert!(0x1::vector::length<u64>(&v4.lockup_weeks) <= (arg2.max_positions_per_user as u64), 9814);
            0x1::vector::push_back<u64>(&mut v4.lockup_weeks, arg7);
            0x2::table::add<u64, u64>(&mut v4.lp_tokens_locked, arg7, arg6);
            0x2::table::add<u64, u64>(&mut v4.unlock_timestamps, arg7, v6);
            0x2::table::add<u64, u128>(&mut v4.lockup_weighted_units, arg7, v5);
            0x2::table::add<u64, bool>(&mut v4.withdrawl_window_flag, arg7, false);
        } else {
            0x2::table::add<u64, u64>(&mut v4.lp_tokens_locked, arg7, 0x2::table::remove<u64, u64>(&mut v4.lp_tokens_locked, arg7) + arg6);
            0x2::table::add<u64, u128>(&mut v4.lockup_weighted_units, arg7, 0x2::table::remove<u64, u128>(&mut v4.lockup_weighted_units, arg7) + v5);
        };
        v4.total_weighted_units = v4.total_weighted_units + v5;
        v4.total_lp_locked = v4.total_lp_locked + arg6;
        let v7 = calculate_hive_rewards(v5, arg3.total_weighted_units, arg3.total_hive_incentives);
        let v8 = calculate_hive_rewards(v4.total_weighted_units, arg3.total_weighted_units, arg3.total_hive_incentives);
        let v9 = FlowxLpTokensDeposited<T0, T1>{
            user_profile                   : v0,
            username                       : v1,
            user_addr                      : v3,
            lockup_weeks                   : arg7,
            liquidity_locked               : arg6,
            unlock_timestamp               : v6,
            total_lp_locked_by_user        : (v4.total_lp_locked as u128),
            increase_in_weighted_units     : v5,
            total_user_weighted_units      : v4.total_weighted_units,
            expected_hive_rewards_increase : v7,
            total_user_exp_hive_rewards    : v8,
        };
        0x2::event::emit<FlowxLpTokensDeposited<T0, T1>>(v9);
        0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::entry_add_to_profile<UserFlowxHivePosition>(&arg3.user_profile_access_cap, arg4, v4, arg8);
        if (0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg5) == 0) {
            0x2::coin::destroy_zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(arg5, v3);
        };
        (v7, v8)
    }

    public fun simulate_lock_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &FlowxAttackConfig, arg2: &FlowxLockdropForPool<T0, T1>, arg3: u64, arg4: u64) : u64 {
        0x2::clock::timestamp_ms(arg0);
        if (arg4 < arg1.min_lock_duration || arg4 > arg1.max_lock_duration) {
            return 0
        };
        let v0 = calculate_weighted_units(arg3, arg4, arg1);
        calculate_hive_rewards(v0, arg2.total_weighted_units + v0, arg2.total_hive_incentives)
    }

    public fun simulate_withdraw_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &FlowxAttackConfig, arg2: &FlowxLockdropForPool<T0, T1>, arg3: &0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::HiveProfile, arg4: u64, arg5: u64) : (u64, u64, bool) {
        let v0 = 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::get_profile_dof_capability_identifier(&arg2.user_profile_access_cap);
        if (!0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::exists_for_profile(arg3, v0)) {
            return (0, 0, false)
        };
        let v1 = 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::borrow_from_profile<UserFlowxHivePosition>(arg3, v0);
        let (v2, _) = 0x1::vector::index_of<u64>(&v1.lockup_weeks, &arg5);
        if (!v2) {
            return (0, 0, false)
        };
        let v4 = *0x2::table::borrow<u64, bool>(&v1.withdrawl_window_flag, arg5);
        if (v4) {
            return (allowed_withdrawal_amount(arg1, 0x2::clock::timestamp_ms(arg0), *0x2::table::borrow<u64, u64>(&v1.lp_tokens_locked, arg5)), 0, v4)
        };
        let v5 = calculate_weighted_units(arg4, arg5, arg1);
        (allowed_withdrawal_amount(arg1, 0x2::clock::timestamp_ms(arg0), *0x2::table::borrow<u64, u64>(&v1.lp_tokens_locked, arg5)), calculate_hive_rewards(v5, arg2.total_weighted_units - v5, arg2.total_hive_incentives), v4)
    }

    public entry fun test_update_timestamps(arg0: &mut FlowxAttackConfig, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.init_timestamp = arg1;
        arg0.deposit_window = arg2;
        arg0.withdrawal_window = arg3;
    }

    public entry fun withdraw_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::config::HiveEntryCap, arg2: &FlowxAttackConfig, arg3: &mut FlowxLockdropForPool<T0, T1>, arg4: &mut 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2, _, v4) = 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::get_profile_meta_info(arg4);
        assert!(0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::exists_for_profile(arg4, 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::get_profile_dof_capability_identifier(&arg3.user_profile_access_cap)), 9808);
        let v5 = 0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::entry_remove_from_profile<UserFlowxHivePosition>(&arg3.user_profile_access_cap, arg4, arg7);
        let (v6, v7) = 0x1::vector::index_of<u64>(&v5.lockup_weeks, &arg6);
        assert!(v6, 9808);
        let v8 = *0x2::table::borrow<u64, u64>(&v5.lp_tokens_locked, arg6);
        allowed_withdrawal_amount(arg2, v0, v8);
        let v9 = false;
        if (v0 > arg2.init_timestamp + arg2.deposit_window) {
            0x2::table::remove<u64, bool>(&mut v5.withdrawl_window_flag, arg6);
            0x2::table::add<u64, bool>(&mut v5.withdrawl_window_flag, arg6, true);
            v9 = true;
        };
        let v10 = calculate_weighted_units(arg5, arg6, arg2);
        arg3.total_lp_locked = arg3.total_lp_locked - (arg5 as u128);
        arg3.total_weighted_units = arg3.total_weighted_units - v10;
        if (v8 == arg5) {
            0x1::vector::remove<u64>(&mut v5.lockup_weeks, v7);
            0x2::table::remove<u64, u64>(&mut v5.lp_tokens_locked, arg6);
            0x2::table::remove<u64, u64>(&mut v5.unlock_timestamps, arg6);
            0x2::table::remove<u64, u128>(&mut v5.lockup_weighted_units, arg6);
            0x2::table::remove<u64, bool>(&mut v5.withdrawl_window_flag, arg6);
        } else {
            0x2::table::add<u64, u64>(&mut v5.lp_tokens_locked, arg6, 0x2::table::remove<u64, u64>(&mut v5.lp_tokens_locked, arg6) - arg5);
            0x2::table::add<u64, u128>(&mut v5.lockup_weighted_units, arg6, 0x2::table::remove<u64, u128>(&mut v5.lockup_weighted_units, arg6) - v10);
        };
        v5.total_weighted_units = v5.total_weighted_units - v10;
        v5.total_lp_locked = v5.total_lp_locked - arg5;
        let v11 = calculate_hive_rewards(v10, arg3.total_weighted_units, arg3.total_hive_incentives);
        let v12 = calculate_hive_rewards(v5.total_weighted_units, arg3.total_weighted_units, arg3.total_hive_incentives);
        let v13 = FlowxLpTokensWithdrawn<T0, T1>{
            user_profile                   : v1,
            username                       : v2,
            user_addr                      : v4,
            lockup_weeks                   : arg6,
            liquidity_withdrawn            : arg5,
            withdrawn_flag                 : v9,
            decrease_in_weighted_units     : v10,
            expected_hive_rewards_decrease : v11,
            total_user_weighted_units      : v5.total_weighted_units,
            total_lp_locked_by_user        : (v5.total_lp_locked as u128),
            total_user_exp_hive_rewards    : v12,
        };
        0x2::event::emit<FlowxLpTokensWithdrawn<T0, T1>>(v13);
        0x26441b28ad1d321b643b606e910a3fc09a2fa65caa4136274baa99f25e93ff79::hive_profile::entry_add_to_profile<UserFlowxHivePosition>(&arg3.user_profile_access_cap, arg4, v5, arg7);
        0x6aded64ac19889cd5782100a6c2e0f8ec2bc6357ecd92fac1c5a6aeb33db3ead::coin_helper::destroy_or_transfer_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::balance::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg3.flowx_lps_locked, arg5), v4, arg7);
        (v11, v12)
    }

    // decompiled from Move bytecode v6
}

