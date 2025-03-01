module 0x4d4a7ad1a625db745e35349b906e9c8496fc00d4b78f6f2e47bcf527d5f7e9::amm {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Market<phantom T0, phantom T1> has store {
        total_pt: 0x2::balance::Balance<T0>,
        total_sy: 0x2::balance::Balance<T1>,
        total_lp: 0x2::balance::Supply<LP<T0, T1>>,
        scalar_root: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        initial_anchor: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        expiry: u64,
        ln_fee_rate_root: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        reserve_fee_percent: u64,
        last_ln_implied_rate: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        fee_balance: 0x2::balance::Balance<T1>,
        withdraw_fee_address: address,
    }

    struct PreComputeMarket has copy, drop {
        rate_scalar: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        total_asset: u64,
        rate_anchor: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        fee_rate: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.total_lp);
        let v3 = 0x2::balance::value<T0>(&arg0.total_pt);
        let v4 = 0x2::balance::value<T1>(&arg0.total_sy);
        let v5 = 0;
        let (v6, v7, v8) = if (v2 == 0) {
            v5 = 1000;
            (0x4d4a7ad1a625db745e35349b906e9c8496fc00d4b78f6f2e47bcf527d5f7e9::utils::mulsqrt_u64(v0, v1) - 1000, v0, v1)
        } else {
            let v9 = v0 * v2 / v3;
            let v10 = v1 * v2 / v4;
            if (v9 < v10) {
                (v9, v0, v4 * v9 / v2)
            } else {
                (v10, v3 * v10 / v2, v1)
            }
        };
        let v11 = if (v6 <= 0) {
            true
        } else if (v8 <= 0) {
            true
        } else {
            v7 <= 0
        };
        if (v11) {
            abort 1
        };
        if (v7 > v0) {
            abort 2
        };
        0x2::coin::put<T0>(&mut arg0.total_pt, 0x2::coin::split<T0>(&mut arg1, v7, arg5));
        if (v7 != v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        if (v8 > v1) {
            abort 2
        };
        0x2::coin::put<T1>(&mut arg0.total_sy, 0x2::coin::split<T1>(&mut arg2, v8, arg5));
        if (v8 != v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        if (v5 != 0) {
            set_initial_ln_implied_rate<T0, T1>(arg0, arg3, arg4);
        };
        let v12 = 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.total_lp, v6 + v5);
        if (v5 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::from_balance<LP<T0, T1>>(v12, arg5), @0x0);
        } else {
            0x2::balance::destroy_zero<LP<T0, T1>>(v12);
        };
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::split<LP<T0, T1>>(&mut v12, v6), arg5)
    }

    fun calc_trade_sell_pt<T0, T1>(arg0: &Market<T0, T1>, arg1: PreComputeMarket, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: u64) : (u64, u64) {
        let v0 = get_exchange_rate(0x2::balance::value<T0>(&arg0.total_pt), arg1.total_asset, arg1.rate_scalar, arg1.rate_anchor, arg3);
        let v1 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg3 as u128) << 64, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(v0));
        let v2 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::sub(arg1.fee_rate, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1));
        let v3 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(v0);
        0x1::debug::print<u128>(&v3);
        let v4 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(v2);
        0x1::debug::print<u128>(&v4);
        let v5 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::math_fixed64::mul_div(v1, v2, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1));
        let v6 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::sub(v1, v5);
        let v7 = 0x4d4a7ad1a625db745e35349b906e9c8496fc00d4b78f6f2e47bcf527d5f7e9::utils::asset_to_sy(((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(v6) >> 64) as u64), arg2);
        let v8 = 0x4d4a7ad1a625db745e35349b906e9c8496fc00d4b78f6f2e47bcf527d5f7e9::utils::asset_to_sy(((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(v5) >> 64) as u64), arg2);
        let v9 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(v5);
        0x1::debug::print<u128>(&v9);
        let v10 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(v6);
        0x1::debug::print<u128>(&v10);
        0x1::debug::print<u64>(&v7);
        0x1::debug::print<u64>(&v8);
        (v7, v8)
    }

    public fun claim_fee<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::take<T1>(&mut arg0.fee_balance, 0x2::balance::value<T1>(&arg0.fee_balance), arg1)
    }

    public fun create_new_market<T0, T1>(arg0: u64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Market<T0, T1> {
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Market<T0, T1>{
            total_pt             : 0x2::balance::zero<T0>(),
            total_sy             : 0x2::balance::zero<T1>(),
            total_lp             : 0x2::balance::create_supply<LP<T0, T1>>(v0),
            scalar_root          : arg1,
            initial_anchor       : arg2,
            expiry               : arg0,
            ln_fee_rate_root     : arg3,
            reserve_fee_percent  : 0,
            last_ln_implied_rate : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(0),
            fee_balance          : 0x2::balance::zero<T1>(),
            withdraw_fee_address : 0x2::tx_context::sender(arg5),
        };
        if (is_expired<T0, T1>(&v1, arg4)) {
            abort 3
        };
        v1
    }

    fun div_fixed64(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg0), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg1))
    }

    fun execute_trade_core_sell_pt<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T1>) {
        if (0x2::balance::value<T0>(&arg0.total_pt) < 0x2::coin::value<T0>(&arg2)) {
            abort 8
        };
        let v0 = pre_compute_value<T0, T1>(arg0, arg1, arg3);
        let (v1, v2) = calc_trade_sell_pt<T0, T1>(arg0, v0, arg1, 0x2::coin::value<T0>(&arg2));
        let v3 = 0x2::coin::take<T1>(&mut arg0.total_sy, v1, arg4);
        let v4 = 0x2::coin::take<T1>(&mut arg0.total_sy, v2, arg4);
        0x2::coin::put<T0>(&mut arg0.total_pt, arg2);
        set_new_market_market_trade<T0, T1>(arg0, v0, arg1, arg3);
        (v3, v4)
    }

    fun get_exchange_rate(arg0: u64, arg1: u64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: u64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        let v0 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg0 as u128) - (arg4 as u128), (arg0 as u128) + (arg1 as u128));
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::greater(v0, get_max_market_proportion())) {
            abort 7
        };
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::add(div_fixed64(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::legato_math::ln(v0), arg2), arg3)
    }

    fun get_exchange_rate_from_implied_rate(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: u64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::math_fixed64::exp(muldiv_fixed64_u128_u128(arg0, (arg1 as u128), (31536000 as u128)))
    }

    fun get_ln_implied_rate(arg0: u64, arg1: u64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: u64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        muldiv_fixed64(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::legato_math::ln(get_exchange_rate(arg0, arg1, arg2, arg3, 0)), arg2, (arg4 as u128))
    }

    fun get_max_market_proportion() : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational(96, 100)
    }

    fun get_rate_anchor(arg0: u64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: u64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: u64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        let v0 = get_exchange_rate_from_implied_rate(arg1, arg4);
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::less(v0, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1))) {
            abort 6
        };
        sub_div_fixed64(v0, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::legato_math::ln(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg0 as u128), (arg0 as u128) + (arg2 as u128))), arg3)
    }

    fun get_rate_scalar<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        let v0 = muldiv_fixed64_u128_u128(arg0.scalar_root, (31536000 as u128), (arg1 as u128));
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::equal(v0, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(0))) {
            abort 4
        };
        v0
    }

    public fun is_expired<T0, T1>(arg0: &Market<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.expiry
    }

    fun muldiv_fixed64(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: u128) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_raw_value((((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg0) as u256) * (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg1) as u256) / 36893488147419103232 / (arg2 as u256)) as u128))
    }

    fun muldiv_fixed64_u128_u128(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: u128, arg2: u128) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_raw_value((((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg0) as u256) * (arg1 as u256) / (arg2 as u256)) as u128))
    }

    fun pre_compute_value<T0, T1>(arg0: &Market<T0, T1>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: &0x2::clock::Clock) : PreComputeMarket {
        let v0 = arg0.expiry - 0x2::clock::timestamp_ms(arg2);
        let v1 = get_rate_scalar<T0, T1>(arg0, v0);
        let v2 = 0x2::balance::value<T0>(&arg0.total_pt);
        let v3 = 0x4d4a7ad1a625db745e35349b906e9c8496fc00d4b78f6f2e47bcf527d5f7e9::utils::sy_to_asset(0x2::balance::value<T1>(&arg0.total_sy), arg1);
        assert!(v2 > 0 && v3 > 0, 5);
        PreComputeMarket{
            rate_scalar : v1,
            total_asset : v3,
            rate_anchor : get_rate_anchor(v2, arg0.last_ln_implied_rate, v3, v1, v0),
            fee_rate    : get_exchange_rate_from_implied_rate(arg0.ln_fee_rate_root, v0),
        }
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.total_lp);
        let v2 = v0 * 0x2::balance::value<T1>(&arg0.total_sy) / v1;
        let v3 = v0 * 0x2::balance::value<T0>(&arg0.total_pt) / v1;
        assert!(v2 > 0 && v3 > 0, 1);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.total_lp, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.total_pt, v3, arg2), 0x2::coin::take<T1>(&mut arg0.total_sy, v2, arg2))
    }

    fun set_initial_ln_implied_rate<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: &0x2::clock::Clock) {
        if (is_expired<T0, T1>(arg0, arg2)) {
            abort 3
        };
        let v0 = arg0.expiry - 0x2::clock::timestamp_ms(arg2);
        arg0.last_ln_implied_rate = get_ln_implied_rate(0x2::balance::value<T0>(&arg0.total_pt), 0x4d4a7ad1a625db745e35349b906e9c8496fc00d4b78f6f2e47bcf527d5f7e9::utils::sy_to_asset(0x2::balance::value<T1>(&arg0.total_sy), arg1), get_rate_scalar<T0, T1>(arg0, v0), arg0.initial_anchor, v0);
    }

    fun set_new_market_market_trade<T0, T1>(arg0: &mut Market<T0, T1>, arg1: PreComputeMarket, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: &0x2::clock::Clock) {
        arg0.last_ln_implied_rate = get_ln_implied_rate(0x2::balance::value<T0>(&arg0.total_pt), 0x4d4a7ad1a625db745e35349b906e9c8496fc00d4b78f6f2e47bcf527d5f7e9::utils::sy_to_asset(0x2::balance::value<T1>(&arg0.total_sy), arg2), arg1.rate_scalar, arg1.rate_anchor, arg0.expiry - 0x2::clock::timestamp_ms(arg3));
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::equal(arg0.last_ln_implied_rate, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(0))) {
            abort 9
        };
    }

    fun sub_div_fixed64(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        let v0 = (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg2) as u256);
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_raw_value(((((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg0) as u256) * v0 - (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg1) as u256)) / v0) as u128))
    }

    public fun swap_exact_pt_for_sy<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (is_expired<T0, T1>(arg0, arg3)) {
            abort 3
        };
        let (v0, v1) = execute_trade_core_sell_pt<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::coin::put<T1>(&mut arg0.fee_balance, v1);
        v0
    }

    // decompiled from Move bytecode v6
}

