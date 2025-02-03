module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic {
    struct LendingCoreExecuteEvent has copy, drop {
        user_id: u64,
        amount: u256,
        pool_id: u16,
        violator_id: u64,
        call_type: u8,
    }

    fun update_interest_rate(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: u16, arg3: u256) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_app_liquidity(arg0, arg2, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_app_id(arg1));
        assert!(v0 >= arg3, 7);
        let v1 = v0 - arg3;
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::rates::calculate_borrow_rate(arg1, arg2, v1);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::update_interest_rate(arg1, arg2, v2, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::rates::calculate_liquidity_rate(arg1, arg2, v2, v1));
    }

    fun update_state(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &0x2::clock::Clock, arg2: u16) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_timestamp(arg1);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_last_update_timestamp(arg0, arg2);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_index(arg0, arg2);
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::rates::calculate_compounded_interest(v0, v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg0, arg2)), v2);
        let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::rates::calculate_linear_interest(v0, v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg0, arg2)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_index(arg0, arg2));
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::update_state(arg0, arg2, v3, v4, v0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::scaled_balance::mint_scaled(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_dtoken_scaled_total_supply(arg0, arg2), v3 - v2), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_treasury_factor(arg0, arg2)), v4));
    }

    fun add_isolate_debt(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u256) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg1);
        let v1 = 0x1::vector::borrow<u16>(&v0, 0);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::update_isolate_debt(arg0, *v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_isolate_debt(arg0, *v1) + arg2);
    }

    public(friend) fun as_collateral(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u16) {
        update_state(arg1, arg3, arg5);
        assert!(is_liquid_asset(arg1, arg4, arg5), 11);
        let v0 = is_isolation_mode(arg1, arg4);
        assert!(!v0, 12);
        if (has_collateral(arg1, arg4)) {
            assert!(!0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::is_isolated_asset(arg1, arg5), 14);
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::remove_user_liquid_asset(arg1, arg4, arg5);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::add_user_collateral(arg1, arg4, arg5);
        update_interest_rate(arg0, arg1, arg5, 0);
        update_average_liquidity(arg1, arg2, arg3, arg4);
        let v1 = LendingCoreExecuteEvent{
            user_id     : arg4,
            amount      : 0,
            pool_id     : arg5,
            violator_id : 0,
            call_type   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_as_colleteral_type(),
        };
        0x2::event::emit<LendingCoreExecuteEvent>(v1);
    }

    fun burn_dtoken(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u16, arg3: u256) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::burn_dtoken_scaled(arg0, arg2, arg1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::scaled_balance::burn_scaled(arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_index(arg0, arg2)));
    }

    fun burn_otoken(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u16, arg3: u256) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::burn_otoken_scaled(arg0, arg2, arg1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::scaled_balance::burn_scaled(arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_index(arg0, arg2)));
    }

    public fun calculate_actual_liquidation(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg1: u16, arg2: u256, arg3: u16, arg4: u256, arg5: u256, arg6: u256) : (u256, u256, u256, u256) {
        let (v0, v1) = if (arg5 >= arg4) {
            (arg2, arg4)
        } else {
            (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg2, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(arg5, arg4)), arg5)
        };
        let v2 = calculate_value(arg0, arg1, v0);
        let v3 = calculate_value(arg0, arg3, v1);
        let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(calculate_amount(arg0, arg1, v2 - v3), arg6);
        (v0, v1, v0 - v4, v4)
    }

    public fun calculate_amount(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg1: u16, arg2: u256) : u256 {
        let (v0, v1, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::get_token_price(arg0, arg1);
        arg2 * (0x2::math::pow(10, v1) as u256) / v0
    }

    public fun calculate_liquidation_base_discount(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) : u256 {
        let v0 = user_health_collateral_value(arg0, arg1, arg2);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray() - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v0, user_health_loan_value(arg0, arg1, arg2))
    }

    public fun calculate_liquidation_discount(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64, arg3: u64) : u256 {
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::exist_user_info(arg0, arg3), 13);
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::exist_user_info(arg0, arg2), 13);
        let v0 = calculate_liquidation_base_discount(arg0, arg1, arg3);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_average_liquidity(arg0, arg2);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v1, 5 * user_health_loan_value(arg0, arg1, arg3)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray()) + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray()), 200000000000000000000000000)
    }

    public fun calculate_max_liquidation(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64, arg3: u64, arg4: u16, arg5: u16) : (u256, u256) {
        let v0 = calculate_liquidation_discount(arg0, arg1, arg2, arg3);
        let v1 = user_health_collateral_value(arg0, arg1, arg3);
        let v2 = user_health_loan_value(arg0, arg1, arg3);
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v2, 1250000000000000000000000000) - v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(1250000000000000000000000000, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray() - v0), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_coefficient(arg0, arg5)) - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_collateral_coefficient(arg0, arg4));
        let v4 = user_collateral_value(arg0, arg1, arg3, arg4);
        let v5 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray() - v0);
        let v6 = user_loan_value(arg0, arg1, arg3, arg5);
        let v7 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v4, v3), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v6, v5)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray());
        let v8 = calculate_amount(arg1, arg4, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v3, v7));
        (v8, calculate_amount(arg1, arg5, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v5, v7)))
    }

    public fun calculate_value(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg1: u16, arg2: u256) : u256 {
        let (v0, v1, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::get_token_price(arg0, arg1);
        arg2 * v0 / (0x2::math::pow(10, v1) as u256)
    }

    public(friend) fun cancel_as_collateral(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u16) {
        update_state(arg1, arg3, arg5);
        assert!(is_collateral(arg1, arg4, arg5), 4);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::remove_user_collateral(arg1, arg4, arg5);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::add_user_liquid_asset(arg1, arg4, arg5);
        check_user_fresh_price(arg2, arg1, arg4, arg3);
        assert!(is_health(arg1, arg2, arg4), 2);
        update_interest_rate(arg0, arg1, arg5, 0);
        update_average_liquidity(arg1, arg2, arg3, arg4);
        let v0 = LendingCoreExecuteEvent{
            user_id     : arg4,
            amount      : 0,
            pool_id     : arg5,
            violator_id : 0,
            call_type   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_cancel_as_colleteral_type(),
        };
        0x2::event::emit<LendingCoreExecuteEvent>(v0);
    }

    public fun check_user_fresh_price(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: u64, arg3: &0x2::clock::Clock) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::check_fresh_price(arg0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg1, arg2), arg3);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::check_fresh_price(arg0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg1, arg2), arg3);
    }

    public fun claim_from_treasury(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg3: &0x2::clock::Clock, arg4: u16, arg5: u64, arg6: u256) {
        update_state(arg2, arg3, arg4);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_reserve_treasury(arg2, arg4);
        let v1 = user_collateral_balance(arg2, v0, arg4);
        let v2 = user_loan_balance(arg2, v0, arg4);
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(v3, arg6);
        burn_otoken(arg2, v0, arg4, v4);
        mint_otoken(arg2, arg5, arg4, v4);
        update_interest_rate(arg1, arg2, arg4, 0);
    }

    fun cover_deficit(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg0, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&v0)) {
            let v2 = 0x1::vector::borrow<u16>(&v0, v1);
            let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_reserve_treasury(arg0, *v2);
            let v4 = user_loan_balance(arg0, arg1, *v2);
            burn_dtoken(arg0, arg1, *v2, v4);
            mint_dtoken(arg0, v3, *v2, v4);
            v1 = v1 + 1;
        };
    }

    public(friend) fun execute_borrow(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u16, arg6: u256) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::ensure_user_info_exist(arg1, arg3, arg4);
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::exist_reserve(arg1, arg5), 6);
        update_state(arg1, arg3, arg5);
        let v0 = is_collateral(arg1, arg4, arg5);
        assert!(!v0, 0);
        let v1 = is_liquid_asset(arg1, arg4, arg5);
        assert!(!v1, 1);
        assert!(is_borrowable_asset(arg1, arg5), 10);
        if (is_isolation_mode(arg1, arg4)) {
            assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::can_borrow_in_isolation(arg1, arg5), 9);
            assert!(not_reach_borrow_ceiling(arg1, arg4, arg6), 8);
            add_isolate_debt(arg1, arg4, arg6);
        };
        let v2 = is_loan(arg1, arg4, arg5);
        if (!v2) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::add_user_loan(arg1, arg4, arg5);
        };
        mint_dtoken(arg1, arg4, arg5, arg6);
        check_user_fresh_price(arg2, arg1, arg4, arg3);
        let v3 = 0x1::vector::empty<u16>();
        0x1::vector::push_back<u16>(&mut v3, arg5);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::check_fresh_price(arg2, v3, arg3);
        assert!(is_health(arg1, arg2, arg4), 2);
        update_interest_rate(arg0, arg1, arg5, arg6);
        update_average_liquidity(arg1, arg2, arg3, arg4);
        let v4 = LendingCoreExecuteEvent{
            user_id     : arg4,
            amount      : arg6,
            pool_id     : arg5,
            violator_id : 0,
            call_type   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type(),
        };
        0x2::event::emit<LendingCoreExecuteEvent>(v4);
    }

    public(friend) fun execute_liquidate(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u16, arg7: u16) {
        assert!(is_collateral(arg1, arg5, arg6), 4);
        assert!(is_loan(arg1, arg5, arg7), 5);
        assert!(is_collateral(arg1, arg4, arg7), 4);
        update_state(arg1, arg3, arg7);
        update_state(arg1, arg3, arg6);
        update_average_liquidity(arg1, arg2, arg3, arg4);
        check_user_fresh_price(arg2, arg1, arg5, arg3);
        let v0 = is_health(arg1, arg2, arg5);
        assert!(!v0, 3);
        let (v1, v2) = calculate_max_liquidation(arg1, arg2, arg4, arg5, arg6, arg7);
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_treasury_factor(arg1, arg6);
        let v4 = user_collateral_balance(arg1, arg4, arg7);
        let (v5, v6, v7, v8) = calculate_actual_liquidation(arg2, arg6, v1, arg7, v2, v4, v3);
        let v9 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_reserve_treasury(arg1, arg6);
        burn_dtoken(arg1, arg5, arg7, v6);
        burn_otoken(arg1, arg5, arg6, v5);
        burn_otoken(arg1, arg4, arg7, v6);
        mint_otoken(arg1, v9, arg6, v8);
        if (has_deficit(arg1, arg2, arg5)) {
            cover_deficit(arg1, arg5);
        };
        if (is_loan(arg1, arg4, arg6)) {
            let v10 = user_loan_balance(arg1, arg4, arg6);
            burn_dtoken(arg1, arg4, arg6, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(v10, v7));
            if (v7 > v10) {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::remove_user_loan(arg1, arg4, arg6);
                mint_otoken(arg1, arg4, arg6, v7 - v10);
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::add_user_liquid_asset(arg1, arg4, arg6);
            };
        } else {
            mint_otoken(arg1, arg4, arg6, v7);
            let v11 = is_collateral(arg1, arg4, arg6);
            let v12 = if (!v11) {
                let v13 = is_liquid_asset(arg1, arg4, arg6);
                !v13
            } else {
                false
            };
            if (v12) {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::add_user_liquid_asset(arg1, arg4, arg6);
            };
        };
        update_interest_rate(arg0, arg1, arg6, 0);
        update_interest_rate(arg0, arg1, arg7, 0);
        update_average_liquidity(arg1, arg2, arg3, arg5);
        let v14 = LendingCoreExecuteEvent{
            user_id     : arg4,
            amount      : v5,
            pool_id     : arg6,
            violator_id : arg5,
            call_type   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_liquidate_type(),
        };
        0x2::event::emit<LendingCoreExecuteEvent>(v14);
    }

    public(friend) fun execute_repay(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u16, arg6: u256) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::ensure_user_info_exist(arg1, arg3, arg4);
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::exist_reserve(arg1, arg5), 6);
        update_state(arg1, arg3, arg5);
        let v0 = user_loan_balance(arg1, arg4, arg5);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(arg6, v0);
        burn_dtoken(arg1, arg4, arg5, v1);
        if (is_isolation_mode(arg1, arg4)) {
            reduce_isolate_debt(arg1, arg4, v1);
        };
        if (arg6 >= v0) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::remove_user_loan(arg1, arg4, arg5);
            let v2 = arg6 - v0;
            if (v2 > 0) {
                mint_otoken(arg1, arg4, arg5, v2);
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::add_user_liquid_asset(arg1, arg4, arg5);
            };
        };
        update_interest_rate(arg0, arg1, arg5, 0);
        update_average_liquidity(arg1, arg2, arg3, arg4);
        let v3 = LendingCoreExecuteEvent{
            user_id     : arg4,
            amount      : v1,
            pool_id     : arg5,
            violator_id : 0,
            call_type   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_repay_type(),
        };
        0x2::event::emit<LendingCoreExecuteEvent>(v3);
    }

    public(friend) fun execute_supply(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u16, arg6: u256) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::ensure_user_info_exist(arg1, arg3, arg4);
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::exist_reserve(arg1, arg5), 6);
        let v0 = is_loan(arg1, arg4, arg5);
        assert!(!v0, 15);
        assert!(not_reach_supply_ceiling(arg1, arg5, arg6), 16);
        update_state(arg1, arg3, arg5);
        mint_otoken(arg1, arg4, arg5, arg6);
        let v1 = is_collateral(arg1, arg4, arg5);
        let v2 = if (!v1) {
            let v3 = is_liquid_asset(arg1, arg4, arg5);
            !v3
        } else {
            false
        };
        if (v2) {
            if (is_isolation_mode(arg1, arg4)) {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::add_user_liquid_asset(arg1, arg4, arg5);
            } else {
                let v4 = has_collateral(arg1, arg4);
                if (!v4) {
                    0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::add_user_collateral(arg1, arg4, arg5);
                } else if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::is_isolated_asset(arg1, arg5)) {
                    0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::add_user_liquid_asset(arg1, arg4, arg5);
                } else {
                    0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::add_user_collateral(arg1, arg4, arg5);
                };
            };
        };
        update_interest_rate(arg0, arg1, arg5, 0);
        update_average_liquidity(arg1, arg2, arg3, arg4);
        let v5 = LendingCoreExecuteEvent{
            user_id     : arg4,
            amount      : arg6,
            pool_id     : arg5,
            violator_id : 0,
            call_type   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type(),
        };
        0x2::event::emit<LendingCoreExecuteEvent>(v5);
    }

    public(friend) fun execute_withdraw(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u16, arg6: u256) : u256 {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::ensure_user_info_exist(arg1, arg3, arg4);
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::exist_reserve(arg1, arg5), 6);
        update_state(arg1, arg3, arg5);
        let v0 = user_collateral_balance(arg1, arg4, arg5);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(arg6, v0);
        burn_otoken(arg1, arg4, arg5, v1);
        check_user_fresh_price(arg2, arg1, arg4, arg3);
        assert!(is_health(arg1, arg2, arg4), 2);
        if (v1 == v0) {
            if (is_collateral(arg1, arg4, arg5)) {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::remove_user_collateral(arg1, arg4, arg5);
            } else {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::remove_user_liquid_asset(arg1, arg4, arg5);
            };
        };
        update_interest_rate(arg0, arg1, arg5, v1);
        update_average_liquidity(arg1, arg2, arg3, arg4);
        let v2 = LendingCoreExecuteEvent{
            user_id     : arg4,
            amount      : v1,
            pool_id     : arg5,
            violator_id : 0,
            call_type   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_withdraw_type(),
        };
        0x2::event::emit<LendingCoreExecuteEvent>(v2);
        v1
    }

    public fun has_collateral(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64) : bool {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg1);
        0x1::vector::length<u16>(&v0) > 0
    }

    public fun has_deficit(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) : bool {
        let v0 = user_total_collateral_value(arg0, arg1, arg2);
        v0 == 0 && user_total_loan_value(arg0, arg1, arg2) > 0
    }

    public fun is_borrowable_asset(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16) : bool {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_coefficient(arg0, arg1) > 0
    }

    public fun is_collateral(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u16) : bool {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg1);
        0x1::vector::contains<u16>(&v0, &arg2)
    }

    public fun is_health(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) : bool {
        user_health_factor(arg0, arg1, arg2) > 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray()
    }

    public fun is_isolation_mode(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64) : bool {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg1);
        0x1::vector::length<u16>(&v0) == 1 && 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::is_isolated_asset(arg0, *0x1::vector::borrow<u16>(&v0, 0))
    }

    public fun is_liquid_asset(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u16) : bool {
        if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::exist_user_info(arg0, arg1)) {
            let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_liquid_assets(arg0, arg1);
            0x1::vector::contains<u16>(&v1, &arg2)
        } else {
            false
        }
    }

    public fun is_loan(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u16) : bool {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg0, arg1);
        0x1::vector::contains<u16>(&v0, &arg2)
    }

    fun mint_dtoken(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u16, arg3: u256) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::mint_dtoken_scaled(arg0, arg2, arg1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::scaled_balance::mint_scaled(arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_index(arg0, arg2)));
    }

    fun mint_otoken(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u16, arg3: u256) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::mint_otoken_scaled(arg0, arg2, arg1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::scaled_balance::mint_scaled(arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_index(arg0, arg2)));
    }

    public fun not_reach_borrow_ceiling(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u256) : bool {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg1);
        let v1 = 0x1::vector::borrow<u16>(&v0, 0);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_reserve_borrow_ceiling(arg0, *v1);
        v2 == 0 || 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_isolate_debt(arg0, *v1) + arg2 < v2
    }

    public fun not_reach_supply_ceiling(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16, arg2: u256) : bool {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_reserve_supply_ceiling(arg0, arg1);
        v0 == 0 || total_otoken_supply(arg0, arg1) + arg2 < v0
    }

    fun reduce_isolate_debt(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u256) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg1);
        let v1 = 0x1::vector::borrow<u16>(&v0, 0);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_isolate_debt(arg0, *v1);
        let v3 = if (v2 >= arg2) {
            v2 - arg2
        } else {
            0
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::update_isolate_debt(arg0, *v1, v3);
    }

    public fun total_dtoken_supply(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16) : u256 {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_dtoken_scaled_total_supply(arg0, arg1), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_index(arg0, arg1))
    }

    public fun total_otoken_supply(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16) : u256 {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_otoken_scaled_total_supply(arg0, arg1), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_index(arg0, arg1))
    }

    fun update_average_liquidity(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: &0x2::clock::Clock, arg3: u64) {
        if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::exist_user_info(arg0, arg3)) {
            let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_last_timestamp(arg0, arg3);
            let v1 = user_health_collateral_value(arg0, arg1, arg3);
            let v2 = user_health_loan_value(arg0, arg1, arg3);
            if (v1 > v2) {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::update_user_average_liquidity(arg0, arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::rates::calculate_average_liquidity(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_timestamp(arg2), v0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_average_liquidity(arg0, arg3), v1 - v2));
            } else {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::update_user_average_liquidity(arg0, arg2, arg3, 0);
            };
        };
    }

    public fun user_collateral_balance(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u16) : u256 {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::scaled_balance::balance_of(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_scaled_otoken(arg0, arg1, arg2), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_index(arg0, arg2))
    }

    public fun user_collateral_value(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64, arg3: u16) : u256 {
        calculate_value(arg1, arg3, user_collateral_balance(arg0, arg2, arg3))
    }

    public fun user_health_collateral_value(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) : u256 {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&v0)) {
            let v3 = 0x1::vector::borrow<u16>(&v0, v2);
            let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_collateral_coefficient(arg0, *v3);
            v1 = v1 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(user_collateral_value(arg0, arg1, arg2, *v3), v4);
            v2 = v2 + 1;
        };
        v1
    }

    public fun user_health_factor(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) : u256 {
        let v0 = user_health_collateral_value(arg0, arg1, arg2);
        let v1 = user_health_loan_value(arg0, arg1, arg2);
        if (v1 > 0) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v0, v1)
        } else {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        }
    }

    public fun user_health_loan_value(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) : u256 {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg0, arg2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&v0)) {
            let v3 = 0x1::vector::borrow<u16>(&v0, v2);
            let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_coefficient(arg0, *v3);
            v1 = v1 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(user_loan_value(arg0, arg1, arg2, *v3), v4);
            v2 = v2 + 1;
        };
        v1
    }

    public fun user_loan_balance(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64, arg2: u16) : u256 {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::scaled_balance::balance_of(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_scaled_dtoken(arg0, arg1, arg2), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_index(arg0, arg2))
    }

    public fun user_loan_value(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64, arg3: u16) : u256 {
        calculate_value(arg1, arg3, user_loan_balance(arg0, arg2, arg3))
    }

    public fun user_total_collateral_value(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) : u256 {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&v0)) {
            v1 = v1 + user_collateral_value(arg0, arg1, arg2, *0x1::vector::borrow<u16>(&v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun user_total_loan_value(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) : u256 {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg0, arg2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&v0)) {
            v1 = v1 + user_loan_value(arg0, arg1, arg2, *0x1::vector::borrow<u16>(&v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

