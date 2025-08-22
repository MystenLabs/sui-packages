module 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2 {
    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SoftLocker has store, key {
        id: 0x2::object::UID,
        locker_cap: 0x1::option::Option<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>,
        version: u64,
        admins: 0x2::vec_set::VecSet<address>,
        staked_positions: 0x2::object_table::ObjectTable<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>,
        periods_blocking: vector<u64>,
        periods_post_lockdown: vector<u64>,
        pause: bool,
        bag: 0x2::bag::Bag,
    }

    struct SoftLockedPosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        tranche_id: 0x2::object::ID,
        start_lock_time: u64,
        expiration_time: u64,
        full_unlocking_time: u64,
        profitability: u64,
        last_reward_claim_epoch: u64,
        last_growth_inside: u128,
        accumulated_amount_earned: u64,
        earned_epoch: 0x2::table::Table<u64, u64>,
        lock_liquidity_info: LockLiquidityInfo,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
    }

    struct LockLiquidityInfo has store {
        total_lock_liquidity: u128,
        current_lock_liquidity: u128,
        last_remove_liquidity_time: u64,
    }

    struct InitLockerEvent has copy, drop {
        locker_id: 0x2::object::ID,
    }

    struct UpdateLockPeriodsEvent has copy, drop {
        locker_id: 0x2::object::ID,
        periods_blocking: vector<u64>,
        periods_post_lockdown: vector<u64>,
    }

    struct LockerPauseEvent has copy, drop {
        locker_id: 0x2::object::ID,
        pause: bool,
    }

    struct CreateLockPositionEvent has copy, drop {
        lock_position_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tranche_id: 0x2::object::ID,
        total_lock_liquidity: u128,
        start_lock_time: u64,
        expiration_time: u64,
        full_unlocking_time: u64,
        profitability: u64,
        last_reward_claim_epoch: u64,
        last_growth_inside: u128,
        remainder_a: u64,
        remainder_b: u64,
    }

    struct UnlockPositionEvent has copy, drop {
        lock_position_id: 0x2::object::ID,
    }

    struct EarlyUnlockPositionEvent has copy, drop {
        lock_position_id: 0x2::object::ID,
    }

    struct UpdateLockLiquidityEvent has copy, drop {
        lock_position_id: 0x2::object::ID,
        current_lock_liquidity: u128,
        last_remove_liquidity_time: u64,
    }

    struct SplitPositionEvent has copy, drop {
        lock_position_id: 0x2::object::ID,
        new_lock_position_id: 0x2::object::ID,
        share_first_part: u64,
        new_total_lock_liquidity: u128,
        new_current_lock_liquidity: u128,
        new_last_growth_inside: u128,
        new_accumulated_amount_earned: u64,
        remainder_a: u64,
        remainder_b: u64,
    }

    struct ChangeRangePositionEvent has copy, drop {
        lock_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        new_lock_liquidity: u128,
        new_tick_lower: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        new_tick_upper: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        new_last_growth_inside: u128,
        new_accumulated_amount_earned: u64,
        new_total_lock_liquidity: u128,
        new_current_lock_liquidity: u128,
        remainder_a: u64,
        remainder_b: u64,
    }

    struct CollectRewardsEvent has copy, drop {
        lock_position_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        claim_epoch: u64,
        income: u64,
        reward_balance: u64,
    }

    struct FirstClaimInEpochEvent has copy, drop {
        last_growth_inside: u128,
        earned_amount_calc: u64,
        last_reward_claim_epoch: u64,
        next_reward_claim_epoch: u64,
    }

    struct MigrateLockPositionEvent has copy, drop {
        lock_position_id_v1: 0x2::object::ID,
        lock_position_id_v2: 0x2::object::ID,
        position_id: 0x2::object::ID,
        total_lock_liquidity: u128,
        last_growth_inside: u128,
    }

    public fun get_lock_periods(arg0: &SoftLocker) : (vector<u64>, vector<u64>) {
        (arg0.periods_blocking, arg0.periods_post_lockdown)
    }

    public fun get_locked_position_id<T0, T1>(arg0: &SoftLockedPosition<T0, T1>) : 0x2::object::ID {
        arg0.position_id
    }

    public fun get_profitability<T0, T1>(arg0: &SoftLockedPosition<T0, T1>) : u64 {
        arg0.profitability
    }

    public fun lock_position_migrate<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLocker, arg3: &mut SoftLocker, arg4: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg6: 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : SoftLockedPosition<T0, T1> {
        checked_package_version(arg3);
        assert!(!arg3.pause, 916023534273428375);
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::check_gauger_pool<T0, T1>(arg4, arg5), 9578252764818432);
        assert!(!0x2::object_table::contains<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&arg3.staked_positions, 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::get_locked_position_id<T0, T1>(&arg6)), 9387246576346433);
        let v0 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let (v1, v2, v3, v4, v5, v6) = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::get_lock_position_info_for_migrate<T0, T1>(&mut arg6);
        let v7 = LockLiquidityInfo{
            total_lock_liquidity       : 0,
            current_lock_liquidity     : 0,
            last_remove_liquidity_time : 0,
        };
        let v8 = SoftLockedPosition<T0, T1>{
            id                        : 0x2::object::new(arg8),
            position_id               : 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::get_locked_position_id<T0, T1>(&arg6),
            tranche_id                : v1,
            start_lock_time           : v2,
            expiration_time           : v3,
            full_unlocking_time       : v4,
            profitability             : 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::get_profitability<T0, T1>(&arg6),
            last_reward_claim_epoch   : 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_start(v0),
            last_growth_inside        : 0,
            accumulated_amount_earned : 0,
            earned_epoch              : 0x2::table::new<u64, u64>(arg8),
            lock_liquidity_info       : v7,
            coin_a                    : v5,
            coin_b                    : v6,
        };
        let v9 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::lock_position_migrate<T0, T1>(arg2, arg6, arg7, arg8);
        let v10 = 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&v9);
        v8.lock_liquidity_info.total_lock_liquidity = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v9);
        v8.lock_liquidity_info.current_lock_liquidity = v8.lock_liquidity_info.total_lock_liquidity;
        let (v11, v12) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::collect_fee<T0, T1>(arg0, arg5, &v9, true);
        let v13 = v12;
        let v14 = v11;
        if (0x2::balance::value<T0>(&v14) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v14, arg8), 0x2::tx_context::sender(arg8));
        } else {
            0x2::balance::destroy_zero<T0>(v14);
        };
        if (0x2::balance::value<T1>(&v13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v13, arg8), 0x2::tx_context::sender(arg8));
        } else {
            0x2::balance::destroy_zero<T1>(v13);
        };
        v8.last_growth_inside = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::get_current_growth_inside<T0, T1>(arg4, arg5, v10, v0);
        0x2::object_table::add<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg3.staked_positions, v10, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg1, arg4, arg5, v9, arg7, arg8));
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::lock_position<T0, T1>(arg4, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg3.locker_cap), v10);
        let v15 = MigrateLockPositionEvent{
            lock_position_id_v1  : 0x2::object::id<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&arg6),
            lock_position_id_v2  : 0x2::object::id<SoftLockedPosition<T0, T1>>(&v8),
            position_id          : v10,
            total_lock_liquidity : v8.lock_liquidity_info.total_lock_liquidity,
            last_growth_inside   : v8.last_growth_inside,
        };
        0x2::event::emit<MigrateLockPositionEvent>(v15);
        v8
    }

    public fun pause(arg0: &SoftLocker) : bool {
        arg0.pause
    }

    public fun add_admin(arg0: &SuperAdminCap, arg1: &mut SoftLocker, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        check_admin(arg1, 0x2::tx_context::sender(arg3));
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &arg2), 9630793046376343);
        0x2::vec_set::insert<address>(&mut arg1.admins, arg2);
    }

    fun add_liquidity_by_lock_position<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut SoftLockedPosition<T0, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg5: &0x2::clock::Clock) {
        let (v0, v1) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::tick_range(arg4);
        let (v2, v3, v4) = if (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::gte(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), v1) || 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::gt(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), v0) && 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::lt(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::sub(v1, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2)), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::sub(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), v0))) {
            if (0x2::balance::value<T1>(&arg3.coin_b) == 0) {
                return
            };
            let (v5, v6, v7) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(v0, v1, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T1>(&arg3.coin_b), false);
            let (v8, v9, v10) = if (v6 > 0x2::balance::value<T0>(&arg3.coin_a)) {
                if (0x2::balance::value<T0>(&arg3.coin_a) == 0) {
                    return
                };
                0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(v0, v1, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T0>(&arg3.coin_a), true)
            } else {
                (v5, v6, v7)
            };
            (v9, v10, v8)
        } else {
            if (0x2::balance::value<T0>(&arg3.coin_a) == 0) {
                return
            };
            let (v11, v12, v13) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(v0, v1, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T0>(&arg3.coin_a), true);
            let (v14, v15, v16) = if (v13 > 0x2::balance::value<T1>(&arg3.coin_b)) {
                if (0x2::balance::value<T1>(&arg3.coin_b) == 0) {
                    return
                };
                0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(v0, v1, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T1>(&arg3.coin_b), false)
            } else {
                (v11, v12, v13)
            };
            (v15, v16, v14)
        };
        let v17 = if (0x2::balance::value<T0>(&arg3.coin_a) >= v2) {
            if (0x2::balance::value<T1>(&arg3.coin_b) >= v3) {
                v4 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v17) {
            let (v18, v19) = add_liquidity_internal<T0, T1>(arg0, arg1, arg2, arg4, 0x2::balance::split<T0>(&mut arg3.coin_a, v2), 0x2::balance::split<T1>(&mut arg3.coin_b, v3), v4, arg5);
            0x2::balance::join<T0>(&mut arg3.coin_a, v18);
            0x2::balance::join<T1>(&mut arg3.coin_b, v19);
        };
    }

    fun add_liquidity_by_lock_position_with_swap_internal<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut SoftLockedPosition<T0, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg6: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg7: &0x2::clock::Clock) {
        let (v0, v1) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::tick_range(arg4);
        if (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::gte(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), v0) && 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::lt(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), v1)) {
            if (0x2::balance::value<T1>(&arg3.coin_b) == 0 && 0x2::balance::value<T0>(&arg3.coin_a) > 2) {
                let (v2, v3, v4) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, 0x2::balance::value<T0>(&arg3.coin_a) / 2, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::min_sqrt_price(), arg5, arg6, arg7);
                let v5 = v4;
                0x2::balance::join<T0>(&mut arg3.coin_a, v2);
                0x2::balance::join<T1>(&mut arg3.coin_b, v3);
                0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut arg3.coin_a, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T0, T1>(&v5)), 0x2::balance::zero<T1>(), v5);
            };
            if (0x2::balance::value<T0>(&arg3.coin_a) == 0 && 0x2::balance::value<T1>(&arg3.coin_b) > 2) {
                let (v6, v7, v8) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, 0x2::balance::value<T1>(&arg3.coin_b) / 2, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::max_sqrt_price(), arg5, arg6, arg7);
                let v9 = v8;
                0x2::balance::join<T1>(&mut arg3.coin_b, v7);
                0x2::balance::join<T0>(&mut arg3.coin_a, v6);
                0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3.coin_b, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T0, T1>(&v9)), v9);
            };
        };
        add_liquidity_by_lock_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
    }

    fun add_liquidity_internal<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u128, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7);
        let (v1, v2) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity_pay_amount<T0, T1>(&v0);
        let v3 = 0x2::balance::value<T0>(&arg4);
        let v4 = v3;
        let v5 = 0x2::balance::value<T1>(&arg5);
        let v6 = v5;
        let v7 = 0x2::balance::zero<T0>();
        if (v1 < v3) {
            0x2::balance::join<T0>(&mut v7, 0x2::balance::split<T0>(&mut arg4, v3 - v1));
            v4 = 0x2::balance::value<T0>(&arg4);
        };
        let v8 = 0x2::balance::zero<T1>();
        if (v2 < v5) {
            0x2::balance::join<T1>(&mut v8, 0x2::balance::split<T1>(&mut arg5, v5 - v2));
            v6 = 0x2::balance::value<T1>(&arg5);
        };
        assert!(v1 == v4, 95346237427834273);
        assert!(v2 == v6, 92368340637234706);
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_add_liquidity<T0, T1>(arg0, arg2, arg4, arg5, v0);
        (v7, v8)
    }

    fun calculate_liquidity_split(arg0: u128, arg1: u64) : (u128, u128) {
        assert!(arg1 <= 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::lock_liquidity_share_denom(), 902354235823942382);
        let v0 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(arg0, (arg1 as u128), (0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::lock_liquidity_share_denom() as u128));
        (v0, arg0 - v0)
    }

    fun calculate_remainder_coin_split(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::lock_liquidity_share_denom(), 902354235823942382);
        0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(arg0, ((0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::lock_liquidity_share_denom() - arg1) as u64), (0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::lock_liquidity_share_denom() as u64))
    }

    public fun change_tick_range<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg4: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg5: &mut SoftLocker, arg6: &mut SoftLockedPosition<T0, T1>, arg7: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg8: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg9: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg10: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg11: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg12: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        checked_package_version(arg5);
        assert!(!arg5.pause, 916023534273428375);
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::check_gauger_pool<T0, T1>(arg7, arg8), 9578252764818432);
        assert!(0x2::clock::timestamp_ms(arg13) / 1000 < arg6.full_unlocking_time, 93297692597493433);
        let v0 = 0x1::type_name::get<T3>();
        assert!(&v0 == 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::borrow_current_epoch_o_sail<T2>(arg2), 9435974578489789);
        let (v1, _) = get_earned_amount_position<T0, T1, T3>(arg7, arg8, arg6, arg6.last_growth_inside, arg13);
        let v3 = claim_position_reward_for_staking<T0, T1, T2, T3>(arg5, arg2, arg4, arg1, arg7, arg8, arg6, arg13, arg14);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::unlock_position<T0, T1>(arg7, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg5.locker_cap), arg6.position_id);
        let v4 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::withdraw_position_by_locker<T0, T1>(arg7, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg5.locker_cap), arg8, 0x2::object_table::remove<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg5.staked_positions, arg6.position_id), arg13, arg14);
        let (v5, v6) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::tick_range(&v4);
        assert!(!0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::eq(arg11, v5) || !0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::eq(arg12, v6), 96203676234264517);
        let v7 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v4);
        let v8 = &mut v4;
        let (v9, v10) = remove_liquidity_and_collect_fee<T0, T1>(arg0, arg3, arg8, v8, v7, arg13);
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::close_position<T0, T1>(arg0, arg8, v4);
        let v11 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::open_position<T0, T1>(arg0, arg8, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(arg11), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(arg12), arg14);
        let v12 = 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&v11);
        let v13 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v7, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::get_sqrt_price_at_tick(v6) - 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::get_sqrt_price_at_tick(v5), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::get_sqrt_price_at_tick(arg12) - 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::get_sqrt_price_at_tick(arg11));
        0x2::balance::join<T0>(&mut arg6.coin_a, v9);
        0x2::balance::join<T1>(&mut arg6.coin_b, v10);
        let v14 = &mut v11;
        add_liquidity_by_lock_position<T0, T1>(arg0, arg3, arg8, arg6, v14, arg13);
        let v15 = if (0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v11) >= v13 || 0x2::balance::value<T0>(&arg6.coin_a) == 0 && 0x2::balance::value<T1>(&arg6.coin_b) == 0) {
            0
        } else {
            v13 - 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v11)
        };
        if (v15 > 0) {
            let (v16, v17) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_amount_by_liquidity(arg11, arg12, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg8), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg8), v15, true);
            let v18 = v17;
            let v19 = v16;
            if (0x2::balance::value<T1>(&arg6.coin_b) < v17 && 0x2::balance::value<T0>(&arg6.coin_a) < v16) {
                let (v20, v21, v22) = get_liquidity_by_amount_by_lock_position<T0, T1>(arg8, arg6, arg11, arg12);
                v18 = v22;
                v19 = v21;
                v15 = v20;
            };
            if (0x2::balance::value<T1>(&arg6.coin_b) > v18) {
                let v23 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::calculate_swap_result<T0, T1>(arg0, arg8, false, true, 0x2::balance::value<T1>(&arg6.coin_b) - v18);
                let v24 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::calculated_swap_result_amount_out(&v23);
                if (v24 + 0x2::balance::value<T0>(&arg6.coin_a) < v19) {
                    let (v25, v26, v27) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(arg11, arg12, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg8), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg8), v24 + 0x2::balance::value<T0>(&arg6.coin_a), true);
                    v18 = v27;
                    v19 = v26;
                    v15 = v25;
                };
            } else if (0x2::balance::value<T0>(&arg6.coin_a) > v19) {
                let v28 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::calculate_swap_result<T0, T1>(arg0, arg8, true, true, 0x2::balance::value<T0>(&arg6.coin_a) - v19);
                let v29 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::calculated_swap_result_amount_out(&v28);
                if (v29 + 0x2::balance::value<T1>(&arg6.coin_b) < v18) {
                    let (v30, v31, v32) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(arg11, arg12, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg8), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg8), v29 + 0x2::balance::value<T1>(&arg6.coin_b), false);
                    v18 = v32;
                    v19 = v31;
                    v15 = v30;
                };
            };
            if (v15 > 0) {
                let v33 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity<T0, T1>(arg0, arg3, arg8, &mut v11, v15, arg13);
                let (v34, v35) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity_pay_amount<T0, T1>(&v33);
                if (0x2::balance::value<T1>(&arg6.coin_b) > v18 || 0x2::balance::value<T0>(&arg6.coin_a) > v19) {
                    let (v36, v37, v38) = if (0x2::balance::value<T1>(&arg6.coin_b) > v18) {
                        let (v39, v40, v41) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap<T0, T1>(arg0, arg3, arg8, false, true, 0x2::balance::value<T1>(&arg6.coin_b) - v18, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::max_sqrt_price(), arg9, arg10, arg13);
                        let v42 = v41;
                        0x2::balance::join<T1>(&mut arg6.coin_b, v40);
                        0x2::balance::join<T0>(&mut arg6.coin_a, v39);
                        (v42, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg6.coin_b, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T0, T1>(&v42)))
                    } else {
                        let (v43, v44, v45) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap<T0, T1>(arg0, arg3, arg8, true, true, 0x2::balance::value<T0>(&arg6.coin_a) - v19, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::min_sqrt_price(), arg9, arg10, arg13);
                        let v46 = v45;
                        0x2::balance::join<T0>(&mut arg6.coin_a, v43);
                        0x2::balance::join<T1>(&mut arg6.coin_b, v44);
                        (v46, 0x2::balance::split<T0>(&mut arg6.coin_a, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T0, T1>(&v46)), 0x2::balance::zero<T1>())
                    };
                    assert!(0x2::balance::value<T0>(&arg6.coin_a) >= v19, 9259346230481212);
                    assert!(0x2::balance::value<T1>(&arg6.coin_b) >= v18, 9387240376820348);
                    0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap<T0, T1>(arg0, arg8, v37, v38, v36);
                };
                let v47 = 0x2::balance::split<T0>(&mut arg6.coin_a, v34);
                let v48 = 0x2::balance::split<T1>(&mut arg6.coin_b, v35);
                assert!(v34 == 0x2::balance::value<T0>(&v47), 95346237427834273);
                assert!(v35 == 0x2::balance::value<T1>(&v48), 92368340637234706);
                0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_add_liquidity<T0, T1>(arg0, arg8, v47, v48, v33);
            };
        };
        let v49 = &mut v11;
        add_liquidity_by_lock_position_with_swap_internal<T0, T1>(arg0, arg3, arg8, arg6, v49, arg9, arg10, arg13);
        let v50 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v11);
        arg6.position_id = v12;
        arg6.lock_liquidity_info.total_lock_liquidity = v50;
        arg6.lock_liquidity_info.current_lock_liquidity = v50;
        let (_, v52) = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::full_earned_for_type<T0, T1, T3>(arg7, arg8, arg6.position_id, 0, arg13);
        arg6.last_growth_inside = v52;
        arg6.accumulated_amount_earned = arg6.accumulated_amount_earned + v1;
        let v53 = ChangeRangePositionEvent{
            lock_position_id              : 0x2::object::id<SoftLockedPosition<T0, T1>>(arg6),
            new_position_id               : v12,
            new_lock_liquidity            : v50,
            new_tick_lower                : arg11,
            new_tick_upper                : arg12,
            new_last_growth_inside        : arg6.last_growth_inside,
            new_accumulated_amount_earned : arg6.accumulated_amount_earned,
            new_total_lock_liquidity      : arg6.lock_liquidity_info.total_lock_liquidity,
            new_current_lock_liquidity    : arg6.lock_liquidity_info.current_lock_liquidity,
            remainder_a                   : 0x2::balance::value<T0>(&arg6.coin_a),
            remainder_b                   : 0x2::balance::value<T1>(&arg6.coin_b),
        };
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::lock_position<T0, T1>(arg7, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg5.locker_cap), v12);
        0x2::object_table::add<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg5.staked_positions, v12, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg1, arg7, arg8, v11, arg13, arg14));
        0x2::event::emit<ChangeRangePositionEvent>(v53);
        v3
    }

    public fun check_admin(arg0: &SoftLocker, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg1), 9389469239702349);
    }

    public fun checked_package_version(arg0: &SoftLocker) {
        assert!(arg0.version == 1, 9346920730473042);
    }

    public fun claim_position_reward_for_staking<T0, T1, T2, T3>(arg0: &SoftLocker, arg1: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg3: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg4: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg6: &mut SoftLockedPosition<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::get_position_reward<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, 0x2::object_table::borrow<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&arg0.staked_positions, arg6.position_id), arg7, arg8)
    }

    public fun collect_reward<T0, T1, T2, T3, T4>(arg0: &SoftLocker, arg1: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg2: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T3>, arg3: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: &mut SoftLockedPosition<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T4> {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::check_gauger_pool<T0, T1>(arg3, arg4), 9578252764818432);
        assert!(0x1::type_name::get<T3>() != 0x1::type_name::get<T4>(), 9230764536453211);
        let v0 = arg5.full_unlocking_time - 1;
        get_rewards_internal<T0, T1, T2, T4>(arg1, arg3, arg4, arg5, v0, arg6, arg7)
    }

    public fun collect_reward_and_unlock_position<T0, T1, T2, T3, T4>(arg0: &mut SoftLocker, arg1: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg2: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T3>, arg3: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: SoftLockedPosition<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T4>) {
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::check_gauger_pool<T0, T1>(arg3, arg4), 9578252764818432);
        let v0 = &mut arg5;
        let v1 = collect_reward<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, v0, arg6, arg7);
        let (v2, v3, v4) = unlock_position<T0, T1>(arg0, arg5, arg3, arg6);
        (v2, v3, v4, v1)
    }

    public fun collect_reward_sail<T0, T1, T2, T3>(arg0: &SoftLocker, arg1: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg2: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T3>, arg3: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: &mut SoftLockedPosition<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::check_gauger_pool<T0, T1>(arg3, arg4), 9578252764818432);
        let v0 = arg5.full_unlocking_time - 1;
        let v1 = get_rewards_internal<T0, T1, T2, T3>(arg1, arg3, arg4, arg5, v0, arg6, arg7);
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::create_lock<T3>(arg2, 0x2::coin::from_balance<T3>(v1, arg7), 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::max_lock_time() / 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::day(), true, arg6, arg7);
    }

    public fun collect_reward_sail_and_unlock_position<T0, T1, T2, T3>(arg0: &mut SoftLocker, arg1: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg2: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T3>, arg3: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: SoftLockedPosition<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg5;
        collect_reward_sail<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v0, arg6, arg7);
        unlock_position<T0, T1>(arg0, arg5, arg3, arg6)
    }

    public fun create_locker(arg0: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SuperAdminCap, arg1: &0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLocker, arg2: &0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::CreateCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::get_init_locker_v2(arg0), 9329703470234099);
        0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::init_locker_v2(arg0);
        let (v0, v1) = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::get_lock_periods(arg1);
        let v2 = SoftLocker{
            id                    : 0x2::object::new(arg3),
            locker_cap            : 0x1::option::none<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(),
            version               : 1,
            admins                : 0x2::vec_set::from_keys<address>(*0x2::vec_set::keys<address>(0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::admins(arg1))),
            staked_positions      : 0x2::object_table::new<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(arg3),
            periods_blocking      : v0,
            periods_post_lockdown : v1,
            pause                 : 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::pause(arg1),
            bag                   : 0x2::bag::new(arg3),
        };
        let v3 = 0x2::object::id<SoftLocker>(&v2);
        let v4 = InitLockerEvent{locker_id: v3};
        0x2::event::emit<InitLockerEvent>(v4);
        0x1::option::fill<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&mut v2.locker_cap, 0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::create_locker_cap(arg2, arg3));
        v2.periods_blocking = v0;
        v2.periods_post_lockdown = v1;
        let v5 = UpdateLockPeriodsEvent{
            locker_id             : v3,
            periods_blocking      : v0,
            periods_post_lockdown : v1,
        };
        0x2::event::emit<UpdateLockPeriodsEvent>(v5);
        0x2::transfer::share_object<SoftLocker>(v2);
        let v6 = SuperAdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<SuperAdminCap>(v6, 0x2::tx_context::sender(arg3));
    }

    fun destroy<T0, T1>(arg0: SoftLockedPosition<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let SoftLockedPosition {
            id                        : v0,
            position_id               : _,
            tranche_id                : _,
            start_lock_time           : _,
            expiration_time           : _,
            full_unlocking_time       : _,
            profitability             : _,
            last_reward_claim_epoch   : _,
            last_growth_inside        : _,
            accumulated_amount_earned : _,
            earned_epoch              : v10,
            lock_liquidity_info       : v11,
            coin_a                    : v12,
            coin_b                    : v13,
        } = arg0;
        let LockLiquidityInfo {
            total_lock_liquidity       : _,
            current_lock_liquidity     : _,
            last_remove_liquidity_time : _,
        } = v11;
        0x2::table::drop<u64, u64>(v10);
        0x2::object::delete(v0);
        (v12, v13)
    }

    public fun early_unlock_position<T0, T1>(arg0: &mut SoftLocker, arg1: SoftLockedPosition<T0, T1>, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg3: &0x2::clock::Clock) : (0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 < arg1.full_unlocking_time, 98923745837578344);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::unlock_position<T0, T1>(arg2, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg0.locker_cap), arg1.position_id);
        let v0 = EarlyUnlockPositionEvent{lock_position_id: 0x2::object::id<SoftLockedPosition<T0, T1>>(&arg1)};
        let (v1, v2) = destroy<T0, T1>(arg1);
        0x2::event::emit<EarlyUnlockPositionEvent>(v0);
        (0x2::object_table::remove<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg0.staked_positions, arg1.position_id), v1, v2)
    }

    fun get_earned_amount_position<T0, T1, T2>(arg0: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg1: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: &SoftLockedPosition<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u128) {
        let (_, v1) = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::full_earned_for_type<T0, T1, T2>(arg0, arg1, arg2.position_id, arg3, arg4);
        let v2 = if (arg3 < v1) {
            (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v1 - arg3, arg2.lock_liquidity_info.current_lock_liquidity, 18446744073709551616) as u64)
        } else {
            0
        };
        (v2, v1)
    }

    fun get_liquidity_by_amount_by_lock_position<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg1: &SoftLockedPosition<T0, T1>, arg2: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg3: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) : (u128, u64, u64) {
        if (0x2::balance::value<T0>(&arg1.coin_a) == 0 && 0x2::balance::value<T1>(&arg1.coin_b) == 0) {
            return (0, 0, 0)
        };
        if (0x2::balance::value<T0>(&arg1.coin_a) > 0 && 0x2::balance::value<T0>(&arg1.coin_a) < 0x2::balance::value<T1>(&arg1.coin_b) || 0x2::balance::value<T1>(&arg1.coin_b) == 0) {
            0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg0), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg0), 0x2::balance::value<T0>(&arg1.coin_a), true)
        } else {
            0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg0), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg0), 0x2::balance::value<T1>(&arg1.coin_b), false)
        }
    }

    public fun get_locker_version(arg0: &SoftLocker) : u64 {
        arg0.version
    }

    public fun get_pool_reward<T0, T1, T2>(arg0: &SoftLocker, arg1: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg3: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: &SoftLockedPosition<T0, T1>, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::get_pool_reward<T0, T1, T2>(arg1, arg2, arg3, arg4, 0x2::object_table::borrow<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&arg0.staked_positions, arg5.position_id), arg6)
    }

    fun get_rewards_internal<T0, T1, T2, T3>(arg0: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg2: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut SoftLockedPosition<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        assert!(0x2::clock::timestamp_ms(arg5) / 1000 >= arg3.full_unlocking_time && 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_next(arg4) == 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_start(arg3.full_unlocking_time), 92352956173712842);
        let v0 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_start(arg4);
        let v1 = 0x1::type_name::get<T2>();
        assert!(&v1 == 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::get_osail_epoch(arg0, v0), 9307294987808056);
        assert!(!0x2::table::contains<u64, u64>(&arg3.earned_epoch, v0), 92352956173712842);
        let (v2, v3) = get_earned_amount_position<T0, T1, T2>(arg1, arg2, arg3, arg3.last_growth_inside, arg5);
        let v4 = v2 + arg3.accumulated_amount_earned;
        arg3.last_growth_inside = v3;
        arg3.accumulated_amount_earned = 0;
        0x2::table::add<u64, u64>(&mut arg3.earned_epoch, v0, v4);
        arg3.last_reward_claim_epoch = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_next(v0);
        if (v4 == 0) {
            return 0x2::balance::zero<T3>()
        };
        let v5 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(v4, arg3.profitability, 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::profitability_rate_denom());
        let v6 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::get_reward_balance<T3>(arg0, 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>>(arg2), arg3.tranche_id, 0x2::object::id<SoftLockedPosition<T0, T1>>(arg3), v5, v0, arg6);
        let v7 = CollectRewardsEvent{
            lock_position_id : 0x2::object::id<SoftLockedPosition<T0, T1>>(arg3),
            reward_type      : 0x1::type_name::get<T3>(),
            claim_epoch      : v0,
            income           : v5,
            reward_balance   : 0x2::balance::value<T3>(&v6),
        };
        0x2::event::emit<CollectRewardsEvent>(v7);
        v6
    }

    public fun get_unlock_time<T0, T1>(arg0: &SoftLockedPosition<T0, T1>) : (u64, u64) {
        (arg0.expiration_time, arg0.full_unlocking_time)
    }

    public fun is_admin(arg0: &SoftLocker, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_position_locked(arg0: &mut SoftLocker, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&arg0.staked_positions, arg1)
    }

    public fun lock_position<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: &mut SoftLocker, arg4: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg5: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg6: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg7: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : vector<SoftLockedPosition<T0, T1>> {
        checked_package_version(arg3);
        assert!(!arg3.pause, 916023534273428375);
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::check_gauger_pool<T0, T1>(arg5, arg6), 9578252764818432);
        assert!(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::is_staked(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::borrow_position_info(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::position_manager<T0, T1>(arg6), 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::position_id(&arg7))), 9387213431353484);
        assert!(!0x2::object_table::contains<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&arg3.staked_positions, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::position_id(&arg7)), 9387246576346433);
        assert!(arg8 < 0x1::vector::length<u64>(&arg3.periods_blocking), 938724654546442874);
        let v0 = 0x2::clock::timestamp_ms(arg9) / 1000;
        let v1 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_next(v0 + 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_to_seconds(*0x1::vector::borrow<u64>(&arg3.periods_blocking, arg8)));
        let v2 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::get_tranches(arg4, 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>>(arg6));
        assert!(0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTranche>(v2) > 0, 9823742374723842);
        let v3 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::get_current_growth_inside<T0, T1>(arg5, arg6, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::position_id(&arg7), v0);
        let v4 = 0x1::vector::empty<SoftLockedPosition<T0, T1>>();
        let v5 = 0x1::option::some<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(arg7);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTranche>(v2)) {
            if (0x1::option::is_none<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&v5)) {
                break
            };
            let v7 = 0x1::vector::borrow_mut<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTranche>(v2, v6);
            if (0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::is_filled(v7)) {
                v6 = v6 + 1;
                continue
            };
            let v8 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::get_duration_profitabilities(v7);
            assert!(0x1::vector::length<u64>(&v8) == 0x1::vector::length<u64>(&arg3.periods_blocking), 93877534345684724);
            let (v9, v10) = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::get_free_volume(v7);
            let v11 = if (v10) {
                0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_locker_utils::calculate_position_liquidity_in_token_a<T0, T1>(arg6, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::position_id(0x1::option::borrow<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&v5)))
            } else {
                0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_locker_utils::calculate_position_liquidity_in_token_b<T0, T1>(arg6, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::position_id(0x1::option::borrow<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&v5)))
            };
            let (v12, v13, v14, v15, v16) = if (v11 > v9) {
                let (v17, v18, v19, _, v21, v22) = split_position_internal<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, 0x1::option::extract<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut v5), (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v9, (0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::lock_liquidity_share_denom() as u128), v11) as u64), arg9, arg10);
                0x1::option::fill<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut v5, v19);
                0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::fill_tranches(v7, v9);
                (v17, v18, v21, v22, true)
            } else {
                0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::fill_tranches(v7, v11);
                let v23 = 0x1::option::extract<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut v5);
                (v23, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::info_liquidity(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::borrow_position_info(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::position_manager<T0, T1>(arg6), 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::position_id(&v23))), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), false)
            };
            let v24 = v12;
            let v25 = LockLiquidityInfo{
                total_lock_liquidity       : v13,
                current_lock_liquidity     : v13,
                last_remove_liquidity_time : 0,
            };
            let v26 = SoftLockedPosition<T0, T1>{
                id                        : 0x2::object::new(arg10),
                position_id               : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::position_id(&v24),
                tranche_id                : 0x2::object::id<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTranche>(v7),
                start_lock_time           : v0,
                expiration_time           : v1,
                full_unlocking_time       : v1 + 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_to_seconds(*0x1::vector::borrow<u64>(&arg3.periods_post_lockdown, arg8)),
                profitability             : *0x1::vector::borrow<u64>(&v8, arg8),
                last_reward_claim_epoch   : 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_start(v0),
                last_growth_inside        : v3,
                accumulated_amount_earned : 0,
                earned_epoch              : 0x2::table::new<u64, u64>(arg10),
                lock_liquidity_info       : v25,
                coin_a                    : 0x2::balance::zero<T0>(),
                coin_b                    : 0x2::balance::zero<T1>(),
            };
            0x2::balance::join<T0>(&mut v26.coin_a, v14);
            0x2::balance::join<T1>(&mut v26.coin_b, v15);
            let v27 = CreateLockPositionEvent{
                lock_position_id        : 0x2::object::id<SoftLockedPosition<T0, T1>>(&v26),
                position_id             : v26.position_id,
                tranche_id              : v26.tranche_id,
                total_lock_liquidity    : v26.lock_liquidity_info.total_lock_liquidity,
                start_lock_time         : v26.start_lock_time,
                expiration_time         : v26.expiration_time,
                full_unlocking_time     : v26.full_unlocking_time,
                profitability           : v26.profitability,
                last_reward_claim_epoch : v26.last_reward_claim_epoch,
                last_growth_inside      : v26.last_growth_inside,
                remainder_a             : 0x2::balance::value<T0>(&v26.coin_a),
                remainder_b             : 0x2::balance::value<T1>(&v26.coin_b),
            };
            0x2::event::emit<CreateLockPositionEvent>(v27);
            0x2::object_table::add<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg3.staked_positions, v26.position_id, v24);
            0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::lock_position<T0, T1>(arg5, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg3.locker_cap), v26.position_id);
            0x1::vector::push_back<SoftLockedPosition<T0, T1>>(&mut v4, v26);
            if (!v16) {
                break
            };
            let v28 = v6 + 1;
            v6 = v28;
            assert!(v28 < 0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTranche>(v2) || !0x1::option::is_none<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&v5), 92035925692467234);
        };
        assert!(0x1::option::is_none<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&v5), 92035925692467234);
        0x1::option::destroy_none<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(v5);
        v4
    }

    public fun locker_pause(arg0: &mut SoftLocker, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.pause = arg1;
        let v0 = LockerPauseEvent{
            locker_id : 0x2::object::id<SoftLocker>(arg0),
            pause     : arg1,
        };
        0x2::event::emit<LockerPauseEvent>(v0);
    }

    fun remove_liquidity_and_collect_fee<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg4: u128, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::collect_fee<T0, T1>(arg0, arg2, arg3, true);
        let (v2, v3) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::join<T0>(&mut v5, v0);
        0x2::balance::join<T1>(&mut v4, v1);
        (v5, v4)
    }

    public fun remove_lock_liquidity<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg4: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg5: &mut SoftLocker, arg6: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg7: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg8: SoftLockedPosition<T0, T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::coin::Coin<T3>) {
        checked_package_version(arg5);
        let v0 = 0x2::clock::timestamp_ms(arg9) / 1000;
        assert!(!arg5.pause, 916023534273428375);
        assert!(v0 >= arg8.expiration_time, 91204958347574966);
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::check_gauger_pool<T0, T1>(arg6, arg7), 9578252764818432);
        let v1 = 0x1::type_name::get<T3>();
        assert!(&v1 == 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::borrow_current_epoch_o_sail<T2>(arg2), 9435974578489789);
        let v2 = v0 >= arg8.full_unlocking_time;
        if (v2) {
            assert!(arg8.last_reward_claim_epoch >= arg8.full_unlocking_time, 912944864567454);
        };
        let v3 = if (v2) {
            arg8.lock_liquidity_info.current_lock_liquidity
        } else {
            if (arg8.lock_liquidity_info.last_remove_liquidity_time == 0) {
                arg8.lock_liquidity_info.last_remove_liquidity_time = arg8.expiration_time;
            };
            let v4 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::number_epochs_in_timestamp(v0 - arg8.lock_liquidity_info.last_remove_liquidity_time);
            assert!(v4 > 0, 91877547573637423);
            0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(arg8.lock_liquidity_info.total_lock_liquidity, (v4 as u128), (0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::number_epochs_in_timestamp(arg8.full_unlocking_time - arg8.expiration_time) as u128))
        };
        let v5 = v3;
        assert!(v3 > 0, 91877547573637423);
        if (v3 > arg8.lock_liquidity_info.current_lock_liquidity) {
            v5 = arg8.lock_liquidity_info.current_lock_liquidity;
        };
        if (!v2) {
            let (v6, v7) = get_earned_amount_position<T0, T1, T3>(arg6, arg7, &arg8, arg8.last_growth_inside, arg9);
            arg8.last_growth_inside = v7;
            arg8.accumulated_amount_earned = arg8.accumulated_amount_earned + v6;
        };
        let v8 = &mut arg8;
        let v9 = claim_position_reward_for_staking<T0, T1, T2, T3>(arg5, arg2, arg4, arg1, arg6, arg7, v8, arg9, arg10);
        let v10 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::withdraw_position_by_locker<T0, T1>(arg6, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg5.locker_cap), arg7, 0x2::object_table::remove<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg5.staked_positions, arg8.position_id), arg9, arg10);
        let (v11, v12) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::remove_liquidity<T0, T1>(arg0, arg3, arg7, &mut v10, v5, arg9);
        let v13 = v12;
        let v14 = v11;
        if (v2) {
            let (v15, v16) = unlock_position_internal<T0, T1>(arg5, arg8, arg6);
            0x2::balance::join<T0>(&mut v14, v15);
            0x2::balance::join<T1>(&mut v13, v16);
            0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::close_position<T0, T1>(arg0, arg7, v10);
        } else {
            0x2::object_table::add<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg5.staked_positions, arg8.position_id, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position_by_locker<T0, T1>(arg6, arg1, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg5.locker_cap), arg7, v10, arg9, arg10));
            arg8.lock_liquidity_info.current_lock_liquidity = arg8.lock_liquidity_info.current_lock_liquidity - v5;
            arg8.lock_liquidity_info.last_remove_liquidity_time = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common::epoch_start(v0);
            let v17 = UpdateLockLiquidityEvent{
                lock_position_id           : 0x2::object::id<SoftLockedPosition<T0, T1>>(&arg8),
                current_lock_liquidity     : arg8.lock_liquidity_info.current_lock_liquidity,
                last_remove_liquidity_time : arg8.lock_liquidity_info.last_remove_liquidity_time,
            };
            0x2::event::emit<UpdateLockLiquidityEvent>(v17);
            0x2::transfer::public_transfer<SoftLockedPosition<T0, T1>>(arg8, 0x2::tx_context::sender(arg10));
        };
        (v14, v13, v9)
    }

    public fun remove_lock_liquidity_save<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg4: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg5: &mut SoftLocker, arg6: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg7: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg8: SoftLockedPosition<T0, T1>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::coin::Coin<T3>) {
        let (v0, v1, v2) = remove_lock_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        let v3 = v1;
        let v4 = v0;
        assert!(0x2::balance::value<T0>(&v4) >= arg9, 9367234807236103);
        assert!(0x2::balance::value<T1>(&v3) >= arg10, 9247240362830633);
        (v4, v3, v2)
    }

    public fun revoke_admin(arg0: &SuperAdminCap, arg1: &mut SoftLocker, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        check_admin(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_set::contains<address>(&arg1.admins, &arg2), 9630793046376343);
        0x2::vec_set::remove<address>(&mut arg1.admins, &arg2);
    }

    public fun split_position<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg4: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg5: &mut SoftLocker, arg6: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg7: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg8: SoftLockedPosition<T0, T1>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (SoftLockedPosition<T0, T1>, SoftLockedPosition<T0, T1>, 0x2::coin::Coin<T3>) {
        checked_package_version(arg5);
        assert!(!arg5.pause, 916023534273428375);
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::check_gauger_pool<T0, T1>(arg6, arg7), 9578252764818432);
        assert!(0x2::clock::timestamp_ms(arg10) / 1000 < arg8.full_unlocking_time, 93297692597493433);
        assert!(arg9 <= 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::lock_liquidity_share_denom() && arg9 > 0, 902354235823942382);
        let v0 = 0x1::type_name::get<T3>();
        assert!(&v0 == 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::borrow_current_epoch_o_sail<T2>(arg2), 9435974578489789);
        let (v1, v2) = get_earned_amount_position<T0, T1, T3>(arg6, arg7, &arg8, arg8.last_growth_inside, arg10);
        let v3 = &mut arg8;
        let v4 = claim_position_reward_for_staking<T0, T1, T2, T3>(arg5, arg2, arg4, arg1, arg6, arg7, v3, arg10, arg11);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::unlock_position<T0, T1>(arg6, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg5.locker_cap), arg8.position_id);
        let (v5, v6, v7, v8, v9, v10) = split_position_internal<T0, T1>(arg0, arg3, arg1, arg5, arg6, arg7, 0x2::object_table::remove<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg5.staked_positions, arg8.position_id), arg9, arg10, arg11);
        let v11 = v7;
        let v12 = v5;
        arg8.position_id = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::position_id(&v12);
        arg8.lock_liquidity_info.total_lock_liquidity = v6;
        arg8.lock_liquidity_info.current_lock_liquidity = v6;
        arg8.last_growth_inside = v2;
        let v13 = arg8.accumulated_amount_earned + v1;
        arg8.accumulated_amount_earned = (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((v13 as u128), (arg9 as u128), (0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::lock_liquidity_share_denom() as u128)) as u64);
        let v14 = LockLiquidityInfo{
            total_lock_liquidity       : v8,
            current_lock_liquidity     : v8,
            last_remove_liquidity_time : arg8.lock_liquidity_info.last_remove_liquidity_time,
        };
        let v15 = SoftLockedPosition<T0, T1>{
            id                        : 0x2::object::new(arg11),
            position_id               : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::position_id(&v11),
            tranche_id                : arg8.tranche_id,
            start_lock_time           : arg8.start_lock_time,
            expiration_time           : arg8.expiration_time,
            full_unlocking_time       : arg8.full_unlocking_time,
            profitability             : arg8.profitability,
            last_reward_claim_epoch   : arg8.last_reward_claim_epoch,
            last_growth_inside        : arg8.last_growth_inside,
            accumulated_amount_earned : v13 - arg8.accumulated_amount_earned,
            earned_epoch              : 0x2::table::new<u64, u64>(arg11),
            lock_liquidity_info       : v14,
            coin_a                    : 0x2::balance::split<T0>(&mut arg8.coin_a, calculate_remainder_coin_split(0x2::balance::value<T0>(&arg8.coin_a), arg9)),
            coin_b                    : 0x2::balance::split<T1>(&mut arg8.coin_b, calculate_remainder_coin_split(0x2::balance::value<T1>(&arg8.coin_b), arg9)),
        };
        0x2::balance::join<T0>(&mut v15.coin_a, v9);
        0x2::balance::join<T1>(&mut v15.coin_b, v10);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::lock_position<T0, T1>(arg6, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg5.locker_cap), arg8.position_id);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::lock_position<T0, T1>(arg6, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg5.locker_cap), v15.position_id);
        0x2::object_table::add<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg5.staked_positions, arg8.position_id, v12);
        0x2::object_table::add<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg5.staked_positions, v15.position_id, v11);
        let v16 = 0x2::object::id<SoftLockedPosition<T0, T1>>(&v15);
        let v17 = SplitPositionEvent{
            lock_position_id              : 0x2::object::id<SoftLockedPosition<T0, T1>>(&arg8),
            new_lock_position_id          : v16,
            share_first_part              : arg9,
            new_total_lock_liquidity      : arg8.lock_liquidity_info.total_lock_liquidity,
            new_current_lock_liquidity    : arg8.lock_liquidity_info.current_lock_liquidity,
            new_last_growth_inside        : arg8.last_growth_inside,
            new_accumulated_amount_earned : arg8.accumulated_amount_earned,
            remainder_a                   : 0x2::balance::value<T0>(&arg8.coin_a),
            remainder_b                   : 0x2::balance::value<T1>(&arg8.coin_b),
        };
        0x2::event::emit<SplitPositionEvent>(v17);
        let v18 = CreateLockPositionEvent{
            lock_position_id        : v16,
            position_id             : v15.position_id,
            tranche_id              : v15.tranche_id,
            total_lock_liquidity    : v15.lock_liquidity_info.total_lock_liquidity,
            start_lock_time         : v15.start_lock_time,
            expiration_time         : v15.expiration_time,
            full_unlocking_time     : v15.full_unlocking_time,
            profitability           : v15.profitability,
            last_reward_claim_epoch : v15.last_reward_claim_epoch,
            last_growth_inside      : v15.last_growth_inside,
            remainder_a             : 0x2::balance::value<T0>(&v15.coin_a),
            remainder_b             : 0x2::balance::value<T1>(&v15.coin_b),
        };
        0x2::event::emit<CreateLockPositionEvent>(v18);
        (arg8, v15, v4)
    }

    fun split_position_internal<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: &SoftLocker, arg4: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg6: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, u128, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::withdraw_position_by_locker<T0, T1>(arg4, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg3.locker_cap), arg5, arg6, arg8, arg9);
        let (v1, v2) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::tick_range(&v0);
        let (_, v4) = calculate_liquidity_split(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v0), arg7);
        let v5 = v4;
        let v6 = &mut v0;
        let (v7, v8) = remove_liquidity_and_collect_fee<T0, T1>(arg0, arg1, arg5, v6, v4, arg8);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0x2::balance::value<T0>(&v10);
        let v12 = 0x2::balance::value<T1>(&v9);
        let v13 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::open_position<T0, T1>(arg0, arg5, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(v1), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(v2), arg9);
        let (v14, v15) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_amount_by_liquidity(v1, v2, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg5), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg5), v4, true);
        let v16 = v15;
        if (v14 > v11) {
            let (v17, _, v19) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(v1, v2, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg5), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg5), v11, true);
            v16 = v19;
            v5 = v17;
        };
        if (v16 > v12) {
            let (v20, _, _) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(v1, v2, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg5), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg5), v12, false);
            v5 = v20;
        };
        let v23 = &mut v13;
        let (v24, v25) = add_liquidity_internal<T0, T1>(arg0, arg1, arg5, v23, v10, v9, v5, arg8);
        (0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg2, arg4, arg5, v0, arg8, arg9), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v0), 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg2, arg4, arg5, v13, arg8, arg9), v5, v24, v25)
    }

    public fun unlock_position<T0, T1>(arg0: &mut SoftLocker, arg1: SoftLockedPosition<T0, T1>, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg3: &0x2::clock::Clock) : (0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 >= arg1.full_unlocking_time, 98923745837578344);
        assert!(arg1.last_reward_claim_epoch >= arg1.full_unlocking_time, 912944864567454);
        let (v0, v1) = unlock_position_internal<T0, T1>(arg0, arg1, arg2);
        (0x2::object_table::remove<0x2::object::ID, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition>(&mut arg0.staked_positions, arg1.position_id), v0, v1)
    }

    fun unlock_position_internal<T0, T1>(arg0: &SoftLocker, arg1: SoftLockedPosition<T0, T1>, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::unlock_position<T0, T1>(arg2, 0x1::option::borrow<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&arg0.locker_cap), arg1.position_id);
        let v0 = UnlockPositionEvent{lock_position_id: 0x2::object::id<SoftLockedPosition<T0, T1>>(&arg1)};
        0x2::event::emit<UnlockPositionEvent>(v0);
        destroy<T0, T1>(arg1)
    }

    public fun update_lock_periods(arg0: &mut SoftLocker, arg1: vector<u64>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x1::vector::length<u64>(&arg1) > 0 && 0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2), 938724658124718472);
        arg0.periods_blocking = arg1;
        arg0.periods_post_lockdown = arg2;
        let v0 = UpdateLockPeriodsEvent{
            locker_id             : 0x2::object::id<SoftLocker>(arg0),
            periods_blocking      : arg1,
            periods_post_lockdown : arg2,
        };
        0x2::event::emit<UpdateLockPeriodsEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

