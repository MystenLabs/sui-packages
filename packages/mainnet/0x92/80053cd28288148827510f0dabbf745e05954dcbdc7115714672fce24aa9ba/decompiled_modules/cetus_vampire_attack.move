module 0x9280053cd28288148827510f0dabbf745e05954dcbdc7115714672fce24aa9ba::cetus_vampire_attack {
    struct CetusAttackConfig has store, key {
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

    struct CetusLockdropForPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        identifier: 0x1::string::String,
        precision: u8,
        user_profile_access_cap: 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveAppAccessCapability,
        participants_position_mapping: 0x2::linked_table::LinkedTable<address, UserCetusLockup>,
        total_weighted_units: u128,
        total_hive_incentives: 0x2::balance::Balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>,
        hive_incentives: u64,
        total_positions_liquidity: u128,
        x_total_liquidity_withdrawn: u64,
        y_total_liquidity_withdrawn: u64,
        x_avail_liquidity_bal: 0x2::balance::Balance<T0>,
        y_avail_liquidity_bal: 0x2::balance::Balance<T1>,
        x_total_fee_withdrawn: u64,
        y_total_fee_withdrawn: u64,
        x_fee_avail_bal: 0x2::balance::Balance<T0>,
        y_fee_avail_bal: 0x2::balance::Balance<T1>,
        total_sui_earned: u64,
        total_cetus_earned: u64,
        sui_earned_bal: 0x2::balance::Balance<0x2::sui::SUI>,
        cetus_earned_bal: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>,
        to_claim_rewards: bool,
    }

    struct UserCetusLockup has store {
        lockup_weeks: vector<u64>,
        position_breakdown: 0x2::table::Table<u64, CetusPositionBreakdown>,
        total_user_weighted_units: u128,
    }

    struct CetusPositionBreakdown has store {
        position_liquidity: u128,
        weighted_units: u128,
        x_withdrawn: u64,
        y_withdrawn: u64,
        fee_earned_x: u64,
        fee_earned_y: u64,
        cetus_earned: u64,
        sui_earned: u64,
    }

    struct UserCetusHivePosition has store, key {
        id: 0x2::object::UID,
        lockup_weeks: vector<u64>,
        lockup_receipts: 0x2::table::Table<u64, Receipt>,
        total_liquidity_locked: u128,
        total_weighted_units: u128,
    }

    struct Receipt has drop, store {
        weeks_locked_for: u64,
        unlock_timestamp: u64,
        position_liquidity: u128,
        weighted_units: u128,
    }

    struct PoolForVampireAttackOnCetusKrafted<phantom T0, phantom T1> has copy, drop, store {
        pool_addr: address,
        hive_incentives: u64,
    }

    struct HiveIncentivesAddedForPool<phantom T0, phantom T1> has copy, drop, store {
        pool_addr: address,
        hive_incentives_added: u64,
        total_incentives: u64,
    }

    struct CetusPositionLocked<phantom T0, phantom T1> has copy, drop {
        user_profile: address,
        username: 0x1::string::String,
        user_addr: address,
        lockup_weeks: u64,
        liquidity_locked: u128,
        unlock_timestamp: u64,
        increase_in_weighted_units: u128,
        total_liquidity_locked: u128,
        total_user_weighted_units: u128,
        expected_hive_rewards_increase: u64,
        total_user_exp_hive_rewards: u64,
    }

    struct CetusPositionDestroyed<phantom T0, phantom T1> has copy, drop, store {
        user_addr: address,
        lockup_weeks: u64,
        x_withdrawn: u64,
        y_withdrawn: u64,
        fee_earned_x: u64,
        fee_earned_y: u64,
        sui_earned: u64,
        cetus_earned: u64,
        position_liquidity: u128,
    }

    public fun mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 9807);
        ((arg0 * arg1 / arg2) as u256)
    }

    public entry fun add_incentives_for_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut CetusLockdropForPool<T0, T1>, arg2: &CetusAttackConfig, arg3: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        assert!(arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window > 0x2::clock::timestamp_ms(arg0), 9803);
        let v0 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg3);
        0x2::balance::join<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut arg1.total_hive_incentives, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v0, arg4));
        arg1.hive_incentives = arg1.hive_incentives + arg4;
        let v1 = HiveIncentivesAddedForPool<T0, T1>{
            pool_addr             : 0x2::object::uid_to_address(&arg1.id),
            hive_incentives_added : arg4,
            total_incentives      : arg1.hive_incentives,
        };
        0x2::event::emit<HiveIncentivesAddedForPool<T0, T1>>(v1);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v0, 0x2::tx_context::sender(arg5), arg5);
        (arg1.hive_incentives, arg1.identifier)
    }

    fun calculate_hive_rewards(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((arg2 as u256), (arg0 as u256), (arg1 as u256)) as u64)
        }
    }

    fun calculate_weighted_units(arg0: u128, arg1: u64, arg2: &CetusAttackConfig) : u128 {
        (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((arg0 as u256), (1000000000 as u256) + mul_div_u256(((arg1 - 1) as u256) * (arg2.weekly_multiplier as u256), (1000000000 as u256), (arg2.weekly_divider as u256)), (1000000000 as u256)) as u128)
    }

    public fun destroy_user_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg2: &CetusAttackConfig, arg3: &CetusLockdropForPool<T0, T1>, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : (vector<u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u128>, 0x2::table::Table<u64, u128>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, u128) {
        assert!(0x2::clock::timestamp_ms(arg0) > arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window, 9812);
        assert!(0x2::balance::value<T0>(&arg3.x_avail_liquidity_bal) == 0, 9815);
        if (!0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::exists_for_profile(arg4, 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_hive_app_name(&arg3.user_profile_access_cap))) {
            return (0x1::vector::empty<u64>(), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u128>(arg6), 0x2::table::new<u64, u128>(arg6), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u64>(arg6), 0)
        };
        let UserCetusHivePosition {
            id                     : v0,
            lockup_weeks           : v1,
            lockup_receipts        : v2,
            total_liquidity_locked : _,
            total_weighted_units   : v4,
        } = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::remove_app_from_profile<UserCetusHivePosition>(&arg3.user_profile_access_cap, arg4, arg6);
        let v5 = v2;
        let v6 = v1;
        0x2::object::delete(v0);
        let v7 = 0x2::linked_table::borrow<address, UserCetusLockup>(&arg3.participants_position_mapping, arg5);
        let v8 = 0x2::table::new<u64, u64>(arg6);
        let v9 = 0x2::table::new<u64, u128>(arg6);
        let v10 = 0x2::table::new<u64, u128>(arg6);
        let v11 = 0x2::table::new<u64, u64>(arg6);
        let v12 = 0x2::table::new<u64, u64>(arg6);
        let v13 = 0x2::table::new<u64, u64>(arg6);
        let v14 = 0x2::table::new<u64, u64>(arg6);
        let v15 = 0x2::table::new<u64, u64>(arg6);
        let v16 = 0x2::table::new<u64, u64>(arg6);
        let v17 = 0;
        while (v17 < 0x1::vector::length<u64>(&v6)) {
            let v18 = *0x1::vector::borrow<u64>(&v6, v17);
            let v19 = 0x2::table::borrow<u64, CetusPositionBreakdown>(&v7.position_breakdown, v18);
            0x2::table::add<u64, u64>(&mut v8, v18, 0x2::table::borrow<u64, Receipt>(&v5, v18).unlock_timestamp);
            0x2::table::add<u64, u128>(&mut v9, v18, v19.position_liquidity);
            0x2::table::add<u64, u128>(&mut v10, v18, v19.weighted_units);
            0x2::table::add<u64, u64>(&mut v11, v18, v19.x_withdrawn);
            0x2::table::add<u64, u64>(&mut v12, v18, v19.y_withdrawn);
            0x2::table::add<u64, u64>(&mut v13, v18, v19.fee_earned_x);
            0x2::table::add<u64, u64>(&mut v14, v18, v19.fee_earned_y);
            0x2::table::add<u64, u64>(&mut v15, v18, v19.cetus_earned);
            0x2::table::add<u64, u64>(&mut v16, v18, v19.sui_earned);
            v17 = v17 + 1;
        };
        0x2::table::drop<u64, Receipt>(v5);
        (v6, v8, v9, v10, v11, v12, v13, v14, v15, v16, v4)
    }

    public fun does_user_have_position<T0, T1>(arg0: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg1: &CetusLockdropForPool<T0, T1>) : bool {
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::exists_for_profile(arg0, 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_hive_app_name(&arg1.user_profile_access_cap))
    }

    public entry fun flip_claim_rewards_switch<T0, T1>(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg1: &mut CetusLockdropForPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.to_claim_rewards = !arg1.to_claim_rewards;
    }

    public fun get_user_position<T0, T1>(arg0: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg1: &CetusLockdropForPool<T0, T1>) : (vector<u64>, vector<u128>, vector<u64>, vector<u128>, vector<u64>, u128, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u128>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_hive_app_name(&arg1.user_profile_access_cap);
        if (!0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::exists_for_profile(arg0, v5)) {
            return (v0, v1, v2, v3, v4, 0, 0)
        };
        let v6 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_from_profile<UserCetusHivePosition>(arg0, v5);
        v0 = v6.lockup_weeks;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v0)) {
            let v8 = 0x2::table::borrow<u64, Receipt>(&v6.lockup_receipts, *0x1::vector::borrow<u64>(&v6.lockup_weeks, v7));
            0x1::vector::push_back<u128>(&mut v1, v8.position_liquidity);
            0x1::vector::push_back<u64>(&mut v2, v8.unlock_timestamp);
            let v9 = v8.weighted_units;
            0x1::vector::push_back<u128>(&mut v3, v9);
            0x1::vector::push_back<u64>(&mut v4, calculate_hive_rewards(v9, arg1.total_weighted_units, arg1.hive_incentives));
            v7 = v7 + 1;
        };
        (v0, v1, v2, v3, v4, v6.total_liquidity_locked, calculate_hive_rewards(v6.total_weighted_units, arg1.total_weighted_units, arg1.hive_incentives))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_attack_on_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg2: 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveAppAccessCapability, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &CetusAttackConfig, arg5: 0x1::string::String, arg6: u8, arg7: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg7);
        let v1 = 0x2::object::new(arg10);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = CetusLockdropForPool<T0, T1>{
            id                            : v1,
            identifier                    : arg5,
            precision                     : arg6,
            user_profile_access_cap       : arg2,
            participants_position_mapping : 0x2::linked_table::new<address, UserCetusLockup>(arg10),
            total_weighted_units          : 0,
            total_hive_incentives         : 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v0, arg8),
            hive_incentives               : arg8,
            total_positions_liquidity     : 0,
            x_total_liquidity_withdrawn   : 0,
            y_total_liquidity_withdrawn   : 0,
            x_avail_liquidity_bal         : 0x2::balance::zero<T0>(),
            y_avail_liquidity_bal         : 0x2::balance::zero<T1>(),
            x_total_fee_withdrawn         : 0,
            y_total_fee_withdrawn         : 0,
            x_fee_avail_bal               : 0x2::balance::zero<T0>(),
            y_fee_avail_bal               : 0x2::balance::zero<T1>(),
            total_sui_earned              : 0,
            total_cetus_earned            : 0,
            sui_earned_bal                : 0x2::balance::zero<0x2::sui::SUI>(),
            cetus_earned_bal              : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
            to_claim_rewards              : arg9,
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v0, 0x2::tx_context::sender(arg10), arg10);
        0x2::transfer::share_object<CetusLockdropForPool<T0, T1>>(v3);
        let v4 = PoolForVampireAttackOnCetusKrafted<T0, T1>{
            pool_addr       : v2,
            hive_incentives : arg8,
        };
        0x2::event::emit<PoolForVampireAttackOnCetusKrafted<T0, T1>>(v4);
        v2
    }

    public entry fun initialize_cetus_attack(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : address {
        0x2::clock::timestamp_ms(arg0);
        assert!(arg6 > arg5 && arg5 > 0, 9801);
        assert!(arg7 > 0 && arg8 > 0, 9802);
        let v0 = 0x2::object::new(arg10);
        let v1 = CetusAttackConfig{
            id                     : v0,
            init_timestamp         : arg2,
            deposit_window         : arg3,
            withdrawal_window      : arg4,
            min_lock_duration      : arg5,
            max_lock_duration      : arg6,
            weekly_multiplier      : arg7,
            weekly_divider         : arg8,
            max_positions_per_user : arg9,
        };
        0x2::transfer::share_object<CetusAttackConfig>(v1);
        0x2::object::uid_to_address(&v0)
    }

    fun kraft_cetus_lockup(arg0: &mut 0x2::tx_context::TxContext) : UserCetusLockup {
        UserCetusLockup{
            lockup_weeks              : 0x1::vector::empty<u64>(),
            position_breakdown        : 0x2::table::new<u64, CetusPositionBreakdown>(arg0),
            total_user_weighted_units : 0,
        }
    }

    fun kraft_cetus_position_breakdown() : CetusPositionBreakdown {
        CetusPositionBreakdown{
            position_liquidity : 0,
            weighted_units     : 0,
            x_withdrawn        : 0,
            y_withdrawn        : 0,
            fee_earned_x       : 0,
            fee_earned_y       : 0,
            cetus_earned       : 0,
            sui_earned         : 0,
        }
    }

    fun perform_validity_checks(arg0: &CetusAttackConfig, arg1: u64, arg2: u64) {
        assert!(arg2 >= arg0.init_timestamp, 9804);
        assert!(arg2 <= arg0.init_timestamp + arg0.deposit_window, 9805);
        assert!(arg1 >= arg0.min_lock_duration && arg1 <= arg0.max_lock_duration, 9806);
    }

    fun remove_liquidity_from_cetus<T0, T1>(arg0: address, arg1: &0x2::clock::Clock, arg2: &CetusAttackConfig, arg3: u64, arg4: &mut CetusLockdropForPool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg9: &mut CetusPositionBreakdown, arg10: &0x2::tx_context::TxContext) : (u128, u128) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg5, arg6, &arg8, true);
        let v2 = 0x2::balance::zero<0x2::sui::SUI>();
        let v3 = 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>();
        if (arg4.to_claim_rewards) {
            0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x2::sui::SUI>(arg5, arg6, &arg8, arg7, true, arg1));
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg5, arg6, &arg8, arg7, true, arg1));
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg8);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg5, arg6, &mut arg8, v4, arg1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg5, arg6, arg8);
        update_pool_and_breakdown_info<T0, T1>(arg0, arg3, arg4, arg9, v2, v3, v4, calculate_weighted_units(v4, arg3, arg2), v5, v6, v0, v1)
    }

    fun remove_liquidity_from_rev_cetus<T0, T1>(arg0: address, arg1: &0x2::clock::Clock, arg2: &CetusAttackConfig, arg3: u64, arg4: &mut CetusLockdropForPool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg9: &mut CetusPositionBreakdown, arg10: &0x2::tx_context::TxContext) : (u128, u128) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg5, arg6, &arg8, true);
        let v2 = 0x2::balance::zero<0x2::sui::SUI>();
        let v3 = 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>();
        if (arg4.to_claim_rewards) {
            0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, 0x2::sui::SUI>(arg5, arg6, &arg8, arg7, true, arg1));
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T0, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg5, arg6, &arg8, arg7, true, arg1));
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg8);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T0>(arg5, arg6, &mut arg8, v4, arg1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T1, T0>(arg5, arg6, arg8);
        update_pool_and_breakdown_info<T0, T1>(arg0, arg3, arg4, arg9, v2, v3, v4, calculate_weighted_units(v4, arg3, arg2), v6, v5, v1, v0)
    }

    public fun simulate_stake_cetus_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &CetusAttackConfig, arg2: &CetusLockdropForPool<T0, T1>, arg3: u128, arg4: u64) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 < arg1.init_timestamp || v0 > arg1.init_timestamp + arg1.deposit_window) {
            return 0
        };
        if (arg4 < arg1.min_lock_duration || arg4 > arg1.max_lock_duration) {
            return 0
        };
        let v1 = calculate_weighted_units(arg3, arg4, arg1);
        calculate_hive_rewards(v1, arg2.total_weighted_units + v1, arg2.hive_incentives)
    }

    public fun stake_cetus_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg2: &CetusAttackConfig, arg3: &mut CetusLockdropForPool<T0, T1>, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (u128, 0x1::string::String, u8) {
        let (v0, v1, _, v3) = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_profile_meta_info(arg4);
        perform_validity_checks(arg2, arg9, 0x2::clock::timestamp_ms(arg0));
        let v4 = if (0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::exists_for_profile(arg4, 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_hive_app_name(&arg3.user_profile_access_cap))) {
            0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::remove_app_from_profile<UserCetusHivePosition>(&arg3.user_profile_access_cap, arg4, arg10)
        } else {
            UserCetusHivePosition{id: 0x2::object::new(arg10), lockup_weeks: 0x1::vector::empty<u64>(), lockup_receipts: 0x2::table::new<u64, Receipt>(arg10), total_liquidity_locked: 0, total_weighted_units: 0}
        };
        if (!0x2::linked_table::contains<address, UserCetusLockup>(&arg3.participants_position_mapping, v0)) {
            let v5 = kraft_cetus_lockup(arg10);
            0x2::linked_table::push_back<address, UserCetusLockup>(&mut arg3.participants_position_mapping, v0, v5);
        };
        let v6 = arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window + arg9 * 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::week_multiplier();
        let v7 = 0x2::linked_table::remove<address, UserCetusLockup>(&mut arg3.participants_position_mapping, v0);
        if (!0x1::vector::contains<u64>(&v4.lockup_weeks, &arg9)) {
            0x1::vector::push_back<u64>(&mut v4.lockup_weeks, arg9);
            let v8 = Receipt{
                weeks_locked_for   : arg9,
                unlock_timestamp   : v6,
                position_liquidity : 0,
                weighted_units     : 0,
            };
            0x2::table::add<u64, Receipt>(&mut v4.lockup_receipts, arg9, v8);
            0x2::table::add<u64, CetusPositionBreakdown>(&mut v7.position_breakdown, arg9, kraft_cetus_position_breakdown());
            0x1::vector::push_back<u64>(&mut v7.lockup_weeks, arg9);
        };
        let v9 = calculate_hive_rewards(v4.total_weighted_units, arg3.total_weighted_units, arg3.hive_incentives);
        let v10 = 0x2::table::remove<u64, CetusPositionBreakdown>(&mut v7.position_breakdown, arg9);
        let v11 = &mut v10;
        let (v12, v13) = remove_liquidity_from_cetus<T0, T1>(v0, arg0, arg2, arg9, arg3, arg5, arg6, arg7, arg8, v11, arg10);
        v7.total_user_weighted_units = v7.total_user_weighted_units + v13;
        0x2::table::add<u64, CetusPositionBreakdown>(&mut v7.position_breakdown, arg9, v10);
        v4.total_liquidity_locked = v4.total_liquidity_locked + v12;
        v4.total_weighted_units = v4.total_weighted_units + v13;
        let v14 = 0x2::table::borrow_mut<u64, Receipt>(&mut v4.lockup_receipts, arg9);
        v14.position_liquidity = v14.position_liquidity + v12;
        v14.weighted_units = v14.weighted_units + v13;
        let v15 = calculate_hive_rewards(v4.total_weighted_units, arg3.total_weighted_units, arg3.hive_incentives);
        0x2::linked_table::push_back<address, UserCetusLockup>(&mut arg3.participants_position_mapping, v0, v7);
        let v16 = CetusPositionLocked<T0, T1>{
            user_profile                   : v0,
            username                       : v1,
            user_addr                      : v3,
            lockup_weeks                   : arg9,
            liquidity_locked               : v12,
            unlock_timestamp               : v6,
            increase_in_weighted_units     : v13,
            total_liquidity_locked         : v4.total_liquidity_locked,
            total_user_weighted_units      : v4.total_weighted_units,
            expected_hive_rewards_increase : v15 - v9,
            total_user_exp_hive_rewards    : v15,
        };
        0x2::event::emit<CetusPositionLocked<T0, T1>>(v16);
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::add_app_to_profile<UserCetusHivePosition>(&arg3.user_profile_access_cap, arg4, v4, arg10);
        (v12, arg3.identifier, arg3.precision)
    }

    public fun stake_rev_cetus_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg2: &CetusAttackConfig, arg3: &mut CetusLockdropForPool<T0, T1>, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (u128, 0x1::string::String, u8) {
        let (v0, v1, _, v3) = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_profile_meta_info(arg4);
        perform_validity_checks(arg2, arg9, 0x2::clock::timestamp_ms(arg0));
        let v4 = if (0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::exists_for_profile(arg4, 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_hive_app_name(&arg3.user_profile_access_cap))) {
            0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::remove_app_from_profile<UserCetusHivePosition>(&arg3.user_profile_access_cap, arg4, arg10)
        } else {
            UserCetusHivePosition{id: 0x2::object::new(arg10), lockup_weeks: 0x1::vector::empty<u64>(), lockup_receipts: 0x2::table::new<u64, Receipt>(arg10), total_liquidity_locked: 0, total_weighted_units: 0}
        };
        if (!0x2::linked_table::contains<address, UserCetusLockup>(&arg3.participants_position_mapping, v0)) {
            let v5 = kraft_cetus_lockup(arg10);
            0x2::linked_table::push_back<address, UserCetusLockup>(&mut arg3.participants_position_mapping, v0, v5);
        };
        let v6 = arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window + arg9 * 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::week_multiplier();
        let v7 = 0x2::linked_table::remove<address, UserCetusLockup>(&mut arg3.participants_position_mapping, v0);
        if (!0x1::vector::contains<u64>(&v4.lockup_weeks, &arg9)) {
            0x1::vector::push_back<u64>(&mut v4.lockup_weeks, arg9);
            let v8 = Receipt{
                weeks_locked_for   : arg9,
                unlock_timestamp   : v6,
                position_liquidity : 0,
                weighted_units     : 0,
            };
            0x2::table::add<u64, Receipt>(&mut v4.lockup_receipts, arg9, v8);
            0x2::table::add<u64, CetusPositionBreakdown>(&mut v7.position_breakdown, arg9, kraft_cetus_position_breakdown());
            0x1::vector::push_back<u64>(&mut v7.lockup_weeks, arg9);
        };
        let v9 = calculate_hive_rewards(v4.total_weighted_units, arg3.total_weighted_units, arg3.hive_incentives);
        let v10 = 0x2::table::remove<u64, CetusPositionBreakdown>(&mut v7.position_breakdown, arg9);
        let v11 = &mut v10;
        let (v12, v13) = remove_liquidity_from_rev_cetus<T0, T1>(v0, arg0, arg2, arg9, arg3, arg5, arg6, arg7, arg8, v11, arg10);
        v7.total_user_weighted_units = v7.total_user_weighted_units + v13;
        0x2::table::add<u64, CetusPositionBreakdown>(&mut v7.position_breakdown, arg9, v10);
        v4.total_liquidity_locked = v4.total_liquidity_locked + v12;
        v4.total_weighted_units = v4.total_weighted_units + v13;
        let v14 = 0x2::table::borrow_mut<u64, Receipt>(&mut v4.lockup_receipts, arg9);
        v14.position_liquidity = v14.position_liquidity + v12;
        v14.weighted_units = v14.weighted_units + v13;
        let v15 = calculate_hive_rewards(v4.total_weighted_units, arg3.total_weighted_units, arg3.hive_incentives);
        0x2::linked_table::push_back<address, UserCetusLockup>(&mut arg3.participants_position_mapping, v0, v7);
        let v16 = CetusPositionLocked<T0, T1>{
            user_profile                   : v0,
            username                       : v1,
            user_addr                      : v3,
            lockup_weeks                   : arg9,
            liquidity_locked               : v12,
            unlock_timestamp               : v6,
            increase_in_weighted_units     : v13,
            total_liquidity_locked         : v4.total_liquidity_locked,
            total_user_weighted_units      : v4.total_weighted_units,
            expected_hive_rewards_increase : v15 - v9,
            total_user_exp_hive_rewards    : v15,
        };
        0x2::event::emit<CetusPositionLocked<T0, T1>>(v16);
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::add_app_to_profile<UserCetusHivePosition>(&arg3.user_profile_access_cap, arg4, v4, arg10);
        (v12, arg3.identifier, arg3.precision)
    }

    public fun transfer_liquidity_from_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg2: &CetusAttackConfig, arg3: &mut CetusLockdropForPool<T0, T1>, arg4: &0x2::tx_context::TxContext) : (u128, u8, u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, 0x2::balance::Balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>) {
        assert!(0x2::clock::timestamp_ms(arg0) > arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window, 9812);
        (arg3.total_positions_liquidity, arg3.precision, arg3.total_weighted_units, 0x2::balance::withdraw_all<T0>(&mut arg3.x_avail_liquidity_bal), 0x2::balance::withdraw_all<T1>(&mut arg3.y_avail_liquidity_bal), 0x2::balance::withdraw_all<T0>(&mut arg3.x_fee_avail_bal), 0x2::balance::withdraw_all<T1>(&mut arg3.y_fee_avail_bal), 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg3.sui_earned_bal), 0x2::balance::withdraw_all<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg3.cetus_earned_bal), 0x2::balance::withdraw_all<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut arg3.total_hive_incentives))
    }

    fun update_pool_and_breakdown_info<T0, T1>(arg0: address, arg1: u64, arg2: &mut CetusLockdropForPool<T0, T1>, arg3: &mut CetusPositionBreakdown, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg6: u128, arg7: u128, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: 0x2::balance::Balance<T0>, arg11: 0x2::balance::Balance<T1>) : (u128, u128) {
        arg2.total_positions_liquidity = arg2.total_positions_liquidity + arg6;
        arg2.total_weighted_units = arg2.total_weighted_units + arg7;
        arg3.position_liquidity = arg3.position_liquidity + arg6;
        arg3.weighted_units = arg3.weighted_units + arg7;
        arg3.x_withdrawn = arg3.x_withdrawn + 0x2::balance::value<T0>(&arg8);
        arg3.y_withdrawn = arg3.y_withdrawn + 0x2::balance::value<T1>(&arg9);
        arg3.fee_earned_x = arg3.fee_earned_x + 0x2::balance::value<T0>(&arg10);
        arg3.fee_earned_y = arg3.fee_earned_y + 0x2::balance::value<T1>(&arg11);
        arg3.sui_earned = arg3.sui_earned + 0x2::balance::value<0x2::sui::SUI>(&arg4);
        arg3.cetus_earned = arg3.cetus_earned + 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg5);
        arg2.x_total_liquidity_withdrawn = arg2.x_total_liquidity_withdrawn + 0x2::balance::value<T0>(&arg8);
        arg2.y_total_liquidity_withdrawn = arg2.y_total_liquidity_withdrawn + 0x2::balance::value<T1>(&arg9);
        0x2::balance::join<T0>(&mut arg2.x_avail_liquidity_bal, arg8);
        0x2::balance::join<T1>(&mut arg2.y_avail_liquidity_bal, arg9);
        arg2.x_total_fee_withdrawn = arg2.x_total_fee_withdrawn + 0x2::balance::value<T0>(&arg10);
        arg2.y_total_fee_withdrawn = arg2.y_total_fee_withdrawn + 0x2::balance::value<T1>(&arg11);
        0x2::balance::join<T0>(&mut arg2.x_fee_avail_bal, arg10);
        0x2::balance::join<T1>(&mut arg2.y_fee_avail_bal, arg11);
        arg2.total_sui_earned = arg2.total_sui_earned + 0x2::balance::value<0x2::sui::SUI>(&arg4);
        arg2.total_cetus_earned = arg2.total_cetus_earned + 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.sui_earned_bal, arg4);
        0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg2.cetus_earned_bal, arg5);
        let v0 = CetusPositionDestroyed<T0, T1>{
            user_addr          : arg0,
            lockup_weeks       : arg1,
            x_withdrawn        : arg3.x_withdrawn,
            y_withdrawn        : arg3.y_withdrawn,
            fee_earned_x       : arg3.fee_earned_x,
            fee_earned_y       : arg3.fee_earned_y,
            sui_earned         : arg3.sui_earned,
            cetus_earned       : arg3.cetus_earned,
            position_liquidity : arg3.position_liquidity,
        };
        0x2::event::emit<CetusPositionDestroyed<T0, T1>>(v0);
        (arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

