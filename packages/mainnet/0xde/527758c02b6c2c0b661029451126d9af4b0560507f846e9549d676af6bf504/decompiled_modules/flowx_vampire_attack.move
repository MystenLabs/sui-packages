module 0xde527758c02b6c2c0b661029451126d9af4b0560507f846e9549d676af6bf504::flowx_vampire_attack {
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
        user_profile_access_cap: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability,
        total_hive_incentives: u64,
        available_hive_tokens: 0x2::balance::Balance<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>,
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
        total_user_weighted_units: u128,
        expected_hive_rewards_decrease: u64,
        total_user_exp_hive_rewards: u64,
    }

    struct LiquidityExtractedFromFlowx<phantom T0, phantom T1> has copy, drop {
        total_lp_deposited: u128,
        x_balance_extracted: u64,
        y_balance_extracted: u64,
        total_weighted_units: u128,
    }

    public entry fun add_incentives_for_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut FlowxLockdropForPool<T0, T1>, arg2: &FlowxAttackConfig, arg3: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        assert!(arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window > 0x2::clock::timestamp_ms(arg0), 9803);
        let v0 = 0x2::coin::into_balance<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>(arg3);
        0x2::balance::join<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>(&mut arg1.available_hive_tokens, 0x2::balance::split<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>(&mut v0, arg4));
        arg1.total_hive_incentives = arg1.total_hive_incentives + arg4;
        let v1 = HiveIncentivesAddedForFlowxPool<T0, T1>{
            pool_addr             : 0x2::object::uid_to_address(&arg1.id),
            hive_incentives_added : arg4,
            total_incentives      : arg1.total_hive_incentives,
        };
        0x2::event::emit<HiveIncentivesAddedForFlowxPool<T0, T1>>(v1);
        0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::coin_helper::destroy_or_transfer_balance<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>(v0, 0x2::tx_context::sender(arg5), arg5);
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
            (0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::math::mul_div_u256((arg2 as u256), ((v2 - arg1) as u256), ((v2 - v1) as u256)) as u64)
        } else {
            0
        }
    }

    fun calculate_hive_rewards(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::math::mul_div_u256((arg2 as u256), (arg0 as u256), (arg1 as u256)) as u64)
        }
    }

    fun calculate_weighted_units(arg0: u64, arg1: u64, arg2: &FlowxAttackConfig) : u128 {
        (((arg0 as u256) * ((1000000000 as u256) + 0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::math::mul_div_u256(((arg1 - 1) as u256) * (arg2.weekly_multiplier as u256), (1000000000 as u256), (arg2.weekly_divider as u256)))) as u128)
    }

    public fun destroy_user_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::HiveEntryCap, arg2: &FlowxAttackConfig, arg3: &FlowxLockdropForPool<T0, T1>, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg5: &mut 0x2::tx_context::TxContext) : (vector<u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u128>, u128, u128) {
        assert!(0x2::clock::timestamp_ms(arg0) > arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window, 9813);
        assert!(0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg3.flowx_lps_locked) == 0 && arg3.total_lp_locked > 0, 9816);
        let v0 = 0x1::string::utf8(b"flowx_vampire_attack");
        0x1::string::append(&mut v0, arg3.identifer);
        if (!0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::exists_for_profile(arg4, 0x1::string::to_ascii(v0))) {
            return (0x1::vector::empty<u64>(), 0x2::table::new<u64, u64>(arg5), 0x2::table::new<u64, u64>(arg5), 0x2::table::new<u64, u128>(arg5), 0, 0)
        };
        let UserFlowxHivePosition {
            id                    : v1,
            lockup_weeks          : v2,
            lp_tokens_locked      : v3,
            unlock_timestamps     : v4,
            lockup_weighted_units : v5,
            withdrawl_window_flag : v6,
            total_lp_locked       : v7,
            total_weighted_units  : v8,
        } = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_remove_from_profile<UserFlowxHivePosition>(&arg3.user_profile_access_cap, arg4, arg5);
        0x2::object::delete(v1);
        0x2::table::drop<u64, bool>(v6);
        (v2, v3, v4, v5, (v7 as u128), v8)
    }

    public fun does_user_have_position<T0, T1>(arg0: &0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg1: &FlowxLockdropForPool<T0, T1>) : bool {
        let v0 = 0x1::string::utf8(b"flowx_vampire_attack");
        0x1::string::append(&mut v0, arg1.identifer);
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::exists_for_profile(arg0, 0x1::string::to_ascii(v0))
    }

    public fun extract_liquidity_from_flowx<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::HiveEntryCap, arg2: &FlowxAttackConfig, arg3: &mut FlowxLockdropForPool<T0, T1>, arg4: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg5: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>) {
        assert!(0x2::clock::timestamp_ms(arg0) > arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window, 9813);
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
        (arg3.total_lp_locked, arg3.total_weighted_units, arg3.total_hive_incentives, v5, v6, 0x2::balance::withdraw_all<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>(&mut arg3.available_hive_tokens))
    }

    public fun get_user_position<T0, T1>(arg0: &0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg1: &FlowxLockdropForPool<T0, T1>) : (vector<u64>, vector<u64>, vector<u64>, vector<u128>, vector<bool>, vector<u64>, u64, u64) {
        let v0 = 0x1::string::utf8(b"flowx_vampire_attack");
        0x1::string::append(&mut v0, arg1.identifer);
        let v1 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::borrow_from_profile<UserFlowxHivePosition>(arg0, 0x1::string::to_ascii(v0));
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

    public entry fun initialize_attack_on_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::HiveEntryCap, arg2: 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::ProfileDofOwnershipCapability, arg3: &mut FlowxAttackConfig, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg3.init_timestamp > 0x2::clock::timestamp_ms(arg0), 9800);
        let v0 = 0x2::coin::into_balance<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>(arg5);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = FlowxLockdropForPool<T0, T1>{
            id                      : v1,
            identifer               : arg4,
            user_profile_access_cap : arg2,
            total_hive_incentives   : arg6,
            available_hive_tokens   : 0x2::balance::split<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>(&mut v0, arg6),
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
        0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::coin_helper::destroy_or_transfer_balance<0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive::HIVE>(v0, 0x2::tx_context::sender(arg7), arg7);
        let v5 = FlowxLockdropPoolKrafted<T0, T1>{
            pool_addr       : v2,
            hive_incentives : arg6,
        };
        0x2::event::emit<FlowxLockdropPoolKrafted<T0, T1>>(v5);
        v2
    }

    public entry fun initialize_flowx_attack_config(arg0: &0x2::clock::Clock, arg1: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::HiveEntryCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg0) && arg3 > 0 && arg4 > 0, 9800);
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

    public entry fun lock_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::HiveEntryCap, arg2: &FlowxAttackConfig, arg3: &mut FlowxLockdropForPool<T0, T1>, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg5: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2, _, v4) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg4);
        assert!(v0 >= arg2.init_timestamp, 9804);
        assert!(v0 <= arg2.init_timestamp + arg2.deposit_window, 9805);
        assert!(arg7 >= arg2.min_lock_duration && arg7 <= arg2.max_lock_duration, 9806);
        let v5 = 0x1::string::utf8(b"flowx_vampire_attack");
        0x1::string::append(&mut v5, arg3.identifer);
        let v6 = if (0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::exists_for_profile(arg4, 0x1::string::to_ascii(v5))) {
            0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_remove_from_profile<UserFlowxHivePosition>(&arg3.user_profile_access_cap, arg4, arg8)
        } else {
            UserFlowxHivePosition{id: 0x2::object::new(arg8), lockup_weeks: 0x1::vector::empty<u64>(), lp_tokens_locked: 0x2::table::new<u64, u64>(arg8), unlock_timestamps: 0x2::table::new<u64, u64>(arg8), lockup_weighted_units: 0x2::table::new<u64, u128>(arg8), withdrawl_window_flag: 0x2::table::new<u64, bool>(arg8), total_lp_locked: 0, total_weighted_units: 0}
        };
        assert!(arg6 <= 0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg5), 9812);
        let v7 = calculate_weighted_units(arg6, arg7, arg2);
        0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg3.flowx_lps_locked, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::coin::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg5, arg6, arg8)));
        arg3.total_weighted_units = arg3.total_weighted_units + v7;
        arg3.total_lp_locked = arg3.total_lp_locked + (arg6 as u128);
        let v8 = arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window + arg7 * 604800000000;
        if (!0x1::vector::contains<u64>(&v6.lockup_weeks, &arg7)) {
            assert!(0x1::vector::length<u64>(&v6.lockup_weeks) <= (arg2.max_positions_per_user as u64), 9814);
            0x1::vector::push_back<u64>(&mut v6.lockup_weeks, arg7);
            0x2::table::add<u64, u64>(&mut v6.lp_tokens_locked, arg7, arg6);
            0x2::table::add<u64, u64>(&mut v6.unlock_timestamps, arg7, v8);
            0x2::table::add<u64, u128>(&mut v6.lockup_weighted_units, arg7, v7);
            0x2::table::add<u64, bool>(&mut v6.withdrawl_window_flag, arg7, false);
        } else {
            0x2::table::add<u64, u64>(&mut v6.lp_tokens_locked, arg7, 0x2::table::remove<u64, u64>(&mut v6.lp_tokens_locked, arg7) + arg6);
            0x2::table::add<u64, u128>(&mut v6.lockup_weighted_units, arg7, 0x2::table::remove<u64, u128>(&mut v6.lockup_weighted_units, arg7) + v7);
        };
        v6.total_weighted_units = v6.total_weighted_units + v7;
        v6.total_lp_locked = v6.total_lp_locked + arg6;
        let v9 = calculate_hive_rewards(v7, arg3.total_weighted_units, arg3.total_hive_incentives);
        let v10 = calculate_hive_rewards(v6.total_weighted_units, arg3.total_weighted_units, arg3.total_hive_incentives);
        let v11 = FlowxLpTokensDeposited<T0, T1>{
            user_profile                   : v1,
            username                       : v2,
            user_addr                      : v4,
            lockup_weeks                   : arg7,
            liquidity_locked               : arg6,
            unlock_timestamp               : v8,
            total_lp_locked_by_user        : (v6.total_lp_locked as u128),
            increase_in_weighted_units     : v7,
            total_user_weighted_units      : v6.total_weighted_units,
            expected_hive_rewards_increase : v9,
            total_user_exp_hive_rewards    : v10,
        };
        0x2::event::emit<FlowxLpTokensDeposited<T0, T1>>(v11);
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_add_to_profile<UserFlowxHivePosition>(&arg3.user_profile_access_cap, arg4, v6, arg8);
        if (0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg5) == 0) {
            0x2::coin::destroy_zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(arg5, v4);
        };
        (v9, v10)
    }

    public entry fun withdraw_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::config::HiveEntryCap, arg2: &FlowxAttackConfig, arg3: &mut FlowxLockdropForPool<T0, T1>, arg4: &mut 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2, _, v4) = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::get_profile_meta_info(arg4);
        assert!(v0 >= arg2.init_timestamp, 9804);
        assert!(v0 < arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window, 9811);
        let v5 = 0x1::string::utf8(b"flowx_vampire_attack");
        0x1::string::append(&mut v5, arg3.identifer);
        assert!(0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::exists_for_profile(arg4, 0x1::string::to_ascii(v5)), 9808);
        let v6 = 0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_remove_from_profile<UserFlowxHivePosition>(&arg3.user_profile_access_cap, arg4, arg7);
        let (v7, v8) = 0x1::vector::index_of<u64>(&v6.lockup_weeks, &arg6);
        assert!(v7, 9808);
        let v9 = *0x2::table::borrow<u64, u64>(&v6.lp_tokens_locked, arg6);
        assert!(arg5 <= allowed_withdrawal_amount(arg2, v0, v9), 9809);
        let v10 = false;
        if (v0 > arg2.init_timestamp + arg2.deposit_window) {
            assert!(!0x2::table::remove<u64, bool>(&mut v6.withdrawl_window_flag, arg6), 9810);
            0x2::table::add<u64, bool>(&mut v6.withdrawl_window_flag, arg6, true);
            v10 = true;
        };
        let v11 = calculate_weighted_units(arg5, arg6, arg2);
        arg3.total_lp_locked = arg3.total_lp_locked - (arg5 as u128);
        arg3.total_weighted_units = arg3.total_weighted_units - v11;
        if (v9 == arg5) {
            0x1::vector::remove<u64>(&mut v6.lockup_weeks, v8);
            0x2::table::remove<u64, u64>(&mut v6.lp_tokens_locked, arg6);
            0x2::table::remove<u64, u64>(&mut v6.unlock_timestamps, arg6);
            0x2::table::remove<u64, u128>(&mut v6.lockup_weighted_units, arg6);
            0x2::table::remove<u64, bool>(&mut v6.withdrawl_window_flag, arg6);
        } else {
            0x2::table::add<u64, u64>(&mut v6.lp_tokens_locked, arg6, 0x2::table::remove<u64, u64>(&mut v6.lp_tokens_locked, arg6) - arg5);
            0x2::table::add<u64, u128>(&mut v6.lockup_weighted_units, arg6, 0x2::table::remove<u64, u128>(&mut v6.lockup_weighted_units, arg6) - v11);
        };
        v6.total_weighted_units = v6.total_weighted_units - v11;
        v6.total_lp_locked = v6.total_lp_locked - arg5;
        let v12 = calculate_hive_rewards(v11, arg3.total_weighted_units, arg3.total_hive_incentives);
        let v13 = calculate_hive_rewards(v6.total_weighted_units, arg3.total_weighted_units, arg3.total_hive_incentives);
        let v14 = FlowxLpTokensWithdrawn<T0, T1>{
            user_profile                   : v1,
            username                       : v2,
            user_addr                      : v4,
            lockup_weeks                   : arg6,
            liquidity_withdrawn            : arg5,
            withdrawn_flag                 : v10,
            decrease_in_weighted_units     : v11,
            total_user_weighted_units      : v6.total_weighted_units,
            expected_hive_rewards_decrease : v12,
            total_user_exp_hive_rewards    : v13,
        };
        0x2::event::emit<FlowxLpTokensWithdrawn<T0, T1>>(v14);
        0x8e95d85cf522a6be4c4cce8ec2be389fbc877cc2c3e9b77c4b95476eecf47fc2::hive_profile::entry_add_to_profile<UserFlowxHivePosition>(&arg3.user_profile_access_cap, arg4, v6, arg7);
        0xf16195c9c3d7b8abb884c854848adfbcee550ed37558fa7ec67da8ffaf593c2e::coin_helper::destroy_or_transfer_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::balance::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg3.flowx_lps_locked, arg5), v4, arg7);
        (v12, v13)
    }

    // decompiled from Move bytecode v6
}

