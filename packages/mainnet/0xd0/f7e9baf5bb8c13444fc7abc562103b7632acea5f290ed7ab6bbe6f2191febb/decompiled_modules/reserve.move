module 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve {
    struct TokenReserve<phantom T0> has key {
        id: 0x2::object::UID,
        pause: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::PauseFlags,
        vault: 0x2::balance::Balance<T0>,
        borrow_rate: u64,
        fee: u64,
        last_utilization: u64,
        last_update_timestamp: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS,
        supply_exchange_price: u64,
        borrow_exchange_price: u64,
        max_utilization: u64,
        total_supply_with_interest: u64,
        total_supply_interest_free: u64,
        total_borrow_with_interest: u64,
        total_borrow_interest_free: u64,
        rate_data_version: u8,
        supply_positions: 0x2::table::Table<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition>,
        borrow_positions: 0x2::table::Table<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition>,
    }

    public(friend) fun deposit<T0>(arg0: &mut TokenReserve<T0>, arg1: 0x2::balance::Balance<T0>) {
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::custody::deposit<T0>(&mut arg0.vault, arg1);
    }

    public(friend) fun withdraw<T0>(arg0: &mut TokenReserve<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::custody::value<T0>(&arg0.vault) >= arg1, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::insufficient_vault_balance());
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::custody::withdraw<T0>(&mut arg0.vault, arg1)
    }

    public fun get_total_borrow<T0>(arg0: &TokenReserve<T0>, arg1: &0x2::clock::Clock) : u128 {
        let (_, v1) = calculate_exchange_prices<T0>(arg0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg1));
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs::get_total_borrow(arg0.total_borrow_with_interest, arg0.total_borrow_interest_free, v1)
    }

    public fun get_total_supply<T0>(arg0: &TokenReserve<T0>, arg1: &0x2::clock::Clock) : u128 {
        let (v0, _) = calculate_exchange_prices<T0>(arg0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg1));
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs::get_total_supply(arg0.total_supply_with_interest, arg0.total_supply_interest_free, v0)
    }

    public(friend) fun assert_reserve_allows<T0>(arg0: &TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action) {
        assert!(0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::get_allows(&arg0.pause, arg1), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::reserve_token_paused());
    }

    public(friend) fun calc_borrow_rate<T0>(arg0: &TokenReserve<T0>, arg1: u64, arg2: 0x1::type_name::TypeName) : u64 {
        if (arg0.rate_data_version == 1) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::rate_model::calc_borrow_rate_v1(0x2::dynamic_field::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::RateDataKey, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params>(&arg0.id, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::rate_data_key()), arg1, arg2)
        } else {
            assert!(arg0.rate_data_version == 2, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::liquidity_calcs_unsupported_rate_version());
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::rate_model::calc_borrow_rate_v2(0x2::dynamic_field::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::RateDataKey, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params>(&arg0.id, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::rate_data_key()), arg1, arg2)
        }
    }

    public(friend) fun calc_revenue<T0>(arg0: &TokenReserve<T0>, arg1: u128, arg2: u128) : u64 {
        let v0 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs::get_total_supply_ceil(arg0.total_supply_with_interest, arg0.total_supply_interest_free, arg1);
        let v1 = if (v0 > 0) {
            let v2 = (get_vault_balance<T0>(arg0) as u128) + 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs::get_total_borrow(arg0.total_borrow_with_interest, arg0.total_borrow_interest_free, arg2);
            if (v2 > v0) {
                v2 - v0
            } else {
                0
            }
        } else {
            (get_vault_balance<T0>(arg0) as u128)
        };
        (v1 as u64)
    }

    public(friend) fun calc_utilization<T0>(arg0: &TokenReserve<T0>, arg1: u128, arg2: u128, arg3: bool, arg4: bool) : u64 {
        let v0 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision();
        let v1 = (arg0.total_supply_with_interest as u128) * arg1;
        let v2 = (arg0.total_borrow_with_interest as u128) * arg2;
        let v3 = v1 + (arg0.total_supply_interest_free as u128) * v0;
        let v4 = v2 + (arg0.total_borrow_interest_free as u128) * v0;
        if (v3 == 0) {
            return 0
        };
        check_scaled_amount_overflow(arg3, v1, v3, true);
        check_scaled_amount_overflow(arg4, v2, v4, false);
        let v5 = v4 * (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals() as u128) / v3;
        assert!(v5 <= (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_rate() as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_value_overflow_utilization());
        (v5 as u64)
    }

    public(friend) fun calculate_exchange_prices<T0>(arg0: &TokenReserve<T0>, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) : (u128, u128) {
        let v0 = (arg0.supply_exchange_price as u128);
        let v1 = (arg0.borrow_exchange_price as u128);
        assert!(v0 != 0 && v1 != 0, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::liquidity_calcs_exchange_price_zero());
        let v2 = (arg0.borrow_rate as u128);
        assert!(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg1) >= 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg0.last_update_timestamp), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        let v3 = (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::elapsed_since(arg1, arg0.last_update_timestamp)) as u128);
        let v4 = if (v3 == 0) {
            true
        } else if (v2 == 0) {
            true
        } else {
            arg0.total_borrow_with_interest == 0
        };
        if (v4) {
            return (v0, v1)
        };
        let v5 = (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals() as u128);
        let v6 = (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::seconds_per_year() as u128);
        let v7 = v1 + 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::div_ceil_u128(v1 * v2 * v3, v6 * v5);
        if (arg0.total_supply_with_interest == 0) {
            return (v0, v7)
        };
        let v8 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::div_ceil_u128((arg0.total_supply_with_interest as u128) * v0, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision());
        let v9 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs::get_with_interest_vs_free_ratio(v8, (arg0.total_supply_interest_free as u128));
        let v10 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_price_rate_output_decimals();
        let v11 = if (v8 < (arg0.total_supply_interest_free as u128)) {
            if (v9 == 0) {
                return (v0, v7)
            };
            (arg0.last_utilization as u128) * (v10 + v10 * v5 / v9) / v5
        } else {
            (arg0.last_utilization as u128) * v10 * (v5 + v9) / v5 * v5
        };
        let v12 = (arg0.total_borrow_with_interest as u128) * v7 / 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision();
        let v13 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs::get_with_interest_vs_free_ratio(v12, (arg0.total_borrow_interest_free as u128));
        let v14 = if (v12 < (arg0.total_borrow_interest_free as u128)) {
            v13 * v10 / (v5 + v13)
        } else {
            v10 - v13 * v10 / (v5 + v13)
        };
        (v0 + v0 * v2 * 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v11, v14, v10) * v5 / v10 * (v5 - (arg0.fee as u128)) * v3 / v6 * v5 / v5 * v5, v7)
    }

    fun check_scaled_amount_overflow(arg0: bool, arg1: u128, arg2: u128, arg3: bool) {
        if (arg0) {
            let v0 = (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_token_amount_cap() as u128) * 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision();
            if (arg1 > v0 || arg2 > v0) {
                assert!(arg3, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_value_overflow_total_borrow());
                abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_value_overflow_total_supply()
            };
        };
    }

    fun clear_rate_data<T0>(arg0: &mut TokenReserve<T0>) {
        if (arg0.rate_data_version == 1) {
            0x2::dynamic_field::remove<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::RateDataKey, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params>(&mut arg0.id, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::rate_data_key());
        } else if (arg0.rate_data_version == 2) {
            0x2::dynamic_field::remove<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::RateDataKey, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params>(&mut arg0.id, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::rate_data_key());
        };
    }

    public(friend) fun ensure_borrow_position<T0>(arg0: &mut TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, arg2: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) {
        if (!0x2::table::contains<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition>(&arg0.borrow_positions, arg1)) {
            0x2::table::add<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition>(&mut arg0.borrow_positions, arg1, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::new_user_borrow_position(arg2));
        };
    }

    public(friend) fun ensure_supply_position<T0>(arg0: &mut TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, arg2: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) {
        if (!0x2::table::contains<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition>(&arg0.supply_positions, arg1)) {
            0x2::table::add<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition>(&mut arg0.supply_positions, arg1, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::new_user_supply_position(arg2));
        };
    }

    public(friend) fun get_borrow_position<T0>(arg0: &TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder) : &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition {
        assert!(0x2::table::contains<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition>(&arg0.borrow_positions, arg1), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_user_not_defined());
        0x2::table::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition>(&arg0.borrow_positions, arg1)
    }

    public(friend) fun get_borrow_position_exists<T0>(arg0: &TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder) : bool {
        0x2::table::contains<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition>(&arg0.borrow_positions, arg1)
    }

    public(friend) fun get_borrow_position_mut<T0>(arg0: &mut TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder) : &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition {
        assert!(0x2::table::contains<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition>(&arg0.borrow_positions, arg1), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_user_not_defined());
        0x2::table::borrow_mut<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition>(&mut arg0.borrow_positions, arg1)
    }

    public fun get_borrow_rate<T0>(arg0: &TokenReserve<T0>) : u64 {
        arg0.borrow_rate
    }

    public fun get_exchange_prices<T0>(arg0: &TokenReserve<T0>, arg1: &0x2::clock::Clock) : (u128, u128) {
        calculate_exchange_prices<T0>(arg0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg1))
    }

    public fun get_last_update_timestamp<T0>(arg0: &TokenReserve<T0>) : u64 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg0.last_update_timestamp)
    }

    public(friend) fun get_max_utilization<T0>(arg0: &TokenReserve<T0>) : u64 {
        arg0.max_utilization
    }

    public fun get_pause_flags<T0>(arg0: &TokenReserve<T0>) : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::PauseFlags {
        arg0.pause
    }

    public fun get_rate_data_set<T0>(arg0: &TokenReserve<T0>) : bool {
        arg0.rate_data_version != 0
    }

    public fun get_rate_data_v1<T0>(arg0: &TokenReserve<T0>) : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params {
        assert!(arg0.rate_data_version == 1, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::liquidity_calcs_unsupported_rate_version());
        *0x2::dynamic_field::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::RateDataKey, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params>(&arg0.id, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::rate_data_key())
    }

    public fun get_rate_data_v2<T0>(arg0: &TokenReserve<T0>) : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params {
        assert!(arg0.rate_data_version == 2, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::liquidity_calcs_unsupported_rate_version());
        *0x2::dynamic_field::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::RateDataKey, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params>(&arg0.id, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::rate_data_key())
    }

    public fun get_rate_data_version<T0>(arg0: &TokenReserve<T0>) : u8 {
        arg0.rate_data_version
    }

    public fun get_revenue<T0>(arg0: &TokenReserve<T0>, arg1: &0x2::clock::Clock) : u64 {
        let (v0, v1) = calculate_exchange_prices<T0>(arg0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg1));
        calc_revenue<T0>(arg0, v0, v1)
    }

    public fun get_stored_exchange_prices<T0>(arg0: &TokenReserve<T0>) : (u64, u64) {
        (arg0.supply_exchange_price, arg0.borrow_exchange_price)
    }

    public(friend) fun get_supply_position<T0>(arg0: &TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder) : &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition {
        assert!(0x2::table::contains<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition>(&arg0.supply_positions, arg1), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_user_not_defined());
        0x2::table::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition>(&arg0.supply_positions, arg1)
    }

    public(friend) fun get_supply_position_exists<T0>(arg0: &TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder) : bool {
        0x2::table::contains<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition>(&arg0.supply_positions, arg1)
    }

    public(friend) fun get_supply_position_mut<T0>(arg0: &mut TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder) : &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition {
        assert!(0x2::table::contains<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition>(&arg0.supply_positions, arg1), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_user_not_defined());
        0x2::table::borrow_mut<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition>(&mut arg0.supply_positions, arg1)
    }

    public fun get_token_config<T0>(arg0: &TokenReserve<T0>) : (u64, u64) {
        (arg0.fee, arg0.max_utilization)
    }

    public fun get_token_config_set<T0>(arg0: &TokenReserve<T0>) : bool {
        arg0.max_utilization != 0
    }

    public fun get_total_amounts<T0>(arg0: &TokenReserve<T0>) : (u64, u64, u64, u64) {
        (arg0.total_supply_with_interest, arg0.total_supply_interest_free, arg0.total_borrow_with_interest, arg0.total_borrow_interest_free)
    }

    public(friend) fun get_total_borrow_interest_free<T0>(arg0: &TokenReserve<T0>) : u64 {
        arg0.total_borrow_interest_free
    }

    public(friend) fun get_total_borrow_with_interest<T0>(arg0: &TokenReserve<T0>) : u64 {
        arg0.total_borrow_with_interest
    }

    public(friend) fun get_total_supply_interest_free<T0>(arg0: &TokenReserve<T0>) : u64 {
        arg0.total_supply_interest_free
    }

    public(friend) fun get_total_supply_with_interest<T0>(arg0: &TokenReserve<T0>) : u64 {
        arg0.total_supply_with_interest
    }

    public fun get_user_borrow_data<T0>(arg0: &TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder) : (bool, u64, u64, u64, u64, u64, u64, u64, u8) {
        if (!get_borrow_position_exists<T0>(arg0, arg1)) {
            return (false, 0, 0, 0, 0, 0, 0, 0, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::position_status_not_set())
        };
        let v0 = get_borrow_position<T0>(arg0, arg1);
        (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::get_borrow_with_interest(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::get_borrow_amount(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::get_borrow_debt_ceiling(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::get_borrow_last_update(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::get_borrow_expand_percent(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::get_borrow_expand_duration(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::get_borrow_base_debt_ceiling(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::get_borrow_max_debt_ceiling(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::get_borrow_status(v0))
    }

    public fun get_user_supply_data<T0>(arg0: &TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder) : (bool, u64, u64, u64, u64, u64, u64, u8) {
        if (!get_supply_position_exists<T0>(arg0, arg1)) {
            return (false, 0, 0, 0, 0, 0, 0, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::position_status_not_set())
        };
        let v0 = get_supply_position<T0>(arg0, arg1);
        (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_with_interest(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_amount(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_withdrawal_limit(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_last_update(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_expand_percent(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_expand_duration(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_base_withdrawal_limit(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_status(v0))
    }

    public fun get_user_supply_decay<T0>(arg0: &TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder) : (u64, u64) {
        if (!get_supply_position_exists<T0>(arg0, arg1)) {
            return (0, 0)
        };
        let v0 = get_supply_position<T0>(arg0, arg1);
        (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_decay_amount(v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_decay_duration(v0))
    }

    public fun get_user_supply_pause<T0>(arg0: &TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, arg2: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action) : bool {
        if (!get_supply_position_exists<T0>(arg0, arg1)) {
            return true
        };
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::get_supply_pause(get_supply_position<T0>(arg0, arg1), arg2)
    }

    public fun get_utilization<T0>(arg0: &TokenReserve<T0>) : u64 {
        arg0.last_utilization
    }

    public fun get_vault_balance<T0>(arg0: &TokenReserve<T0>) : u64 {
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::custody::value<T0>(&arg0.vault)
    }

    public(friend) fun new_reserve<T0>(arg0: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: u8, arg2: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS, arg3: &mut 0x2::tx_context::TxContext) : TokenReserve<T0> {
        assert!(arg1 >= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::min_token_decimals() && arg1 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_token_decimals(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_token_invalid_decimals_range());
        TokenReserve<T0>{
            id                         : 0x2::derived_object::claim<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::ReserveKey<T0>>(0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::get_uid_mut(arg0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::reserve_key<T0>()),
            pause                      : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::none(),
            vault                      : 0x2::balance::zero<T0>(),
            borrow_rate                : 0,
            fee                        : 0,
            last_utilization           : 0,
            last_update_timestamp      : arg2,
            supply_exchange_price      : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::initial_exchange_price(),
            borrow_exchange_price      : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::initial_exchange_price(),
            max_utilization            : 0,
            total_supply_with_interest : 0,
            total_supply_interest_free : 0,
            total_borrow_with_interest : 0,
            total_borrow_interest_free : 0,
            rate_data_version          : 0,
            supply_positions           : 0x2::table::new<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position::UserSupplyPosition>(arg3),
            borrow_positions           : 0x2::table::new<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position::UserBorrowPosition>(arg3),
        }
    }

    public(friend) fun set_new_total_borrow_interest_free<T0>(arg0: &mut TokenReserve<T0>, arg1: bool, arg2: u128) {
        let v0 = (arg0.total_borrow_interest_free as u128);
        let v1 = if (arg1) {
            v0 + arg2
        } else if (v0 > arg2) {
            v0 - arg2
        } else {
            0
        };
        assert!(v1 <= (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_token_amount_cap() as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_value_overflow_total_borrow());
        arg0.total_borrow_interest_free = (v1 as u64);
    }

    public(friend) fun set_new_total_borrow_with_interest<T0>(arg0: &mut TokenReserve<T0>, arg1: bool, arg2: u128) {
        let v0 = (arg0.total_borrow_with_interest as u128);
        let v1 = if (arg1) {
            v0 + arg2
        } else if (v0 > arg2) {
            v0 - arg2
        } else {
            0
        };
        assert!(v1 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        arg0.total_borrow_with_interest = (v1 as u64);
    }

    public(friend) fun set_new_total_supply_interest_free<T0>(arg0: &mut TokenReserve<T0>, arg1: bool, arg2: u128) {
        let v0 = (arg0.total_supply_interest_free as u128);
        let v1 = if (arg1) {
            v0 + arg2
        } else if (v0 > arg2) {
            v0 - arg2
        } else {
            0
        };
        assert!(v1 <= (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_token_amount_cap() as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_value_overflow_total_supply());
        arg0.total_supply_interest_free = (v1 as u64);
    }

    public(friend) fun set_new_total_supply_with_interest<T0>(arg0: &mut TokenReserve<T0>, arg1: bool, arg2: u128) {
        let v0 = (arg0.total_supply_with_interest as u128);
        let v1 = if (arg1) {
            v0 + arg2
        } else if (v0 > arg2) {
            v0 - arg2
        } else {
            0
        };
        assert!(v1 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        arg0.total_supply_with_interest = (v1 as u64);
    }

    public(friend) fun set_rate_data_v1<T0>(arg0: &mut TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params) {
        clear_rate_data<T0>(arg0);
        0x2::dynamic_field::add<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::RateDataKey, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params>(&mut arg0.id, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::rate_data_key(), arg1);
        arg0.rate_data_version = 1;
    }

    public(friend) fun set_rate_data_v2<T0>(arg0: &mut TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params) {
        clear_rate_data<T0>(arg0);
        0x2::dynamic_field::add<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::RateDataKey, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params>(&mut arg0.id, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::rate_data_key(), arg1);
        arg0.rate_data_version = 2;
    }

    public(friend) fun set_reserve_pause<T0>(arg0: &mut TokenReserve<T0>, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action, arg2: bool) {
        arg0.pause = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::set(arg0.pause, arg1, arg2);
    }

    public(friend) fun set_token_config<T0>(arg0: &mut TokenReserve<T0>, arg1: u64, arg2: u64) {
        arg0.fee = arg1;
        arg0.max_utilization = arg2;
    }

    public(friend) fun share<T0>(arg0: TokenReserve<T0>) {
        0x2::transfer::share_object<TokenReserve<T0>>(arg0);
    }

    public(friend) fun store_reserve_state<T0>(arg0: &mut TokenReserve<T0>, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) {
        assert!(arg1 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64() && arg2 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_value_overflow_exchange_prices());
        arg0.supply_exchange_price = (arg1 as u64);
        arg0.borrow_exchange_price = (arg2 as u64);
        arg0.last_utilization = arg3;
        arg0.borrow_rate = arg4;
        arg0.last_update_timestamp = arg5;
    }

    public(friend) fun update_exchange_price<T0>(arg0: &mut TokenReserve<T0>, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) : (u128, u128) {
        let (v0, v1) = calculate_exchange_prices<T0>(arg0, arg1);
        assert!(v0 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64() && v1 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_value_overflow_exchange_prices());
        arg0.supply_exchange_price = (v0 as u64);
        arg0.borrow_exchange_price = (v1 as u64);
        arg0.last_update_timestamp = arg1;
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::events::emit_log_update_exchange_prices(0x1::type_name::with_defining_ids<T0>(), (v0 as u64), (v1 as u64), arg0.borrow_rate, arg0.last_utilization);
        (v0, v1)
    }

    public(friend) fun update_exchange_prices_and_rates<T0>(arg0: &mut TokenReserve<T0>, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) : (u128, u128) {
        let (v0, v1) = calculate_exchange_prices<T0>(arg0, arg1);
        let v2 = calc_utilization<T0>(arg0, v0, v1, false, false);
        let v3 = calc_borrow_rate<T0>(arg0, v2, 0x1::type_name::with_defining_ids<T0>());
        assert!(v0 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64() && v1 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_value_overflow_exchange_prices());
        arg0.supply_exchange_price = (v0 as u64);
        arg0.borrow_exchange_price = (v1 as u64);
        arg0.last_utilization = v2;
        arg0.borrow_rate = v3;
        arg0.last_update_timestamp = arg1;
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::events::emit_log_update_exchange_prices(0x1::type_name::with_defining_ids<T0>(), (v0 as u64), (v1 as u64), v3, v2);
        (v0, v1)
    }

    // decompiled from Move bytecode v7
}

