module 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market {
    struct MarketState<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        py_state_id: 0x2::object::ID,
        market_id: 0x1::string::String,
        expiry: u64,
        total_pt: u64,
        total_sy: 0x2::balance::Balance<T0>,
        lp_supply: u64,
        last_ln_implied_rate: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64,
        current_exchange_rate: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
        vault: 0x2::balance::Balance<T0>,
        scalar_root: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
        initial_anchor: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
        ln_fee_rate_root: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64,
        market_cap: u64,
        reward_pool: 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::RewardPool,
    }

    struct MarketStateCache<phantom T0: drop> has copy, drop {
        total_asset: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64,
        rate_scalar: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
        rate_anchor: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
        fee_rate: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
        time_to_expire: u64,
        index: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64,
    }

    struct AddLiquidityEvent<phantom T0: drop> has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        pt_amount: u64,
        sy_amount: u64,
        lp_amount: u64,
        exchange_rate: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
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
        pt_amount: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
        sy_amount: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
        fee: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
        reserve_fee: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
        exchange_rate: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    public fun burn_lp<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg5: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg6: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceVoucher<T0>, arg7: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::yield_factory::YieldFactoryConfig, arg8: &mut MarketState<T0>, arg9: 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::MarketPosition, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::py_state_id(arg4) == arg8.py_state_id, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_invalid_py_state());
        assert!(arg8.py_state_id == 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>>(arg5), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_invalid_py_state());
        assert!(arg1 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_lp_amount_is_zero());
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::market_state_id(&arg9) == 0x2::object::id<MarketState<T0>>(arg8), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_invalid_market_position());
        let v0 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::yield_factory::redeem_due_interest<T0>(arg0, arg4, arg5, arg6, arg7, arg10, arg11);
        let v1 = (((arg1 as u128) * (0x2::balance::value<T0>(&arg8.total_sy) as u128) / (arg8.lp_supply as u128)) as u64);
        let v2 = (((arg1 as u128) * (arg8.total_pt as u128) / (arg8.lp_supply as u128)) as u64);
        assert!(v1 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_sy_amount_is_zero());
        assert!(v2 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_pt_amount_is_zero());
        assert!(v1 >= arg2, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_slippage_tolerance_not_met());
        assert!(v2 >= arg3, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_slippage_tolerance_not_met());
        arg8.lp_supply = arg8.lp_supply - arg1;
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::decrease_lp_amount(&mut arg9, arg1, arg10);
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::update_lp_display(&mut arg9, 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::decimal(arg4));
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::remove_stake_shares_with_reward_debt(&mut arg8.reward_pool, arg1, 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::lp_amount(&arg9), 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::borrow_reward_debt(&mut arg9), arg10);
        if (0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::lp_amount(&arg9) == 0) {
            0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::burn(arg9);
        } else {
            0x2::transfer::public_transfer<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::MarketPosition>(arg9, 0x2::tx_context::sender(arg11));
        };
        arg8.total_pt = arg8.total_pt - v2;
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::join_pt(arg4, v2, arg10);
        let v3 = RemoveLiquidityEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg8),
            expiry          : arg8.expiry,
            pt_amount       : v2,
            sy_amount       : v1,
            lp_amount       : arg1,
        };
        0x2::event::emit<RemoveLiquidityEvent<T0>>(v3);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::take<T0>(&mut arg8.total_sy, v1, arg11));
        v0
    }

    public(friend) fun check_market_cap<T0: drop>(arg0: &MarketState<T0>) {
        assert!(arg0.market_cap == 0 || 0x2::balance::value<T0>(&arg0.total_sy) <= arg0.market_cap, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_cap_exceeded());
    }

    public(friend) fun check_precondition<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &MarketState<T0>, arg2: &0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg3: &0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg4: &0x2::clock::Clock) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.expiry, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_expired());
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::py_state_id(arg2) == arg1.py_state_id, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_invalid_py_state());
        assert!(arg1.py_state_id == 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>>(arg3), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_invalid_py_state());
    }

    public fun claim_reward<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut MarketState<T0>, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::MarketPosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::market_state_id(arg2) == 0x2::object::id<MarketState<T0>>(arg1), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_invalid_market_position());
        let (v0, v1) = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::borrow_reward_debt_harvested(arg2);
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::claim_rewarder<T1>(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::lp_amount(arg2), &mut arg1.reward_pool, v0, v1, arg3, arg4)
    }

    public fun collect_fee_to_treasury<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut MarketState<T1>, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::State, arg3: &0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_global::MarketFactoryConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::redeem<T1, T0>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.vault, 0x2::balance::value<T1>(&arg1.vault)), arg4), arg2, arg4), 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_global::get_treasury(arg3));
    }

    public(friend) fun create<T0: drop>(arg0: 0x1::string::String, arg1: &0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg2: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, arg4: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = MarketState<T0>{
            id                    : 0x2::object::new(arg6),
            py_state_id           : 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>>(arg1),
            market_id             : arg0,
            expiry                : 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::expiry<T0>(arg1),
            total_pt              : 0,
            total_sy              : 0x2::balance::zero<T0>(),
            lp_supply             : 0,
            last_ln_implied_rate  : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::zero(),
            current_exchange_rate : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::zero(),
            vault                 : 0x2::balance::zero<T0>(),
            scalar_root           : arg2,
            initial_anchor        : arg3,
            ln_fee_rate_root      : arg4,
            market_cap            : arg5,
            reward_pool           : 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::init_reward_pool(arg6),
        };
        0x2::transfer::share_object<MarketState<T0>>(v0);
        0x2::object::id<MarketState<T0>>(&v0)
    }

    public(friend) fun create_position<T0: drop>(arg0: &MarketState<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::MarketPosition {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::mint(0x2::object::id<MarketState<T0>>(arg0), 0x1::string::from_ascii(0x1::type_name::get_module(&v0)), arg0.expiry, arg1, arg2)
    }

    public(friend) fun execute_trade_core<T0: drop>(arg0: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, arg1: &MarketStateCache<T0>, arg2: &0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_global::MarketFactoryConfig, arg3: &MarketState<T0>) : (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign) {
        assert!(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::less_or_equal(arg0, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(arg3.total_pt)), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_insufficient_pt_for_swap());
        let v0 = arg1.rate_scalar;
        let v1 = arg1.rate_anchor;
        let v2 = arg1.fee_rate;
        let v3 = arg1.index;
        let v4 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_math::get_exchange_rate(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::truncate(arg1.total_asset)), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(arg3.total_pt), v0, v1, arg0);
        let v5 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::neg(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::div(arg0, v4));
        let v6 = if (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::is_positive(arg0)) {
            assert!(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::greater_or_equal(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::div(v4, v2), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::one()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_exchange_rate_below_one());
            0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::mul(v5, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::sub(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::one(), v2))
        } else {
            0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::neg(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::div(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::mul(v5, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::sub(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::one(), v2)), v2))
        };
        let v7 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::sub(v5, v6);
        let v8 = if (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::less(v7, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::zero())) {
            0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::neg(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::div(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::sub(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::add(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::abs(v7), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(v3), true)), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::create_from_raw_value(1, true)), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(v3), true)))
        } else {
            0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::div(v7, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(v3), true))
        };
        (v8, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::div(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::mul(v6, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_global::get_reserve_fee_percent(arg2, arg3.market_id)), true)), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(v3), true)), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::div(v6, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(v3), true)), v0, v1)
    }

    public fun get_cached_exchange_rate<T0: drop>(arg0: &MarketStateCache<T0>) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        arg0.index
    }

    public fun get_cached_fee_rate<T0: drop>(arg0: &MarketStateCache<T0>) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign {
        arg0.fee_rate
    }

    public fun get_cached_index<T0: drop>(arg0: &MarketStateCache<T0>) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        arg0.index
    }

    public fun get_cached_rate_anchor<T0: drop>(arg0: &MarketStateCache<T0>) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign {
        arg0.rate_anchor
    }

    public fun get_cached_rate_scalar<T0: drop>(arg0: &MarketStateCache<T0>) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign {
        arg0.rate_scalar
    }

    public fun get_cached_time_to_expire<T0: drop>(arg0: &MarketStateCache<T0>) : u64 {
        arg0.time_to_expire
    }

    public fun get_cached_total_asset<T0: drop>(arg0: &MarketStateCache<T0>) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        arg0.total_asset
    }

    public(friend) fun get_exchange_rate<T0: drop>(arg0: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg1: &MarketState<T0>, arg2: &0x2::clock::Clock, arg3: bool) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign {
        if (arg3) {
            0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_math::get_exchange_rate(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::truncate(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::sy_to_asset(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::current_py_index<T0>(arg0), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg1.total_sy))))), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(arg1.total_pt), 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_math::get_rate_scalar(arg1.scalar_root, arg1.expiry - 0x2::clock::timestamp_ms(arg2)), arg1.initial_anchor, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::zero())
        } else {
            let (v1, v2, v3, _, _) = get_market_state<T0>(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::current_py_index<T0>(arg0), arg1, arg2);
            0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_math::get_exchange_rate(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::truncate(v1)), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(arg1.total_pt), v2, v3, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::zero())
        }
    }

    fun get_ln_implied_rate(arg0: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u64) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64::mul_div(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::remove_sign(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math_fixed64_with_sign::ln(arg0)), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::from_uint64(31536000000), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::from_uint64(arg1))
    }

    public fun get_market_lp_supply<T0: drop>(arg0: &MarketState<T0>) : u64 {
        arg0.lp_supply
    }

    fun get_market_state<T0: drop>(arg0: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, arg1: &MarketState<T0>, arg2: &0x2::clock::Clock) : (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::FixedPoint64WithSign, u64) {
        let v0 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::sy_to_asset(arg0, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg1.total_sy)));
        let v1 = arg1.expiry - 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_math::get_rate_scalar(arg1.scalar_root, v1);
        (v0, v2, 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_math::get_rate_anchor(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::from_uint64(arg1.total_pt), arg1.last_ln_implied_rate, v0, v2, v1), 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_math::get_exchange_rate_from_implied_rate(arg1.ln_fee_rate_root, v1), v1)
    }

    public(friend) fun get_market_state_cache<T0: drop>(arg0: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg1: &MarketState<T0>, arg2: &0x2::clock::Clock) : MarketStateCache<T0> {
        let v0 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::current_py_index<T0>(arg0);
        let (v1, v2, v3, v4, v5) = get_market_state<T0>(v0, arg1, arg2);
        MarketStateCache<T0>{
            total_asset    : v1,
            rate_scalar    : v2,
            rate_anchor    : v3,
            fee_rate       : v4,
            time_to_expire : v5,
            index          : v0,
        }
    }

    public(friend) fun get_market_state_cache_with_price_rate<T0: drop>(arg0: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, arg1: &MarketState<T0>, arg2: &0x2::clock::Clock) : MarketStateCache<T0> {
        let (v0, v1, v2, v3, v4) = get_market_state<T0>(arg0, arg1, arg2);
        MarketStateCache<T0>{
            total_asset    : v0,
            rate_scalar    : v1,
            rate_anchor    : v2,
            fee_rate       : v3,
            time_to_expire : v4,
            index          : arg0,
        }
    }

    public fun get_market_total_pt<T0: drop>(arg0: &MarketState<T0>) : u64 {
        arg0.total_pt
    }

    public fun get_market_total_sy<T0: drop>(arg0: &MarketState<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_sy)
    }

    public(friend) fun join_sy<T0: drop>(arg0: &mut MarketState<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.total_sy, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun market_expiry<T0: drop>(arg0: &MarketState<T0>) : u64 {
        arg0.expiry
    }

    public(friend) fun market_reward_pool<T0: drop>(arg0: &mut MarketState<T0>) : &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::RewardPool {
        &mut arg0.reward_pool
    }

    public fun mint_lp<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceVoucher<T0>, arg5: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg6: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::MarketPosition) {
        check_precondition<T0>(arg0, arg7, arg5, arg6, arg8);
        let (v0, _) = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::py_amount(arg5);
        assert!(arg2 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_pt_amount_is_zero());
        assert!(v0 >= arg2, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_insufficient_pt_in_for_mint_lp());
        assert!(arg7.lp_supply > 0 || arg2 == 0x2::coin::value<T0>(&arg1), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_invalid_market_position());
        let v2 = create_position<T0>(arg7, arg8, arg9);
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::set_py_index_stored<T0>(arg6, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::get_price<T0>(arg0, arg4, arg9)), arg8);
        let v3 = &mut v2;
        let v4 = mint_lp_internal<T0>(arg2, arg1, arg5, arg6, v3, arg7, arg8, arg9);
        assert!(arg7.market_cap == 0 || 0x2::balance::value<T0>(&arg7.total_sy) <= arg7.market_cap, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_cap_exceeded());
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::lp_amount(&v2) >= arg3, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::insufficient_lp_output());
        (v4, v2)
    }

    public(friend) fun mint_lp_internal<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg4: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::MarketPosition, arg5: &mut MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_sy_amount_is_zero());
        if (arg5.lp_supply == 0) {
            let v2 = (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::math128::sqrt((arg0 as u128) * (v0 as u128)) as u64);
            assert!(v2 >= 1000, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_liquidity_too_low());
            update_liquidity_state<T0>(arg5, arg2, arg4, arg3, arg0, v0, arg1, v2, v2 - 1000, true, arg6, arg7)
        } else {
            let v3 = (((arg0 as u128) * (arg5.lp_supply as u128) / (arg5.total_pt as u128)) as u64);
            let v4 = (((v0 as u128) * (arg5.lp_supply as u128) / (0x2::balance::value<T0>(&arg5.total_sy) as u128)) as u64);
            assert!(v3 > 0 && v4 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_lp_amount_is_zero());
            if (v3 < v4) {
                let v5 = ((((0x2::balance::value<T0>(&arg5.total_sy) as u128) * (v3 as u128) + ((arg5.lp_supply - 1) as u128)) / (arg5.lp_supply as u128)) as u64);
                assert!(v5 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_sy_amount_is_zero());
                update_liquidity_state<T0>(arg5, arg2, arg4, arg3, arg0, v5, arg1, v3, v3, false, arg6, arg7)
            } else {
                let v6 = ((((arg5.total_pt as u128) * (v4 as u128) + ((arg5.lp_supply - 1) as u128)) / (arg5.lp_supply as u128)) as u64);
                assert!(v6 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_pt_amount_is_zero());
                update_liquidity_state<T0>(arg5, arg2, arg4, arg3, v6, v0, arg1, v4, v4, false, arg6, arg7)
            }
        }
    }

    public fun seed_liquidity<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceVoucher<T0>, arg4: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg5: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg6: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::yield_factory::YieldFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::MarketPosition {
        check_precondition<T0>(arg0, arg7, arg4, arg5, arg8);
        let v0 = create_position<T0>(arg7, arg8, arg9);
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::set_py_index_stored<T0>(arg5, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::get_price<T0>(arg0, arg3, arg9)), arg8);
        let v1 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::yield_factory::mint_py_internal<T0>(0x2::coin::split<T0>(&mut arg1, 0x2::coin::value<T0>(&arg1) / 2, arg9), arg4, arg5, arg6, arg8, arg9);
        let v2 = &mut v0;
        let v3 = mint_lp_internal<T0>(v1, arg1, arg4, arg5, v2, arg7, arg8, arg9);
        assert!(0x2::coin::value<T0>(&v3) == 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_burn_sy_amount_is_zero());
        0x2::coin::destroy_zero<T0>(v3);
        assert!(arg7.market_cap == 0 || 0x2::balance::value<T0>(&arg7.total_sy) <= arg7.market_cap, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_cap_exceeded());
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::lp_amount(&v0) >= arg2, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::insufficient_lp_output());
        v0
    }

    public fun swap_exact_pt_for_sy<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: u64, arg2: u64, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg4: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg5: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceVoucher<T0>, arg6: &0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_precondition<T0>(arg0, arg7, arg3, arg4, arg8);
        let (v0, _) = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::py_amount(arg3);
        assert!(v0 >= arg1, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_insufficient_pt_in_for_mint_lp());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::set_py_index_stored<T0>(arg4, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::get_price<T0>(arg0, arg5, arg9)), arg8);
        let v2 = get_market_state_cache<T0>(arg4, arg7, arg8);
        let (v3, _, _) = swap_exact_pt_for_sy_internal<T0>(arg1, arg3, &v2, arg6, arg7, arg8, arg9);
        let v6 = v3;
        assert!(0x2::coin::value<T0>(&v6) >= arg2, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::wrong_slippage_tolerance());
        v6
    }

    public(friend) fun swap_exact_pt_for_sy_internal<T0: drop>(arg0: u64, arg1: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg2: &MarketStateCache<T0>, arg3: &0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_global::MarketFactoryConfig, arg4: &mut MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64) {
        let (v0, v1, v2, v3, v4) = execute_trade_core<T0>(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::neg(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(arg0)), arg2, arg3, arg4);
        assert!(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::less_or_equal(v0, v1) || 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::truncate(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::add(v0, v1)) <= 0x2::balance::value<T0>(&arg4.total_sy), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_insufficient_sy_for_swap());
        arg4.total_pt = arg4.total_pt + arg0;
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::split_pt(arg1, arg0, arg5);
        0x2::balance::join<T0>(&mut arg4.vault, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.total_sy, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::truncate(v1), arg6)));
        let v5 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_math::get_exchange_rate(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::sy_to_asset(arg2.index, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg4.total_sy)))), true), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(arg4.total_pt), v3, v4, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::zero());
        arg4.last_ln_implied_rate = get_ln_implied_rate(v5, arg4.expiry - 0x2::clock::timestamp_ms(arg5));
        let v6 = SwapEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg4),
            expiry          : arg4.expiry,
            pt_amount       : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::neg(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(arg0)),
            sy_amount       : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::neg(v0),
            fee             : v2,
            reserve_fee     : v1,
            exchange_rate   : v5,
        };
        0x2::event::emit<SwapEvent<T0>>(v6);
        (0x2::coin::take<T0>(&mut arg4.total_sy, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::truncate(v0), arg6), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::get_raw_value(v2)), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::get_raw_value(v1)))
    }

    public fun swap_sy_for_exact_pt<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceVoucher<T0>, arg4: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg5: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg6: &0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64) {
        check_precondition<T0>(arg0, arg7, arg4, arg5, arg8);
        assert!(arg1 <= arg7.total_pt, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_insufficient_pt_for_swap());
        assert!(arg1 > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_pt_amount_is_zero());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::set_py_index_stored<T0>(arg5, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::get_price<T0>(arg0, arg3, arg9)), arg8);
        let v0 = get_market_state_cache<T0>(arg5, arg7, arg8);
        swap_sy_for_exact_pt_internal<T0>(arg1, arg2, &v0, arg4, arg6, arg7, arg8, arg9)
    }

    public(friend) fun swap_sy_for_exact_pt_internal<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &MarketStateCache<T0>, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg4: &0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_global::MarketFactoryConfig, arg5: &mut MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64) {
        let (v0, v1, v2, v3, v4) = execute_trade_core<T0>(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(arg0), arg2, arg4, arg5);
        let v5 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::neg(v0);
        let v6 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg5.total_sy, 0x2::balance::split<T0>(&mut v6, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::truncate_up(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::sub(v5, v1))));
        0x2::balance::join<T0>(&mut arg5.vault, 0x2::balance::split<T0>(&mut v6, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::truncate_up(v1)));
        arg5.total_pt = arg5.total_pt - arg0;
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::join_pt(arg3, arg0, arg6);
        let v7 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_math::get_exchange_rate(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::sy_to_asset(arg2.index, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg5.total_sy)))), true), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(arg5.total_pt), v3, v4, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::zero());
        arg5.last_ln_implied_rate = get_ln_implied_rate(v7, arg5.expiry - 0x2::clock::timestamp_ms(arg6));
        let v8 = SwapEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg5),
            expiry          : arg5.expiry,
            pt_amount       : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::neg(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::from_uint64(arg0)),
            sy_amount       : v5,
            fee             : v2,
            reserve_fee     : v1,
            exchange_rate   : v7,
        };
        0x2::event::emit<SwapEvent<T0>>(v8);
        (0x2::coin::from_balance<T0>(v6, arg7), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::get_raw_value(v2)), 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64_with_sign::get_raw_value(v1)))
    }

    public(friend) fun update_liquidity_state<T0: drop>(arg0: &mut MarketState<T0>, arg1: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::PyPosition, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::MarketPosition, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::PyState<T0>, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py::split_pt(arg1, arg4, arg10);
        arg0.total_pt = arg0.total_pt + arg4;
        0x2::balance::join<T0>(&mut arg0.total_sy, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg6, arg5, arg11)));
        let v0 = if (arg9) {
            arg7
        } else {
            arg0.lp_supply + arg8
        };
        arg0.lp_supply = v0;
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::set_lp_amount(arg2, arg8, arg10);
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::update_lp_display(arg2, 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::py_position::decimal(arg1));
        let v1 = get_exchange_rate<T0>(arg3, arg0, arg10, arg9);
        arg0.last_ln_implied_rate = get_ln_implied_rate(v1, arg0.expiry - 0x2::clock::timestamp_ms(arg10));
        assert!(!0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::equal(arg0.last_ln_implied_rate, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::zero()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_ln_implied_rate_is_zero());
        let v2 = AddLiquidityEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg0),
            expiry          : arg0.expiry,
            pt_amount       : arg4,
            sy_amount       : arg5,
            lp_amount       : arg8,
            exchange_rate   : v1,
        };
        0x2::event::emit<AddLiquidityEvent<T0>>(v2);
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::stake_rewarder(&mut arg0.reward_pool, 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::lp_amount(arg2), 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_position::borrow_reward_debt(arg2), arg10);
        arg6
    }

    // decompiled from Move bytecode v6
}

