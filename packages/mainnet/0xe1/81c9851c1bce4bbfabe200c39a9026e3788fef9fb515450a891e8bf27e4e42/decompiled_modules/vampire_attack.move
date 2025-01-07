module 0xc032c245e40f0313f2dc56722188af5739cba964c730a1ea1601a41cefeec1d9::vampire_attack {
    struct FlowxVampireAttackCap has store, key {
        id: 0x2::object::UID,
    }

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
    }

    struct FlowxLockdropForPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        identifer: 0x1::string::String,
        total_hive_incentives: u64,
        available_hive_tokens: 0x2::balance::Balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>,
        flowx_lps_locked: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>,
        total_lp_locked: u128,
        total_weighted_units: u128,
        total_x_withdrawn: u64,
        total_y_withdrawn: u64,
        withdrawn_x_balance: 0x2::balance::Balance<T0>,
        withdrawn_y_balance: 0x2::balance::Balance<T1>,
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

    public entry fun add_incentives_for_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &FlowxVampireAttackCap, arg2: &mut FlowxLockdropForPool<T0, T1>, arg3: &FlowxAttackConfig, arg4: 0x2::coin::Coin<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(arg4);
        0x2::balance::join<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&mut arg2.available_hive_tokens, 0x2::balance::split<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&mut v0, arg5));
        arg2.total_hive_incentives = arg2.total_hive_incentives + arg5;
        let v1 = HiveIncentivesAddedForFlowxPool<T0, T1>{
            pool_addr             : 0x2::object::uid_to_address(&arg2.id),
            hive_incentives_added : arg5,
            total_incentives      : arg2.total_hive_incentives,
        };
        0x2::event::emit<HiveIncentivesAddedForFlowxPool<T0, T1>>(v1);
        let v2 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(v0, v2, arg6);
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
            (0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u256((arg2 as u256), ((v2 - arg1) as u256), ((v2 - v1) as u256)) as u64)
        } else {
            0
        }
    }

    fun calculate_hive_rewards(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u256((arg2 as u256), (arg0 as u256), (arg1 as u256)) as u64)
        }
    }

    fun calculate_weighted_units(arg0: u64, arg1: u64, arg2: &FlowxAttackConfig) : u128 {
        (((arg0 as u256) * ((1000000000 as u256) + 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u256(((arg1 - 1) as u256) * (arg2.weekly_multiplier as u256), (1000000000 as u256), (arg2.weekly_divider as u256)))) as u128)
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public entry fun extract_liquidity_from_flowx<T0, T1>(arg0: &0x2::clock::Clock, arg1: &FlowxVampireAttackCap, arg2: &FlowxAttackConfig, arg3: &mut FlowxLockdropForPool<T0, T1>, arg4: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg3.flowx_lps_locked);
        arg3.total_lp_locked = (v0 as u128);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair_and_treasury<T0, T1>(arg4);
        let (v3, v4) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::burn<T0, T1>(v1, v2, 0x2::coin::from_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::balance::withdraw_all<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg3.flowx_lps_locked), arg5), arg5);
        let v5 = 0x2::coin::into_balance<T0>(v3);
        let v6 = 0x2::coin::into_balance<T1>(v4);
        arg3.total_x_withdrawn = 0x2::balance::value<T0>(&v5);
        arg3.total_y_withdrawn = 0x2::balance::value<T1>(&v6);
        0x2::balance::join<T0>(&mut arg3.withdrawn_x_balance, v5);
        0x2::balance::join<T1>(&mut arg3.withdrawn_y_balance, v6);
        let v7 = LiquidityExtractedFromFlowx<T0, T1>{
            total_lp_deposited   : (v0 as u128),
            x_balance_extracted  : arg3.total_x_withdrawn,
            y_balance_extracted  : arg3.total_y_withdrawn,
            total_weighted_units : arg3.total_weighted_units,
        };
        0x2::event::emit<LiquidityExtractedFromFlowx<T0, T1>>(v7);
    }

    public fun get_user_position<T0, T1>(arg0: &0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg1: &mut FlowxLockdropForPool<T0, T1>) : (vector<u64>, vector<u64>, vector<u64>, vector<u128>, vector<bool>, vector<u64>, u64, u64) {
        let v0 = 0x1::string::utf8(b"flowx_vampire_attack");
        0x1::string::append(&mut v0, arg1.identifer);
        let v1 = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::borrow_from_profile<0x1::string::String, UserFlowxHivePosition>(arg0, v0);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u128>();
        let v5 = 0x1::vector::empty<bool>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v1.lockup_weeks)) {
            0x1::vector::push_back<u64>(&mut v2, *0x2::table::borrow<u64, u64>(&v1.lp_tokens_locked, v7));
            0x1::vector::push_back<u64>(&mut v3, *0x2::table::borrow<u64, u64>(&v1.unlock_timestamps, v7));
            let v8 = *0x2::table::borrow<u64, u128>(&v1.lockup_weighted_units, v7);
            0x1::vector::push_back<u128>(&mut v4, v8);
            0x1::vector::push_back<bool>(&mut v5, *0x2::table::borrow<u64, bool>(&v1.withdrawl_window_flag, v7));
            0x1::vector::push_back<u64>(&mut v6, calculate_hive_rewards(v8, arg1.total_weighted_units, arg1.total_hive_incentives));
            v7 = v7 + 1;
        };
        (v1.lockup_weeks, v2, v3, v4, v5, v6, v1.total_lp_locked, calculate_hive_rewards(v1.total_weighted_units, arg1.total_weighted_units, arg1.total_hive_incentives))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlowxVampireAttackCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FlowxVampireAttackCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_attack_on_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &FlowxVampireAttackCap, arg2: &FlowxAttackConfig, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(arg4);
        let v1 = 0x2::object::new(arg6);
        let v2 = FlowxLockdropForPool<T0, T1>{
            id                    : v1,
            identifer             : arg3,
            total_hive_incentives : arg5,
            available_hive_tokens : 0x2::balance::split<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&mut v0, arg5),
            flowx_lps_locked      : 0x2::balance::zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(),
            total_lp_locked       : 0,
            total_weighted_units  : 0,
            total_x_withdrawn     : 0,
            total_y_withdrawn     : 0,
            withdrawn_x_balance   : 0x2::balance::zero<T0>(),
            withdrawn_y_balance   : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<FlowxLockdropForPool<T0, T1>>(v2);
        let v3 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(v0, v3, arg6);
        let v4 = FlowxLockdropPoolKrafted<T0, T1>{
            pool_addr       : 0x2::object::uid_to_address(&v1),
            hive_incentives : arg5,
        };
        0x2::event::emit<FlowxLockdropPoolKrafted<T0, T1>>(v4);
    }

    public entry fun initialize_flowx_attack_config(arg0: &0x2::clock::Clock, arg1: &FlowxVampireAttackCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
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
        };
        let v1 = FlowxAttackConfigInitialized{
            id                     : 0x2::object::uid_to_address(&v0.id),
            init_timestamp         : arg2,
            deposit_window         : arg3,
            withdrawal_window      : arg4,
            min_lock_duration      : arg5,
            max_lock_duration      : arg6,
            weekly_multiplier      : arg7,
            weekly_divider         : arg8,
            max_positions_per_user : arg9,
        };
        0x2::event::emit<FlowxAttackConfigInitialized>(v1);
        0x2::transfer::share_object<FlowxAttackConfig>(v0);
    }

    public entry fun lock_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &FlowxAttackConfig, arg2: &mut FlowxLockdropForPool<T0, T1>, arg3: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let (v0, v1, _, v3) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"flowx_vampire_attack");
        0x1::string::append(&mut v4, arg2.identifer);
        let v5 = if (0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::exists_for_profile<0x1::string::String>(arg3, v4)) {
            0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::remove_from_profile<0x1::string::String, UserFlowxHivePosition>(true, arg3, v4, arg7)
        } else {
            UserFlowxHivePosition{id: 0x2::object::new(arg7), lockup_weeks: 0x1::vector::empty<u64>(), lp_tokens_locked: 0x2::table::new<u64, u64>(arg7), unlock_timestamps: 0x2::table::new<u64, u64>(arg7), lockup_weighted_units: 0x2::table::new<u64, u128>(arg7), withdrawl_window_flag: 0x2::table::new<u64, bool>(arg7), total_lp_locked: 0, total_weighted_units: 0}
        };
        assert!(arg5 <= 0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg4), 9812);
        let v6 = calculate_weighted_units(arg5, arg6, arg1);
        0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg2.flowx_lps_locked, 0x2::coin::into_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::coin::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg4, arg5, arg7)));
        arg2.total_weighted_units = arg2.total_weighted_units + v6;
        arg2.total_lp_locked = arg2.total_lp_locked + (arg5 as u128);
        let v7 = arg1.init_timestamp + arg1.deposit_window + arg1.withdrawal_window + arg6 * 604800000000;
        if (!0x1::vector::contains<u64>(&v5.lockup_weeks, &arg6)) {
            assert!(0x1::vector::length<u64>(&v5.lockup_weeks) <= (arg1.max_positions_per_user as u64), 9814);
            0x1::vector::push_back<u64>(&mut v5.lockup_weeks, arg6);
            0x2::table::add<u64, u64>(&mut v5.lp_tokens_locked, arg6, arg5);
            0x2::table::add<u64, u64>(&mut v5.unlock_timestamps, arg6, v7);
            0x2::table::add<u64, u128>(&mut v5.lockup_weighted_units, arg6, v6);
            0x2::table::add<u64, bool>(&mut v5.withdrawl_window_flag, arg6, false);
        } else {
            0x2::table::add<u64, u64>(&mut v5.lp_tokens_locked, arg6, 0x2::table::remove<u64, u64>(&mut v5.lp_tokens_locked, arg6) + arg5);
            0x2::table::add<u64, u128>(&mut v5.lockup_weighted_units, arg6, 0x2::table::remove<u64, u128>(&mut v5.lockup_weighted_units, arg6) + v6);
        };
        v5.total_weighted_units = v5.total_weighted_units + v6;
        v5.total_lp_locked = v5.total_lp_locked + arg5;
        let v8 = FlowxLpTokensDeposited<T0, T1>{
            user_profile                   : v0,
            username                       : v1,
            user_addr                      : v3,
            lockup_weeks                   : arg6,
            liquidity_locked               : arg5,
            unlock_timestamp               : v7,
            total_lp_locked_by_user        : (v5.total_lp_locked as u128),
            increase_in_weighted_units     : v6,
            total_user_weighted_units      : v5.total_weighted_units,
            expected_hive_rewards_increase : calculate_hive_rewards(v6, arg2.total_weighted_units, arg2.total_hive_incentives),
            total_user_exp_hive_rewards    : calculate_hive_rewards(v5.total_weighted_units, arg2.total_weighted_units, arg2.total_hive_incentives),
        };
        0x2::event::emit<FlowxLpTokensDeposited<T0, T1>>(v8);
        0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::add_to_profile<0x1::string::String, UserFlowxHivePosition>(true, arg3, v4, v5, arg7);
        if (0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg4) == 0) {
            0x2::coin::destroy_zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(arg4, v3);
        };
    }

    public entry fun withdraw_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &FlowxAttackConfig, arg2: &mut FlowxLockdropForPool<T0, T1>, arg3: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2, _, v4) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_profile_meta_info(arg3);
        let v5 = 0x1::string::utf8(b"flowx_vampire_attack");
        0x1::string::append(&mut v5, arg2.identifer);
        assert!(0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::exists_for_profile<0x1::string::String>(arg3, v5), 9808);
        let v6 = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::remove_from_profile<0x1::string::String, UserFlowxHivePosition>(true, arg3, v5, arg6);
        assert!(0x1::vector::contains<u64>(&v6.lockup_weeks, &arg5), 9808);
        let v7 = *0x2::table::borrow<u64, u64>(&mut v6.lp_tokens_locked, arg5);
        assert!(arg4 <= allowed_withdrawal_amount(arg1, v0, v7), 9809);
        let v8 = false;
        if (v0 > arg1.init_timestamp + arg1.deposit_window) {
            assert!(!0x2::table::remove<u64, bool>(&mut v6.withdrawl_window_flag, arg5), 9810);
            0x2::table::add<u64, bool>(&mut v6.withdrawl_window_flag, arg5, true);
            v8 = true;
        };
        let v9 = calculate_weighted_units(arg4, arg5, arg1);
        arg2.total_lp_locked = arg2.total_lp_locked - (arg4 as u128);
        arg2.total_weighted_units = arg2.total_weighted_units - v9;
        if (v7 == arg4) {
            if (0x1::vector::length<u64>(&v6.lockup_weeks) == 1) {
                v6.lockup_weeks = 0x1::vector::empty<u64>();
            };
            0x2::table::remove<u64, u64>(&mut v6.lp_tokens_locked, arg5);
            0x2::table::remove<u64, u64>(&mut v6.unlock_timestamps, arg5);
            0x2::table::remove<u64, u128>(&mut v6.lockup_weighted_units, arg5);
            0x2::table::remove<u64, bool>(&mut v6.withdrawl_window_flag, arg5);
        } else {
            0x2::table::add<u64, u64>(&mut v6.lp_tokens_locked, arg5, 0x2::table::remove<u64, u64>(&mut v6.lp_tokens_locked, arg5) - arg4);
            0x2::table::add<u64, u128>(&mut v6.lockup_weighted_units, arg5, 0x2::table::remove<u64, u128>(&mut v6.lockup_weighted_units, arg5) - v9);
        };
        v6.total_weighted_units = v6.total_weighted_units - v9;
        v6.total_lp_locked = v6.total_lp_locked - arg4;
        let v10 = FlowxLpTokensWithdrawn<T0, T1>{
            user_profile                   : v1,
            username                       : v2,
            user_addr                      : v4,
            lockup_weeks                   : arg5,
            liquidity_withdrawn            : arg4,
            withdrawn_flag                 : v8,
            decrease_in_weighted_units     : v9,
            total_user_weighted_units      : v6.total_weighted_units,
            expected_hive_rewards_decrease : calculate_hive_rewards(v9, arg2.total_weighted_units, arg2.total_hive_incentives),
            total_user_exp_hive_rewards    : calculate_hive_rewards(v6.total_weighted_units, arg2.total_weighted_units, arg2.total_hive_incentives),
        };
        0x2::event::emit<FlowxLpTokensWithdrawn<T0, T1>>(v10);
        0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::add_to_profile<0x1::string::String, UserFlowxHivePosition>(true, arg3, v5, v6, arg6);
        destroy_or_transfer_balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x2::balance::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg2.flowx_lps_locked, arg4), v4, arg6);
    }

    // decompiled from Move bytecode v6
}

