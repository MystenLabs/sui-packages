module 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::liquidity_lock_v1 {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        init_locker_v2: bool,
    }

    struct Locker has store, key {
        id: 0x2::object::UID,
        locker_cap: 0x1::option::Option<0xab9d24835874bbb604be11e529a450e484d2aa9429a7e5790829a461b179173b::locker_cap::LockerCap>,
        version: u64,
        admins: 0x2::vec_set::VecSet<address>,
        positions: 0x2::object_table::ObjectTable<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>,
        periods_blocking: vector<u64>,
        periods_post_lockdown: vector<u64>,
        pause: bool,
        whitelisted_providers: 0x2::vec_set::VecSet<address>,
        ignore_whitelist_providers: bool,
    }

    struct LockedPosition<phantom T0, phantom T1> has store, key {
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
    }

    struct TransferLockPositionEvent has copy, drop {
        lock_position_id: 0x2::object::ID,
        to: address,
    }

    struct UnlockPositionEvent has copy, drop {
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
    }

    struct ChangeRangePositionEvent has copy, drop {
        lock_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        new_lock_liquidity: u128,
        new_tick_lower: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        new_tick_upper: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        new_last_growth_inside: u128,
        new_accumulated_amount_earned: u64,
    }

    public fun add_addresses_to_whitelist(arg0: &mut Locker, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::vec_set::contains<address>(&arg0.whitelisted_providers, &v1)) {
                0x2::vec_set::insert<address>(&mut arg0.whitelisted_providers, v1);
                let v2 = AddAddressToWhitelistProvidersEvent{address: v1};
                0x2::event::emit<AddAddressToWhitelistProvidersEvent>(v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun add_admin(arg0: &mut Locker, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(!0x2::vec_set::contains<address>(&arg0.admins, &arg1), 9630793046376343);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
    }

    fun add_liquidity_by_lock_position<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut LockedPosition<T0, T1>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position, arg5: &0x2::clock::Clock) {
        if (0x2::balance::value<T0>(&arg3.coin_a) > 0 && 0x2::balance::value<T1>(&arg3.coin_b) > 0) {
            let (v0, v1) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::tick_range(arg4);
            let (v2, v3, v4) = if (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::gte(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg2), v1)) {
                let (v5, v6, v7) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_liquidity_by_amount(v0, v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg2), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T1>(&arg3.coin_b), false);
                let (v8, v9, v10) = if (v6 > 0x2::balance::value<T0>(&arg3.coin_a)) {
                    0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_liquidity_by_amount(v0, v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg2), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T0>(&arg3.coin_a), true)
                } else {
                    (v5, v6, v7)
                };
                (v10, v8, v9)
            } else {
                let (v11, v12, v13) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_liquidity_by_amount(v0, v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg2), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T0>(&arg3.coin_a), true);
                let (v14, v15, v16) = if (v13 > 0x2::balance::value<T1>(&arg3.coin_b)) {
                    0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_liquidity_by_amount(v0, v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg2), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T1>(&arg3.coin_b), false)
                } else {
                    (v11, v12, v13)
                };
                (v16, v14, v15)
            };
            let (v17, v18) = add_liquidity_internal<T0, T1>(arg0, arg1, arg2, arg4, 0x2::balance::split<T0>(&mut arg3.coin_a, v4), 0x2::balance::split<T1>(&mut arg3.coin_b, v2), v3, arg5);
            0x2::balance::join<T0>(&mut arg3.coin_a, v17);
            0x2::balance::join<T1>(&mut arg3.coin_b, v18);
        };
    }

    fun add_liquidity_internal<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u128, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7);
        let (v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::add_liquidity_pay_amount<T0, T1>(&v0);
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
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_add_liquidity<T0, T1>(arg0, arg2, arg4, arg5, v0);
        (v7, v8)
    }

    public(friend) fun admins(arg0: &Locker) : &0x2::vec_set::VecSet<address> {
        &arg0.admins
    }

    fun calculate_liquidity_split(arg0: u128, arg1: u64) : (u128, u128) {
        assert!(arg1 <= 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::consts::lock_liquidity_share_denom(), 902354235823942382);
        let v0 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(arg0, (arg1 as u128), (0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::consts::lock_liquidity_share_denom() as u128));
        (v0, arg0 - v0)
    }

    public fun change_tick_range<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut Locker, arg3: &mut LockedPosition<T0, T1>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg6: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg7: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg8: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg9) / 1000 < arg3.expiration_time, 99423692832693454);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg2.positions, arg3.position_id);
        let (v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::tick_range(&v0);
        assert!(!0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::eq(arg7, v1) || !0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::eq(arg8, v2), 96203676234264517);
        let v3 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::liquidity(&v0);
        let v4 = &mut v0;
        let (v5, v6) = remove_liquidity_and_collect_fee<T0, T1>(arg0, arg1, arg4, v4, v3, arg9, arg10);
        let v7 = v6;
        let v8 = v5;
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::close_position<T0, T1>(arg0, arg4, v0);
        let v9 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::open_position<T0, T1>(arg0, arg4, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(arg7), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(arg8), arg10);
        let v10 = 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&v9);
        let v11 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v3, (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::abs_u32(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::sub(v2, v1)) as u128), (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::abs_u32(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::sub(arg8, arg7)) as u128));
        let v12 = v11;
        let (v13, v14) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_amount_by_liquidity(arg7, arg8, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg4), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg4), v11, true);
        let v15 = v14;
        let v16 = v13;
        if (0x2::balance::value<T1>(&v7) > v14 || 0x2::balance::value<T0>(&v8) > v13) {
            if (0x2::balance::value<T1>(&v7) > v14) {
                let v17 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, T1>(arg0, arg4, false, true, 0x2::balance::value<T1>(&v7) - v14);
                let v18 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v17);
                if (v18 + 0x2::balance::value<T0>(&v8) < v13) {
                    let (v19, v20, v21) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_liquidity_by_amount(arg7, arg8, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg4), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg4), v18 + 0x2::balance::value<T0>(&v8), true);
                    v15 = v21;
                    v16 = v20;
                    v12 = v19;
                };
            } else {
                let v22 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, T1>(arg0, arg4, true, true, 0x2::balance::value<T0>(&v8) - v13);
                let v23 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v22);
                if (v23 + 0x2::balance::value<T1>(&v7) < v14) {
                    let (v24, v25, v26) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_liquidity_by_amount(arg7, arg8, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg4), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg4), v23 + 0x2::balance::value<T1>(&v7), false);
                    v15 = v26;
                    v16 = v25;
                    v12 = v24;
                };
            };
        };
        let v27 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::add_liquidity<T0, T1>(arg0, arg1, arg4, &mut v9, v12, arg9);
        let (v28, v29) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::add_liquidity_pay_amount<T0, T1>(&v27);
        if (0x2::balance::value<T1>(&v7) > v15 || 0x2::balance::value<T0>(&v8) > v16) {
            let (v30, v31, v32) = if (0x2::balance::value<T1>(&v7) > v15) {
                let (v33, v34, v35) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg4, false, true, 0x2::balance::value<T1>(&v7) - v15, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::max_sqrt_price(), arg5, arg6, arg9);
                let v36 = v35;
                0x2::balance::join<T1>(&mut v7, v34);
                0x2::balance::join<T0>(&mut v8, v33);
                (v36, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v36)))
            } else {
                let (v37, v38, v39) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg4, true, true, 0x2::balance::value<T0>(&v8) - v16, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::min_sqrt_price(), arg5, arg6, arg9);
                let v40 = v39;
                0x2::balance::join<T0>(&mut v8, v37);
                0x2::balance::join<T1>(&mut v7, v38);
                (v40, 0x2::balance::split<T0>(&mut v8, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v40)), 0x2::balance::zero<T1>())
            };
            assert!(0x2::balance::value<T0>(&v8) >= v16, 9259346230481212);
            assert!(0x2::balance::value<T1>(&v7) >= v15, 9387240376820348);
            0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg4, v31, v32, v30);
        };
        if (0x2::balance::value<T0>(&v8) > v28) {
            0x2::balance::join<T0>(&mut arg3.coin_a, 0x2::balance::split<T0>(&mut v8, 0x2::balance::value<T0>(&v8) - v28));
        };
        if (0x2::balance::value<T1>(&v7) > v29) {
            0x2::balance::join<T1>(&mut arg3.coin_b, 0x2::balance::split<T1>(&mut v7, 0x2::balance::value<T1>(&v7) - v29));
        };
        assert!(v28 == 0x2::balance::value<T0>(&v8), 95346237427834273);
        assert!(v29 == 0x2::balance::value<T1>(&v7), 92368340637234706);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_add_liquidity<T0, T1>(arg0, arg4, v8, v7, v27);
        let v41 = &mut v9;
        add_liquidity_by_lock_position<T0, T1>(arg0, arg1, arg4, arg3, v41, arg9);
        let v42 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::liquidity(&v9);
        arg3.position_id = v10;
        arg3.lock_liquidity_info.total_lock_liquidity = v42;
        arg3.lock_liquidity_info.current_lock_liquidity = v42;
        arg3.last_growth_inside = 0;
        arg3.accumulated_amount_earned = arg3.accumulated_amount_earned + 0;
        let v43 = ChangeRangePositionEvent{
            lock_position_id              : 0x2::object::id<LockedPosition<T0, T1>>(arg3),
            new_position_id               : v10,
            new_lock_liquidity            : v42,
            new_tick_lower                : arg7,
            new_tick_upper                : arg8,
            new_last_growth_inside        : arg3.last_growth_inside,
            new_accumulated_amount_earned : arg3.accumulated_amount_earned,
        };
        0x2::object_table::add<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg2.positions, v10, v9);
        0x2::event::emit<ChangeRangePositionEvent>(v43);
    }

    public fun check_admin(arg0: &Locker, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg1), 9389469239702349);
    }

    public fun checked_package_version(arg0: &Locker) {
        assert!(arg0.version == 1, 9346920730473042);
    }

    public fun collect_fee<T0, T1>(arg0: &mut Locker, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &LockedPosition<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg0.positions, arg3.position_id);
        let (v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::collect_fee<T0, T1>(arg1, arg2, &v0, true);
        let v3 = v2;
        let v4 = v1;
        0x2::object_table::add<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg0.positions, 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&v0), v0);
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
    }

    fun destroy<T0, T1>(arg0: LockedPosition<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let LockedPosition {
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
        let v13 = v12;
        let v14 = v11;
        let LockLiquidityInfo {
            total_lock_liquidity       : _,
            current_lock_liquidity     : _,
            last_remove_liquidity_time : _,
        } = v10;
        if (0x2::balance::value<T0>(&v14) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v14, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(v14);
        };
        if (0x2::balance::value<T1>(&v13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v13, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T1>(v13);
        };
        0x2::object::delete(v0);
    }

    public fun get_ignore_whitelist_flag(arg0: &Locker) : bool {
        arg0.ignore_whitelist_providers
    }

    public fun get_init_locker_v2(arg0: &AdminCap) : bool {
        arg0.init_locker_v2
    }

    public fun get_lock_periods(arg0: &Locker) : (vector<u64>, vector<u64>) {
        (arg0.periods_blocking, arg0.periods_post_lockdown)
    }

    public(friend) fun get_lock_position_info_for_migrate<T0, T1>(arg0: &mut LockedPosition<T0, T1>) : (0x2::object::ID, u64, u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (arg0.tranche_id, arg0.start_lock_time, arg0.expiration_time, arg0.full_unlocking_time, 0x2::balance::withdraw_all<T0>(&mut arg0.coin_a), 0x2::balance::withdraw_all<T1>(&mut arg0.coin_b))
    }

    public fun get_locked_position_id<T0, T1>(arg0: &LockedPosition<T0, T1>) : 0x2::object::ID {
        arg0.position_id
    }

    public fun get_locker_version(arg0: &Locker) : u64 {
        arg0.version
    }

    public fun get_profitability<T0, T1>(arg0: &LockedPosition<T0, T1>) : u64 {
        arg0.profitability
    }

    public fun get_unlock_time<T0, T1>(arg0: &LockedPosition<T0, T1>) : (u64, u64) {
        (arg0.expiration_time, arg0.full_unlocking_time)
    }

    public fun get_whitelisted_providers(arg0: &Locker) : vector<address> {
        0x2::vec_set::into_keys<address>(arg0.whitelisted_providers)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Locker{
            id                         : 0x2::object::new(arg0),
            locker_cap                 : 0x1::option::none<0xab9d24835874bbb604be11e529a450e484d2aa9429a7e5790829a461b179173b::locker_cap::LockerCap>(),
            version                    : 1,
            admins                     : 0x2::vec_set::empty<address>(),
            positions                  : 0x2::object_table::new<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(arg0),
            periods_blocking           : 0x1::vector::empty<u64>(),
            periods_post_lockdown      : 0x1::vector::empty<u64>(),
            pause                      : false,
            whitelisted_providers      : 0x2::vec_set::empty<address>(),
            ignore_whitelist_providers : false,
        };
        0x2::vec_set::insert<address>(&mut v0.admins, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Locker>(v0);
        let v1 = AdminCap{
            id             : 0x2::object::new(arg0),
            init_locker_v2 : false,
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = InitLockerEvent{locker_id: 0x2::object::id<Locker>(&v0)};
        0x2::event::emit<InitLockerEvent>(v2);
    }

    public fun init_locker(arg0: &AdminCap, arg1: &0xab9d24835874bbb604be11e529a450e484d2aa9429a7e5790829a461b179173b::locker_cap::CreateCap, arg2: &mut Locker, arg3: vector<u64>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg3) > 0 && 0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 938724658124718472);
        0x1::option::fill<0xab9d24835874bbb604be11e529a450e484d2aa9429a7e5790829a461b179173b::locker_cap::LockerCap>(&mut arg2.locker_cap, 0xab9d24835874bbb604be11e529a450e484d2aa9429a7e5790829a461b179173b::locker_cap::create_locker_cap(arg1, arg5));
        arg2.periods_blocking = arg3;
        arg2.periods_post_lockdown = arg4;
        let v0 = UpdateLockPeriodsEvent{
            locker_id             : 0x2::object::id<Locker>(arg2),
            periods_blocking      : arg3,
            periods_post_lockdown : arg4,
        };
        0x2::event::emit<UpdateLockPeriodsEvent>(v0);
    }

    public fun init_locker_v2(arg0: &mut AdminCap) {
        arg0.init_locker_v2 = true;
    }

    public fun is_position_locked(arg0: &mut Locker, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&arg0.positions, arg1)
    }

    public fun lock_position<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut Locker, arg3: &mut 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::PoolTrancheManager, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg5: 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<LockedPosition<T0, T1>> {
        assert!(!arg2.pause, 916023534273428375);
        let v0 = if (arg2.ignore_whitelist_providers) {
            true
        } else {
            let v1 = 0x2::tx_context::sender(arg8);
            0x2::vec_set::contains<address>(&arg2.whitelisted_providers, &v1)
        };
        assert!(v0, 9349734723203073);
        let v2 = 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&arg5);
        assert!(!0x2::object_table::contains<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&arg2.positions, v2), 9387246576346433);
        assert!(arg6 < 0x1::vector::length<u64>(&arg2.periods_blocking), 938724654546442874);
        let v3 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let v4 = 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::time_manager::epoch_next(v3 + 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::time_manager::epoch_to_seconds(*0x1::vector::borrow<u64>(&arg2.periods_blocking, arg6)));
        let v5 = 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::get_tranches(arg3, 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg4));
        assert!(0x1::vector::length<0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::PoolTranche>(v5) > 0, 9823742374723842);
        let v6 = 0x1::vector::empty<LockedPosition<T0, T1>>();
        let v7 = v2;
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::PoolTranche>(v5)) {
            let v9 = 0x1::vector::borrow_mut<0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::PoolTranche>(v5, v8);
            if (0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::is_filled(v9)) {
                v8 = v8 + 1;
                continue
            };
            let v10 = 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::get_duration_profitabilities(v9);
            assert!(0x1::vector::length<u64>(&v10) == 0x1::vector::length<u64>(&arg2.periods_blocking), 93877534345684724);
            let (v11, v12) = 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::get_free_volume(v9);
            let v13 = if (v12) {
                0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::locker_utils::calculate_position_liquidity_in_token_a<T0, T1>(arg4, v7)
            } else {
                0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::locker_utils::calculate_position_liquidity_in_token_b<T0, T1>(arg4, v7)
            };
            let (v14, v15, v16, v17, v18) = if (v13 > v11) {
                let v19 = &mut arg5;
                let (v20, v21, v22, v23, v24) = split_position_internal<T0, T1>(arg0, arg1, arg4, v19, (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v11, (0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::consts::lock_liquidity_share_denom() as u128), v13) as u64), arg7, arg8);
                let v25 = v21;
                let v26 = v20;
                v7 = v25.position_id;
                0x2::object_table::add<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg2.positions, v25.position_id, v24);
                0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::fill_tranches(v9, v11);
                (v26.position_id, v26.liquidity, v22, v23, true)
            } else {
                0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::fill_tranches(v9, v13);
                (v7, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::info_liquidity(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::borrow_position_info(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::position_manager<T0, T1>(arg4), v7)), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), false)
            };
            let v27 = LockLiquidityInfo{
                total_lock_liquidity       : v15,
                current_lock_liquidity     : v15,
                last_remove_liquidity_time : 0,
            };
            let v28 = LockedPosition<T0, T1>{
                id                        : 0x2::object::new(arg8),
                position_id               : v14,
                tranche_id                : 0x2::object::id<0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::PoolTranche>(v9),
                start_lock_time           : v3,
                expiration_time           : v4,
                full_unlocking_time       : v4 + 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::time_manager::epoch_to_seconds(*0x1::vector::borrow<u64>(&arg2.periods_post_lockdown, arg6)),
                profitability             : *0x1::vector::borrow<u64>(&v10, arg6),
                last_reward_claim_epoch   : v3,
                last_growth_inside        : 0,
                accumulated_amount_earned : 0,
                lock_liquidity_info       : v27,
                coin_a                    : 0x2::balance::zero<T0>(),
                coin_b                    : 0x2::balance::zero<T1>(),
            };
            0x2::balance::join<T0>(&mut v28.coin_a, v16);
            0x2::balance::join<T1>(&mut v28.coin_b, v17);
            let v29 = CreateLockPositionEvent{
                lock_position_id        : 0x2::object::id<LockedPosition<T0, T1>>(&v28),
                position_id             : v28.position_id,
                tranche_id              : v28.tranche_id,
                total_lock_liquidity    : v28.lock_liquidity_info.total_lock_liquidity,
                start_lock_time         : v28.start_lock_time,
                expiration_time         : v28.expiration_time,
                full_unlocking_time     : v28.full_unlocking_time,
                profitability           : v28.profitability,
                last_reward_claim_epoch : v28.last_reward_claim_epoch,
                last_growth_inside      : v28.last_growth_inside,
            };
            0x2::event::emit<CreateLockPositionEvent>(v29);
            0x1::vector::push_back<LockedPosition<T0, T1>>(&mut v6, v28);
            if (!v18) {
                break
            };
            let v30 = v8 + 1;
            v8 = v30;
            assert!(v30 < 0x1::vector::length<0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::pool_tranche::PoolTranche>(v5) || v7 == v14, 92035925692467234);
        };
        0x2::object_table::add<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg2.positions, v2, arg5);
        v6
    }

    public(friend) fun lock_position_migrate<T0, T1>(arg0: &mut Locker, arg1: LockedPosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position {
        assert!(!arg0.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 < arg1.expiration_time, 99423692832693454);
        destroy<T0, T1>(arg1, arg3);
        0x2::object_table::remove<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg0.positions, arg1.position_id)
    }

    public fun locker_pause(arg0: &mut Locker, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.pause = arg1;
        let v0 = LockerPauseEvent{
            locker_id : 0x2::object::id<Locker>(arg0),
            pause     : arg1,
        };
        0x2::event::emit<LockerPauseEvent>(v0);
    }

    public fun pause(arg0: &Locker) : bool {
        arg0.pause
    }

    public fun remove_addresses_from_whitelist(arg0: &mut Locker, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::vec_set::contains<address>(&arg0.whitelisted_providers, &v1)) {
                0x2::vec_set::remove<address>(&mut arg0.whitelisted_providers, &v1);
                let v2 = RemoveAddressFromWhitelistProvidersEvent{address: v1};
                0x2::event::emit<RemoveAddressFromWhitelistProvidersEvent>(v2);
            };
            v0 = v0 + 1;
        };
    }

    fun remove_liquidity_and_collect_fee<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::collect_fee<T0, T1>(arg0, arg2, arg3, true);
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg6), 0x2::tx_context::sender(arg6));
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        if (0x2::balance::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg6), 0x2::tx_context::sender(arg6));
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun remove_lock_liquidity<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut Locker, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg4: LockedPosition<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
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
            let v3 = 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::time_manager::number_epochs_in_timestamp(v0 - arg4.lock_liquidity_info.last_remove_liquidity_time);
            assert!(v3 > 0, 91877547573637423);
            0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(arg4.lock_liquidity_info.total_lock_liquidity, (v3 as u128), (0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::time_manager::number_epochs_in_timestamp(arg4.full_unlocking_time - arg4.expiration_time) as u128))
        };
        let v4 = v2;
        assert!(v2 > 0, 91877547573637423);
        if (v2 > arg4.lock_liquidity_info.current_lock_liquidity) {
            v4 = arg4.lock_liquidity_info.current_lock_liquidity;
        };
        let v5 = 0x2::object_table::remove<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg2.positions, arg4.position_id);
        let v6 = &mut v5;
        let (v7, v8) = remove_liquidity_and_collect_fee<T0, T1>(arg0, arg1, arg3, v6, v4, arg5, arg6);
        if (v1) {
            let v9 = UnlockPositionEvent{lock_position_id: 0x2::object::id<LockedPosition<T0, T1>>(&arg4)};
            destroy<T0, T1>(arg4, arg6);
            0x2::event::emit<UnlockPositionEvent>(v9);
            0x2::transfer::public_transfer<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(v5, 0x2::tx_context::sender(arg6));
        } else {
            0x2::object_table::add<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg2.positions, arg4.position_id, v5);
            arg4.lock_liquidity_info.current_lock_liquidity = arg4.lock_liquidity_info.current_lock_liquidity - v4;
            arg4.lock_liquidity_info.last_remove_liquidity_time = 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::time_manager::epoch_start(v0);
            let v10 = UpdateLockLiquidityEvent{
                lock_position_id           : 0x2::object::id<LockedPosition<T0, T1>>(&arg4),
                current_lock_liquidity     : arg4.lock_liquidity_info.current_lock_liquidity,
                last_remove_liquidity_time : arg4.lock_liquidity_info.last_remove_liquidity_time,
            };
            0x2::event::emit<UpdateLockLiquidityEvent>(v10);
            0x2::transfer::public_transfer<LockedPosition<T0, T1>>(arg4, 0x2::tx_context::sender(arg6));
        };
        (v7, v8)
    }

    public entry fun remove_lock_liquidity_save<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut Locker, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg4: LockedPosition<T0, T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = remove_lock_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) >= arg5, 9367234807236103);
        assert!(0x2::balance::value<T1>(&v2) >= arg6, 9247240362830633);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg8), 0x2::tx_context::sender(arg8));
    }

    public fun revoke_admin(arg0: &mut Locker, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg1), 9630793046376343);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
    }

    public fun set_ignore_whitelist(arg0: &mut Locker, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.ignore_whitelist_providers = arg1;
        let v0 = SetIgnoreWhitelistProvidersEvent{ignore_whitelist_providers: arg1};
        0x2::event::emit<SetIgnoreWhitelistProvidersEvent>(v0);
    }

    public fun split_position<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut Locker, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg4: LockedPosition<T0, T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (LockedPosition<T0, T1>, LockedPosition<T0, T1>) {
        assert!(!arg2.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg6) / 1000 < arg4.expiration_time, 99423692832693454);
        assert!(arg5 <= 0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::consts::lock_liquidity_share_denom() && arg5 > 0, 902354235823942382);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg2.positions, arg4.position_id);
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
        let v10 = LockedPosition<T0, T1>{
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
            coin_a                    : 0x2::balance::split<T0>(&mut arg4.coin_a, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(0x2::balance::value<T0>(&arg4.coin_a), (arg5 as u64), (0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::consts::lock_liquidity_share_denom() as u64))),
            coin_b                    : 0x2::balance::split<T1>(&mut arg4.coin_b, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(0x2::balance::value<T1>(&arg4.coin_b), ((0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::consts::lock_liquidity_share_denom() - arg5) as u64), (0x2aaaf44f568c60b8add5a39e5e0e168b9bbb7455e5164638dbc55527918a22c2::consts::lock_liquidity_share_denom() as u64))),
        };
        0x2::balance::join<T0>(&mut v10.coin_a, v4);
        0x2::balance::join<T1>(&mut v10.coin_b, v5);
        0x2::object_table::add<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg2.positions, arg4.position_id, v0);
        0x2::object_table::add<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg2.positions, v10.position_id, v6);
        let v11 = 0x2::object::id<LockedPosition<T0, T1>>(&v10);
        let v12 = SplitPositionEvent{
            lock_position_id              : 0x2::object::id<LockedPosition<T0, T1>>(&arg4),
            new_lock_position_id          : v11,
            share_first_part              : arg5,
            new_total_lock_liquidity      : v10.lock_liquidity_info.total_lock_liquidity,
            new_current_lock_liquidity    : v10.lock_liquidity_info.current_lock_liquidity,
            new_last_growth_inside        : v10.last_growth_inside,
            new_accumulated_amount_earned : v10.accumulated_amount_earned,
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
        };
        0x2::event::emit<CreateLockPositionEvent>(v13);
        (arg4, v10)
    }

    fun split_position_internal<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (SplitPositionResult<T0, T1>, SplitPositionResult<T0, T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position) {
        let (v0, v1) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::tick_range(arg3);
        let (_, v3) = calculate_liquidity_split(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::liquidity(arg3), arg4);
        let v4 = v3;
        let (v5, v6) = remove_liquidity_and_collect_fee<T0, T1>(arg0, arg1, arg2, arg3, v3, arg5, arg6);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        let v11 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::open_position<T0, T1>(arg0, arg2, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(v0), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(v1), arg6);
        let (v12, v13) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_amount_by_liquidity(v0, v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg2), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg2), v3, true);
        let v14 = v13;
        if (v12 > v9) {
            let (v15, _, v17) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_liquidity_by_amount(v0, v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg2), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg2), v9, true);
            v14 = v17;
            v4 = v15;
        };
        if (v14 > v10) {
            let (v18, _, _) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_liquidity_by_amount(v0, v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg2), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg2), v10, false);
            v4 = v18;
        };
        let v21 = &mut v11;
        let (v22, v23) = add_liquidity_internal<T0, T1>(arg0, arg1, arg2, v21, v8, v7, v4, arg5);
        let v24 = SplitPositionResult<T0, T1>{
            position_id : 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(arg3),
            liquidity   : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::liquidity(arg3),
        };
        let v25 = SplitPositionResult<T0, T1>{
            position_id : 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&v11),
            liquidity   : v4,
        };
        (v24, v25, v22, v23, v11)
    }

    public fun unlock_position<T0, T1>(arg0: &mut Locker, arg1: LockedPosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position {
        assert!(!arg0.pause, 916023534273428375);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= arg1.full_unlocking_time, 98923745837578344);
        let v0 = UnlockPositionEvent{lock_position_id: 0x2::object::id<LockedPosition<T0, T1>>(&arg1)};
        destroy<T0, T1>(arg1, arg3);
        0x2::event::emit<UnlockPositionEvent>(v0);
        0x2::object_table::remove<0x2::object::ID, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position>(&mut arg0.positions, arg1.position_id)
    }

    public fun update_lock_periods(arg0: &mut Locker, arg1: vector<u64>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x1::vector::length<u64>(&arg1) > 0 && 0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2), 938724658124718472);
        arg0.periods_blocking = arg1;
        arg0.periods_post_lockdown = arg2;
        let v0 = UpdateLockPeriodsEvent{
            locker_id             : 0x2::object::id<Locker>(arg0),
            periods_blocking      : arg1,
            periods_post_lockdown : arg2,
        };
        0x2::event::emit<UpdateLockPeriodsEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

