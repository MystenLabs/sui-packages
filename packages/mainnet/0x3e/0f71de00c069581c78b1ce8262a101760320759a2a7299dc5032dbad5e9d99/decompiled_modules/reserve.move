module 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Price has store {
        price: 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal,
        last_update_timestamp_ms: u64,
    }

    struct ReserveConfig has store {
        id: 0x2::object::UID,
        open_ltv_pct: u8,
        close_ltv_pct: u8,
        borrow_weight_bps: u64,
        deposit_limit: u64,
        borrow_limit: u64,
        liquidation_bonus_pct: u8,
        borrow_fee_bps: u64,
        spread_fee_bps: u64,
        liquidation_fee_bps: u64,
        interest_rate: InterestRateModel,
    }

    struct InterestRateModel has drop, store {
        utils: vector<u8>,
        aprs: vector<u64>,
    }

    struct Reserve<phantom T0> has store {
        config: 0x1::option::Option<ReserveConfig>,
        mint_decimals: u8,
        price: 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal,
        price_last_update_timestamp_s: u64,
        available_amount: u64,
        ctoken_supply: u64,
        borrowed_amount: 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal,
        cumulative_borrow_rate: 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal,
        interest_last_update_timestamp_s: u64,
        fees_accumulated: 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal,
    }

    struct ReserveTreasury<phantom T0, phantom T1> has store {
        reserve_id: u64,
        available_amount: 0x2::balance::Balance<T1>,
        ctoken_supply: 0x2::balance::Supply<CToken<T0, T1>>,
    }

    public(friend) fun borrow_liquidity<T0, T1>(arg0: &mut Reserve<T0>, arg1: &mut ReserveTreasury<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) : 0x2::balance::Balance<T1> {
        compound_interest<T0>(arg0, arg2);
        arg0.available_amount = arg0.available_amount - arg3;
        arg0.borrowed_amount = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::add(arg0.borrowed_amount, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(arg3));
        0x2::balance::split<T1>(&mut arg1.available_amount, arg3)
    }

    public fun borrow_weight<T0>(arg0: &Reserve<T0>) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from_bps(0x1::option::borrow<ReserveConfig>(&arg0.config).borrow_weight_bps)
    }

    public fun calculate_apr<T0>(arg0: &Reserve<T0>) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from_percent(5)
    }

    public fun calculate_utilization_rate<T0>(arg0: &Reserve<T0>) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        let v0 = total_supply<T0>(arg0);
        if (0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::eq(v0, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(0))) {
            0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(0)
        } else {
            0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::div(arg0.borrowed_amount, v0)
        }
    }

    public fun close_ltv<T0>(arg0: &Reserve<T0>) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from_percent(0x1::option::borrow<ReserveConfig>(&arg0.config).close_ltv_pct)
    }

    public(friend) fun compound_interest<T0>(arg0: &mut Reserve<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(v0 - arg0.interest_last_update_timestamp_s);
        if (0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::eq(v1, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(0))) {
            return
        };
        let v2 = 8;
        0x1::debug::print<u64>(&v2);
        0x1::debug::print<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal>(&v1);
        let v3 = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::add(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(1), 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::mul(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::div(calculate_apr<T0>(arg0), 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(31536000)), v1));
        arg0.cumulative_borrow_rate = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::mul(arg0.cumulative_borrow_rate, v3);
        arg0.borrowed_amount = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::mul(arg0.borrowed_amount, v3);
        arg0.interest_last_update_timestamp_s = v0;
    }

    public(friend) fun create_reserve<T0, T1>(arg0: ReserveConfig, arg1: &0x2::coin::CoinMetadata<T1>, arg2: u256, arg3: &0x2::clock::Clock, arg4: u64) : (Reserve<T0>, ReserveTreasury<T0, T1>) {
        let v0 = Reserve<T0>{
            config                           : 0x1::option::some<ReserveConfig>(arg0),
            mint_decimals                    : 0x2::coin::get_decimals<T1>(arg1),
            price                            : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from_scaled_val(arg2),
            price_last_update_timestamp_s    : 0x2::clock::timestamp_ms(arg3) / 1000,
            available_amount                 : 0,
            ctoken_supply                    : 0,
            borrowed_amount                  : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(0),
            cumulative_borrow_rate           : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(1),
            interest_last_update_timestamp_s : 0x2::clock::timestamp_ms(arg3) / 1000,
            fees_accumulated                 : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(0),
        };
        let v1 = CToken<T0, T1>{dummy_field: false};
        let v2 = ReserveTreasury<T0, T1>{
            reserve_id       : arg4,
            available_amount : 0x2::balance::zero<T1>(),
            ctoken_supply    : 0x2::balance::create_supply<CToken<T0, T1>>(v1),
        };
        (v0, v2)
    }

    public fun create_reserve_config(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) : ReserveConfig {
        let v0 = InterestRateModel{
            utils : arg8,
            aprs  : arg9,
        };
        ReserveConfig{
            id                    : 0x2::object::new(arg10),
            open_ltv_pct          : arg0,
            close_ltv_pct         : arg1,
            borrow_weight_bps     : arg2,
            deposit_limit         : arg3,
            borrow_limit          : arg4,
            liquidation_bonus_pct : 5,
            borrow_fee_bps        : arg5,
            spread_fee_bps        : arg6,
            liquidation_fee_bps   : arg7,
            interest_rate         : v0,
        }
    }

    public fun ctoken_ratio<T0>(arg0: &Reserve<T0>) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        let v0 = total_supply<T0>(arg0);
        if (0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::eq(v0, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(0))) {
            0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(1)
        } else {
            0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::div(v0, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(arg0.ctoken_supply))
        }
    }

    public fun cumulative_borrow_rate<T0>(arg0: &Reserve<T0>) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        arg0.cumulative_borrow_rate
    }

    public(friend) fun deposit_liquidity_and_mint_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: &mut ReserveTreasury<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<CToken<T0, T1>> {
        compound_interest<T0>(arg0, arg3);
        let v0 = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::floor(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::div(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(0x2::balance::value<T1>(&arg2)), ctoken_ratio<T0>(arg0)));
        arg0.available_amount = arg0.available_amount + 0x2::balance::value<T1>(&arg2);
        arg0.ctoken_supply = arg0.ctoken_supply + v0;
        0x2::balance::join<T1>(&mut arg1.available_amount, arg2);
        0x2::balance::increase_supply<CToken<T0, T1>>(&mut arg1.ctoken_supply, v0)
    }

    public fun liquidation_bonus<T0>(arg0: &Reserve<T0>) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from_percent(0x1::option::borrow<ReserveConfig>(&arg0.config).liquidation_bonus_pct)
    }

    public fun market_value<T0>(arg0: &Reserve<T0>, arg1: &0x2::clock::Clock, arg2: 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::div(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::mul(price<T0>(arg0, arg1), arg2), 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(0x2::math::pow(10, arg0.mint_decimals)))
    }

    public fun open_ltv<T0>(arg0: &Reserve<T0>) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from_percent(0x1::option::borrow<ReserveConfig>(&arg0.config).open_ltv_pct)
    }

    public fun price<T0>(arg0: &Reserve<T0>, arg1: &0x2::clock::Clock) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 - arg0.price_last_update_timestamp_s <= 60, 0);
        arg0.price
    }

    public(friend) fun redeem_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: &mut ReserveTreasury<T0, T1>, arg2: 0x2::balance::Balance<CToken<T0, T1>>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        compound_interest<T0>(arg0, arg3);
        let v0 = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::floor(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::mul(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(0x2::balance::value<CToken<T0, T1>>(&arg2)), ctoken_ratio<T0>(arg0)));
        arg0.available_amount = arg0.available_amount - v0;
        arg0.ctoken_supply = arg0.ctoken_supply - 0x2::balance::value<CToken<T0, T1>>(&arg2);
        0x2::balance::decrease_supply<CToken<T0, T1>>(&mut arg1.ctoken_supply, arg2);
        0x2::balance::split<T1>(&mut arg1.available_amount, v0)
    }

    public(friend) fun repay_liquidity<T0, T1>(arg0: &mut Reserve<T0>, arg1: &mut ReserveTreasury<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>) {
        compound_interest<T0>(arg0, arg2);
        arg0.available_amount = arg0.available_amount + 0x2::balance::value<T1>(&arg3);
        arg0.borrowed_amount = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::sub(arg0.borrowed_amount, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(0x2::balance::value<T1>(&arg3)));
        0x2::balance::join<T1>(&mut arg1.available_amount, arg3);
    }

    public fun reserve_id<T0, T1>(arg0: &ReserveTreasury<T0, T1>) : u64 {
        arg0.reserve_id
    }

    public fun total_supply<T0>(arg0: &Reserve<T0>) : 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal {
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::add(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::from(arg0.available_amount), arg0.borrowed_amount)
    }

    public(friend) fun update_reserve_config<T0>(arg0: &mut Reserve<T0>, arg1: ReserveConfig) {
        0x1::option::fill<ReserveConfig>(&mut arg0.config, arg1);
        let ReserveConfig {
            id                    : v0,
            open_ltv_pct          : _,
            close_ltv_pct         : _,
            borrow_weight_bps     : _,
            deposit_limit         : _,
            borrow_limit          : _,
            liquidation_bonus_pct : _,
            borrow_fee_bps        : _,
            spread_fee_bps        : _,
            liquidation_fee_bps   : _,
            interest_rate         : _,
        } = 0x1::option::extract<ReserveConfig>(&mut arg0.config);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

