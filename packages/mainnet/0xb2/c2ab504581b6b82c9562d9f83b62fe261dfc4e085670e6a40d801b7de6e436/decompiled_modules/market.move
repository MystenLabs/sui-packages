module 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market {
    struct MarketState<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        py_state_id: 0x2::object::ID,
        expiry: u64,
        total_pt: u64,
        total_sy: 0x2::balance::Balance<T0>,
        lp_supply: u64,
        last_ln_implied_rate: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        current_exchange_rate: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
        scalar_root: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
        initial_anchor: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
        ln_fee_rate_root: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        market_cap: u64,
    }

    struct AddLiquidityEvent<phantom T0: drop> has copy, drop {
        market_state_id: 0x2::object::ID,
        expiry: u64,
        pt_amount: u64,
        sy_amount: u64,
        lp_amount: u64,
        exchange_rate: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
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
        pt_amount: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
        sy_amount: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
        fee: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
        reserve_fee: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
        exchange_rate: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    public fun burn_lp<T0: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: address, arg2: u64, arg3: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::PyPosition, arg4: &mut MarketState<T0>, arg5: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::MarketPosition, arg6: &mut 0x2::tx_context::TxContext) {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        assert!(arg2 > 0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_lp_amount_is_zero());
        assert!(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::lp_amount(arg5) >= arg2, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_insufficient_lp_for_burn());
        assert!(arg4.py_state_id == 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::py_state_id(arg3), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_py_state());
        assert!(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::market_state_id(arg5) == 0x2::object::id<MarketState<T0>>(arg4), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_market_position());
        let v0 = (((arg2 as u128) * (0x2::balance::value<T0>(&arg4.total_sy) as u128) / (arg4.lp_supply as u128)) as u64);
        let v1 = (((arg2 as u128) * (arg4.total_pt as u128) / (arg4.lp_supply as u128)) as u64);
        assert!(v0 > 0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_sy_amount_is_zero());
        assert!(v1 > 0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_pt_amount_is_zero());
        arg4.lp_supply = arg4.lp_supply - arg2;
        0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::decrease_lp_amount(arg5, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg4.total_sy, v0, arg6), arg1);
        arg4.total_pt = arg4.total_pt - v1;
        0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::join_pt(arg3, v1);
        let v2 = RemoveLiquidityEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg4),
            expiry          : arg4.expiry,
            pt_amount       : v1,
            sy_amount       : v0,
            lp_amount       : arg2,
        };
        0x2::event::emit<RemoveLiquidityEvent<T0>>(v2);
    }

    public(friend) fun create<T0: drop>(arg0: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketState<T0>{
            id                    : 0x2::object::new(arg5),
            py_state_id           : 0x2::object::id<0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>>(arg0),
            expiry                : 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::py_state_expiry<T0>(arg0),
            total_pt              : 0,
            total_sy              : 0x2::balance::zero<T0>(),
            lp_supply             : 0,
            last_ln_implied_rate  : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::zero(),
            current_exchange_rate : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::zero(),
            scalar_root           : arg1,
            initial_anchor        : arg2,
            ln_fee_rate_root      : arg3,
            market_cap            : arg4,
        };
        0x2::transfer::share_object<MarketState<T0>>(v0);
    }

    public(friend) fun create_position<T0: drop>(arg0: &MarketState<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::MarketPosition {
        let v0 = 0x1::type_name::get<T0>();
        0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::mint(0x2::object::id<MarketState<T0>>(arg0), 0x1::string::from_ascii(0x1::type_name::get_module(&v0)), arg0.expiry, arg1)
    }

    fun execute_trade_core<T0: drop>(arg0: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg2: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::MarketFactoryConfig, arg3: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg4: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg5: &MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign) {
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::less(arg0, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::from_uint64(arg5.total_pt)), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_insufficient_pt_for_swap());
        let v0 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::current_py_index<T0>(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::cache_in_same_block(arg3), arg1, arg4, arg7);
        let v1 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::multiply(v0, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg5.total_sy)));
        let v2 = arg5.expiry - 0x2::clock::timestamp_ms(arg6);
        let v3 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_math::get_rate_scalar(arg5.scalar_root, v2);
        let v4 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_math::get_rate_anchor(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(arg5.total_pt), arg5.last_ln_implied_rate, v1, v3, v2);
        let v5 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_math::get_exchange_rate_from_implied_rate(arg5.ln_fee_rate_root, v2);
        let v6 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_math::get_exchange_rate(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::get_raw_value(v1), true), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::from_uint64(arg5.total_pt), v3, v4, arg0);
        let v7 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::neg(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::div(arg0, v6));
        let v8 = if (0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::is_positive(arg0)) {
            assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::greater_or_equal(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::div(v6, v5), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::one()), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_exchange_rate_below_one());
            0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::mul(v7, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::sub(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::one(), v5))
        } else {
            0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::neg(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::div(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::mul(v7, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::sub(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::one(), v5)), v5))
        };
        let v9 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::sub(v7, v8);
        let v10 = if (0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::less(v9, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::zero())) {
            0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::neg(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::div(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::sub(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::add(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::abs(v9), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::get_raw_value(v0), true)), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(1, true)), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::get_raw_value(v0), true)))
        } else {
            0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::div(v9, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::get_raw_value(v0), true))
        };
        (v10, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::div(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::mul(v8, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::get_raw_value(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::get_reserve_fee_percent(arg2)), true)), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::get_raw_value(v0), true)), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::div(v8, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::get_raw_value(v0), true)), v3, v4)
    }

    fun get_exchange_rate<T0: drop>(arg0: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg1: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg2: &MarketState<T0>, arg3: &0x2::clock::Clock, arg4: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::multiply(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::current_py_index<T0>(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::cache_in_same_block(arg0), arg4, arg1, arg6), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(0x2::balance::value<T0>(&arg2.total_sy)));
        let v1 = arg2.expiry - 0x2::clock::timestamp_ms(arg3);
        let v2 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_math::get_rate_scalar(arg2.scalar_root, v1);
        let v3 = arg2.initial_anchor;
        if (!arg5) {
            v3 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_math::get_rate_anchor(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(arg2.total_pt), arg2.last_ln_implied_rate, v0, v2, v1);
        };
        0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_math::get_exchange_rate(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::create_from_raw_value(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::get_raw_value(v0), true), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::from_uint64(arg2.total_pt), v2, v3, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::zero())
    }

    fun get_ln_implied_rate(arg0: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u64) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64 {
        0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64::mul_div(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::remove_sign(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math_fixed64_with_sign::ln(arg0)), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(31536000000), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::from_uint64(arg1))
    }

    public fun get_sy_amount_in_for_exact_pt_out<T0: drop>(arg0: u64, arg1: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::MarketFactoryConfig, arg2: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg3: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg4: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg5: &mut MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, _, _, _) = execute_trade_core<T0>(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::from_uint64(arg0), arg3, arg1, arg2, arg4, arg5, arg6, arg7);
        0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::truncate(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::add(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::neg(v0), v1))
    }

    public fun get_sy_amount_in_for_exact_yt_out<T0: drop>(arg0: u64, arg1: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::MarketFactoryConfig, arg2: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg3: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg4: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg5: &mut MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::get_sy_amount_in_for_exact_py_out<T0>(arg0, 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::cache_in_same_block(arg4), arg3, arg2, arg7);
        let v1 = get_sy_amount_out_for_exact_pt_in<T0>(arg0, arg3, arg4, arg2, arg1, arg5, arg6, arg7);
        assert!(v0 > v1, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::repay_sy_in_exceeds_expected_sy_in());
        (v0, v1)
    }

    public fun get_sy_amount_out_for_exact_pt_in<T0: drop>(arg0: u64, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg2: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg3: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg4: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::MarketFactoryConfig, arg5: &mut MarketState<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, _, _, _, _) = execute_trade_core<T0>(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::neg(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::from_uint64(arg0)), arg1, arg4, arg2, arg3, arg5, arg6, arg7);
        0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::truncate(v0)
    }

    public fun mint_lp<T0: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::PriceVoucher<T0>, arg4: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::PyPosition, arg5: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg6: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::MarketPosition) {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        let (v0, _) = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::get_py_amount(arg4);
        assert!(0x2::clock::timestamp_ms(arg8) < 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::expiry(arg4), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_expired());
        assert!(arg2 > 0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_pt_amount_is_zero());
        assert!(v0 >= arg2, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_insufficient_pt_in_for_mint_lp());
        assert!(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::py_state_id(arg4) == arg7.py_state_id, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_py_state());
        let v2 = create_position<T0>(arg7, arg9);
        let v3 = &mut v2;
        let v4 = mint_lp_internal<T0>(arg2, arg1, arg3, arg4, arg5, v3, arg6, arg7, arg8, arg9);
        assert!(arg7.market_cap == 0 || 0x2::balance::value<T0>(&arg7.total_sy) <= arg7.market_cap, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_cap_exceeded());
        (v4, v2)
    }

    public(friend) fun mint_lp_internal<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::PriceVoucher<T0>, arg3: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::PyPosition, arg4: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg5: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::MarketPosition, arg6: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        assert!(0x2::balance::value<T0>(&v0) > 0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_sy_amount_is_zero());
        let v1 = 0x2::balance::value<T0>(&v0);
        if (arg7.lp_supply == 0) {
            let v3 = (0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::math128::sqrt((arg0 as u128) * (v1 as u128)) as u64);
            assert!(v3 >= 1000, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_liquidity_too_low());
            let v4 = v3 - 1000;
            0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::split_pt(arg3, arg0);
            arg7.total_pt = arg7.total_pt + arg0;
            0x2::balance::join<T0>(&mut arg7.total_sy, 0x2::balance::split<T0>(&mut v0, v1));
            arg7.lp_supply = v4 + 1000;
            0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::set_lp_amount(arg5, v4);
            let v5 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::get_price<T0>(arg2, arg9));
            let v6 = get_exchange_rate<T0>(arg6, arg4, arg7, arg8, v5, true, arg9);
            arg7.last_ln_implied_rate = get_ln_implied_rate(v6, arg7.expiry - 0x2::clock::timestamp_ms(arg8));
            assert!(!0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::equal(arg7.last_ln_implied_rate, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::zero()), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_ln_implied_rate_is_zero());
            let v7 = AddLiquidityEvent<T0>{
                market_state_id : 0x2::object::id<MarketState<T0>>(arg7),
                expiry          : arg7.expiry,
                pt_amount       : arg0,
                sy_amount       : v1,
                lp_amount       : v4,
                exchange_rate   : v6,
            };
            0x2::event::emit<AddLiquidityEvent<T0>>(v7);
            0x2::coin::from_balance<T0>(v0, arg9)
        } else {
            let v8 = (((arg0 as u128) * (arg7.lp_supply as u128) / (arg7.total_pt as u128)) as u64);
            let v9 = (((v1 as u128) * (arg7.lp_supply as u128) / (0x2::balance::value<T0>(&arg7.total_sy) as u128)) as u64);
            assert!(v8 > 0 && v9 > 0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_lp_amount_is_zero());
            if (v8 < v9) {
                arg7.total_pt = arg7.total_pt + arg0;
                0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::split_pt(arg3, arg0);
                let v10 = 0x2::balance::split<T0>(&mut v0, ((((0x2::balance::value<T0>(&arg7.total_sy) as u128) * (v8 as u128) + ((arg7.lp_supply - 1) as u128)) / (arg7.lp_supply as u128)) as u64));
                assert!(0x2::balance::value<T0>(&v10) > 0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_sy_amount_is_zero());
                0x2::balance::join<T0>(&mut arg7.total_sy, v10);
                arg7.lp_supply = arg7.lp_supply + v8;
                0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::increase_lp_amount(arg5, v8);
                let v11 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::get_price<T0>(arg2, arg9));
                let v12 = get_exchange_rate<T0>(arg6, arg4, arg7, arg8, v11, true, arg9);
                let v13 = AddLiquidityEvent<T0>{
                    market_state_id : 0x2::object::id<MarketState<T0>>(arg7),
                    expiry          : arg7.expiry,
                    pt_amount       : arg0,
                    sy_amount       : 0x2::balance::value<T0>(&v10),
                    lp_amount       : v8,
                    exchange_rate   : v12,
                };
                0x2::event::emit<AddLiquidityEvent<T0>>(v13);
                0x2::coin::from_balance<T0>(v0, arg9)
            } else {
                0x2::balance::join<T0>(&mut arg7.total_sy, 0x2::balance::split<T0>(&mut v0, v1));
                let v14 = ((((arg7.total_pt as u128) * (v9 as u128) + ((arg7.lp_supply - 1) as u128)) / (arg7.lp_supply as u128)) as u64);
                assert!(v14 > 0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_pt_amount_is_zero());
                0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::split_pt(arg3, v14);
                arg7.total_pt = arg7.total_pt + v14;
                arg7.lp_supply = arg7.lp_supply + v9;
                0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_position::increase_lp_amount(arg5, v9);
                let v15 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::get_price<T0>(arg2, arg9));
                let v16 = get_exchange_rate<T0>(arg6, arg4, arg7, arg8, v15, true, arg9);
                let v17 = AddLiquidityEvent<T0>{
                    market_state_id : 0x2::object::id<MarketState<T0>>(arg7),
                    expiry          : arg7.expiry,
                    pt_amount       : v14,
                    sy_amount       : v1,
                    lp_amount       : v9,
                    exchange_rate   : v16,
                };
                0x2::event::emit<AddLiquidityEvent<T0>>(v17);
                0x2::coin::from_balance<T0>(v0, arg9)
            }
        }
    }

    public fun swap_exact_pt_for_sy<T0: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: u64, arg2: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::PyPosition, arg3: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg4: 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::PriceVoucher<T0>, arg5: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg6: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::get_price<T0>(arg4, arg9));
        swap_exact_pt_for_sy_internal<T0>(arg1, arg2, arg3, v0, arg5, arg6, arg7, arg8, arg9)
    }

    public(friend) fun swap_exact_pt_for_sy_internal<T0: drop>(arg0: u64, arg1: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::PyPosition, arg2: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg3: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg4: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg5: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::MarketFactoryConfig, arg6: &mut MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, _) = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::get_py_amount(arg1);
        assert!(v0 >= arg0, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_insufficient_pt_in_for_mint_lp());
        assert!(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::py_state_id(arg1) == arg6.py_state_id, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_py_state());
        assert!(arg6.py_state_id == 0x2::object::id<0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>>(arg2), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_py_state());
        let (v2, v3, v4, _, _) = execute_trade_core<T0>(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::neg(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::from_uint64(arg0)), arg3, arg5, arg4, arg2, arg6, arg7, arg8);
        arg6.total_pt = arg6.total_pt + arg0;
        0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::split_pt(arg1, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg6.total_sy, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::truncate(v3), arg8), 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::get_treasury(arg5));
        let v7 = get_exchange_rate<T0>(arg4, arg2, arg6, arg7, arg3, false, arg8);
        arg6.last_ln_implied_rate = get_ln_implied_rate(v7, arg6.expiry - 0x2::clock::timestamp_ms(arg7));
        let v8 = SwapEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg6),
            expiry          : arg6.expiry,
            pt_amount       : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::neg(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::from_uint64(arg0)),
            sy_amount       : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::neg(v2),
            fee             : v4,
            reserve_fee     : v3,
            exchange_rate   : v7,
        };
        0x2::event::emit<SwapEvent<T0>>(v8);
        0x2::coin::take<T0>(&mut arg6.total_sy, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::truncate(v2), arg8)
    }

    public fun swap_exact_yt_for_sy<T0: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: u64, arg2: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::PyPosition, arg3: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg4: 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::PriceVoucher<T0>, arg5: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg6: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        let (_, v1) = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::get_py_amount(arg2);
        assert!(v1 >= arg1, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_insufficient_yt_balance_swap());
        assert!(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::py_state_id(arg2) == arg7.py_state_id, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_py_state());
        assert!(arg7.py_state_id == 0x2::object::id<0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>>(arg3), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_py_state());
        let v2 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::split_yt(arg2, arg1);
        let (v3, v4) = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::borrow_pt_amount<T0>(arg2, v2, arg3, arg9);
        let v5 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::get_price<T0>(arg4, arg9);
        let v6 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::redeem_py_internal<T0>(arg1, v3, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(v5), arg2, arg3, arg5, arg8, arg9);
        let v7 = swap_sy_for_exact_pt_internal<T0>(v2, v6, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(v5), arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::repay_pt_amount<T0>(arg2, arg3, v4, arg9);
        v7
    }

    public fun swap_sy_for_exact_pt<T0: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::PriceVoucher<T0>, arg4: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::PyPosition, arg5: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg6: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg7: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::MarketFactoryConfig, arg8: &mut MarketState<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::get_price<T0>(arg3, arg10));
        swap_sy_for_exact_pt_internal<T0>(arg1, arg2, v0, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public(friend) fun swap_sy_for_exact_pt_internal<T0: drop>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg3: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::PyPosition, arg4: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg5: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg6: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::MarketFactoryConfig, arg7: &mut MarketState<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::py_state_id(arg3) == arg7.py_state_id, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_py_state());
        assert!(arg7.py_state_id == 0x2::object::id<0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>>(arg4), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_py_state());
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let (v1, v2, v3, _, _) = execute_trade_core<T0>(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::from_uint64(arg0), arg2, arg6, arg5, arg4, arg7, arg8, arg9);
        let v6 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::neg(v1);
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::truncate(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::add(v6, v2)) <= 0x2::balance::value<T0>(&v0), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_insufficient_sy_for_swap());
        0x2::balance::join<T0>(&mut arg7.total_sy, 0x2::balance::split<T0>(&mut v0, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::truncate(v6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::truncate(v2)), arg9), 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::get_treasury(arg6));
        arg7.total_pt = arg7.total_pt - arg0;
        0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::join_pt(arg3, arg0);
        let v7 = get_exchange_rate<T0>(arg5, arg4, arg7, arg8, arg2, false, arg9);
        arg7.last_ln_implied_rate = get_ln_implied_rate(v7, arg7.expiry - 0x2::clock::timestamp_ms(arg8));
        let v8 = SwapEvent<T0>{
            market_state_id : 0x2::object::id<MarketState<T0>>(arg7),
            expiry          : arg7.expiry,
            pt_amount       : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::neg(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::from_uint64(arg0)),
            sy_amount       : v6,
            fee             : v3,
            reserve_fee     : v2,
            exchange_rate   : v7,
        };
        0x2::event::emit<SwapEvent<T0>>(v8);
        0x2::coin::from_balance<T0>(v0, arg9)
    }

    public fun swap_sy_for_exact_yt<T0: drop>(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::PriceVoucher<T0>, arg4: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::PyPosition, arg5: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg6: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::sy::State, arg7: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg8: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::market_global::MarketFactoryConfig, arg9: &mut MarketState<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        assert!(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::py_state_id(arg4) == arg9.py_state_id, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_py_state());
        assert!(arg9.py_state_id == 0x2::object::id<0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>>(arg5), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_invalid_py_state());
        let v0 = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::oracle::get_price<T0>(arg3, arg11);
        let (v1, v2) = get_sy_amount_in_for_exact_yt_out<T0>(arg1, arg8, arg5, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(v0), arg7, arg9, arg10, arg11);
        assert!(v1 - v2 <= 0x2::coin::value<T0>(&arg2), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_insufficient_sy_in_for_swap_yt());
        let (v3, v4) = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::sy::borrow<T0>(v2, arg6, arg11);
        0x2::coin::join<T0>(&mut arg2, v3);
        let (_, v6) = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::get_py_amount(arg4);
        0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::mint_py_internal<T0>(0x2::coin::split<T0>(&mut arg2, v1, arg11), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(v0), arg4, arg5, arg7, arg10, arg11);
        let (_, v8) = 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py_position::get_py_amount(arg4);
        assert!(v8 - v6 == arg1, 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_pt_amount_is_zero());
        let v9 = swap_exact_pt_for_sy_internal<T0>(arg1, arg4, arg5, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(v0), arg7, arg8, arg9, arg10, arg11);
        0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::update_user_interest<T0>(0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::cache_in_same_block(arg7), 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::treasury(arg7), 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::interest_fee_rate(arg7), 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(v0), arg4, arg5, arg11);
        0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::sy::repay<T0>(v4, v9, arg6, arg11);
        arg2
    }

    public fun update_current_exchange_rate<T0: drop>(arg0: &0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::yield_factory::YieldFactoryConfig, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64, arg2: &mut 0xb2c2ab504581b6b82c9562d9f83b62fe261dfc4e085670e6a40d801b7de6e436::py::PyState<T0>, arg3: &mut MarketState<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = get_exchange_rate<T0>(arg0, arg2, arg3, arg4, arg1, false, arg5);
        arg3.current_exchange_rate = v0;
        v0
    }

    // decompiled from Move bytecode v6
}

