module 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve {
    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
        array_index: u64,
        coin_type: 0x1::type_name::TypeName,
        config: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::cell::Cell<0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::ReserveConfig>,
        mint_decimals: u8,
        price_identifier: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier,
        price: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal,
        smoothed_price: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal,
        price_last_update_timestamp_s: u64,
        available_amount: u64,
        ctoken_supply: u64,
        borrowed_amount: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal,
        cumulative_borrow_rate: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal,
        interest_last_update_timestamp_s: u64,
        unclaimed_spread_fees: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal,
    }

    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct BalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Balances<phantom T0, phantom T1> has store {
        available_amount: 0x2::balance::Balance<T1>,
        ctoken_supply: 0x2::balance::Supply<CToken<T0, T1>>,
        fees: 0x2::balance::Balance<T1>,
        ctoken_fees: 0x2::balance::Balance<CToken<T0, T1>>,
        deposited_ctokens: 0x2::balance::Balance<CToken<T0, T1>>,
    }

    struct InterestUpdateEvent<phantom T0> has copy, drop {
        reserve_id: 0x2::object::ID,
        cumulative_borrow_rate: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal,
        available_amount: u64,
        borrowed_amount: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal,
        ctoken_supply: u64,
        timestamp_s: u64,
    }

    public fun array_index<T0>(arg0: &Reserve<T0>) : u64 {
        arg0.array_index
    }

    public fun assert_price_is_fresh<T0>(arg0: &Reserve<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 - arg0.price_last_update_timestamp_s <= 0, 0);
    }

    public fun available_amount<T0>(arg0: &Reserve<T0>) : u64 {
        arg0.available_amount
    }

    public(friend) fun borrow_liquidity<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : (0x2::balance::Balance<T1>, u64) {
        let v0 = calculate_borrow_fee<T0>(arg0, arg1);
        let v1 = arg1 + v0;
        arg0.available_amount = arg0.available_amount - v1;
        arg0.borrowed_amount = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::add(arg0.borrowed_amount, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(v1));
        assert!(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::le(arg0.borrowed_amount, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::borrow_limit(config<T0>(arg0)))), 3);
        assert!(arg0.available_amount >= 100, 5);
        let v2 = BalanceKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v2);
        let v4 = 0x2::balance::split<T1>(&mut v3.available_amount, v1);
        0x2::balance::join<T1>(&mut v3.fees, 0x2::balance::split<T1>(&mut v4, v0));
        (v4, v1)
    }

    public fun borrowed_amount<T0>(arg0: &Reserve<T0>) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        arg0.borrowed_amount
    }

    public fun calculate_borrow_fee<T0>(arg0: &Reserve<T0>, arg1: u64) : u64 {
        0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::ceil(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(arg1), 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::borrow_fee(config<T0>(arg0))))
    }

    public fun calculate_utilization_rate<T0>(arg0: &Reserve<T0>) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        let v0 = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::add(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(arg0.available_amount), arg0.borrowed_amount);
        if (0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::eq(v0, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0))) {
            0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0)
        } else {
            0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::div(arg0.borrowed_amount, v0)
        }
    }

    public(friend) fun claim_fees<T0, T1>(arg0: &mut Reserve<T0>) : (0x2::balance::Balance<CToken<T0, T1>>, 0x2::balance::Balance<T1>) {
        let v0 = BalanceKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0);
        let v2 = 0x2::balance::withdraw_all<T1>(&mut v1.fees);
        if (arg0.available_amount >= 100) {
            let v3 = 0x2::balance::split<T1>(&mut v1.available_amount, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::floor(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::min(arg0.unclaimed_spread_fees, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(arg0.available_amount - 100))));
            arg0.unclaimed_spread_fees = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::sub(arg0.unclaimed_spread_fees, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0x2::balance::value<T1>(&v3)));
            arg0.available_amount = arg0.available_amount - 0x2::balance::value<T1>(&v3);
            0x2::balance::join<T1>(&mut v2, v3);
        };
        (0x2::balance::withdraw_all<CToken<T0, T1>>(&mut v1.ctoken_fees), v2)
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
        let v2 = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::pow(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::add(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(1), 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::div(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::calculate_apr(config<T0>(arg0), calculate_utilization_rate<T0>(arg0)), 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(31536000))), v1);
        arg0.cumulative_borrow_rate = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(arg0.cumulative_borrow_rate, v2);
        let v3 = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(arg0.borrowed_amount, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::sub(v2, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(1)));
        arg0.unclaimed_spread_fees = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::add(arg0.unclaimed_spread_fees, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(v3, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::spread_fee(config<T0>(arg0))));
        arg0.borrowed_amount = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::add(arg0.borrowed_amount, v3);
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

    public fun config<T0>(arg0: &Reserve<T0>) : &0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::ReserveConfig {
        0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::cell::get<0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::ReserveConfig>(&arg0.config)
    }

    public(friend) fun create_reserve<T0, T1>(arg0: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::ReserveConfig, arg1: u64, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Reserve<T0> {
        let (v0, v1, v2) = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::oracles::get_pyth_price_and_identifier(arg3, arg4);
        let v3 = v0;
        assert!(0x1::option::is_some<0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal>(&v3), 4);
        let v4 = Reserve<T0>{
            id                               : 0x2::object::new(arg5),
            array_index                      : arg1,
            coin_type                        : 0x1::type_name::get<T1>(),
            config                           : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::cell::new<0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::ReserveConfig>(arg0),
            mint_decimals                    : 0x2::coin::get_decimals<T1>(arg2),
            price_identifier                 : v2,
            price                            : 0x1::option::extract<0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal>(&mut v3),
            smoothed_price                   : v1,
            price_last_update_timestamp_s    : 0x2::clock::timestamp_ms(arg4) / 1000,
            available_amount                 : 0,
            ctoken_supply                    : 0,
            borrowed_amount                  : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0),
            cumulative_borrow_rate           : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(1),
            interest_last_update_timestamp_s : 0x2::clock::timestamp_ms(arg4) / 1000,
            unclaimed_spread_fees            : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0),
        };
        let v5 = BalanceKey{dummy_field: false};
        let v6 = CToken<T0, T1>{dummy_field: false};
        let v7 = Balances<T0, T1>{
            available_amount  : 0x2::balance::zero<T1>(),
            ctoken_supply     : 0x2::balance::create_supply<CToken<T0, T1>>(v6),
            fees              : 0x2::balance::zero<T1>(),
            ctoken_fees       : 0x2::balance::zero<CToken<T0, T1>>(),
            deposited_ctokens : 0x2::balance::zero<CToken<T0, T1>>(),
        };
        0x2::dynamic_field::add<BalanceKey, Balances<T0, T1>>(&mut v4.id, v5, v7);
        v4
    }

    public fun ctoken_market_value<T0>(arg0: &Reserve<T0>, arg1: u64) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        market_value<T0>(arg0, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(arg1), ctoken_ratio<T0>(arg0)))
    }

    public fun ctoken_market_value_lower_bound<T0>(arg0: &Reserve<T0>, arg1: u64) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        market_value_lower_bound<T0>(arg0, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(arg1), ctoken_ratio<T0>(arg0)))
    }

    public fun ctoken_market_value_upper_bound<T0>(arg0: &Reserve<T0>, arg1: u64) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        market_value_upper_bound<T0>(arg0, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(arg1), ctoken_ratio<T0>(arg0)))
    }

    public fun ctoken_ratio<T0>(arg0: &Reserve<T0>) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        if (arg0.ctoken_supply == 0) {
            0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(1)
        } else {
            0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::div(total_supply<T0>(arg0), 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(arg0.ctoken_supply))
        }
    }

    public fun cumulative_borrow_rate<T0>(arg0: &Reserve<T0>) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        arg0.cumulative_borrow_rate
    }

    public fun deduct_liquidation_fee<T0, T1>(arg0: &mut Reserve<T0>, arg1: &mut 0x2::balance::Balance<CToken<T0, T1>>) {
        let v0 = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::liquidation_bonus(config<T0>(arg0));
        let v1 = BalanceKey{dummy_field: false};
        0x2::balance::join<CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v1).ctoken_fees, 0x2::balance::split<CToken<T0, T1>>(arg1, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::ceil(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::div(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(v0, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::liquidation_fee(config<T0>(arg0))), 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::add(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(1), v0)), 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0x2::balance::value<CToken<T0, T1>>(arg1))))));
    }

    public(friend) fun deposit_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::balance::Balance<CToken<T0, T1>>) {
        let v0 = BalanceKey{dummy_field: false};
        0x2::balance::join<CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).deposited_ctokens, arg1);
    }

    public(friend) fun deposit_liquidity_and_mint_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<CToken<T0, T1>> {
        let v0 = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::floor(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::div(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0x2::balance::value<T1>(&arg1)), ctoken_ratio<T0>(arg0)));
        arg0.available_amount = arg0.available_amount + 0x2::balance::value<T1>(&arg1);
        arg0.ctoken_supply = arg0.ctoken_supply + v0;
        assert!(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::le(total_supply<T0>(arg0), 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::deposit_limit(config<T0>(arg0)))), 2);
        let v1 = BalanceKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v1);
        0x2::balance::join<T1>(&mut v2.available_amount, arg1);
        0x2::balance::increase_supply<CToken<T0, T1>>(&mut v2.ctoken_supply, v0)
    }

    public fun market_value<T0>(arg0: &Reserve<T0>, arg1: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::div(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(price<T0>(arg0), arg1), 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0x2::math::pow(10, arg0.mint_decimals)))
    }

    public fun market_value_lower_bound<T0>(arg0: &Reserve<T0>, arg1: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::div(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(price_lower_bound<T0>(arg0), arg1), 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0x2::math::pow(10, arg0.mint_decimals)))
    }

    public fun market_value_upper_bound<T0>(arg0: &Reserve<T0>, arg1: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::div(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(price_upper_bound<T0>(arg0), arg1), 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0x2::math::pow(10, arg0.mint_decimals)))
    }

    public fun price<T0>(arg0: &Reserve<T0>) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        arg0.price
    }

    public fun price_lower_bound<T0>(arg0: &Reserve<T0>) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::min(arg0.price, arg0.smoothed_price)
    }

    public fun price_upper_bound<T0>(arg0: &Reserve<T0>) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::max(arg0.price, arg0.smoothed_price)
    }

    public(friend) fun redeem_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::balance::Balance<CToken<T0, T1>>) : 0x2::balance::Balance<T1> {
        let v0 = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::floor(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::mul(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0x2::balance::value<CToken<T0, T1>>(&arg1)), ctoken_ratio<T0>(arg0)));
        arg0.available_amount = arg0.available_amount - v0;
        arg0.ctoken_supply = arg0.ctoken_supply - 0x2::balance::value<CToken<T0, T1>>(&arg1);
        assert!(arg0.available_amount >= 100, 5);
        let v1 = BalanceKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v1);
        0x2::balance::decrease_supply<CToken<T0, T1>>(&mut v2.ctoken_supply, arg1);
        0x2::balance::split<T1>(&mut v2.available_amount, v0)
    }

    public(friend) fun repay_liquidity<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::balance::Balance<T1>) {
        arg0.available_amount = arg0.available_amount + 0x2::balance::value<T1>(&arg1);
        arg0.borrowed_amount = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::sub(arg0.borrowed_amount, 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(0x2::balance::value<T1>(&arg1)));
        let v0 = BalanceKey{dummy_field: false};
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).available_amount, arg1);
    }

    public fun total_supply<T0>(arg0: &Reserve<T0>) : 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal {
        0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::sub(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::add(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::from(arg0.available_amount), arg0.borrowed_amount), arg0.unclaimed_spread_fees)
    }

    public(friend) fun update_price<T0>(arg0: &mut Reserve<T0>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let (v0, v1, v2) = 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::oracles::get_pyth_price_and_identifier(arg2, arg1);
        let v3 = v0;
        assert!(v2 == arg0.price_identifier, 1);
        assert!(0x1::option::is_some<0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal>(&v3), 4);
        arg0.price = 0x1::option::extract<0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::decimal::Decimal>(&mut v3);
        arg0.smoothed_price = v1;
        arg0.price_last_update_timestamp_s = 0x2::clock::timestamp_ms(arg1) / 1000;
    }

    public(friend) fun update_reserve_config<T0>(arg0: &mut Reserve<T0>, arg1: 0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::ReserveConfig) {
        0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::destroy(0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::cell::set<0xae5353292dac0d55c40185b4a25a589e187d0f5f34179e4c8f3ccd77dabc9d5::reserve_config::ReserveConfig>(&mut arg0.config, arg1));
    }

    public(friend) fun withdraw_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<CToken<T0, T1>> {
        let v0 = BalanceKey{dummy_field: false};
        0x2::balance::split<CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).deposited_ctokens, arg1)
    }

    // decompiled from Move bytecode v6
}

