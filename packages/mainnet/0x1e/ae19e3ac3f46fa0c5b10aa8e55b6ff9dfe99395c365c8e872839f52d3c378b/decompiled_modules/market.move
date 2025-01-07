module 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market {
    struct MarketPosition has store, key {
        id: 0x2::object::UID,
        market_state_id: 0x2::object::ID,
        expiry: u64,
        name: 0x1::ascii::String,
        url: 0x1::ascii::String,
        description: 0x1::ascii::String,
        lp_amount: u64,
    }

    struct MarketState<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        py_state_id: 0x2::object::ID,
        expiry: u64,
        total_pt: u64,
        total_sy: 0x2::balance::Balance<T0>,
        lp_supply: u64,
        last_ln_implied_rate: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        current_exchange_rate: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign,
        scalar_root: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign,
        initial_anchor: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign,
        ln_fee_rate_root: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64,
        market_cap: u64,
    }

    struct AddLiquidityEvent<phantom T0: drop> has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        pt_amount: u64,
        sy_amount: u64,
        lp_amount: u64,
        exchange_rate: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    struct RemoveLiquidityEvent<phantom T0: drop> has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        pt_amount: u64,
        sy_amount: u64,
        lp_amount: u64,
    }

    struct SwapEvent<phantom T0: drop> has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        pt_amount: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign,
        sy_amount: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign,
        fee: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign,
        reserve_fee: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign,
        exchange_rate: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    public fun burn_lp<T0: drop>(arg0: address, arg1: u64, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition, arg3: &mut MarketState<T0>, arg4: &mut MarketPosition, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_lp_amount_is_zero());
        assert!(arg4.lp_amount >= arg1, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_insufficient_lp_for_burn());
        assert!(arg3.py_state_id == 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_state_id(arg2), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_py_state());
        assert!(arg4.market_state_id == 0x2::object::id<MarketState<T0>>(arg3), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_market_position());
        let v0 = (((arg1 as u128) * (0x2::balance::value<T0>(&arg3.total_sy) as u128) / (arg3.lp_supply as u128)) as u64);
        let v1 = (((arg1 as u128) * (arg3.total_pt as u128) / (arg3.lp_supply as u128)) as u64);
        assert!(v0 > 0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_sy_amount_is_zero());
        assert!(v1 > 0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_pt_amount_is_zero());
        arg3.lp_supply = arg3.lp_supply - arg1;
        arg4.lp_amount = arg4.lp_amount - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg3.total_sy, v0, arg5), arg0);
        arg3.total_pt = arg3.total_pt - v1;
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::join_pt(arg2, v1);
        let v2 = RemoveLiquidityEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg3),
            expiry          : arg3.expiry,
            pt_amount       : v1,
            sy_amount       : v0,
            lp_amount       : arg1,
        };
        0x2::event::emit<RemoveLiquidityEvent<T0>>(v2);
    }

    public(friend) fun create<T0: drop>(arg0: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg1: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketState<T0>{
            id                    : 0x2::object::new(arg5),
            py_state_id           : 0x2::object::id<0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>>(arg0),
            expiry                : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_state_expiry<T0>(arg0),
            total_pt              : 0,
            total_sy              : 0x2::balance::zero<T0>(),
            lp_supply             : 0,
            last_ln_implied_rate  : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero(),
            current_exchange_rate : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::zero(),
            scalar_root           : arg1,
            initial_anchor        : arg2,
            ln_fee_rate_root      : arg3,
            market_cap            : arg4,
        };
        0x2::transfer::share_object<MarketState<T0>>(v0);
    }

    public(friend) fun create_position<T0: drop>(arg0: &MarketState<T0>, arg1: &mut 0x2::tx_context::TxContext) : MarketPosition {
        MarketPosition{
            id              : 0x2::object::new(arg1),
            market_state_id : 0x2::object::id<MarketState<T0>>(arg0),
            expiry          : arg0.expiry,
            name            : 0x1::ascii::string(b"LP"),
            url             : 0x1::ascii::string(b""),
            description     : 0x1::ascii::string(b"Nemo LP"),
            lp_amount       : 0,
        }
    }

    fun execute_trade_core<T0: drop>(arg0: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign, arg1: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::MarketFactoryConfig, arg2: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg3: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg4: &MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign) {
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::less(arg0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::from_uint64(arg4.total_pt)), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_insufficient_pt_for_swap());
        let v0 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::current_py_index<T0>(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::cache_in_same_block(arg2), arg3, arg6);
        let v1 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::multiply(v0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg4.total_sy)));
        let v2 = arg4.expiry - 0x2::clock::timestamp_ms(arg5);
        let v3 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_math::get_rate_scalar(arg4.scalar_root, v2);
        let v4 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_math::get_rate_anchor(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(arg4.total_pt), arg4.last_ln_implied_rate, v1, v3, v2);
        let v5 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_math::get_exchange_rate_from_implied_rate(arg4.ln_fee_rate_root, v2);
        let v6 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_math::get_exchange_rate(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::create_from_raw_value(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::get_raw_value(v1), true), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::from_uint64(arg4.total_pt), v3, v4, arg0);
        let v7 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::neg(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::div(arg0, v6));
        let v8 = if (0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::is_positive(arg0)) {
            assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::greater_or_equal(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::div(v6, v5), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::one()), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_exchange_rate_below_one());
            0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::mul(v7, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::sub(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::one(), v5))
        } else {
            0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::neg(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::div(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::mul(v7, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::sub(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::one(), v5)), v5))
        };
        let v9 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::sub(v7, v8);
        let v10 = if (0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::less(v9, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::zero())) {
            0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::neg(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::div(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::sub(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::add(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::abs(v9), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::create_from_raw_value(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::get_raw_value(v0), true)), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::create_from_raw_value(1, true)), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::create_from_raw_value(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::get_raw_value(v0), true)))
        } else {
            0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::div(v9, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::create_from_raw_value(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::get_raw_value(v0), true))
        };
        (v10, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::div(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::mul(v8, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::create_from_raw_value(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::get_raw_value(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::get_reserve_fee_percent(arg1)), true)), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::create_from_raw_value(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::get_raw_value(v0), true)), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::div(v8, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::create_from_raw_value(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::get_raw_value(v0), true)), v3, v4)
    }

    fun get_exchange_rate<T0: drop>(arg0: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg1: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg2: &MarketState<T0>, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::multiply(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::current_py_index<T0>(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::cache_in_same_block(arg0), arg1, arg5), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg2.total_sy)));
        let v1 = arg2.expiry - 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_math::get_rate_scalar(arg2.scalar_root, v1);
        let v3 = arg2.initial_anchor;
        if (!arg4) {
            v3 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_math::get_rate_anchor(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(arg2.total_pt), arg2.last_ln_implied_rate, v0, v2, v1);
        };
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_math::get_exchange_rate(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::create_from_raw_value(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::get_raw_value(v0), true), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::from_uint64(arg2.total_pt), v2, v3, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::zero())
    }

    fun get_ln_implied_rate(arg0: 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u64) : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::FixedPoint64 {
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64::mul_div(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::remove_sign(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math_fixed64_with_sign::ln(arg0)), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(31536000000), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::from_uint64(arg1))
    }

    public fun get_lp_position(arg0: &MarketPosition) : u64 {
        arg0.lp_amount
    }

    public fun get_sy_amount_in_for_exact_pt_out<T0: drop>(arg0: u64, arg1: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::MarketFactoryConfig, arg2: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg3: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg4: &mut MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, _, _, _) = execute_trade_core<T0>(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::from_uint64(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::truncate(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::add(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::neg(v0), v1))
    }

    public fun get_sy_amount_in_for_exact_yt_out<T0: drop>(arg0: u64, arg1: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::MarketFactoryConfig, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg3: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg4: &mut MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::get_sy_amount_in_for_exact_py_out<T0>(arg0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::cache_in_same_block(arg3), arg2, arg6);
        let v1 = get_sy_amount_out_for_exact_pt_in<T0>(arg0, arg3, arg2, arg1, arg4, arg5, arg6);
        assert!(v0 > v1, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::repay_sy_in_exceeds_expected_sy_in());
        (v0, v1)
    }

    public fun get_sy_amount_out_for_exact_pt_in<T0: drop>(arg0: u64, arg1: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg3: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::MarketFactoryConfig, arg4: &mut MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, _, _, _, _) = execute_trade_core<T0>(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::neg(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::from_uint64(arg0)), arg3, arg1, arg2, arg4, arg5, arg6);
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::truncate(v0)
    }

    public fun mint_lp<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition, arg3: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg4: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg5: &mut MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MarketPosition) {
        let (v0, _) = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::get_py_amount(arg2);
        assert!(0x2::clock::timestamp_ms(arg6) < 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_expiry(arg2), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_expired());
        assert!(arg1 > 0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_pt_amount_is_zero());
        assert!(v0 >= arg1, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_insufficient_pt_in_for_mint_lp());
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_state_id(arg2) == arg5.py_state_id, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_py_state());
        let v2 = create_position<T0>(arg5, arg7);
        let v3 = &mut v2;
        let v4 = mint_lp_internal<T0>(arg1, arg0, arg2, arg3, v3, arg4, arg5, arg6, arg7);
        assert!(arg5.market_cap == 0 || 0x2::balance::value<T0>(&arg5.total_sy) <= arg5.market_cap, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_cap_exceeded());
        (v4, v2)
    }

    public(friend) fun mint_lp_internal<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition, arg3: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg4: &mut MarketPosition, arg5: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        assert!(0x2::balance::value<T0>(&v0) > 0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_sy_amount_is_zero());
        let v1 = 0x2::balance::value<T0>(&v0);
        if (arg6.lp_supply == 0) {
            let v3 = (0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::math128::sqrt((arg0 as u128) * (v1 as u128)) as u64);
            assert!(v3 >= 1000, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_liquidity_too_low());
            let v4 = v3 - 1000;
            0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::split_pt(arg2, arg0);
            arg6.total_pt = arg6.total_pt + arg0;
            0x2::balance::join<T0>(&mut arg6.total_sy, 0x2::balance::split<T0>(&mut v0, v1));
            arg6.lp_supply = v4 + 1000;
            arg4.lp_amount = v4;
            let v5 = get_exchange_rate<T0>(arg5, arg3, arg6, arg7, true, arg8);
            arg6.last_ln_implied_rate = get_ln_implied_rate(v5, arg6.expiry - 0x2::clock::timestamp_ms(arg7));
            assert!(!0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::equal(arg6.last_ln_implied_rate, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64::zero()), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_ln_implied_rate_is_zero());
            let v6 = AddLiquidityEvent<T0>{
                market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
                expiry          : arg6.expiry,
                pt_amount       : arg0,
                sy_amount       : v1,
                lp_amount       : v4,
                exchange_rate   : v5,
            };
            0x2::event::emit<AddLiquidityEvent<T0>>(v6);
            0x2::coin::from_balance<T0>(v0, arg8)
        } else {
            let v7 = (((arg0 as u128) * (arg6.lp_supply as u128) / (arg6.total_pt as u128)) as u64);
            let v8 = (((v1 as u128) * (arg6.lp_supply as u128) / (0x2::balance::value<T0>(&arg6.total_sy) as u128)) as u64);
            assert!(v7 > 0 && v8 > 0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_lp_amount_is_zero());
            if (v7 < v8) {
                arg6.total_pt = arg6.total_pt + arg0;
                0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::split_pt(arg2, arg0);
                let v9 = 0x2::balance::split<T0>(&mut v0, ((((0x2::balance::value<T0>(&arg6.total_sy) as u128) * (v7 as u128) + ((arg6.lp_supply - 1) as u128)) / (arg6.lp_supply as u128)) as u64));
                assert!(0x2::balance::value<T0>(&v9) > 0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_sy_amount_is_zero());
                0x2::balance::join<T0>(&mut arg6.total_sy, v9);
                arg6.lp_supply = arg6.lp_supply + v7;
                arg4.lp_amount = arg4.lp_amount + v7;
                let v10 = get_exchange_rate<T0>(arg5, arg3, arg6, arg7, true, arg8);
                let v11 = AddLiquidityEvent<T0>{
                    market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
                    expiry          : arg6.expiry,
                    pt_amount       : arg0,
                    sy_amount       : 0x2::balance::value<T0>(&v9),
                    lp_amount       : v7,
                    exchange_rate   : v10,
                };
                0x2::event::emit<AddLiquidityEvent<T0>>(v11);
                0x2::coin::from_balance<T0>(v0, arg8)
            } else {
                0x2::balance::join<T0>(&mut arg6.total_sy, 0x2::balance::split<T0>(&mut v0, v1));
                let v12 = ((((arg6.total_pt as u128) * (v8 as u128) + ((arg6.lp_supply - 1) as u128)) / (arg6.lp_supply as u128)) as u64);
                assert!(v12 > 0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_pt_amount_is_zero());
                0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::split_pt(arg2, v12);
                arg6.total_pt = arg6.total_pt + v12;
                arg6.lp_supply = arg6.lp_supply + v8;
                arg4.lp_amount = arg4.lp_amount + v8;
                let v13 = get_exchange_rate<T0>(arg5, arg3, arg6, arg7, true, arg8);
                let v14 = AddLiquidityEvent<T0>{
                    market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
                    expiry          : arg6.expiry,
                    pt_amount       : v12,
                    sy_amount       : v1,
                    lp_amount       : v8,
                    exchange_rate   : v13,
                };
                0x2::event::emit<AddLiquidityEvent<T0>>(v14);
                0x2::coin::from_balance<T0>(v0, arg8)
            }
        }
    }

    public fun swap_exact_pt_for_sy<T0: drop>(arg0: u64, arg1: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg3: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg4: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::MarketFactoryConfig, arg5: &mut MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, _) = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::get_py_amount(arg1);
        assert!(v0 >= arg0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_insufficient_pt_in_for_mint_lp());
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_state_id(arg1) == arg5.py_state_id, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_py_state());
        assert!(arg5.py_state_id == 0x2::object::id<0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>>(arg2), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_py_state());
        let (v2, v3, v4, _, _) = execute_trade_core<T0>(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::neg(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::from_uint64(arg0)), arg4, arg3, arg2, arg5, arg6, arg7);
        arg5.total_pt = arg5.total_pt + arg0;
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::split_pt(arg1, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg5.total_sy, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::truncate(v3), arg7), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::get_treasury(arg4));
        let v7 = get_exchange_rate<T0>(arg3, arg2, arg5, arg6, false, arg7);
        arg5.last_ln_implied_rate = get_ln_implied_rate(v7, arg5.expiry - 0x2::clock::timestamp_ms(arg6));
        let v8 = SwapEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg5),
            expiry          : arg5.expiry,
            pt_amount       : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::neg(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::from_uint64(arg0)),
            sy_amount       : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::neg(v2),
            fee             : v4,
            reserve_fee     : v3,
            exchange_rate   : v7,
        };
        0x2::event::emit<SwapEvent<T0>>(v8);
        0x2::coin::take<T0>(&mut arg5.total_sy, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::truncate(v2), arg7)
    }

    public fun swap_exact_yt_for_sy<T0: drop>(arg0: u64, arg1: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg3: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg4: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::MarketFactoryConfig, arg5: &mut MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (_, v1) = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::get_py_amount(arg1);
        assert!(v1 >= arg0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_insufficient_yt_balance_swap());
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_state_id(arg1) == arg5.py_state_id, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_py_state());
        assert!(arg5.py_state_id == 0x2::object::id<0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>>(arg2), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_py_state());
        let v2 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::split_yt(arg1, arg0);
        let (v3, v4) = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::borrow_pt_amount<T0>(arg1, v2, arg2, arg7);
        let v5 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::redeem_py<T0>(arg0, v3, arg1, arg2, arg3, arg6, arg7);
        let v6 = swap_sy_for_exact_pt<T0>(v2, v5, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::repay_pt_amount<T0>(arg1, arg2, v4, arg7);
        v6
    }

    public fun swap_sy_for_exact_pt<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition, arg3: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg4: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg5: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::MarketFactoryConfig, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_state_id(arg2) == arg6.py_state_id, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_py_state());
        assert!(arg6.py_state_id == 0x2::object::id<0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>>(arg3), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_py_state());
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let (v1, v2, v3, _, _) = execute_trade_core<T0>(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::from_uint64(arg0), arg5, arg4, arg3, arg6, arg7, arg8);
        let v6 = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::neg(v1);
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::truncate(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::add(v6, v2)) <= 0x2::balance::value<T0>(&v0), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_insufficient_sy_for_swap());
        0x2::balance::join<T0>(&mut arg6.total_sy, 0x2::balance::split<T0>(&mut v0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::truncate(v6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::truncate(v2)), arg8), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::get_treasury(arg5));
        arg6.total_pt = arg6.total_pt - arg0;
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::join_pt(arg2, arg0);
        let v7 = get_exchange_rate<T0>(arg4, arg3, arg6, arg7, false, arg8);
        arg6.last_ln_implied_rate = get_ln_implied_rate(v7, arg6.expiry - 0x2::clock::timestamp_ms(arg7));
        let v8 = SwapEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
            expiry          : arg6.expiry,
            pt_amount       : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::neg(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::from_uint64(arg0)),
            sy_amount       : v6,
            fee             : v3,
            reserve_fee     : v2,
            exchange_rate   : v7,
        };
        0x2::event::emit<SwapEvent<T0>>(v8);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public fun swap_sy_for_exact_yt<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyPosition, arg3: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg4: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::sy::State, arg5: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg6: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::py_state_id(arg2) == arg7.py_state_id, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_py_state());
        assert!(arg7.py_state_id == 0x2::object::id<0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>>(arg3), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_invalid_py_state());
        let (v0, v1) = get_sy_amount_in_for_exact_yt_out<T0>(arg0, arg6, arg3, arg5, arg7, arg8, arg9);
        assert!(v0 - v1 <= 0x2::coin::value<T0>(&arg1), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_insufficient_sy_in_for_swap_yt());
        let (v2, v3) = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::sy::borrow<T0>(v1, arg4, arg9);
        0x2::coin::join<T0>(&mut arg1, v2);
        let (_, v5) = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::get_py_amount(arg2);
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::mint_py<T0>(0x2::coin::split<T0>(&mut arg1, v0, arg9), arg2, arg3, arg5, arg8, arg9);
        let (_, v7) = 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::get_py_amount(arg2);
        assert!(v7 - v5 == arg0, 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::error::market_pt_amount_is_zero());
        let v8 = swap_exact_pt_for_sy<T0>(arg0, arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::update_user_interest<T0>(0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::cache_in_same_block(arg5), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::treasury(arg5), 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::interest_fee_rate(arg5), arg2, arg3, arg9);
        0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::sy::repay<T0>(v3, v8, arg4, arg9);
        arg1
    }

    public fun update_current_exchange_rate<T0: drop>(arg0: &0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::yield_factory::YieldFactoryConfig, arg1: &mut 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::py::PyState<T0>, arg2: &mut MarketState<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x780911cb11b6e6df09b2020d576810341c2df462c32047ab32f71316e44d2f5d::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = get_exchange_rate<T0>(arg0, arg1, arg2, arg3, false, arg4);
        arg2.current_exchange_rate = v0;
        v0
    }

    // decompiled from Move bytecode v6
}

