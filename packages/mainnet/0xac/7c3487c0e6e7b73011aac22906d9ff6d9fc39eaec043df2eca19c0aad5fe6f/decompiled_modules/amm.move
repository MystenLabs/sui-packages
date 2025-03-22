module 0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::amm {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Market<phantom T0, phantom T1> has store {
        pt_balance: 0x2::balance::Balance<T0>,
        sy_balance: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        total_pt: u64,
        total_sy: u64,
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

    struct SellYoBorrowPt<phantom T0, phantom T1> {
        amount: u64,
    }

    struct BuyYoBorrowSy<phantom T0, phantom T1> {
        amount: u64,
    }

    struct AddLiquidityEvent<phantom T0, phantom T1> has copy, drop {
        pt_amount: u64,
        sy_amount: u64,
        lp_amount: u64,
        exchange_rate: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        sender: address,
        is_bootstrap: bool,
    }

    struct RemoveLiquidityEvent<phantom T0, phantom T1> has copy, drop {
        pt_amount: u64,
        sy_amount: u64,
        lp_amount: u64,
        sender: address,
    }

    struct SwapExactPtForSyEvent<phantom T0, phantom T1> has copy, drop {
        pt_amount: u64,
        sy_amount: u64,
        sy_fee_amount: u64,
        exchange_rate: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        sender: address,
    }

    struct SwapSyForExactPtEvent<phantom T0, phantom T1> has copy, drop {
        pt_amount: u64,
        sy_amount: u64,
        sy_fee_amount: u64,
        exchange_rate: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        sender: address,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v3 = arg0.total_pt;
        let v4 = arg0.total_sy;
        let v5 = 0;
        let (v6, v7, v8) = if (v2 == 0) {
            v5 = 1000;
            (0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::utils::mulsqrt_u64(v0, v1) - 1000, v0, v1)
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
        0x2::coin::put<T0>(&mut arg0.pt_balance, 0x2::coin::split<T0>(&mut arg1, v7, arg5));
        arg0.total_pt = arg0.total_pt + v7;
        if (v7 != v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        if (v8 > v1) {
            abort 2
        };
        0x2::coin::put<T1>(&mut arg0.sy_balance, 0x2::coin::split<T1>(&mut arg2, v8, arg5));
        arg0.total_sy = arg0.total_sy + v8;
        if (v8 != v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        if (v5 != 0) {
            set_initial_ln_implied_rate<T0, T1>(arg0, arg3, arg4);
        };
        let v12 = 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v6 + v5);
        if (v5 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::from_balance<LP<T0, T1>>(v12, arg5), @0x0);
        } else {
            0x2::balance::destroy_zero<LP<T0, T1>>(v12);
        };
        let v13 = AddLiquidityEvent<T0, T1>{
            pt_amount     : v7,
            sy_amount     : v8,
            lp_amount     : v6,
            exchange_rate : arg3,
            sender        : 0x2::tx_context::sender(arg5),
            is_bootstrap  : v2 == 0,
        };
        0x2::event::emit<AddLiquidityEvent<T0, T1>>(v13);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::split<LP<T0, T1>>(&mut v12, v6), arg5)
    }

    public fun borrow_pt<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (SellYoBorrowPt<T0, T1>, 0x2::coin::Coin<T0>) {
        if (is_expired<T0, T1>(arg0, arg2)) {
            abort 3
        };
        let v0 = SellYoBorrowPt<T0, T1>{amount: arg1};
        (v0, 0x2::coin::take<T0>(&mut arg0.pt_balance, arg1, arg3))
    }

    public fun borrow_sy<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (BuyYoBorrowSy<T0, T1>, 0x2::coin::Coin<T1>) {
        if (is_expired<T0, T1>(arg0, arg2)) {
            abort 3
        };
        let v0 = BuyYoBorrowSy<T0, T1>{amount: arg1};
        (v0, 0x2::coin::take<T1>(&mut arg0.sy_balance, arg1, arg3))
    }

    public fun calc_trade(arg0: u64, arg1: PreComputeMarket, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: u64, arg4: bool) : (u64, u64) {
        let v0 = get_exchange_rate_pt_to_asset(arg0, arg1.total_asset, arg1.rate_scalar, arg1.rate_anchor, arg3, arg4);
        let v1 = ((((arg3 as u128) << 64) / 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::math_fixed64::mul_div(v0, arg1.fee_rate, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1)))) as u64);
        (0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::utils::asset_to_sy(v1, arg2), 0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::utils::asset_to_sy(((((arg3 as u128) << 64) / 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(v0)) as u64) - v1, arg2))
    }

    public fun claim_fee<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg1) == arg0.withdraw_fee_address, 9);
        0x2::coin::take<T1>(&mut arg0.fee_balance, 0x2::balance::value<T1>(&arg0.fee_balance), arg1)
    }

    public fun create_new_market<T0, T1>(arg0: u64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Market<T0, T1> {
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Market<T0, T1>{
            pt_balance           : 0x2::balance::zero<T0>(),
            sy_balance           : 0x2::balance::zero<T1>(),
            lp_supply            : 0x2::balance::create_supply<LP<T0, T1>>(v0),
            total_pt             : 0,
            total_sy             : 0,
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

    fun get_exchange_rate_from_implied_rate(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: u64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::math_fixed64::exp(0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::math_utils::muldiv_fixed64_u64_u64(arg0, arg1, 31536000000))
    }

    public fun get_exchange_rate_pt_to_asset(arg0: u64, arg1: u64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: u64, arg5: bool) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        let v0 = if (arg5) {
            arg0 + arg4
        } else {
            arg0 - arg4
        };
        let v1 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((v0 as u128), (arg0 as u128) + (arg1 as u128));
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::greater(v1, get_max_market_proportion())) {
            abort 7
        };
        let v2 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(v1), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::sub(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1), v1)));
        let v3 = if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::less(v2, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1))) {
            0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::sub(arg3, 0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::math_utils::div_fixed64(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::legato_math::ln(v2), arg2))
        } else {
            0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::add(0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::math_utils::div_fixed64(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::legato_math::ln(v2), arg2), arg3)
        };
        assert!(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::greater(v3, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1)), 6);
        v3
    }

    fun get_ln_implied_rate(arg0: u64, arg1: u64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: u64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::math_utils::muldiv_fixed64_u64_u64(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::legato_math::ln(get_exchange_rate_pt_to_asset(arg0, arg1, arg2, arg3, 0, false)), 31536000000, arg4)
    }

    fun get_max_market_proportion() : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational(96, 100)
    }

    public fun get_rate_anchor(arg0: u64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: u64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: u64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        let v0 = get_exchange_rate_from_implied_rate(arg1, arg4);
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::less(v0, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1))) {
            abort 6
        };
        let v1 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg0 as u128), (arg0 as u128) + (arg2 as u128));
        let v2 = 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(v1), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::sub(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1), v1)));
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::less(v2, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1))) {
            0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::math_utils::add_div_fixed64(v0, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::legato_math::ln(v2), arg3)
        } else {
            0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::math_utils::sub_div_fixed64(v0, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::legato_math::ln(v2), arg3)
        }
    }

    public fun get_rate_scalar(arg0: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg1: u64) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        let v0 = 0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::math_utils::muldiv_fixed64_u64_u64(arg0, 31536000000, arg1);
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::equal(v0, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(0))) {
            abort 4
        };
        v0
    }

    public fun is_expired<T0, T1>(arg0: &Market<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.expiry
    }

    fun pre_compute_market<T0, T1>(arg0: &Market<T0, T1>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: &0x2::clock::Clock) : PreComputeMarket {
        pre_compute_value(arg0.total_pt, arg0.total_sy, arg0.ln_fee_rate_root, arg0.last_ln_implied_rate, arg0.scalar_root, arg1, arg0.expiry - 0x2::clock::timestamp_ms(arg2))
    }

    public fun pre_compute_value(arg0: u64, arg1: u64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg5: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg6: u64) : PreComputeMarket {
        let v0 = 0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::utils::sy_to_asset(arg1, arg5);
        assert!(arg0 > 0 && v0 > 0, 5);
        let v1 = get_rate_scalar(arg4, arg6);
        PreComputeMarket{
            rate_scalar : v1,
            total_asset : v0,
            rate_anchor : get_rate_anchor(arg0, arg3, v0, v1, arg6),
            fee_rate    : get_exchange_rate_from_implied_rate(arg2, arg6),
        }
    }

    public fun refund_pt<T0, T1>(arg0: &mut Market<T0, T1>, arg1: SellYoBorrowPt<T0, T1>, arg2: 0x2::coin::Coin<T0>) {
        let SellYoBorrowPt { amount: v0 } = arg1;
        assert!(0x2::coin::value<T0>(&arg2) == v0, 11);
        0x2::coin::put<T0>(&mut arg0.pt_balance, arg2);
    }

    public fun refund_sy<T0, T1>(arg0: &mut Market<T0, T1>, arg1: BuyYoBorrowSy<T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let BuyYoBorrowSy { amount: v0 } = arg1;
        assert!(0x2::coin::value<T1>(&arg2) == v0, 11);
        0x2::coin::put<T1>(&mut arg0.sy_balance, arg2);
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v2 = v0 * arg0.total_sy / v1;
        let v3 = v0 * arg0.total_pt / v1;
        assert!(v2 > 0 && v3 > 0, 1);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        arg0.total_pt = arg0.total_pt - v3;
        arg0.total_sy = arg0.total_sy - v2;
        let v4 = RemoveLiquidityEvent<T0, T1>{
            pt_amount : v3,
            sy_amount : v2,
            lp_amount : v0,
            sender    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RemoveLiquidityEvent<T0, T1>>(v4);
        (0x2::coin::take<T0>(&mut arg0.pt_balance, v3, arg2), 0x2::coin::take<T1>(&mut arg0.sy_balance, v2, arg2))
    }

    fun set_initial_ln_implied_rate<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: &0x2::clock::Clock) {
        if (is_expired<T0, T1>(arg0, arg2)) {
            abort 3
        };
        let v0 = arg0.expiry - 0x2::clock::timestamp_ms(arg2);
        arg0.last_ln_implied_rate = get_ln_implied_rate(arg0.total_pt, 0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::utils::sy_to_asset(arg0.total_sy, arg1), get_rate_scalar(arg0.scalar_root, v0), arg0.initial_anchor, v0);
    }

    fun set_new_market_market_trade<T0, T1>(arg0: &mut Market<T0, T1>, arg1: PreComputeMarket, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: &0x2::clock::Clock) {
        arg0.last_ln_implied_rate = get_ln_implied_rate(arg0.total_pt, 0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::utils::sy_to_asset(arg0.total_sy, arg2), arg1.rate_scalar, arg1.rate_anchor, arg0.expiry - 0x2::clock::timestamp_ms(arg3));
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::equal(arg0.last_ln_implied_rate, 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(0))) {
            abort 8
        };
    }

    public fun swap_exact_pt_for_sy<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (is_expired<T0, T1>(arg0, arg3)) {
            abort 3
        };
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = pre_compute_market<T0, T1>(arg0, arg1, arg3);
        let (v2, v3) = calc_trade(arg0.total_pt, v1, arg1, 0x2::coin::value<T0>(&arg2), true);
        let v4 = 0x2::coin::take<T1>(&mut arg0.sy_balance, v2, arg4);
        let v5 = 0x2::coin::take<T1>(&mut arg0.sy_balance, v3, arg4);
        arg0.total_sy = arg0.total_sy - v2 + v3;
        arg0.total_pt = arg0.total_pt + v0;
        0x2::coin::put<T0>(&mut arg0.pt_balance, arg2);
        set_new_market_market_trade<T0, T1>(arg0, v1, arg1, arg3);
        let v6 = SwapExactPtForSyEvent<T0, T1>{
            pt_amount     : v0,
            sy_amount     : 0x2::coin::value<T1>(&v4),
            sy_fee_amount : 0x2::coin::value<T1>(&v5),
            exchange_rate : arg1,
            sender        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SwapExactPtForSyEvent<T0, T1>>(v6);
        0x2::coin::put<T1>(&mut arg0.fee_balance, v5);
        v4
    }

    public fun swap_exact_pt_for_sy_with_hot_potato<T0, T1>(arg0: &mut Market<T0, T1>, arg1: BuyYoBorrowSy<T0, T1>, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, BuyYoBorrowSy<T0, T1>) {
        if (is_expired<T0, T1>(arg0, arg4)) {
            abort 3
        };
        let BuyYoBorrowSy { amount: v0 } = arg1;
        let v1 = pre_compute_market<T0, T1>(arg0, arg2, arg4);
        let (v2, v3) = calc_trade(arg0.total_pt, v1, arg2, 0x2::coin::value<T0>(&arg3), true);
        let (v4, v5) = if (v0 > v2) {
            (0, v0 - v2)
        } else {
            (v2 - v0, 0)
        };
        let v6 = 0x2::coin::take<T1>(&mut arg0.sy_balance, v4, arg5);
        let v7 = 0x2::coin::take<T1>(&mut arg0.sy_balance, v3, arg5);
        arg0.total_sy = arg0.total_sy - v4 + v3;
        arg0.total_pt = arg0.total_pt + 0x2::coin::value<T0>(&arg3);
        0x2::coin::put<T0>(&mut arg0.pt_balance, arg3);
        set_new_market_market_trade<T0, T1>(arg0, v1, arg2, arg4);
        if (0x2::balance::value<T1>(&arg0.sy_balance) + v5 < v4) {
            abort 2
        };
        let v8 = SwapExactPtForSyEvent<T0, T1>{
            pt_amount     : 0x2::coin::value<T0>(&arg3),
            sy_amount     : v4,
            sy_fee_amount : 0x2::coin::value<T1>(&v7),
            exchange_rate : arg2,
            sender        : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<SwapExactPtForSyEvent<T0, T1>>(v8);
        0x2::coin::put<T1>(&mut arg0.fee_balance, v7);
        let v9 = BuyYoBorrowSy<T0, T1>{amount: v5};
        (v6, v9)
    }

    public fun swap_sy_for_exact_pt<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        if (is_expired<T0, T1>(arg0, arg4)) {
            abort 3
        };
        let v0 = pre_compute_market<T0, T1>(arg0, arg1, arg4);
        let (v1, v2) = calc_trade(arg0.total_pt, v0, arg1, arg3, false);
        assert!(0x2::coin::value<T1>(&arg2) >= v1 + v2, 10);
        arg0.total_sy = arg0.total_sy + v1;
        0x2::coin::put<T1>(&mut arg0.sy_balance, 0x2::coin::split<T1>(&mut arg2, v1, arg5));
        arg0.total_pt = arg0.total_pt - arg3;
        let v3 = 0x2::coin::take<T0>(&mut arg0.pt_balance, arg3, arg5);
        set_new_market_market_trade<T0, T1>(arg0, v0, arg1, arg4);
        0x2::coin::put<T1>(&mut arg0.fee_balance, 0x2::coin::split<T1>(&mut arg2, v2, arg5));
        (arg2, v3)
    }

    public fun swap_sy_for_exact_pt_with_hot_potato<T0, T1>(arg0: &mut Market<T0, T1>, arg1: SellYoBorrowPt<T0, T1>, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, SellYoBorrowPt<T0, T1>) {
        if (is_expired<T0, T1>(arg0, arg5)) {
            abort 3
        };
        let SellYoBorrowPt { amount: v0 } = arg1;
        let v1 = pre_compute_market<T0, T1>(arg0, arg2, arg5);
        let (v2, v3) = calc_trade(arg0.total_pt, v1, arg2, arg4, false);
        assert!(0x2::coin::value<T1>(&arg3) >= v2 + v3, 10);
        let v4 = 0x2::coin::split<T1>(&mut arg3, v3, arg6);
        arg0.total_sy = arg0.total_sy + v2;
        0x2::coin::put<T1>(&mut arg0.sy_balance, 0x2::coin::split<T1>(&mut arg3, v2, arg6));
        if (0x2::balance::value<T0>(&arg0.pt_balance) + v0 < arg4) {
            abort 2
        };
        let v5 = if (v0 > arg4) {
            let v5 = v0 - arg4;
            arg4 = 0;
            v5
        } else {
            arg4 = arg4 - v0;
            0
        };
        arg0.total_pt = arg0.total_pt - arg4;
        let v6 = 0x2::coin::take<T0>(&mut arg0.pt_balance, arg4, arg6);
        set_new_market_market_trade<T0, T1>(arg0, v1, arg2, arg5);
        let v7 = SwapSyForExactPtEvent<T0, T1>{
            pt_amount     : arg4,
            sy_amount     : v2,
            sy_fee_amount : 0x2::coin::value<T1>(&v4),
            exchange_rate : arg2,
            sender        : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<SwapSyForExactPtEvent<T0, T1>>(v7);
        0x2::coin::put<T1>(&mut arg0.fee_balance, v4);
        let v8 = SellYoBorrowPt<T0, T1>{amount: v5};
        (arg3, v6, v8)
    }

    // decompiled from Move bytecode v6
}

