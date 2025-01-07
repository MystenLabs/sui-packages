module 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve {
    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
        lending_market_id: 0x2::object::ID,
        array_index: u64,
        coin_type: 0x1::type_name::TypeName,
        config: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::cell::Cell<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::ReserveConfig>,
        mint_decimals: u8,
        price_identifier: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier,
        price: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        smoothed_price: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        price_last_update_timestamp_s: u64,
        available_amount: u64,
        ctoken_supply: u64,
        borrowed_amount: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        cumulative_borrow_rate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        interest_last_update_timestamp_s: u64,
        unclaimed_spread_fees: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        attributed_borrow_value: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        deposits_pool_reward_manager: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::PoolRewardManager,
        borrows_pool_reward_manager: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::PoolRewardManager,
    }

    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct LiquidityRequest<phantom T0, phantom T1> {
        amount: u64,
        fee: u64,
    }

    struct BalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StakerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Balances<phantom T0, phantom T1> has store {
        available_amount: 0x2::balance::Balance<T1>,
        ctoken_supply: 0x2::balance::Supply<CToken<T0, T1>>,
        fees: 0x2::balance::Balance<T1>,
        ctoken_fees: 0x2::balance::Balance<CToken<T0, T1>>,
        deposited_ctokens: 0x2::balance::Balance<CToken<T0, T1>>,
    }

    struct InterestUpdateEvent has copy, drop {
        lending_market_id: address,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        cumulative_borrow_rate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        available_amount: u64,
        borrowed_amount: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        unclaimed_spread_fees: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        ctoken_supply: u64,
        borrow_interest_paid: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        spread_fee: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        supply_interest_earned: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        borrow_interest_paid_usd_estimate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        protocol_fee_usd_estimate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        supply_interest_earned_usd_estimate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
    }

    struct ReserveAssetDataEvent has copy, drop {
        lending_market_id: address,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        available_amount: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        supply_amount: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        borrowed_amount: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        available_amount_usd_estimate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        supply_amount_usd_estimate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        borrowed_amount_usd_estimate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        borrow_apr: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        supply_apr: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        ctoken_supply: u64,
        cumulative_borrow_rate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        price: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        smoothed_price: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        price_last_update_timestamp_s: u64,
    }

    struct ClaimStakingRewardsEvent has copy, drop {
        lending_market_id: address,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        amount: u64,
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

    public fun balances<T0, T1>(arg0: &Reserve<T0>) : &Balances<T0, T1> {
        let v0 = BalanceKey{dummy_field: false};
        0x2::dynamic_field::borrow<BalanceKey, Balances<T0, T1>>(&arg0.id, v0)
    }

    public fun balances_available_amount<T0, T1>(arg0: &Balances<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.available_amount
    }

    public fun balances_ctoken_fees<T0, T1>(arg0: &Balances<T0, T1>) : &0x2::balance::Balance<CToken<T0, T1>> {
        &arg0.ctoken_fees
    }

    public fun balances_ctoken_supply<T0, T1>(arg0: &Balances<T0, T1>) : &0x2::balance::Supply<CToken<T0, T1>> {
        &arg0.ctoken_supply
    }

    public fun balances_fees<T0, T1>(arg0: &Balances<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.fees
    }

    public(friend) fun borrow_liquidity<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : LiquidityRequest<T0, T1> {
        let v0 = calculate_borrow_fee<T0>(arg0, arg1);
        let v1 = arg1 + v0;
        arg0.available_amount = arg0.available_amount - v1;
        arg0.borrowed_amount = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.borrowed_amount, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(v1));
        assert!(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::le(arg0.borrowed_amount, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_limit(config<T0>(arg0)))), 3);
        assert!(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::le(market_value_upper_bound<T0>(arg0, arg0.borrowed_amount), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_limit_usd(config<T0>(arg0)))), 3);
        assert!(arg0.available_amount >= 100 && arg0.ctoken_supply >= 100, 5);
        log_reserve_data<T0>(arg0);
        LiquidityRequest<T0, T1>{
            amount : v1,
            fee    : v0,
        }
    }

    public fun borrowed_amount<T0>(arg0: &Reserve<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.borrowed_amount
    }

    public fun borrows_pool_reward_manager<T0>(arg0: &Reserve<T0>) : &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::PoolRewardManager {
        &arg0.borrows_pool_reward_manager
    }

    public(friend) fun borrows_pool_reward_manager_mut<T0>(arg0: &mut Reserve<T0>) : &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::PoolRewardManager {
        &mut arg0.borrows_pool_reward_manager
    }

    public fun calculate_borrow_fee<T0>(arg0: &Reserve<T0>, arg1: u64) : u64 {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::ceil(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg1), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_fee(config<T0>(arg0))))
    }

    public fun calculate_utilization_rate<T0>(arg0: &Reserve<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        let v0 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg0.available_amount), arg0.borrowed_amount);
        if (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::eq(v0, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0))) {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0)
        } else {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(arg0.borrowed_amount, v0)
        }
    }

    public(friend) fun change_price_feed<T0>(arg0: &mut Reserve<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let (_, _, v2) = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::oracles::get_pyth_price_and_identifier(arg1, arg2);
        arg0.price_identifier = v2;
    }

    public(friend) fun claim_fees<T0, T1>(arg0: &mut Reserve<T0>) : (0x2::balance::Balance<CToken<T0, T1>>, 0x2::balance::Balance<T1>) {
        let v0 = BalanceKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0);
        let v2 = 0x2::balance::withdraw_all<T1>(&mut v1.fees);
        if (arg0.available_amount >= 100) {
            let v3 = 0x2::balance::split<T1>(&mut v1.available_amount, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::min(arg0.unclaimed_spread_fees, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg0.available_amount - 100))));
            arg0.unclaimed_spread_fees = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(arg0.unclaimed_spread_fees, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::balance::value<T1>(&v3)));
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
        let v2 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::pow(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(1), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::calculate_apr(config<T0>(arg0), calculate_utilization_rate<T0>(arg0)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(31536000))), v1);
        arg0.cumulative_borrow_rate = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(arg0.cumulative_borrow_rate, v2);
        let v3 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(arg0.borrowed_amount, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(v2, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(1)));
        let v4 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(v3, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::spread_fee(config<T0>(arg0)));
        arg0.unclaimed_spread_fees = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.unclaimed_spread_fees, v4);
        arg0.borrowed_amount = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.borrowed_amount, v3);
        arg0.interest_last_update_timestamp_s = v0;
        let v5 = InterestUpdateEvent{
            lending_market_id                   : 0x2::object::id_to_address(&arg0.lending_market_id),
            coin_type                           : arg0.coin_type,
            reserve_id                          : 0x2::object::uid_to_address(&arg0.id),
            cumulative_borrow_rate              : arg0.cumulative_borrow_rate,
            available_amount                    : arg0.available_amount,
            borrowed_amount                     : arg0.borrowed_amount,
            unclaimed_spread_fees               : arg0.unclaimed_spread_fees,
            ctoken_supply                       : arg0.ctoken_supply,
            borrow_interest_paid                : v3,
            spread_fee                          : v4,
            supply_interest_earned              : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(v3, v4),
            borrow_interest_paid_usd_estimate   : market_value<T0>(arg0, v3),
            protocol_fee_usd_estimate           : market_value<T0>(arg0, v4),
            supply_interest_earned_usd_estimate : market_value<T0>(arg0, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(v3, v4)),
        };
        0x2::event::emit<InterestUpdateEvent>(v5);
    }

    public fun config<T0>(arg0: &Reserve<T0>) : &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::ReserveConfig {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::cell::get<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::ReserveConfig>(&arg0.config)
    }

    public(friend) fun create_reserve<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::ReserveConfig, arg2: u64, arg3: u8, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Reserve<T0> {
        let (v0, v1, v2) = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::oracles::get_pyth_price_and_identifier(arg4, arg5);
        let v3 = v0;
        assert!(0x1::option::is_some<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal>(&v3), 4);
        let v4 = Reserve<T0>{
            id                               : 0x2::object::new(arg6),
            lending_market_id                : arg0,
            array_index                      : arg2,
            coin_type                        : 0x1::type_name::get<T1>(),
            config                           : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::cell::new<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::ReserveConfig>(arg1),
            mint_decimals                    : arg3,
            price_identifier                 : v2,
            price                            : 0x1::option::extract<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal>(&mut v3),
            smoothed_price                   : v1,
            price_last_update_timestamp_s    : 0x2::clock::timestamp_ms(arg5) / 1000,
            available_amount                 : 0,
            ctoken_supply                    : 0,
            borrowed_amount                  : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            cumulative_borrow_rate           : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(1),
            interest_last_update_timestamp_s : 0x2::clock::timestamp_ms(arg5) / 1000,
            unclaimed_spread_fees            : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            attributed_borrow_value          : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            deposits_pool_reward_manager     : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::new_pool_reward_manager(arg6),
            borrows_pool_reward_manager      : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::new_pool_reward_manager(arg6),
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

    public fun ctoken_market_value<T0>(arg0: &Reserve<T0>, arg1: u64) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        market_value<T0>(arg0, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg1), ctoken_ratio<T0>(arg0)))
    }

    public fun ctoken_market_value_lower_bound<T0>(arg0: &Reserve<T0>, arg1: u64) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        market_value_lower_bound<T0>(arg0, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg1), ctoken_ratio<T0>(arg0)))
    }

    public fun ctoken_market_value_upper_bound<T0>(arg0: &Reserve<T0>, arg1: u64) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        market_value_upper_bound<T0>(arg0, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg1), ctoken_ratio<T0>(arg0)))
    }

    public fun ctoken_ratio<T0>(arg0: &Reserve<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        if (arg0.ctoken_supply == 0) {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(1)
        } else {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(total_supply<T0>(arg0), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg0.ctoken_supply))
        }
    }

    public fun ctoken_supply<T0>(arg0: &Reserve<T0>) : u64 {
        arg0.ctoken_supply
    }

    public fun cumulative_borrow_rate<T0>(arg0: &Reserve<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.cumulative_borrow_rate
    }

    public(friend) fun deduct_liquidation_fee<T0, T1>(arg0: &mut Reserve<T0>, arg1: &mut 0x2::balance::Balance<CToken<T0, T1>>) : (u64, u64) {
        let v0 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::liquidation_bonus(config<T0>(arg0));
        let v1 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::protocol_liquidation_fee(config<T0>(arg0));
        let v2 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::ceil(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(v1, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(1), v0), v1)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::balance::value<CToken<T0, T1>>(arg1))));
        let v3 = BalanceKey{dummy_field: false};
        0x2::balance::join<CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v3).ctoken_fees, 0x2::balance::split<CToken<T0, T1>>(arg1, v2));
        (v2, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::ceil(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(v0, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(1), v0), v1)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::balance::value<CToken<T0, T1>>(arg1)))))
    }

    public(friend) fun deposit_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::balance::Balance<CToken<T0, T1>>) {
        log_reserve_data<T0>(arg0);
        let v0 = BalanceKey{dummy_field: false};
        0x2::balance::join<CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).deposited_ctokens, arg1);
    }

    public(friend) fun deposit_liquidity_and_mint_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<CToken<T0, T1>> {
        let v0 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::balance::value<T1>(&arg1)), ctoken_ratio<T0>(arg0)));
        arg0.available_amount = arg0.available_amount + 0x2::balance::value<T1>(&arg1);
        arg0.ctoken_supply = arg0.ctoken_supply + v0;
        let v1 = total_supply<T0>(arg0);
        assert!(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::le(v1, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::deposit_limit(config<T0>(arg0)))), 2);
        assert!(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::le(market_value_upper_bound<T0>(arg0, v1), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::deposit_limit_usd(config<T0>(arg0)))), 2);
        log_reserve_data<T0>(arg0);
        let v2 = BalanceKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v2);
        0x2::balance::join<T1>(&mut v3.available_amount, arg1);
        0x2::balance::increase_supply<CToken<T0, T1>>(&mut v3.ctoken_supply, v0)
    }

    public fun deposits_pool_reward_manager<T0>(arg0: &Reserve<T0>) : &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::PoolRewardManager {
        &arg0.deposits_pool_reward_manager
    }

    public(friend) fun deposits_pool_reward_manager_mut<T0>(arg0: &mut Reserve<T0>) : &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::PoolRewardManager {
        &mut arg0.deposits_pool_reward_manager
    }

    public(friend) fun forgive_debt<T0>(arg0: &mut Reserve<T0>, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) {
        arg0.borrowed_amount = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(arg0.borrowed_amount, arg1);
        log_reserve_data<T0>(arg0);
    }

    public(friend) fun fulfill_liquidity_request<T0, T1>(arg0: &mut Reserve<T0>, arg1: LiquidityRequest<T0, T1>) : 0x2::balance::Balance<T1> {
        let LiquidityRequest {
            amount : v0,
            fee    : v1,
        } = arg1;
        let v2 = BalanceKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v2);
        let v4 = 0x2::balance::split<T1>(&mut v3.available_amount, v0);
        0x2::balance::join<T1>(&mut v3.fees, 0x2::balance::split<T1>(&mut v4, v1));
        v4
    }

    public(friend) fun init_staker<T0, T1: drop>(arg0: &mut Reserve<T0>, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakerKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<StakerKey>(&arg0.id, v0), 8);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<0xe0b710b419fdec56d71fd89f9f29e82902aac77b5b5d1fd359d40df6e721a686::sprungsui::SPRUNGSUI>(), 7);
        let v1 = StakerKey{dummy_field: false};
        0x2::dynamic_field::add<StakerKey, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::staker::Staker<T1>>(&mut arg0.id, v1, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::staker::create_staker<T1>(arg1, arg2));
    }

    public(friend) fun liquidity_request_amount<T0, T1>(arg0: &LiquidityRequest<T0, T1>) : u64 {
        arg0.amount
    }

    public(friend) fun liquidity_request_fee<T0, T1>(arg0: &LiquidityRequest<T0, T1>) : u64 {
        arg0.fee
    }

    fun log_reserve_data<T0>(arg0: &Reserve<T0>) {
        let v0 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg0.available_amount);
        let v1 = total_supply<T0>(arg0);
        let v2 = calculate_utilization_rate<T0>(arg0);
        let v3 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::calculate_apr(config<T0>(arg0), v2);
        let v4 = ReserveAssetDataEvent{
            lending_market_id             : 0x2::object::id_to_address(&arg0.lending_market_id),
            coin_type                     : arg0.coin_type,
            reserve_id                    : 0x2::object::uid_to_address(&arg0.id),
            available_amount              : v0,
            supply_amount                 : v1,
            borrowed_amount               : arg0.borrowed_amount,
            available_amount_usd_estimate : market_value<T0>(arg0, v0),
            supply_amount_usd_estimate    : market_value<T0>(arg0, v1),
            borrowed_amount_usd_estimate  : market_value<T0>(arg0, arg0.borrowed_amount),
            borrow_apr                    : v3,
            supply_apr                    : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::calculate_supply_apr(config<T0>(arg0), v2, v3),
            ctoken_supply                 : arg0.ctoken_supply,
            cumulative_borrow_rate        : arg0.cumulative_borrow_rate,
            price                         : arg0.price,
            smoothed_price                : arg0.smoothed_price,
            price_last_update_timestamp_s : arg0.price_last_update_timestamp_s,
        };
        0x2::event::emit<ReserveAssetDataEvent>(v4);
    }

    public fun market_value<T0>(arg0: &Reserve<T0>, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(price<T0>(arg0), arg1), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::math::pow(10, arg0.mint_decimals)))
    }

    public fun market_value_lower_bound<T0>(arg0: &Reserve<T0>, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(price_lower_bound<T0>(arg0), arg1), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::math::pow(10, arg0.mint_decimals)))
    }

    public fun market_value_upper_bound<T0>(arg0: &Reserve<T0>, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(price_upper_bound<T0>(arg0), arg1), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::math::pow(10, arg0.mint_decimals)))
    }

    public fun max_borrow_amount<T0>(arg0: &Reserve<T0>) : u64 {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::min(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg0.available_amount), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(100)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::min(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_limit(config<T0>(arg0))), arg0.borrowed_amount), usd_to_token_amount_lower_bound<T0>(arg0, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_limit_usd(config<T0>(arg0))), market_value_upper_bound<T0>(arg0, arg0.borrowed_amount))))))
    }

    public fun max_redeem_amount<T0>(arg0: &Reserve<T0>) : u64 {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg0.available_amount), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(100)), ctoken_ratio<T0>(arg0)))
    }

    public fun price<T0>(arg0: &Reserve<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.price
    }

    public fun price_identifier<T0>(arg0: &Reserve<T0>) : &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier {
        &arg0.price_identifier
    }

    public fun price_lower_bound<T0>(arg0: &Reserve<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::min(arg0.price, arg0.smoothed_price)
    }

    public fun price_upper_bound<T0>(arg0: &Reserve<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::max(arg0.price, arg0.smoothed_price)
    }

    public(friend) fun rebalance_staker<T0>(arg0: &mut Reserve<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakerKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<StakerKey>(&arg0.id, v0), 9);
        let v1 = BalanceKey{dummy_field: false};
        let v2 = StakerKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<StakerKey, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::staker::Staker<0xe0b710b419fdec56d71fd89f9f29e82902aac77b5b5d1fd359d40df6e721a686::sprungsui::SPRUNGSUI>>(&mut arg0.id, v2);
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::staker::deposit<0xe0b710b419fdec56d71fd89f9f29e82902aac77b5b5d1fd359d40df6e721a686::sprungsui::SPRUNGSUI>(v3, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, 0x2::sui::SUI>>(&mut arg0.id, v1).available_amount));
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::staker::rebalance<0xe0b710b419fdec56d71fd89f9f29e82902aac77b5b5d1fd359d40df6e721a686::sprungsui::SPRUNGSUI>(v3, arg1, arg2);
        let v4 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::staker::claim_fees<0xe0b710b419fdec56d71fd89f9f29e82902aac77b5b5d1fd359d40df6e721a686::sprungsui::SPRUNGSUI>(v3, arg1, arg2);
        if (0x2::balance::value<0x2::sui::SUI>(&v4) > 0) {
            let v5 = ClaimStakingRewardsEvent{
                lending_market_id : 0x2::object::id_to_address(&arg0.lending_market_id),
                coin_type         : arg0.coin_type,
                reserve_id        : 0x2::object::uid_to_address(&arg0.id),
                amount            : 0x2::balance::value<0x2::sui::SUI>(&v4),
            };
            0x2::event::emit<ClaimStakingRewardsEvent>(v5);
            let v6 = BalanceKey{dummy_field: false};
            0x2::balance::join<0x2::sui::SUI>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, 0x2::sui::SUI>>(&mut arg0.id, v6).fees, v4);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
        };
    }

    public(friend) fun redeem_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::balance::Balance<CToken<T0, T1>>) : LiquidityRequest<T0, T1> {
        let v0 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::balance::value<CToken<T0, T1>>(&arg1)), ctoken_ratio<T0>(arg0)));
        arg0.available_amount = arg0.available_amount - v0;
        arg0.ctoken_supply = arg0.ctoken_supply - 0x2::balance::value<CToken<T0, T1>>(&arg1);
        assert!(arg0.available_amount >= 100 && arg0.ctoken_supply >= 100, 5);
        log_reserve_data<T0>(arg0);
        let v1 = BalanceKey{dummy_field: false};
        0x2::balance::decrease_supply<CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v1).ctoken_supply, arg1);
        LiquidityRequest<T0, T1>{
            amount : v0,
            fee    : 0,
        }
    }

    public(friend) fun repay_liquidity<T0, T1>(arg0: &mut Reserve<T0>, arg1: 0x2::balance::Balance<T1>, arg2: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) {
        assert!(0x2::balance::value<T1>(&arg1) == 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::ceil(arg2), 6);
        arg0.available_amount = arg0.available_amount + 0x2::balance::value<T1>(&arg1);
        arg0.borrowed_amount = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(arg0.borrowed_amount, arg2);
        log_reserve_data<T0>(arg0);
        let v0 = BalanceKey{dummy_field: false};
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).available_amount, arg1);
    }

    public fun staker<T0, T1>(arg0: &Reserve<T0>) : &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::staker::Staker<T1> {
        let v0 = StakerKey{dummy_field: false};
        0x2::dynamic_field::borrow<StakerKey, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::staker::Staker<T1>>(&arg0.id, v0)
    }

    public fun total_supply<T0>(arg0: &Reserve<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg0.available_amount), arg0.borrowed_amount), arg0.unclaimed_spread_fees)
    }

    public fun unclaimed_spread_fees<T0>(arg0: &Reserve<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.unclaimed_spread_fees
    }

    public(friend) fun unstake_sui_from_staker<T0>(arg0: &mut Reserve<T0>, arg1: &LiquidityRequest<T0, 0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.coin_type == 0x1::type_name::get<0x2::sui::SUI>(), 7);
        let v0 = StakerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<StakerKey>(&arg0.id, v0)) {
            return
        };
        let v1 = BalanceKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<BalanceKey, Balances<T0, 0x2::sui::SUI>>(&arg0.id, v1);
        if (arg1.amount <= 0x2::balance::value<0x2::sui::SUI>(&v2.available_amount)) {
            return
        };
        let v3 = StakerKey{dummy_field: false};
        let v4 = BalanceKey{dummy_field: false};
        0x2::balance::join<0x2::sui::SUI>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, 0x2::sui::SUI>>(&mut arg0.id, v4).available_amount, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::staker::withdraw<0xe0b710b419fdec56d71fd89f9f29e82902aac77b5b5d1fd359d40df6e721a686::sprungsui::SPRUNGSUI>(0x2::dynamic_field::borrow_mut<StakerKey, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::staker::Staker<0xe0b710b419fdec56d71fd89f9f29e82902aac77b5b5d1fd359d40df6e721a686::sprungsui::SPRUNGSUI>>(&mut arg0.id, v3), arg1.amount - 0x2::balance::value<0x2::sui::SUI>(&v2.available_amount), arg2, arg3));
    }

    public(friend) fun update_price<T0>(arg0: &mut Reserve<T0>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let (v0, v1, v2) = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::oracles::get_pyth_price_and_identifier(arg2, arg1);
        let v3 = v0;
        assert!(v2 == arg0.price_identifier, 1);
        assert!(0x1::option::is_some<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal>(&v3), 4);
        arg0.price = 0x1::option::extract<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal>(&mut v3);
        arg0.smoothed_price = v1;
        arg0.price_last_update_timestamp_s = 0x2::clock::timestamp_ms(arg1) / 1000;
    }

    public(friend) fun update_reserve_config<T0>(arg0: &mut Reserve<T0>, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::ReserveConfig) {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::destroy(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::cell::set<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::ReserveConfig>(&mut arg0.config, arg1));
    }

    public fun usd_to_token_amount_lower_bound<T0>(arg0: &Reserve<T0>, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::math::pow(10, arg0.mint_decimals)), arg1), price_upper_bound<T0>(arg0))
    }

    public fun usd_to_token_amount_upper_bound<T0>(arg0: &Reserve<T0>, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::math::pow(10, arg0.mint_decimals)), arg1), price_lower_bound<T0>(arg0))
    }

    public(friend) fun withdraw_ctokens<T0, T1>(arg0: &mut Reserve<T0>, arg1: u64) : 0x2::balance::Balance<CToken<T0, T1>> {
        log_reserve_data<T0>(arg0);
        let v0 = BalanceKey{dummy_field: false};
        0x2::balance::split<CToken<T0, T1>>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).deposited_ctokens, arg1)
    }

    // decompiled from Move bytecode v6
}

