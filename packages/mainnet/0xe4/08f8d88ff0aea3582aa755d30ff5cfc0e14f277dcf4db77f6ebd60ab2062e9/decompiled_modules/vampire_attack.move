module 0xe408f8d88ff0aea3582aa755d30ff5cfc0e14f277dcf4db77f6ebd60ab2062e9::vampire_attack {
    struct KriyaVampireAttackCap has store, key {
        id: 0x2::object::UID,
    }

    struct KriyaAttackConfig has key {
        id: 0x2::object::UID,
        init_timestamp: u64,
        deposit_window: u64,
        withdrawal_window: u64,
        min_lock_duration: u64,
        max_lock_duration: u64,
        weekly_multiplier: u64,
        weekly_divider: u64,
        max_positions_per_user: u8,
        vesting_duration: u64,
    }

    struct KriyaLockdropForPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        identifer: 0x1::string::String,
        total_hive_incentives: u64,
        available_hive_tokens: 0x2::balance::Balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>,
        kriya_lps_locked: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>,
        total_lp_locked: u128,
        total_weighted_units: u128,
        total_x_withdrawn: u64,
        total_y_withdrawn: u64,
        withdrawn_x_balance: 0x2::balance::Balance<T0>,
        withdrawn_y_balance: 0x2::balance::Balance<T1>,
    }

    struct UserKriyaHivePosition has store, key {
        id: 0x2::object::UID,
        lockup_weeks: vector<u64>,
        lp_tokens_locked: 0x2::table::Table<u64, u64>,
        unlock_timestamps: 0x2::table::Table<u64, u64>,
        lockup_weighted_units: 0x2::table::Table<u64, u128>,
        withdrawl_window_flag: 0x2::table::Table<u64, bool>,
        lockup_lp_withdrawl_flag: 0x2::table::Table<u64, bool>,
        total_lp_locked: u128,
        total_weighted_units: u128,
    }

    struct PoolForVampireAttackOnKriyaKrafted<phantom T0, phantom T1> has copy, drop {
        pool_addr: address,
        hive_incentives: u64,
    }

    struct HiveIncentivesAddedForPool<phantom T0, phantom T1> has copy, drop {
        pool_addr: address,
        hive_incentives_added: u64,
        total_incentives: u64,
    }

    struct LpTokensLocked<phantom T0, phantom T1> has copy, drop {
        user_addr: address,
        lockup_weeks: u64,
        liquidity_locked: u128,
        lockup_weighted_units: u128,
        unlock_timestamp: u64,
        total_lp_locked_by_user: u128,
    }

    struct LpTokensWithdrawn<phantom T0, phantom T1> has copy, drop {
        user_addr: address,
        lockup_weeks: u64,
        liquidity_withdrawn: u128,
        total_lp_locked_by_user: u128,
        withdrawn_flag: bool,
    }

    struct LiquidityExtractedFromKriya<phantom T0, phantom T1> has copy, drop {
        shared_extracted: u128,
        x_balance_extracted: u64,
        y_balance_extracted: u64,
    }

    struct LpTokensStaked has copy, drop {
        shared_staked: u128,
    }

    struct UserClaimedKriyaRewards has copy, drop {
        user_addr: address,
        claimed_hive_incentives: u64,
        earned_hive_gems: u64,
        claimed_degenhive_lp_tokens: u64,
        unlocked_positions: vector<u64>,
    }

    public entry fun add_incentives_for_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &KriyaVampireAttackCap, arg2: &mut KriyaLockdropForPool<T0, T1>, arg3: &KriyaAttackConfig, arg4: 0x2::coin::Coin<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(arg4);
        0x2::balance::join<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&mut arg2.available_hive_tokens, 0x2::balance::split<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&mut v0, arg5));
        arg2.total_hive_incentives = arg2.total_hive_incentives + arg5;
        let v1 = HiveIncentivesAddedForPool<T0, T1>{
            pool_addr             : 0x2::object::uid_to_address(&arg2.id),
            hive_incentives_added : arg5,
            total_incentives      : arg2.total_hive_incentives,
        };
        0x2::event::emit<HiveIncentivesAddedForPool<T0, T1>>(v1);
        let v2 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(v0, v2, arg6);
    }

    fun allowed_withdrawal_amount(arg0: &KriyaAttackConfig, arg1: u64, arg2: u64) : u64 {
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

    fun calculate_weighted_units(arg0: u128, arg1: u64, arg2: &KriyaAttackConfig) : u128 {
        (((arg0 as u256) * ((1000000000 as u256) + 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u256(((arg1 - 1) as u256) * (arg2.weekly_multiplier as u256), (1000000000 as u256), (arg2.weekly_divider as u256)))) as u128)
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public entry fun extract_liquidity_from_kriya<T0, T1>(arg0: &0x2::clock::Clock, arg1: &KriyaVampireAttackCap, arg2: &KriyaAttackConfig, arg3: &mut KriyaLockdropForPool<T0, T1>, arg4: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<T0, T1>(&arg3.kriya_lps_locked);
        arg3.total_lp_locked = (v0 as u128);
        let (v1, v2) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::remove_liquidity<T0, T1>(arg4, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_split<T0, T1>(&mut arg3.kriya_lps_locked, v0, arg5), v0, arg5);
        let v3 = 0x2::coin::into_balance<T0>(v2);
        let v4 = 0x2::coin::into_balance<T1>(v1);
        arg3.total_x_withdrawn = 0x2::balance::value<T0>(&v3);
        arg3.total_y_withdrawn = 0x2::balance::value<T1>(&v4);
        0x2::balance::join<T0>(&mut arg3.withdrawn_x_balance, v3);
        0x2::balance::join<T1>(&mut arg3.withdrawn_y_balance, v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KriyaVampireAttackCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<KriyaVampireAttackCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_attack_on_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &KriyaVampireAttackCap, arg2: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg3: &KriyaAttackConfig, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(arg5);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<T0, T1>(&arg2);
        let v2 = 0x2::object::new(arg7);
        let v3 = KriyaLockdropForPool<T0, T1>{
            id                    : v2,
            identifer             : arg4,
            total_hive_incentives : arg6,
            available_hive_tokens : 0x2::balance::split<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&mut v0, arg6),
            kriya_lps_locked      : arg2,
            total_lp_locked       : (v1 as u128),
            total_weighted_units  : calculate_weighted_units((v1 as u128), arg3.min_lock_duration, arg3),
            total_x_withdrawn     : 0,
            total_y_withdrawn     : 0,
            withdrawn_x_balance   : 0x2::balance::zero<T0>(),
            withdrawn_y_balance   : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<KriyaLockdropForPool<T0, T1>>(v3);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(v0, v4, arg7);
        let v5 = PoolForVampireAttackOnKriyaKrafted<T0, T1>{
            pool_addr       : 0x2::object::uid_to_address(&v2),
            hive_incentives : arg6,
        };
        0x2::event::emit<PoolForVampireAttackOnKriyaKrafted<T0, T1>>(v5);
    }

    public entry fun initialize_kriya_attack_config(arg0: &0x2::clock::Clock, arg1: &KriyaVampireAttackCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg0) && arg3 > 0 && arg4 > 0, 9800);
        assert!(arg6 > arg5 && arg5 > 0, 9801);
        assert!(arg7 > 0 && arg8 > 0, 9802);
        let v0 = KriyaAttackConfig{
            id                     : 0x2::object::new(arg11),
            init_timestamp         : arg2,
            deposit_window         : arg3,
            withdrawal_window      : arg4,
            min_lock_duration      : arg5,
            max_lock_duration      : arg6,
            weekly_multiplier      : arg7,
            weekly_divider         : arg8,
            max_positions_per_user : arg9,
            vesting_duration       : arg10,
        };
        0x2::transfer::share_object<KriyaAttackConfig>(v0);
    }

    public entry fun lock_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &KriyaAttackConfig, arg2: &mut KriyaLockdropForPool<T0, T1>, arg3: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg4: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let (_, _, _, v3) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_profile_meta_info(arg3);
        let v4 = 0x1::string::utf8(b"kriya_vampire_attack");
        0x1::string::append(&mut v4, arg2.identifer);
        let v5 = if (0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::exists_for_profile<0x1::string::String>(arg3, v4)) {
            0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::remove_from_profile<0x1::string::String, UserKriyaHivePosition>(true, arg3, v4, arg7)
        } else {
            UserKriyaHivePosition{id: 0x2::object::new(arg7), lockup_weeks: 0x1::vector::empty<u64>(), lp_tokens_locked: 0x2::table::new<u64, u64>(arg7), unlock_timestamps: 0x2::table::new<u64, u64>(arg7), lockup_weighted_units: 0x2::table::new<u64, u128>(arg7), withdrawl_window_flag: 0x2::table::new<u64, bool>(arg7), lockup_lp_withdrawl_flag: 0x2::table::new<u64, bool>(arg7), total_lp_locked: 0, total_weighted_units: 0}
        };
        assert!(arg5 <= 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<T0, T1>(&arg4), 9812);
        let v6 = calculate_weighted_units((arg5 as u128), arg6, arg1);
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_join<T0, T1>(&mut arg2.kriya_lps_locked, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_split<T0, T1>(&mut arg4, arg5, arg7));
        arg2.total_lp_locked = arg2.total_lp_locked + (arg5 as u128);
        arg2.total_weighted_units = arg2.total_weighted_units + v6;
        if (!0x1::vector::contains<u64>(&v5.lockup_weeks, &arg6)) {
            0x1::vector::push_back<u64>(&mut v5.lockup_weeks, arg6);
            0x2::table::add<u64, u64>(&mut v5.lp_tokens_locked, arg6, arg5);
            0x2::table::add<u64, u64>(&mut v5.unlock_timestamps, arg6, arg1.init_timestamp + arg1.deposit_window + arg1.withdrawal_window + arg6 * 604800000000);
            0x2::table::add<u64, u128>(&mut v5.lockup_weighted_units, arg6, v6);
            0x2::table::add<u64, bool>(&mut v5.withdrawl_window_flag, arg6, false);
            0x2::table::add<u64, bool>(&mut v5.lockup_lp_withdrawl_flag, arg6, false);
        } else {
            0x2::table::add<u64, u64>(&mut v5.lp_tokens_locked, arg6, 0x2::table::remove<u64, u64>(&mut v5.lp_tokens_locked, arg6) + arg5);
            0x2::table::add<u64, u128>(&mut v5.lockup_weighted_units, arg6, 0x2::table::remove<u64, u128>(&mut v5.lockup_weighted_units, arg6) + v6);
        };
        v5.total_weighted_units = v5.total_weighted_units + v6;
        v5.total_lp_locked = v5.total_lp_locked + (arg5 as u128);
        0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::add_to_profile<0x1::string::String, UserKriyaHivePosition>(true, arg3, v4, v5, arg7);
        if (0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<T0, T1>(&arg4) == 0) {
            0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_destroy_zero<T0, T1>(arg4);
        } else {
            0x2::transfer::public_transfer<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>>(arg4, v3);
        };
    }

    public entry fun withdraw_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &KriyaAttackConfig, arg2: &mut KriyaLockdropForPool<T0, T1>, arg3: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (_, _, _, v4) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_profile_meta_info(arg3);
        let v5 = 0x1::string::utf8(b"kriya_vampire_attack");
        0x1::string::append(&mut v5, arg2.identifer);
        assert!(0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::exists_for_profile<0x1::string::String>(arg3, v5), 9808);
        let v6 = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::remove_from_profile<0x1::string::String, UserKriyaHivePosition>(true, arg3, v5, arg6);
        assert!(0x1::vector::contains<u64>(&v6.lockup_weeks, &arg5), 9808);
        let v7 = *0x2::table::borrow<u64, u64>(&mut v6.lp_tokens_locked, arg5);
        assert!(arg4 <= allowed_withdrawal_amount(arg1, v0, v7), 9809);
        if (v0 > arg1.init_timestamp + arg1.deposit_window) {
            assert!(!0x2::table::remove<u64, bool>(&mut v6.withdrawl_window_flag, arg5), 9810);
            0x2::table::add<u64, bool>(&mut v6.withdrawl_window_flag, arg5, true);
        };
        let v8 = calculate_weighted_units((arg4 as u128), arg5, arg1);
        arg2.total_lp_locked = arg2.total_lp_locked - (arg4 as u128);
        arg2.total_weighted_units = arg2.total_weighted_units - v8;
        if (v7 == arg4) {
            0x1::vector::remove<u64>(&mut v6.lockup_weeks, arg5);
            0x2::table::remove<u64, u64>(&mut v6.lp_tokens_locked, arg5);
            0x2::table::remove<u64, u64>(&mut v6.unlock_timestamps, arg5);
            0x2::table::remove<u64, u128>(&mut v6.lockup_weighted_units, arg5);
            0x2::table::remove<u64, bool>(&mut v6.withdrawl_window_flag, arg5);
            0x2::table::remove<u64, bool>(&mut v6.lockup_lp_withdrawl_flag, arg5);
        } else {
            0x2::table::add<u64, u64>(&mut v6.lp_tokens_locked, arg5, 0x2::table::remove<u64, u64>(&mut v6.lp_tokens_locked, arg5) - arg4);
            0x2::table::add<u64, u128>(&mut v6.lockup_weighted_units, arg5, 0x2::table::remove<u64, u128>(&mut v6.lockup_weighted_units, arg5) - v8);
        };
        v6.total_weighted_units = v6.total_weighted_units - v8;
        v6.total_lp_locked = v6.total_lp_locked - (arg4 as u128);
        0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::add_to_profile<0x1::string::String, UserKriyaHivePosition>(true, arg3, v5, v6, arg6);
        0x2::transfer::public_transfer<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_split<T0, T1>(&mut arg2.kriya_lps_locked, arg4, arg6), v4);
    }

    // decompiled from Move bytecode v6
}

