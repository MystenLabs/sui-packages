module 0xd1654b29bd6182181768053ff7075ca55bc86169fbb41187559b8143922ff334::kriya_vampire_attack {
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
        krafted_pools_map: 0x2::linked_table::LinkedTable<0x1::string::String, address>,
    }

    struct KriyaLockdropForPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        identifier: 0x1::string::String,
        precision: u8,
        user_profile_access_cap: 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::ProfileDofOwnershipCapability,
        total_hive_incentives: u64,
        available_hive_tokens: 0x2::balance::Balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>,
        kriya_lps_locked: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>,
        total_lp_locked: u128,
        total_weighted_units: u128,
        total_x_withdrawn: u64,
        total_y_withdrawn: u64,
    }

    struct UserKriyaHivePosition has store, key {
        id: 0x2::object::UID,
        lockup_weeks: vector<u64>,
        lp_tokens_locked: 0x2::table::Table<u64, u64>,
        unlock_timestamps: 0x2::table::Table<u64, u64>,
        lockup_weighted_units: 0x2::table::Table<u64, u128>,
        withdrawl_window_flag: 0x2::table::Table<u64, bool>,
        total_lp_locked: u128,
        total_weighted_units: u128,
    }

    struct KriyaAttackConfigInitialized has copy, drop {
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

    struct KriyaLockdropPoolKrafted<phantom T0, phantom T1> has copy, drop {
        pool_addr: address,
        hive_incentives: u64,
    }

    struct HiveIncentivesAddedForKriyaPool<phantom T0, phantom T1> has copy, drop {
        pool_addr: address,
        hive_incentives_added: u64,
        total_incentives: u64,
    }

    struct KriyaLpTokensDeposited<phantom T0, phantom T1> has copy, drop {
        user_profile: address,
        username: 0x1::string::String,
        user_addr: address,
        lockup_weeks: u64,
        liquidity_locked: u64,
        unlock_timestamp: u64,
        increase_in_weighted_units: u128,
        expected_hive_rewards_increase: u64,
        total_lp_locked_by_user: u128,
        total_user_weighted_units: u128,
        total_user_exp_hive_rewards: u64,
    }

    struct KriyaLpTokensWithdrawn<phantom T0, phantom T1> has copy, drop {
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

    struct LiquidityExtractedFromKriya<phantom T0, phantom T1> has copy, drop {
        total_lp_deposited: u128,
        x_balance_extracted: u64,
        y_balance_extracted: u64,
        total_weighted_units: u128,
    }

    public entry fun add_incentives_for_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut KriyaLockdropForPool<T0, T1>, arg2: &KriyaAttackConfig, arg3: 0x2::coin::Coin<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(arg3);
        0x2::balance::join<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&mut arg1.available_hive_tokens, 0x2::balance::split<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&mut v0, arg4));
        arg1.total_hive_incentives = arg1.total_hive_incentives + arg4;
        let v1 = HiveIncentivesAddedForKriyaPool<T0, T1>{
            pool_addr             : 0x2::object::uid_to_address(&arg1.id),
            hive_incentives_added : arg4,
            total_incentives      : arg1.total_hive_incentives,
        };
        0x2::event::emit<HiveIncentivesAddedForKriyaPool<T0, T1>>(v1);
        0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::coin_helper::destroy_or_transfer_balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(v0, 0x2::tx_context::sender(arg5), arg5);
        (arg1.total_hive_incentives, arg1.identifier)
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
            (0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::math::mul_div_u256(((arg2 / 2) as u256), ((v2 - arg1) as u256), ((v2 - v1) as u256)) as u64)
        } else {
            0
        }
    }

    fun calculate_hive_rewards(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::math::mul_div_u256((arg2 as u256), (arg0 as u256), (arg1 as u256)) as u64)
        }
    }

    fun calculate_weighted_units(arg0: u128, arg1: u64, arg2: &KriyaAttackConfig) : u128 {
        (((arg0 as u256) * ((1000000000 as u256) + 0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::math::mul_div_u256(((arg1 - 1) as u256) * (arg2.weekly_multiplier as u256), (1000000000 as u256), (arg2.weekly_divider as u256)))) as u128)
    }

    public fun destroy_user_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::config::HiveEntryCap, arg2: &KriyaAttackConfig, arg3: &KriyaLockdropForPool<T0, T1>, arg4: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveProfile, arg5: &mut 0x2::tx_context::TxContext) : (vector<u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u128>, u128, u128) {
        0x2::clock::timestamp_ms(arg0);
        if (!0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::exists_for_profile(arg4, 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::get_profile_dof_capability_identifier(&arg3.user_profile_access_cap))) {
            return (0x1::vector::empty<u64>(), 0x2::table::new<u64, u64>(arg5), 0x2::table::new<u64, u64>(arg5), 0x2::table::new<u64, u128>(arg5), 0, 0)
        };
        let UserKriyaHivePosition {
            id                    : v0,
            lockup_weeks          : v1,
            lp_tokens_locked      : v2,
            unlock_timestamps     : v3,
            lockup_weighted_units : v4,
            withdrawl_window_flag : v5,
            total_lp_locked       : v6,
            total_weighted_units  : v7,
        } = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_remove_from_profile<UserKriyaHivePosition>(&arg3.user_profile_access_cap, arg4, arg5);
        0x2::object::delete(v0);
        0x2::table::drop<u64, bool>(v5);
        (v1, v2, v3, v4, v6, v7)
    }

    public fun does_user_have_position<T0, T1>(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveProfile, arg1: &KriyaLockdropForPool<T0, T1>) : bool {
        0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::exists_for_profile(arg0, 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap))
    }

    public fun extract_liquidity_from_kriya<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::config::HiveEntryCap, arg2: &KriyaAttackConfig, arg3: &mut KriyaLockdropForPool<T0, T1>, arg4: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : (u128, u8, u128, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<T0, T1>(&arg3.kriya_lps_locked);
        arg3.total_lp_locked = (v0 as u128);
        let (v1, v2) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::remove_liquidity<T0, T1>(arg4, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_split<T0, T1>(&mut arg3.kriya_lps_locked, v0, arg5), v0, arg5);
        let v3 = 0x2::coin::into_balance<T0>(v2);
        let v4 = 0x2::coin::into_balance<T1>(v1);
        arg3.total_x_withdrawn = arg3.total_x_withdrawn + 0x2::balance::value<T0>(&v3);
        arg3.total_y_withdrawn = arg3.total_y_withdrawn + 0x2::balance::value<T1>(&v4);
        let v5 = LiquidityExtractedFromKriya<T0, T1>{
            total_lp_deposited   : (v0 as u128),
            x_balance_extracted  : arg3.total_x_withdrawn,
            y_balance_extracted  : arg3.total_y_withdrawn,
            total_weighted_units : arg3.total_weighted_units,
        };
        0x2::event::emit<LiquidityExtractedFromKriya<T0, T1>>(v5);
        (arg3.total_lp_locked, arg3.precision, arg3.total_weighted_units, arg3.total_hive_incentives, v3, v4, 0x2::balance::withdraw_all<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&mut arg3.available_hive_tokens))
    }

    public fun get_user_position<T0, T1>(arg0: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveProfile, arg1: &KriyaLockdropForPool<T0, T1>) : (vector<u64>, vector<u64>, vector<u64>, vector<u128>, vector<bool>, vector<u64>, u128, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u128>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap);
        if (!0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::exists_for_profile(arg0, v5)) {
            return (0x1::vector::empty<u64>(), v0, v1, v2, v3, v4, 0, 0)
        };
        let v6 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::borrow_from_profile<UserKriyaHivePosition>(arg0, v5);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v6.lockup_weeks)) {
            let v8 = *0x1::vector::borrow<u64>(&v6.lockup_weeks, v7);
            0x1::vector::push_back<u64>(&mut v0, *0x2::table::borrow<u64, u64>(&v6.lp_tokens_locked, v8));
            0x1::vector::push_back<u64>(&mut v1, *0x2::table::borrow<u64, u64>(&v6.unlock_timestamps, v8));
            let v9 = *0x2::table::borrow<u64, u128>(&v6.lockup_weighted_units, v8);
            0x1::vector::push_back<u128>(&mut v2, v9);
            0x1::vector::push_back<bool>(&mut v3, *0x2::table::borrow<u64, bool>(&v6.withdrawl_window_flag, v8));
            0x1::vector::push_back<u64>(&mut v4, calculate_hive_rewards(v9, arg1.total_weighted_units, arg1.total_hive_incentives));
            v7 = v7 + 1;
        };
        (v6.lockup_weeks, v0, v1, v2, v3, v4, v6.total_lp_locked, calculate_hive_rewards(v6.total_weighted_units, arg1.total_weighted_units, arg1.total_hive_incentives))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_attack_on_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::config::HiveEntryCap, arg2: 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::ProfileDofOwnershipCapability, arg3: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg4: &mut KriyaAttackConfig, arg5: 0x1::string::String, arg6: u8, arg7: 0x2::coin::Coin<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : address {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(arg7);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<T0, T1>(&arg3);
        let v2 = 0x2::object::new(arg9);
        let v3 = 0x2::object::uid_to_address(&v2);
        let v4 = KriyaLockdropForPool<T0, T1>{
            id                      : v2,
            identifier              : arg5,
            precision               : arg6,
            user_profile_access_cap : arg2,
            total_hive_incentives   : arg8,
            available_hive_tokens   : 0x2::balance::split<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(&mut v0, arg8),
            kriya_lps_locked        : arg3,
            total_lp_locked         : (v1 as u128),
            total_weighted_units    : calculate_weighted_units((v1 as u128), arg4.min_lock_duration, arg4),
            total_x_withdrawn       : 0,
            total_y_withdrawn       : 0,
        };
        0x2::transfer::share_object<KriyaLockdropForPool<T0, T1>>(v4);
        let v5 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v5, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x2::linked_table::push_back<0x1::string::String, address>(&mut arg4.krafted_pools_map, v5, v3);
        0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::coin_helper::destroy_or_transfer_balance<0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive::HIVE>(v0, 0x2::tx_context::sender(arg9), arg9);
        let v6 = KriyaLockdropPoolKrafted<T0, T1>{
            pool_addr       : v3,
            hive_incentives : arg8,
        };
        0x2::event::emit<KriyaLockdropPoolKrafted<T0, T1>>(v6);
        v3
    }

    public entry fun initialize_kriya_attack_config(arg0: &0x2::clock::Clock, arg1: &0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::config::HiveEntryCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : address {
        0x2::clock::timestamp_ms(arg0);
        let v0 = KriyaAttackConfig{
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
        let v2 = KriyaAttackConfigInitialized{
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
        0x2::event::emit<KriyaAttackConfigInitialized>(v2);
        0x2::transfer::share_object<KriyaAttackConfig>(v0);
        v1
    }

    public fun join_kriya_lp<T0, T1>(arg0: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg1: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>) : 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1> {
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_join<T0, T1>(&mut arg0, arg1);
        arg0
    }

    public entry fun lock_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::config::HiveEntryCap, arg2: &KriyaAttackConfig, arg3: &mut KriyaLockdropForPool<T0, T1>, arg4: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveProfile, arg5: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u8) {
        0x2::clock::timestamp_ms(arg0);
        let (v0, v1, _, v3) = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::get_profile_meta_info(arg4);
        let v4 = if (0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::exists_for_profile(arg4, 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::get_profile_dof_capability_identifier(&arg3.user_profile_access_cap))) {
            0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_remove_from_profile<UserKriyaHivePosition>(&arg3.user_profile_access_cap, arg4, arg8)
        } else {
            UserKriyaHivePosition{id: 0x2::object::new(arg8), lockup_weeks: 0x1::vector::empty<u64>(), lp_tokens_locked: 0x2::table::new<u64, u64>(arg8), unlock_timestamps: 0x2::table::new<u64, u64>(arg8), lockup_weighted_units: 0x2::table::new<u64, u128>(arg8), withdrawl_window_flag: 0x2::table::new<u64, bool>(arg8), total_lp_locked: 0, total_weighted_units: 0}
        };
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<T0, T1>(&arg5);
        let v5 = calculate_weighted_units((arg6 as u128), arg7, arg2);
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_join<T0, T1>(&mut arg3.kriya_lps_locked, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_split<T0, T1>(&mut arg5, arg6, arg8));
        arg3.total_lp_locked = arg3.total_lp_locked + (arg6 as u128);
        arg3.total_weighted_units = arg3.total_weighted_units + v5;
        let v6 = arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window + arg7 * 1800000;
        if (!0x1::vector::contains<u64>(&v4.lockup_weeks, &arg7)) {
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
        v4.total_lp_locked = v4.total_lp_locked + (arg6 as u128);
        let v7 = KriyaLpTokensDeposited<T0, T1>{
            user_profile                   : v0,
            username                       : v1,
            user_addr                      : v3,
            lockup_weeks                   : arg7,
            liquidity_locked               : arg6,
            unlock_timestamp               : v6,
            increase_in_weighted_units     : v5,
            expected_hive_rewards_increase : calculate_hive_rewards(v5, arg3.total_weighted_units, arg3.total_hive_incentives),
            total_lp_locked_by_user        : v4.total_lp_locked,
            total_user_weighted_units      : v4.total_weighted_units,
            total_user_exp_hive_rewards    : calculate_hive_rewards(v4.total_weighted_units, arg3.total_weighted_units, arg3.total_hive_incentives),
        };
        0x2::event::emit<KriyaLpTokensDeposited<T0, T1>>(v7);
        0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_add_to_profile<UserKriyaHivePosition>(&arg3.user_profile_access_cap, arg4, v4, arg8);
        if (0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<T0, T1>(&arg5) == 0) {
            0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_destroy_zero<T0, T1>(arg5);
        } else {
            0x2::transfer::public_transfer<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>>(arg5, v3);
        };
        (arg3.identifier, arg3.precision)
    }

    public fun simulate_lock_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &KriyaAttackConfig, arg2: &KriyaLockdropForPool<T0, T1>, arg3: u128, arg4: u64) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 < arg1.init_timestamp || v0 > arg1.init_timestamp + arg1.deposit_window) {
            return 0
        };
        if (arg4 < arg1.min_lock_duration || arg4 > arg1.max_lock_duration) {
            return 0
        };
        let v1 = calculate_weighted_units(arg3, arg4, arg1);
        calculate_hive_rewards(v1, arg2.total_weighted_units + v1, arg2.total_hive_incentives)
    }

    public fun simulate_withdraw_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &KriyaAttackConfig, arg2: &KriyaLockdropForPool<T0, T1>, arg3: &0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveProfile, arg4: u128, arg5: u64) : (u64, u64, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 < arg1.init_timestamp || v0 > arg1.init_timestamp + arg1.deposit_window + arg1.withdrawal_window) {
            return (0, 0, false)
        };
        let v1 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::get_profile_dof_capability_identifier(&arg2.user_profile_access_cap);
        if (!0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::exists_for_profile(arg3, v1)) {
            return (0, 0, false)
        };
        let v2 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::borrow_from_profile<UserKriyaHivePosition>(arg3, v1);
        let (v3, _) = 0x1::vector::index_of<u64>(&v2.lockup_weeks, &arg5);
        if (!v3) {
            return (0, 0, false)
        };
        let v5 = *0x2::table::borrow<u64, bool>(&v2.withdrawl_window_flag, arg5);
        if (v5) {
            return (allowed_withdrawal_amount(arg1, v0, *0x2::table::borrow<u64, u64>(&v2.lp_tokens_locked, arg5)), 0, v5)
        };
        let v6 = calculate_weighted_units(arg4, arg5, arg1);
        (allowed_withdrawal_amount(arg1, v0, *0x2::table::borrow<u64, u64>(&v2.lp_tokens_locked, arg5)), calculate_hive_rewards(v6, arg2.total_weighted_units - v6, arg2.total_hive_incentives), v5)
    }

    public entry fun withdraw_lp_tokens<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::config::HiveEntryCap, arg2: &KriyaAttackConfig, arg3: &mut KriyaLockdropForPool<T0, T1>, arg4: &mut 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u8) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2, _, v4) = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::get_profile_meta_info(arg4);
        0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::get_profile_dof_capability_identifier(&arg3.user_profile_access_cap);
        let v5 = 0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_remove_from_profile<UserKriyaHivePosition>(&arg3.user_profile_access_cap, arg4, arg7);
        let (_, v7) = 0x1::vector::index_of<u64>(&v5.lockup_weeks, &arg6);
        let v8 = *0x2::table::borrow<u64, u64>(&v5.lp_tokens_locked, arg6);
        allowed_withdrawal_amount(arg2, v0, v8);
        let v9 = false;
        if (v0 > arg2.init_timestamp + arg2.deposit_window) {
            0x2::table::remove<u64, bool>(&mut v5.withdrawl_window_flag, arg6);
            0x2::table::add<u64, bool>(&mut v5.withdrawl_window_flag, arg6, true);
            v9 = true;
        };
        let v10 = calculate_weighted_units((arg5 as u128), arg6, arg2);
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
        v5.total_lp_locked = v5.total_lp_locked - (arg5 as u128);
        let v11 = KriyaLpTokensWithdrawn<T0, T1>{
            user_profile                   : v1,
            username                       : v2,
            user_addr                      : v4,
            lockup_weeks                   : arg6,
            liquidity_withdrawn            : arg5,
            withdrawn_flag                 : v9,
            decrease_in_weighted_units     : v10,
            expected_hive_rewards_decrease : calculate_hive_rewards(v10, arg3.total_weighted_units, arg3.total_hive_incentives),
            total_user_weighted_units      : v5.total_weighted_units,
            total_lp_locked_by_user        : v5.total_lp_locked,
            total_user_exp_hive_rewards    : calculate_hive_rewards(v5.total_weighted_units, arg3.total_weighted_units, arg3.total_hive_incentives),
        };
        0x2::event::emit<KriyaLpTokensWithdrawn<T0, T1>>(v11);
        0x249a788a31d9c48bda91536ff9d9396ec473b7d168d13f99e8788ca31e130e6f::hive_profile::entry_add_to_profile<UserKriyaHivePosition>(&arg3.user_profile_access_cap, arg4, v5, arg7);
        0x2::transfer::public_transfer<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_split<T0, T1>(&mut arg3.kriya_lps_locked, arg5, arg7), v4);
        (arg3.identifier, arg3.precision)
    }

    // decompiled from Move bytecode v6
}

