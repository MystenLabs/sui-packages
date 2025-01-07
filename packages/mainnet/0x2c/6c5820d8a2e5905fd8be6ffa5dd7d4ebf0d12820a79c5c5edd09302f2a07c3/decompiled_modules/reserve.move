module 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve {
    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        config: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::cell::Cell<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::ReserveConfig>,
        mint_decimals: u8,
        price_identifier: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier,
        price: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal,
        smoothed_price: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal,
        price_last_update_timestamp_s: u64,
        available_amount: u64,
        ctoken_supply: u64,
        borrowed_amount: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal,
        cumulative_borrow_rate: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal,
        interest_last_update_timestamp_s: u64,
        unclaimed_spread_fees: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal,
    }

    struct InterestUpdateEvent<phantom T0> has copy, drop {
        reserve_id: 0x2::object::ID,
        cumulative_borrow_rate: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal,
        available_amount: u64,
        borrowed_amount: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal,
        ctoken_supply: u64,
        timestamp_s: u64,
    }

    public fun assert_price_is_fresh<T0>(arg0: &Reserve<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 - arg0.price_last_update_timestamp_s <= 0, 0);
    }

    public(friend) fun borrow_liquidity<T0>(arg0: &mut Reserve<T0>, arg1: u64) {
        arg0.available_amount = arg0.available_amount - arg1;
        arg0.borrowed_amount = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::add(arg0.borrowed_amount, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg1));
        assert!(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::le(arg0.borrowed_amount, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::borrow_limit(config<T0>(arg0)))), 3);
        assert!(arg0.available_amount >= 100, 5);
    }

    public fun calculate_borrow_fee<T0>(arg0: &Reserve<T0>, arg1: u64) : u64 {
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::ceil(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg1), 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::borrow_fee(config<T0>(arg0))))
    }

    public fun calculate_liquidation_fee<T0>(arg0: &Reserve<T0>, arg1: u64) : u64 {
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::ceil(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg1), 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::liquidation_fee(config<T0>(arg0))))
    }

    public fun calculate_utilization_rate<T0>(arg0: &Reserve<T0>) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        let v0 = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::add(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg0.available_amount), arg0.borrowed_amount);
        if (0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::eq(v0, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(0))) {
            0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(0)
        } else {
            0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::div(arg0.borrowed_amount, v0)
        }
    }

    public(friend) fun claim_spread_fees<T0>(arg0: &mut Reserve<T0>) : u64 {
        let v0 = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::floor(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::min(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg0.available_amount), arg0.unclaimed_spread_fees));
        arg0.available_amount = arg0.available_amount - v0;
        arg0.unclaimed_spread_fees = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::sub(arg0.unclaimed_spread_fees, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(v0));
        v0
    }

    public fun coin_type<T0>(arg0: &Reserve<T0>) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public(friend) fun compound_interest<T0>(arg0: &mut Reserve<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = v0 - arg0.interest_last_update_timestamp_s;
        if (v1 == 0) {
            return
        };
        let v2 = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::pow(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::add(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(1), 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::div(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::calculate_apr(config<T0>(arg0), calculate_utilization_rate<T0>(arg0)), 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(31536000))), v1);
        arg0.cumulative_borrow_rate = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(arg0.cumulative_borrow_rate, v2);
        let v3 = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(arg0.borrowed_amount, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::sub(v2, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(1)));
        arg0.unclaimed_spread_fees = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::add(arg0.unclaimed_spread_fees, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(v3, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::spread_fee(config<T0>(arg0))));
        arg0.borrowed_amount = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::add(arg0.borrowed_amount, v3);
        arg0.interest_last_update_timestamp_s = v0;
        let v4 = InterestUpdateEvent<T0>{
            reserve_id             : 0x2::object::uid_to_inner(&arg0.id),
            cumulative_borrow_rate : arg0.cumulative_borrow_rate,
            available_amount       : arg0.available_amount,
            borrowed_amount        : arg0.borrowed_amount,
            ctoken_supply          : arg0.ctoken_supply,
            timestamp_s            : v0,
        };
        0x2::event::emit<InterestUpdateEvent<T0>>(v4);
    }

    public fun config<T0>(arg0: &Reserve<T0>) : &0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::ReserveConfig {
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::cell::get<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::ReserveConfig>(&arg0.config)
    }

    public(friend) fun create_reserve<T0, T1>(arg0: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::ReserveConfig, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Reserve<T0> {
        let (v0, v1, v2) = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::oracles::get_pyth_price_and_identifier(arg2, arg3);
        let v3 = v0;
        assert!(0x1::option::is_some<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal>(&v3), 4);
        Reserve<T0>{
            id                               : 0x2::object::new(arg4),
            coin_type                        : 0x1::type_name::get<T1>(),
            config                           : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::cell::new<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::ReserveConfig>(arg0),
            mint_decimals                    : 0x2::coin::get_decimals<T1>(arg1),
            price_identifier                 : v2,
            price                            : 0x1::option::extract<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal>(&mut v3),
            smoothed_price                   : v1,
            price_last_update_timestamp_s    : 0x2::clock::timestamp_ms(arg3) / 1000,
            available_amount                 : 0,
            ctoken_supply                    : 0,
            borrowed_amount                  : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(0),
            cumulative_borrow_rate           : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(1),
            interest_last_update_timestamp_s : 0x2::clock::timestamp_ms(arg3) / 1000,
            unclaimed_spread_fees            : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(0),
        }
    }

    public fun ctoken_market_value<T0>(arg0: &Reserve<T0>, arg1: u64) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        market_value<T0>(arg0, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg1), ctoken_ratio<T0>(arg0)))
    }

    public fun ctoken_market_value_lower_bound<T0>(arg0: &Reserve<T0>, arg1: u64) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        market_value_lower_bound<T0>(arg0, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg1), ctoken_ratio<T0>(arg0)))
    }

    public fun ctoken_market_value_upper_bound<T0>(arg0: &Reserve<T0>, arg1: u64) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        market_value_upper_bound<T0>(arg0, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg1), ctoken_ratio<T0>(arg0)))
    }

    public fun ctoken_ratio<T0>(arg0: &Reserve<T0>) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        if (arg0.ctoken_supply == 0) {
            0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(1)
        } else {
            0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::div(total_supply<T0>(arg0), 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg0.ctoken_supply))
        }
    }

    public fun cumulative_borrow_rate<T0>(arg0: &Reserve<T0>) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        arg0.cumulative_borrow_rate
    }

    public(friend) fun deposit_liquidity_and_mint_ctokens<T0>(arg0: &mut Reserve<T0>, arg1: u64) : u64 {
        let v0 = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::floor(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::div(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg1), ctoken_ratio<T0>(arg0)));
        arg0.available_amount = arg0.available_amount + arg1;
        arg0.ctoken_supply = arg0.ctoken_supply + v0;
        assert!(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::le(total_supply<T0>(arg0), 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::deposit_limit(config<T0>(arg0)))), 2);
        v0
    }

    public fun market_value<T0>(arg0: &Reserve<T0>, arg1: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::div(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(price<T0>(arg0), arg1), 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(0x2::math::pow(10, arg0.mint_decimals)))
    }

    public fun market_value_lower_bound<T0>(arg0: &Reserve<T0>, arg1: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::div(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(price_lower_bound<T0>(arg0), arg1), 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(0x2::math::pow(10, arg0.mint_decimals)))
    }

    public fun market_value_upper_bound<T0>(arg0: &Reserve<T0>, arg1: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::div(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(price_upper_bound<T0>(arg0), arg1), 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(0x2::math::pow(10, arg0.mint_decimals)))
    }

    public fun price<T0>(arg0: &Reserve<T0>) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        arg0.price
    }

    public fun price_lower_bound<T0>(arg0: &Reserve<T0>) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::min(arg0.price, arg0.smoothed_price)
    }

    public fun price_upper_bound<T0>(arg0: &Reserve<T0>) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::max(arg0.price, arg0.smoothed_price)
    }

    public(friend) fun redeem_ctokens<T0>(arg0: &mut Reserve<T0>, arg1: u64) : u64 {
        let v0 = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::floor(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::mul(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg1), ctoken_ratio<T0>(arg0)));
        arg0.available_amount = arg0.available_amount - v0;
        arg0.ctoken_supply = arg0.ctoken_supply - arg1;
        assert!(arg0.available_amount >= 100, 5);
        v0
    }

    public(friend) fun repay_liquidity<T0>(arg0: &mut Reserve<T0>, arg1: u64) {
        arg0.available_amount = arg0.available_amount + arg1;
        arg0.borrowed_amount = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::sub(arg0.borrowed_amount, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg1));
    }

    public fun total_supply<T0>(arg0: &Reserve<T0>) : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal {
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::sub(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::add(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg0.available_amount), arg0.borrowed_amount), arg0.unclaimed_spread_fees)
    }

    public(friend) fun update_price<T0>(arg0: &mut Reserve<T0>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let (v0, _, v2) = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::oracles::get_pyth_price_and_identifier(arg2, arg1);
        let v3 = v0;
        assert!(v2 == arg0.price_identifier, 1);
        assert!(0x1::option::is_some<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal>(&v3), 4);
        arg0.price = 0x1::option::extract<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::Decimal>(&mut v3);
        arg0.price_last_update_timestamp_s = 0x2::clock::timestamp_ms(arg1) / 1000;
    }

    public(friend) fun update_reserve_config<T0>(arg0: &mut Reserve<T0>, arg1: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::ReserveConfig) {
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::destroy(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::cell::set<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::ReserveConfig>(&mut arg0.config, arg1));
    }

    // decompiled from Move bytecode v6
}

