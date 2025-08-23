module 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1 {
    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
        init_locker_v2: bool,
    }

    struct SoftLocker has store, key {
        id: 0x2::object::UID,
        locker_cap: 0x1::option::Option<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>,
        version: u64,
        admins: 0x2::vec_set::VecSet<address>,
        positions: 0x2::object_table::ObjectTable<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>,
        periods_blocking: vector<u64>,
        periods_post_lockdown: vector<u64>,
        pause: bool,
        whitelisted_providers: 0x2::table::Table<address, bool>,
        ignore_whitelist_providers: bool,
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
        lock_liquidity_info: LockLiquidityInfo,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
    }

    struct LockLiquidityInfo has store {
        total_lock_liquidity: u128,
        current_lock_liquidity: u128,
        last_remove_liquidity_time: u64,
    }

    struct SplitPositionResult<phantom T0, phantom T1> has copy, drop {
        position_id: 0x2::object::ID,
        liquidity: u128,
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

    struct SetIgnoreWhitelistProvidersEvent has copy, drop {
        ignore_whitelist_providers: bool,
    }

    struct AddAddressToWhitelistProvidersEvent has copy, drop {
        address: address,
    }

    struct RemoveAddressFromWhitelistProvidersEvent has copy, drop {
        address: address,
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

    public fun add_addresses_to_whitelist(arg0: &mut SoftLocker, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, bool>(&arg0.whitelisted_providers, v1)) {
                0x2::table::add<address, bool>(&mut arg0.whitelisted_providers, v1, true);
                let v2 = AddAddressToWhitelistProvidersEvent{address: v1};
                0x2::event::emit<AddAddressToWhitelistProvidersEvent>(v2);
            };
            v0 = v0 + 1;
        };
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

    public fun add_liquidity_by_lock_position_with_swap<T0, T1>(arg0: &mut SoftLocker, arg1: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: &mut SoftLockedPosition<T0, T1>, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg6: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg7: &0x2::clock::Clock) {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg7) / 1000 < arg4.full_unlocking_time, 93297692597493433);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg0.positions, arg4.position_id);
        let v1 = &mut v0;
        add_liquidity_by_lock_position_with_swap_internal<T0, T1>(arg1, arg2, arg3, arg4, v1, arg5, arg6, arg7);
        0x2::object_table::add<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg0.positions, 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&v0), v0);
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

    public(friend) fun admins(arg0: &SoftLocker) : &0x2::vec_set::VecSet<address> {
        &arg0.admins
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

    public fun change_tick_range<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut SoftLocker, arg3: &mut SoftLockedPosition<T0, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg6: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg7: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg8: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg2);
        assert!(!arg2.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg9) / 1000 < arg3.full_unlocking_time, 93297692597493433);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg2.positions, arg3.position_id);
        let (v1, v2) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::tick_range(&v0);
        assert!(!0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::eq(arg7, v1) || !0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::eq(arg8, v2), 96203676234264517);
        let v3 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v0);
        let v4 = &mut v0;
        let (v5, v6) = remove_liquidity_and_collect_fee<T0, T1>(arg0, arg1, arg4, v4, v3, arg9);
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::close_position<T0, T1>(arg0, arg4, v0);
        let v7 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::open_position<T0, T1>(arg0, arg4, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(arg7), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(arg8), arg10);
        let v8 = 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&v7);
        let v9 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v3, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::get_sqrt_price_at_tick(v2) - 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::get_sqrt_price_at_tick(v1), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::get_sqrt_price_at_tick(arg8) - 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::get_sqrt_price_at_tick(arg7));
        0x2::balance::join<T0>(&mut arg3.coin_a, v5);
        0x2::balance::join<T1>(&mut arg3.coin_b, v6);
        let v10 = &mut v7;
        add_liquidity_by_lock_position<T0, T1>(arg0, arg1, arg4, arg3, v10, arg9);
        let v11 = if (0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v7) >= v9 || 0x2::balance::value<T0>(&arg3.coin_a) == 0 && 0x2::balance::value<T1>(&arg3.coin_b) == 0) {
            0
        } else {
            v9 - 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v7)
        };
        if (v11 > 0) {
            let (v12, v13) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_amount_by_liquidity(arg7, arg8, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg4), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg4), v11, true);
            let v14 = v13;
            let v15 = v12;
            if (0x2::balance::value<T1>(&arg3.coin_b) < v13 && 0x2::balance::value<T0>(&arg3.coin_a) < v12) {
                let (v16, v17, v18) = get_liquidity_by_amount_by_lock_position<T0, T1>(arg4, arg3, arg7, arg8);
                v14 = v18;
                v15 = v17;
                v11 = v16;
            };
            if (0x2::balance::value<T1>(&arg3.coin_b) > v14) {
                let v19 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::calculate_swap_result<T0, T1>(arg0, arg4, false, true, 0x2::balance::value<T1>(&arg3.coin_b) - v14);
                let v20 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::calculated_swap_result_amount_out(&v19);
                if (v20 + 0x2::balance::value<T0>(&arg3.coin_a) < v15) {
                    let (v21, v22, v23) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(arg7, arg8, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg4), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg4), v20 + 0x2::balance::value<T0>(&arg3.coin_a), true);
                    v14 = v23;
                    v15 = v22;
                    v11 = v21;
                };
            } else if (0x2::balance::value<T0>(&arg3.coin_a) > v15) {
                let v24 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::calculate_swap_result<T0, T1>(arg0, arg4, true, true, 0x2::balance::value<T0>(&arg3.coin_a) - v15);
                let v25 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::calculated_swap_result_amount_out(&v24);
                if (v25 + 0x2::balance::value<T1>(&arg3.coin_b) < v14) {
                    let (v26, v27, v28) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(arg7, arg8, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg4), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg4), v25 + 0x2::balance::value<T1>(&arg3.coin_b), false);
                    v14 = v28;
                    v15 = v27;
                    v11 = v26;
                };
            };
            if (v11 > 0) {
                let v29 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity<T0, T1>(arg0, arg1, arg4, &mut v7, v11, arg9);
                let (v30, v31) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity_pay_amount<T0, T1>(&v29);
                if (0x2::balance::value<T1>(&arg3.coin_b) > v14 || 0x2::balance::value<T0>(&arg3.coin_a) > v15) {
                    let (v32, v33, v34) = if (0x2::balance::value<T1>(&arg3.coin_b) > v14) {
                        let (v35, v36, v37) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap<T0, T1>(arg0, arg1, arg4, false, true, 0x2::balance::value<T1>(&arg3.coin_b) - v14, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::max_sqrt_price(), arg5, arg6, arg9);
                        let v38 = v37;
                        0x2::balance::join<T1>(&mut arg3.coin_b, v36);
                        0x2::balance::join<T0>(&mut arg3.coin_a, v35);
                        (v38, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3.coin_b, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T0, T1>(&v38)))
                    } else {
                        let (v39, v40, v41) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap<T0, T1>(arg0, arg1, arg4, true, true, 0x2::balance::value<T0>(&arg3.coin_a) - v15, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::tick_math::min_sqrt_price(), arg5, arg6, arg9);
                        let v42 = v41;
                        0x2::balance::join<T0>(&mut arg3.coin_a, v39);
                        0x2::balance::join<T1>(&mut arg3.coin_b, v40);
                        (v42, 0x2::balance::split<T0>(&mut arg3.coin_a, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T0, T1>(&v42)), 0x2::balance::zero<T1>())
                    };
                    assert!(0x2::balance::value<T0>(&arg3.coin_a) >= v15, 9259346230481212);
                    assert!(0x2::balance::value<T1>(&arg3.coin_b) >= v14, 9387240376820348);
                    0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap<T0, T1>(arg0, arg4, v33, v34, v32);
                };
                let v43 = 0x2::balance::split<T0>(&mut arg3.coin_a, v30);
                let v44 = 0x2::balance::split<T1>(&mut arg3.coin_b, v31);
                assert!(v30 == 0x2::balance::value<T0>(&v43), 95346237427834273);
                assert!(v31 == 0x2::balance::value<T1>(&v44), 92368340637234706);
                0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_add_liquidity<T0, T1>(arg0, arg4, v43, v44, v29);
            };
        };
        let v45 = &mut v7;
        add_liquidity_by_lock_position_with_swap_internal<T0, T1>(arg0, arg1, arg4, arg3, v45, arg5, arg6, arg9);
        let v46 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&v7);
        arg3.position_id = v8;
        arg3.lock_liquidity_info.total_lock_liquidity = v46;
        arg3.lock_liquidity_info.current_lock_liquidity = v46;
        arg3.last_growth_inside = 0;
        arg3.accumulated_amount_earned = arg3.accumulated_amount_earned + 0;
        let v47 = ChangeRangePositionEvent{
            lock_position_id              : 0x2::object::id<SoftLockedPosition<T0, T1>>(arg3),
            new_position_id               : v8,
            new_lock_liquidity            : v46,
            new_tick_lower                : arg7,
            new_tick_upper                : arg8,
            new_last_growth_inside        : arg3.last_growth_inside,
            new_accumulated_amount_earned : arg3.accumulated_amount_earned,
            new_total_lock_liquidity      : arg3.lock_liquidity_info.total_lock_liquidity,
            new_current_lock_liquidity    : arg3.lock_liquidity_info.current_lock_liquidity,
            remainder_a                   : 0x2::balance::value<T0>(&arg3.coin_a),
            remainder_b                   : 0x2::balance::value<T1>(&arg3.coin_b),
        };
        0x2::object_table::add<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg2.positions, v8, v7);
        0x2::event::emit<ChangeRangePositionEvent>(v47);
    }

    public fun check_admin(arg0: &SoftLocker, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg1), 9389469239702349);
    }

    public fun checked_package_version(arg0: &SoftLocker) {
        assert!(arg0.version == 1, 9346920730473042);
    }

    public fun collect_fee<T0, T1>(arg0: &mut SoftLocker, arg1: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &SoftLockedPosition<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg0.positions, arg3.position_id);
        let (v1, v2) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::collect_fee<T0, T1>(arg1, arg2, &v0, true);
        0x2::object_table::add<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg0.positions, 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&v0), v0);
        (v1, v2)
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
            lock_liquidity_info       : v10,
            coin_a                    : v11,
            coin_b                    : v12,
        } = arg0;
        let LockLiquidityInfo {
            total_lock_liquidity       : _,
            current_lock_liquidity     : _,
            last_remove_liquidity_time : _,
        } = v10;
        0x2::object::delete(v0);
        (v11, v12)
    }

    public fun early_unlock_position<T0, T1>(arg0: &mut SoftLocker, arg1: SoftLockedPosition<T0, T1>, arg2: &0x2::clock::Clock) : (0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 < arg1.full_unlocking_time, 98923745837578344);
        let v0 = EarlyUnlockPositionEvent{lock_position_id: 0x2::object::id<SoftLockedPosition<T0, T1>>(&arg1)};
        let (v1, v2) = destroy<T0, T1>(arg1);
        0x2::event::emit<EarlyUnlockPositionEvent>(v0);
        (0x2::object_table::remove<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg0.positions, arg1.position_id), v1, v2)
    }

    public fun get_ignore_whitelist_flag(arg0: &SoftLocker) : bool {
        arg0.ignore_whitelist_providers
    }

    public fun get_init_locker_v2(arg0: &SuperAdminCap) : bool {
        arg0.init_locker_v2
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

    public fun get_lock_periods(arg0: &SoftLocker) : (vector<u64>, vector<u64>) {
        (arg0.periods_blocking, arg0.periods_post_lockdown)
    }

    public(friend) fun get_lock_position_info_for_migrate<T0, T1>(arg0: &mut SoftLockedPosition<T0, T1>) : (0x2::object::ID, u64, u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (arg0.tranche_id, arg0.start_lock_time, arg0.expiration_time, arg0.full_unlocking_time, 0x2::balance::withdraw_all<T0>(&mut arg0.coin_a), 0x2::balance::withdraw_all<T1>(&mut arg0.coin_b))
    }

    public fun get_locked_position_id<T0, T1>(arg0: &SoftLockedPosition<T0, T1>) : 0x2::object::ID {
        arg0.position_id
    }

    public fun get_locker_version(arg0: &SoftLocker) : u64 {
        arg0.version
    }

    public fun get_pool_reward<T0, T1, T2>(arg0: &SoftLocker, arg1: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: &SoftLockedPosition<T0, T1>, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::collect_reward<T0, T1, T2>(arg1, arg3, 0x2::object_table::borrow<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&arg0.positions, arg4.position_id), arg2, true, arg5)
    }

    public fun get_profitability<T0, T1>(arg0: &SoftLockedPosition<T0, T1>) : u64 {
        arg0.profitability
    }

    public fun get_unlock_time<T0, T1>(arg0: &SoftLockedPosition<T0, T1>) : (u64, u64) {
        (arg0.expiration_time, arg0.full_unlocking_time)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SoftLocker{
            id                         : 0x2::object::new(arg0),
            locker_cap                 : 0x1::option::none<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(),
            version                    : 1,
            admins                     : 0x2::vec_set::empty<address>(),
            positions                  : 0x2::object_table::new<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(arg0),
            periods_blocking           : 0x1::vector::empty<u64>(),
            periods_post_lockdown      : 0x1::vector::empty<u64>(),
            pause                      : false,
            whitelisted_providers      : 0x2::table::new<address, bool>(arg0),
            ignore_whitelist_providers : false,
            bag                        : 0x2::bag::new(arg0),
        };
        0x2::vec_set::insert<address>(&mut v0.admins, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<SoftLocker>(v0);
        let v1 = SuperAdminCap{
            id             : 0x2::object::new(arg0),
            init_locker_v2 : false,
        };
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = InitLockerEvent{locker_id: 0x2::object::id<SoftLocker>(&v0)};
        0x2::event::emit<InitLockerEvent>(v2);
    }

    public fun init_locker(arg0: &SuperAdminCap, arg1: &0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::CreateCap, arg2: &mut SoftLocker, arg3: vector<u64>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg2);
        assert!(0x1::vector::length<u64>(&arg3) > 0 && 0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 938724658124718472);
        0x1::option::fill<0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::LockerCap>(&mut arg2.locker_cap, 0xaa46f6a26e09b3dc3961108a41d0223248090d03820b5dd02a6986c0f620b646::locker_cap::create_locker_cap(arg1, arg5));
        arg2.periods_blocking = arg3;
        arg2.periods_post_lockdown = arg4;
        let v0 = UpdateLockPeriodsEvent{
            locker_id             : 0x2::object::id<SoftLocker>(arg2),
            periods_blocking      : arg3,
            periods_post_lockdown : arg4,
        };
        0x2::event::emit<UpdateLockPeriodsEvent>(v0);
    }

    public fun init_locker_v2(arg0: &mut SuperAdminCap) {
        arg0.init_locker_v2 = true;
    }

    public fun is_admin(arg0: &SoftLocker, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_position_locked(arg0: &mut SoftLocker, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&arg0.positions, arg1)
    }

    public fun is_provider_whitelisted(arg0: &SoftLocker, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelisted_providers, arg1)
    }

    public fun lock_position<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut SoftLocker, arg3: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<SoftLockedPosition<T0, T1>> {
        checked_package_version(arg2);
        assert!(!arg2.pause, 916023534273428375);
        assert!(arg2.ignore_whitelist_providers || 0x2::table::contains<address, bool>(&arg2.whitelisted_providers, 0x2::tx_context::sender(arg8)), 9349734723203073);
        let v0 = 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&arg5);
        assert!(!0x2::object_table::contains<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&arg2.positions, v0), 9387246576346433);
        assert!(arg6 < 0x1::vector::length<u64>(&arg2.periods_blocking), 938724654546442874);
        let v1 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let v2 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_time_manager::epoch_next(v1 + 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_time_manager::epoch_to_seconds(*0x1::vector::borrow<u64>(&arg2.periods_blocking, arg6)));
        let v3 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::get_tranches(arg3, 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>>(arg4));
        assert!(0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTranche>(v3) > 0, 9823742374723842);
        let v4 = 0x1::vector::empty<SoftLockedPosition<T0, T1>>();
        let v5 = v0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTranche>(v3)) {
            let v7 = 0x1::vector::borrow_mut<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTranche>(v3, v6);
            if (0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::is_filled(v7)) {
                v6 = v6 + 1;
                continue
            };
            let v8 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::get_duration_profitabilities(v7);
            assert!(0x1::vector::length<u64>(&v8) == 0x1::vector::length<u64>(&arg2.periods_blocking), 93877534345684724);
            let (v9, v10) = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::get_free_volume(v7);
            let v11 = if (v10) {
                0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_locker_utils::calculate_position_liquidity_in_token_a<T0, T1>(arg4, v5)
            } else {
                0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_locker_utils::calculate_position_liquidity_in_token_b<T0, T1>(arg4, v5)
            };
            let (v12, v13, v14, v15, v16) = if (v11 > v9) {
                let v17 = &mut arg5;
                let (v18, v19, v20, v21, v22) = split_position_internal<T0, T1>(arg0, arg1, arg4, v17, (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v9, (0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::lock_liquidity_share_denom() as u128), v11) as u64), arg7, arg8);
                let v23 = v19;
                let v24 = v18;
                v5 = v23.position_id;
                0x2::object_table::add<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg2.positions, v23.position_id, v22);
                0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::fill_tranches(v7, v9);
                (v24.position_id, v24.liquidity, v20, v21, true)
            } else {
                0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::fill_tranches(v7, v11);
                (v5, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::info_liquidity(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::borrow_position_info(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::position_manager<T0, T1>(arg4), v5)), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), false)
            };
            let v25 = LockLiquidityInfo{
                total_lock_liquidity       : v13,
                current_lock_liquidity     : v13,
                last_remove_liquidity_time : 0,
            };
            let v26 = SoftLockedPosition<T0, T1>{
                id                        : 0x2::object::new(arg8),
                position_id               : v12,
                tranche_id                : 0x2::object::id<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTranche>(v7),
                start_lock_time           : v1,
                expiration_time           : v2,
                full_unlocking_time       : v2 + 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_time_manager::epoch_to_seconds(*0x1::vector::borrow<u64>(&arg2.periods_post_lockdown, arg6)),
                profitability             : *0x1::vector::borrow<u64>(&v8, arg6),
                last_reward_claim_epoch   : v1,
                last_growth_inside        : 0,
                accumulated_amount_earned : 0,
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
            0x1::vector::push_back<SoftLockedPosition<T0, T1>>(&mut v4, v26);
            if (!v16) {
                break
            };
            let v28 = v6 + 1;
            v6 = v28;
            assert!(v28 < 0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTranche>(v3) || v5 == v12, 92035925692467234);
        };
        0x2::object_table::add<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg2.positions, v0, arg5);
        v4
    }

    public(friend) fun lock_position_migrate<T0, T1>(arg0: &mut SoftLocker, arg1: SoftLockedPosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 < arg1.expiration_time, 99423692832693454);
        let (v0, v1) = destroy<T0, T1>(arg1);
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        if (0x2::balance::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
        0x2::object_table::remove<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg0.positions, arg1.position_id)
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

    public fun pause(arg0: &SoftLocker) : bool {
        arg0.pause
    }

    public fun remove_addresses_from_whitelist(arg0: &mut SoftLocker, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, bool>(&arg0.whitelisted_providers, v1)) {
                0x2::table::remove<address, bool>(&mut arg0.whitelisted_providers, v1);
                let v2 = RemoveAddressFromWhitelistProvidersEvent{address: v1};
                0x2::event::emit<RemoveAddressFromWhitelistProvidersEvent>(v2);
            };
            v0 = v0 + 1;
        };
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

    public fun remove_lock_liquidity<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut SoftLocker, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: SoftLockedPosition<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        checked_package_version(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        assert!(!arg2.pause, 916023534273428375);
        assert!(v0 >= arg4.expiration_time, 91204958347574966);
        let v1 = v0 >= arg4.full_unlocking_time;
        let v2 = if (v1) {
            arg4.lock_liquidity_info.current_lock_liquidity
        } else {
            if (arg4.lock_liquidity_info.last_remove_liquidity_time == 0) {
                arg4.lock_liquidity_info.last_remove_liquidity_time = arg4.expiration_time;
            };
            let v3 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_time_manager::number_epochs_in_timestamp(v0 - arg4.lock_liquidity_info.last_remove_liquidity_time);
            assert!(v3 > 0, 91877547573637423);
            0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(arg4.lock_liquidity_info.total_lock_liquidity, (v3 as u128), (0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_time_manager::number_epochs_in_timestamp(arg4.full_unlocking_time - arg4.expiration_time) as u128))
        };
        let v4 = v2;
        assert!(v2 > 0, 91877547573637423);
        if (v2 > arg4.lock_liquidity_info.current_lock_liquidity) {
            v4 = arg4.lock_liquidity_info.current_lock_liquidity;
        };
        let v5 = 0x2::object_table::remove<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg2.positions, arg4.position_id);
        let v6 = &mut v5;
        let (v7, v8) = remove_liquidity_and_collect_fee<T0, T1>(arg0, arg1, arg3, v6, v4, arg5);
        let v9 = v8;
        let v10 = v7;
        if (v1) {
            let v11 = UnlockPositionEvent{lock_position_id: 0x2::object::id<SoftLockedPosition<T0, T1>>(&arg4)};
            let (v12, v13) = destroy<T0, T1>(arg4);
            0x2::balance::join<T0>(&mut v10, v12);
            0x2::balance::join<T1>(&mut v9, v13);
            0x2::event::emit<UnlockPositionEvent>(v11);
            0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::close_position<T0, T1>(arg0, arg3, v5);
        } else {
            0x2::object_table::add<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg2.positions, arg4.position_id, v5);
            arg4.lock_liquidity_info.current_lock_liquidity = arg4.lock_liquidity_info.current_lock_liquidity - v4;
            arg4.lock_liquidity_info.last_remove_liquidity_time = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_time_manager::epoch_start(v0);
            let v14 = UpdateLockLiquidityEvent{
                lock_position_id           : 0x2::object::id<SoftLockedPosition<T0, T1>>(&arg4),
                current_lock_liquidity     : arg4.lock_liquidity_info.current_lock_liquidity,
                last_remove_liquidity_time : arg4.lock_liquidity_info.last_remove_liquidity_time,
            };
            0x2::event::emit<UpdateLockLiquidityEvent>(v14);
            0x2::transfer::public_transfer<SoftLockedPosition<T0, T1>>(arg4, 0x2::tx_context::sender(arg6));
        };
        (v10, v9)
    }

    public fun remove_lock_liquidity_save<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut SoftLocker, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: SoftLockedPosition<T0, T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = remove_lock_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) >= arg5, 9367234807236103);
        assert!(0x2::balance::value<T1>(&v2) >= arg6, 9247240362830633);
        (v3, v2)
    }

    public fun revoke_admin(arg0: &SuperAdminCap, arg1: &mut SoftLocker, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        check_admin(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_set::contains<address>(&arg1.admins, &arg2), 9630793046376343);
        0x2::vec_set::remove<address>(&mut arg1.admins, &arg2);
    }

    public fun set_ignore_whitelist(arg0: &mut SoftLocker, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.ignore_whitelist_providers = arg1;
        let v0 = SetIgnoreWhitelistProvidersEvent{ignore_whitelist_providers: arg1};
        0x2::event::emit<SetIgnoreWhitelistProvidersEvent>(v0);
    }

    public fun split_position<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut SoftLocker, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: SoftLockedPosition<T0, T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (SoftLockedPosition<T0, T1>, SoftLockedPosition<T0, T1>) {
        checked_package_version(arg2);
        assert!(!arg2.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg6) / 1000 < arg4.full_unlocking_time, 93297692597493433);
        assert!(arg5 <= 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::soft_consts::lock_liquidity_share_denom() && arg5 > 0, 902354235823942382);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg2.positions, arg4.position_id);
        let v1 = &mut v0;
        let (v2, v3, v4, v5, v6) = split_position_internal<T0, T1>(arg0, arg1, arg3, v1, arg5, arg6, arg7);
        let v7 = v3;
        let v8 = v2;
        arg4.position_id = v8.position_id;
        arg4.lock_liquidity_info.total_lock_liquidity = v8.liquidity;
        arg4.lock_liquidity_info.current_lock_liquidity = v8.liquidity;
        arg4.last_growth_inside = 0;
        arg4.accumulated_amount_earned = 0;
        let v9 = LockLiquidityInfo{
            total_lock_liquidity       : v7.liquidity,
            current_lock_liquidity     : v7.liquidity,
            last_remove_liquidity_time : arg4.lock_liquidity_info.last_remove_liquidity_time,
        };
        let v10 = SoftLockedPosition<T0, T1>{
            id                        : 0x2::object::new(arg7),
            position_id               : v7.position_id,
            tranche_id                : arg4.tranche_id,
            start_lock_time           : arg4.start_lock_time,
            expiration_time           : arg4.expiration_time,
            full_unlocking_time       : arg4.full_unlocking_time,
            profitability             : arg4.profitability,
            last_reward_claim_epoch   : arg4.last_reward_claim_epoch,
            last_growth_inside        : 0,
            accumulated_amount_earned : 0,
            lock_liquidity_info       : v9,
            coin_a                    : 0x2::balance::split<T0>(&mut arg4.coin_a, calculate_remainder_coin_split(0x2::balance::value<T0>(&arg4.coin_a), arg5)),
            coin_b                    : 0x2::balance::split<T1>(&mut arg4.coin_b, calculate_remainder_coin_split(0x2::balance::value<T1>(&arg4.coin_b), arg5)),
        };
        0x2::balance::join<T0>(&mut v10.coin_a, v4);
        0x2::balance::join<T1>(&mut v10.coin_b, v5);
        0x2::object_table::add<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg2.positions, arg4.position_id, v0);
        0x2::object_table::add<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg2.positions, v10.position_id, v6);
        let v11 = 0x2::object::id<SoftLockedPosition<T0, T1>>(&v10);
        let v12 = SplitPositionEvent{
            lock_position_id              : 0x2::object::id<SoftLockedPosition<T0, T1>>(&arg4),
            new_lock_position_id          : v11,
            share_first_part              : arg5,
            new_total_lock_liquidity      : arg4.lock_liquidity_info.total_lock_liquidity,
            new_current_lock_liquidity    : arg4.lock_liquidity_info.current_lock_liquidity,
            new_last_growth_inside        : arg4.last_growth_inside,
            new_accumulated_amount_earned : arg4.accumulated_amount_earned,
            remainder_a                   : 0x2::balance::value<T0>(&arg4.coin_a),
            remainder_b                   : 0x2::balance::value<T1>(&arg4.coin_b),
        };
        0x2::event::emit<SplitPositionEvent>(v12);
        let v13 = CreateLockPositionEvent{
            lock_position_id        : v11,
            position_id             : v10.position_id,
            tranche_id              : v10.tranche_id,
            total_lock_liquidity    : v10.lock_liquidity_info.total_lock_liquidity,
            start_lock_time         : v10.start_lock_time,
            expiration_time         : v10.expiration_time,
            full_unlocking_time     : v10.full_unlocking_time,
            profitability           : v10.profitability,
            last_reward_claim_epoch : v10.last_reward_claim_epoch,
            last_growth_inside      : v10.last_growth_inside,
            remainder_a             : 0x2::balance::value<T0>(&arg4.coin_a),
            remainder_b             : 0x2::balance::value<T1>(&arg4.coin_b),
        };
        0x2::event::emit<CreateLockPositionEvent>(v13);
        (arg4, v10)
    }

    fun split_position_internal<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (SplitPositionResult<T0, T1>, SplitPositionResult<T0, T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position) {
        let (v0, v1) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::tick_range(arg3);
        let (_, v3) = calculate_liquidity_split(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(arg3), arg4);
        let v4 = v3;
        let (v5, v6) = remove_liquidity_and_collect_fee<T0, T1>(arg0, arg1, arg2, arg3, v3, arg5);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        let v11 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::open_position<T0, T1>(arg0, arg2, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(v0), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(v1), arg6);
        let (v12, v13) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_amount_by_liquidity(v0, v1, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg2), v3, true);
        let v14 = v13;
        if (v12 > v9) {
            let (v15, _, v17) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(v0, v1, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg2), v9, true);
            v14 = v17;
            v4 = v15;
        };
        if (v14 > v10) {
            let (v18, _, _) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::clmm_math::get_liquidity_by_amount(v0, v1, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_tick_index<T0, T1>(arg2), 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg2), v10, false);
            v4 = v18;
        };
        let v21 = &mut v11;
        let (v22, v23) = add_liquidity_internal<T0, T1>(arg0, arg1, arg2, v21, v8, v7, v4, arg5);
        let v24 = SplitPositionResult<T0, T1>{
            position_id : 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(arg3),
            liquidity   : 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(arg3),
        };
        let v25 = SplitPositionResult<T0, T1>{
            position_id : 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&v11),
            liquidity   : v4,
        };
        (v24, v25, v22, v23, v11)
    }

    public fun unlock_position<T0, T1>(arg0: &mut SoftLocker, arg1: SoftLockedPosition<T0, T1>, arg2: &0x2::clock::Clock) : (0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        checked_package_version(arg0);
        assert!(!arg0.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= arg1.full_unlocking_time, 98923745837578344);
        let v0 = UnlockPositionEvent{lock_position_id: 0x2::object::id<SoftLockedPosition<T0, T1>>(&arg1)};
        let (v1, v2) = destroy<T0, T1>(arg1);
        0x2::event::emit<UnlockPositionEvent>(v0);
        (0x2::object_table::remove<0x2::object::ID, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(&mut arg0.positions, arg1.position_id), v1, v2)
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

