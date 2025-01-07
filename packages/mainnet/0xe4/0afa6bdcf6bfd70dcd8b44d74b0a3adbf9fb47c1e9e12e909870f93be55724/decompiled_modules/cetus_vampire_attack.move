module 0xe40afa6bdcf6bfd70dcd8b44d74b0a3adbf9fb47c1e9e12e909870f93be55724::cetus_vampire_attack {
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

    struct LockdropForPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        identifer: 0x1::string::String,
        user_profile_access_cap: 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::ProfileDofOwnershipCapability,
        paricipants_position_mapping: 0x2::linked_table::LinkedTable<address, UserCetusLockup>,
        last_liq_extracted_for_user: 0x1::option::Option<address>,
        liquidity_extracted_bool: 0x2::linked_table::LinkedTable<address, bool>,
        total_weighted_units: u128,
        total_hive_incentives: 0x2::balance::Balance<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>,
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
    }

    struct UserCetusLockup has store {
        lockup_weeks: vector<u64>,
        nft_positions: 0x2::table::Table<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
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

    public entry fun add_incentives_for_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut LockdropForPool<T0, T1>, arg2: &CetusAttackConfig, arg3: 0x2::coin::Coin<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>(arg3);
        0x2::balance::join<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>(&mut arg1.total_hive_incentives, 0x2::balance::split<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>(&mut v0, arg4));
        arg1.hive_incentives = arg1.hive_incentives + arg4;
        let v1 = HiveIncentivesAddedForPool<T0, T1>{
            pool_addr             : 0x2::object::uid_to_address(&arg1.id),
            hive_incentives_added : arg4,
            total_incentives      : arg1.hive_incentives,
        };
        0x2::event::emit<HiveIncentivesAddedForPool<T0, T1>>(v1);
        0x359d15f9d92be81be90194003b1d8fea72c3da8b6cafd14e271e69b596e2c371::coin_helper::destroy_or_transfer_balance<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>(v0, 0x2::tx_context::sender(arg5), arg5);
        (arg1.hive_incentives, arg1.identifer)
    }

    fun calculate_hive_rewards(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (0x359d15f9d92be81be90194003b1d8fea72c3da8b6cafd14e271e69b596e2c371::math::mul_div_u256((arg2 as u256), (arg0 as u256), (arg1 as u256)) as u64)
        }
    }

    fun calculate_weighted_units(arg0: u128, arg1: u64, arg2: &CetusAttackConfig) : u128 {
        (((arg0 as u256) * ((1000000000 as u256) + mul_div_u256(((arg1 - 1) as u256) * (arg2.weekly_multiplier as u256), (1000000000 as u256), (arg2.weekly_divider as u256)))) as u128)
    }

    public fun destroy_user_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x359d15f9d92be81be90194003b1d8fea72c3da8b6cafd14e271e69b596e2c371::config::HiveEntryCap, arg2: &CetusAttackConfig, arg3: &LockdropForPool<T0, T1>, arg4: &mut 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::HiveProfile, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : (vector<u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u128>, 0x2::table::Table<u64, u128>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, 0x2::table::Table<u64, u64>, u128) {
        0x2::clock::timestamp_ms(arg0);
        if (!0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::exists_for_profile(arg4, 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::get_profile_dof_capability_identifier(&arg3.user_profile_access_cap))) {
            return (0x1::vector::empty<u64>(), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u128>(arg6), 0x2::table::new<u64, u128>(arg6), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u64>(arg6), 0x2::table::new<u64, u64>(arg6), 0)
        };
        let UserCetusHivePosition {
            id                     : v0,
            lockup_weeks           : v1,
            lockup_receipts        : v2,
            total_liquidity_locked : _,
            total_weighted_units   : v4,
        } = 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::entry_remove_from_profile<UserCetusHivePosition>(&arg3.user_profile_access_cap, arg4, arg6);
        let v5 = v2;
        let v6 = v1;
        0x2::object::delete(v0);
        let v7 = 0x2::linked_table::borrow<address, UserCetusLockup>(&arg3.paricipants_position_mapping, arg5);
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

    public fun does_user_have_position<T0, T1>(arg0: &0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::HiveProfile, arg1: &LockdropForPool<T0, T1>) : bool {
        0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::exists_for_profile(arg0, 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap))
    }

    public entry fun extract_liquidity_from_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: &CetusAttackConfig, arg2: &mut LockdropForPool<T0, T1>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = if (0x1::option::is_some<address>(&arg2.last_liq_extracted_for_user)) {
            arg2.last_liq_extracted_for_user
        } else {
            *0x2::linked_table::front<address, UserCetusLockup>(&arg2.paricipants_position_mapping)
        };
        if (0x2::linked_table::contains<address, bool>(&arg2.liquidity_extracted_bool, *0x1::option::borrow<address>(&v0))) {
        };
        let v1 = 0;
        while (v1 < arg3 || 0x1::option::is_some<address>(&v0)) {
            let v2 = *0x1::option::borrow<address>(&v0);
            let v3 = 0x2::linked_table::remove<address, UserCetusLockup>(&mut arg2.paricipants_position_mapping, v2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<u64>(&v3.lockup_weeks)) {
                let v5 = *0x1::vector::borrow<u64>(&v3.lockup_weeks, v4);
                if (!0x2::table::contains<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v3.nft_positions, v5)) {
                    v4 = v4 + 1;
                    continue
                };
                let v6 = 0x2::table::remove<u64, CetusPositionBreakdown>(&mut v3.position_breakdown, v5);
                arg2.total_weighted_units = arg2.total_weighted_units - v6.weighted_units;
                v3.total_user_weighted_units = v3.total_user_weighted_units - v6.weighted_units;
                let v7 = &mut v6;
                let v8 = remove_liquidity_from_cetus<T0, T1>(v2, arg0, arg1, v5, arg2, arg4, arg5, arg6, 0x2::table::remove<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v3.nft_positions, v5), v7, arg7);
                arg2.total_weighted_units = arg2.total_weighted_units + v8;
                v3.total_user_weighted_units = v3.total_user_weighted_units + v8;
                0x2::table::add<u64, CetusPositionBreakdown>(&mut v3.position_breakdown, v5, v6);
                v4 = v4 + 1;
            };
            0x2::linked_table::push_back<address, UserCetusLockup>(&mut arg2.paricipants_position_mapping, v2, v3);
            0x2::linked_table::push_back<address, bool>(&mut arg2.liquidity_extracted_bool, v2, true);
            v0 = *0x2::linked_table::next<address, UserCetusLockup>(&arg2.paricipants_position_mapping, v2);
            v1 = v1 + 1;
        };
    }

    public fun get_user_position<T0, T1>(arg0: &0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::HiveProfile, arg1: &LockdropForPool<T0, T1>) : (vector<u64>, vector<u128>, vector<u64>, vector<u128>, vector<u64>, u128, u64) {
        let v0 = 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::borrow_from_profile<UserCetusHivePosition>(arg0, 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap));
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u128>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v0.lockup_weeks)) {
            let v6 = 0x2::table::borrow<u64, Receipt>(&v0.lockup_receipts, *0x1::vector::borrow<u64>(&v0.lockup_weeks, v5));
            0x1::vector::push_back<u128>(&mut v1, v6.position_liquidity);
            0x1::vector::push_back<u64>(&mut v2, v6.unlock_timestamp);
            let v7 = v6.weighted_units;
            0x1::vector::push_back<u128>(&mut v3, v7);
            0x1::vector::push_back<u64>(&mut v4, calculate_hive_rewards(v7, arg1.total_weighted_units, arg1.hive_incentives));
            v5 = v5 + 1;
        };
        (v0.lockup_weeks, v1, v2, v3, v4, v0.total_liquidity_locked, calculate_hive_rewards(v0.total_weighted_units, arg1.total_weighted_units, arg1.hive_incentives))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_attack_on_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x359d15f9d92be81be90194003b1d8fea72c3da8b6cafd14e271e69b596e2c371::config::HiveEntryCap, arg2: 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::ProfileDofOwnershipCapability, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &CetusAttackConfig, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : address {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::coin::into_balance<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>(arg6);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = LockdropForPool<T0, T1>{
            id                           : v1,
            identifer                    : arg5,
            user_profile_access_cap      : arg2,
            paricipants_position_mapping : 0x2::linked_table::new<address, UserCetusLockup>(arg8),
            last_liq_extracted_for_user  : 0x1::option::none<address>(),
            liquidity_extracted_bool     : 0x2::linked_table::new<address, bool>(arg8),
            total_weighted_units         : 0,
            total_hive_incentives        : 0x2::balance::split<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>(&mut v0, arg7),
            hive_incentives              : arg7,
            total_positions_liquidity    : 0,
            x_total_liquidity_withdrawn  : 0,
            y_total_liquidity_withdrawn  : 0,
            x_avail_liquidity_bal        : 0x2::balance::zero<T0>(),
            y_avail_liquidity_bal        : 0x2::balance::zero<T1>(),
            x_total_fee_withdrawn        : 0,
            y_total_fee_withdrawn        : 0,
            x_fee_avail_bal              : 0x2::balance::zero<T0>(),
            y_fee_avail_bal              : 0x2::balance::zero<T1>(),
            total_sui_earned             : 0,
            total_cetus_earned           : 0,
            sui_earned_bal               : 0x2::balance::zero<0x2::sui::SUI>(),
            cetus_earned_bal             : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
        };
        0x359d15f9d92be81be90194003b1d8fea72c3da8b6cafd14e271e69b596e2c371::coin_helper::destroy_or_transfer_balance<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>(v0, 0x2::tx_context::sender(arg8), arg8);
        0x2::transfer::share_object<LockdropForPool<T0, T1>>(v3);
        let v4 = PoolForVampireAttackOnCetusKrafted<T0, T1>{
            pool_addr       : v2,
            hive_incentives : arg7,
        };
        0x2::event::emit<PoolForVampireAttackOnCetusKrafted<T0, T1>>(v4);
        v2
    }

    public entry fun initialize_cetus_attack(arg0: &0x2::clock::Clock, arg1: &0x359d15f9d92be81be90194003b1d8fea72c3da8b6cafd14e271e69b596e2c371::config::HiveEntryCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : address {
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
            nft_positions             : 0x2::table::new<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0),
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

    fun kraft_cetus_receipt(arg0: &mut UserCetusHivePosition, arg1: u64, arg2: u128, arg3: u128, arg4: u64) {
        let v0 = Receipt{
            weeks_locked_for   : arg1,
            unlock_timestamp   : arg4,
            position_liquidity : arg2,
            weighted_units     : arg3,
        };
        0x1::vector::push_back<u64>(&mut arg0.lockup_weeks, arg1);
        0x2::table::add<u64, Receipt>(&mut arg0.lockup_receipts, arg1, v0);
    }

    fun remove_liquidity_from_cetus<T0, T1>(arg0: address, arg1: &0x2::clock::Clock, arg2: &CetusAttackConfig, arg3: u64, arg4: &mut LockdropForPool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg9: &mut CetusPositionBreakdown, arg10: &0x2::tx_context::TxContext) : u128 {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg5, arg6, &arg8, true);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x2::sui::SUI>(arg5, arg6, &arg8, arg7, true, arg1);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg5, arg6, &arg8, arg7, true, arg1);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg8);
        let v7 = calculate_weighted_units(v6, arg3, arg2);
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg5, arg6, &mut arg8, v6, arg1);
        let v10 = v9;
        let v11 = v8;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg5, arg6, arg8);
        arg4.total_positions_liquidity = arg4.total_positions_liquidity - arg9.position_liquidity + v6;
        arg9.position_liquidity = v6;
        arg9.weighted_units = v7;
        arg9.x_withdrawn = 0x2::balance::value<T0>(&v11);
        arg9.y_withdrawn = 0x2::balance::value<T1>(&v10);
        arg9.fee_earned_x = 0x2::balance::value<T0>(&v3);
        arg9.fee_earned_y = 0x2::balance::value<T1>(&v2);
        arg9.sui_earned = 0x2::balance::value<0x2::sui::SUI>(&v4);
        arg9.cetus_earned = 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v5);
        arg4.x_total_liquidity_withdrawn = arg4.x_total_liquidity_withdrawn + 0x2::balance::value<T0>(&v11);
        arg4.y_total_liquidity_withdrawn = arg4.y_total_liquidity_withdrawn + 0x2::balance::value<T1>(&v10);
        0x2::balance::join<T0>(&mut arg4.x_avail_liquidity_bal, v11);
        0x2::balance::join<T1>(&mut arg4.y_avail_liquidity_bal, v10);
        arg4.x_total_fee_withdrawn = arg4.x_total_fee_withdrawn + 0x2::balance::value<T0>(&v3);
        arg4.y_total_fee_withdrawn = arg4.y_total_fee_withdrawn + 0x2::balance::value<T1>(&v2);
        0x2::balance::join<T0>(&mut arg4.x_fee_avail_bal, v3);
        0x2::balance::join<T1>(&mut arg4.y_fee_avail_bal, v2);
        arg4.total_sui_earned = arg4.total_sui_earned + 0x2::balance::value<0x2::sui::SUI>(&v4);
        arg4.total_cetus_earned = arg4.total_cetus_earned + 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.sui_earned_bal, v4);
        0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg4.cetus_earned_bal, v5);
        let v12 = CetusPositionDestroyed<T0, T1>{
            user_addr          : arg0,
            lockup_weeks       : arg3,
            x_withdrawn        : arg9.x_withdrawn,
            y_withdrawn        : arg9.y_withdrawn,
            fee_earned_x       : arg9.fee_earned_x,
            fee_earned_y       : arg9.fee_earned_y,
            sui_earned         : arg9.sui_earned,
            cetus_earned       : arg9.cetus_earned,
            position_liquidity : arg9.position_liquidity,
        };
        0x2::event::emit<CetusPositionDestroyed<T0, T1>>(v12);
        v7
    }

    public fun simulate_stake_cetus_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &CetusAttackConfig, arg2: &mut LockdropForPool<T0, T1>, arg3: u128, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::clock::timestamp_ms(arg0);
        if (arg4 < arg1.min_lock_duration || arg4 > arg1.max_lock_duration) {
            return 0
        };
        let v0 = calculate_weighted_units(arg3, arg4, arg1);
        calculate_hive_rewards(v0, arg2.total_weighted_units + v0, arg2.hive_incentives)
    }

    public fun stake_cetus_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x359d15f9d92be81be90194003b1d8fea72c3da8b6cafd14e271e69b596e2c371::config::HiveEntryCap, arg2: &CetusAttackConfig, arg3: &mut LockdropForPool<T0, T1>, arg4: &mut 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::HiveProfile, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::clock::timestamp_ms(arg0);
        let (v0, v1, _, v3) = 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::get_profile_meta_info(arg4);
        assert!(arg6 >= arg2.min_lock_duration && arg6 <= arg2.max_lock_duration, 9806);
        let v4 = if (0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::exists_for_profile(arg4, 0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::get_profile_dof_capability_identifier(&arg3.user_profile_access_cap))) {
            0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::entry_remove_from_profile<UserCetusHivePosition>(&arg3.user_profile_access_cap, arg4, arg7)
        } else {
            UserCetusHivePosition{id: 0x2::object::new(arg7), lockup_weeks: 0x1::vector::empty<u64>(), lockup_receipts: 0x2::table::new<u64, Receipt>(arg7), total_liquidity_locked: 0, total_weighted_units: 0}
        };
        if (!0x2::linked_table::contains<address, UserCetusLockup>(&arg3.paricipants_position_mapping, v0)) {
            let v5 = kraft_cetus_lockup(arg7);
            0x2::linked_table::push_back<address, UserCetusLockup>(&mut arg3.paricipants_position_mapping, v0, v5);
        };
        assert!(!0x1::vector::contains<u64>(&v4.lockup_weeks, &arg6), 9816);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg5);
        let v7 = arg2.init_timestamp + arg2.deposit_window + arg2.withdrawal_window + arg6 * 604800000000;
        let v8 = calculate_weighted_units(v6, arg6, arg2);
        let v9 = &mut v4;
        kraft_cetus_receipt(v9, arg6, v6, v8, v7);
        let v10 = 0x2::linked_table::remove<address, UserCetusLockup>(&mut arg3.paricipants_position_mapping, v0);
        0x1::vector::push_back<u64>(&mut v10.lockup_weeks, arg6);
        0x2::table::add<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v10.nft_positions, arg6, arg5);
        let v11 = kraft_cetus_position_breakdown();
        v11.position_liquidity = v6;
        v11.weighted_units = v8;
        0x2::table::add<u64, CetusPositionBreakdown>(&mut v10.position_breakdown, arg6, v11);
        0x2::linked_table::push_back<address, UserCetusLockup>(&mut arg3.paricipants_position_mapping, v0, v10);
        arg3.total_weighted_units = arg3.total_weighted_units + v8;
        v4.total_weighted_units = v4.total_weighted_units + v8;
        v4.total_liquidity_locked = v4.total_liquidity_locked + v6;
        let v12 = calculate_hive_rewards(v4.total_weighted_units, arg3.total_weighted_units, arg3.hive_incentives);
        let v13 = CetusPositionLocked<T0, T1>{
            user_profile                   : v0,
            username                       : v1,
            user_addr                      : v3,
            lockup_weeks                   : arg6,
            liquidity_locked               : v6,
            unlock_timestamp               : v7,
            increase_in_weighted_units     : v8,
            total_liquidity_locked         : v4.total_liquidity_locked,
            total_user_weighted_units      : v4.total_weighted_units,
            expected_hive_rewards_increase : v12 - calculate_hive_rewards(v4.total_weighted_units, arg3.total_weighted_units, arg3.hive_incentives),
            total_user_exp_hive_rewards    : v12,
        };
        0x2::event::emit<CetusPositionLocked<T0, T1>>(v13);
        0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive_profile::entry_add_to_profile<UserCetusHivePosition>(&arg3.user_profile_access_cap, arg4, v4, arg7);
        v12
    }

    public fun transfer_liquidity_from_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x359d15f9d92be81be90194003b1d8fea72c3da8b6cafd14e271e69b596e2c371::config::HiveEntryCap, arg2: &CetusAttackConfig, arg3: &mut LockdropForPool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : (u128, u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, 0x2::balance::Balance<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>) {
        0x2::clock::timestamp_ms(arg0);
        (arg3.total_positions_liquidity, arg3.total_weighted_units, 0x2::balance::withdraw_all<T0>(&mut arg3.x_avail_liquidity_bal), 0x2::balance::withdraw_all<T1>(&mut arg3.y_avail_liquidity_bal), 0x2::balance::withdraw_all<T0>(&mut arg3.x_fee_avail_bal), 0x2::balance::withdraw_all<T1>(&mut arg3.y_fee_avail_bal), 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg3.sui_earned_bal), 0x2::balance::withdraw_all<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg3.cetus_earned_bal), 0x2::balance::withdraw_all<0x293d13428cdbdbe3904c6479843e53b5f77ba055a0bc8423613bc59a42e5b1ba::hive::HIVE>(&mut arg3.total_hive_incentives))
    }

    // decompiled from Move bytecode v6
}

