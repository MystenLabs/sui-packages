module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve {
    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct ReserveLiquidity<phantom T0> has store {
        mint_token_type: 0x1::string::String,
        available_amount: u64,
        borrowed_amount: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        market_price: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        market_price_last_updated_ts: u64,
        mint_decimal: u8,
        deposit_limit_crossed_ts: u64,
        borrow_limit_crossed_ts: u64,
        cumulative_borrow_rate: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        accumulated_protocol_fees: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        supply_balance: 0x2::balance::Balance<T0>,
        fee_balance: 0x2::balance::Balance<T0>,
    }

    struct ReserveCollateral<phantom T0, phantom T1> has store {
        mint_total_amount: u64,
        ctoken_mint_total_balance: 0x2::balance::Balance<CToken<T0, T1>>,
        ctoken_mint_total_supply: 0x2::balance::Supply<CToken<T0, T1>>,
    }

    struct ReserveConfig has store {
        status: u8,
        asset_tier: u8,
        base_fixed_interest_rate_bps: u16,
        reserve_factor_rate_bps: u16,
        max_interest_rate_bps: u16,
        loan_to_value_bps: u16,
        liquidation_threshold_bps: u16,
        liquidation_max_debt_close_factor_bps: u16,
        liquidation_penalty_bps: u16,
        borrow_rate_at_optimal_bps: u16,
        borrow_factor_bps: u16,
        borrow_fee_bps: u16,
        deposit_limit: u64,
        borrow_limit: u64,
        token_info: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::TokenInfo,
        deposit_withdrawal_cap: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::WithdrawalCap,
        debt_withdrawal_cap: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::WithdrawalCap,
        utilization_optimal_bps: u16,
        utilization_limit_block_borrowing_above_bps: u16,
        min_net_value_in_obligation: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
    }

    struct Reserve<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        liquidity: ReserveLiquidity<T1>,
        collateral: ReserveCollateral<T0, T1>,
        config: ReserveConfig,
        last_update: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::LastUpdate,
    }

    struct InitReserveEvent has copy, drop {
        reserve: 0x2::object::ID,
        market_type: 0x1::string::String,
        reserve_liquidity_mint: 0x1::string::String,
        reserve_collateral_mint: 0x1::string::String,
        asset_tier: u8,
        base_fixed_interest_rate_bps: u16,
        reserve_factor_rate_bps: u16,
        loan_to_value_bps: u16,
        liquidation_penalty_bps: u16,
        borrow_rate_at_optimal_bps: u16,
        borrow_factor_bps: u16,
        borrow_fee_bps: u16,
        deposit_limit: u64,
        borrow_limit: u64,
        utilization_optimal_bps: u16,
        min_net_value_in_obligation: u128,
    }

    struct UpdateReserveEvent has copy, drop {
        reserve: 0x2::object::ID,
        market_type: 0x1::string::String,
        asset_tier: u8,
        base_fixed_interest_rate_bps: u16,
        reserve_factor_rate_bps: u16,
        loan_to_value_bps: u16,
        liquidation_penalty_bps: u16,
        borrow_rate_at_optimal_bps: u16,
        borrow_factor_bps: u16,
        borrow_fee_bps: u16,
        deposit_limit: u64,
        borrow_limit: u64,
        utilization_optimal_bps: u16,
        min_net_value_in_obligation: u128,
    }

    struct RefreshReserveEvent has copy, drop {
        reserve: 0x2::object::ID,
        total_supply_sf: u256,
        total_borrow_sf: u256,
        total_mint_collateral: u64,
        borrow_rate_sf: u256,
        supply_rate_sf: u256,
    }

    public(friend) fun borrow<T0: copy + drop + store, T1: store, T2, T3>(arg0: &Reserve<T2, T3>, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut<T0: copy + drop + store, T1: store, T2, T3>(arg0: &mut Reserve<T2, T3>, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun add<T0: copy + drop + store, T1: store, T2, T3>(arg0: &mut Reserve<T2, T3>, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun remove<T0: copy + drop + store, T1: store, T2, T3>(arg0: &mut Reserve<T2, T3>, arg1: T0) : T1 {
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun new<T0, T1>(arg0: u16, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u16, arg8: u16, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u16, arg15: u16, arg16: u128, arg17: u16, arg18: 0x1::string::String, arg19: u8, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: 0x1::option::Option<0x1::string::String>, arg27: 0x1::option::Option<0x1::string::String>, arg28: &0x2::clock::Clock, arg29: &mut 0x2::tx_context::TxContext) : Reserve<T0, T1> {
        let v0 = 0x2::clock::timestamp_ms(arg28);
        let v1 = CToken<T0, T1>{dummy_field: false};
        let v2 = ReserveCollateral<T0, T1>{
            mint_total_amount         : 0,
            ctoken_mint_total_balance : 0x2::balance::zero<CToken<T0, T1>>(),
            ctoken_mint_total_supply  : 0x2::balance::create_supply<CToken<T0, T1>>(v1),
        };
        let v3 = ReserveLiquidity<T1>{
            mint_token_type              : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T1>(),
            available_amount             : 0,
            borrowed_amount              : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            market_price                 : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            market_price_last_updated_ts : 0,
            mint_decimal                 : arg19,
            deposit_limit_crossed_ts     : 0,
            borrow_limit_crossed_ts      : 0,
            cumulative_borrow_rate       : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::one(),
            accumulated_protocol_fees    : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            supply_balance               : 0x2::balance::zero<T1>(),
            fee_balance                  : 0x2::balance::zero<T1>(),
        };
        let v4 = ReserveConfig{
            status                                      : 0,
            asset_tier                                  : 0,
            base_fixed_interest_rate_bps                : arg0,
            reserve_factor_rate_bps                     : arg1,
            max_interest_rate_bps                       : arg2,
            loan_to_value_bps                           : arg3,
            liquidation_threshold_bps                   : arg4,
            liquidation_max_debt_close_factor_bps       : arg17,
            liquidation_penalty_bps                     : arg5,
            borrow_rate_at_optimal_bps                  : arg6,
            borrow_factor_bps                           : arg7,
            borrow_fee_bps                              : arg8,
            deposit_limit                               : arg9,
            borrow_limit                                : arg10,
            token_info                                  : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::new(arg18, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T1>(), arg21, arg20, arg22, arg23, arg24, arg25, arg26, arg27, 0),
            deposit_withdrawal_cap                      : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::new(arg11, arg13, v0),
            debt_withdrawal_cap                         : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::new(arg12, arg13, v0),
            utilization_optimal_bps                     : arg14,
            utilization_limit_block_borrowing_above_bps : arg15,
            min_net_value_in_obligation                 : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_u128(arg16),
        };
        let v5 = Reserve<T0, T1>{
            id          : 0x2::object::new(arg29),
            liquidity   : v3,
            collateral  : v2,
            config      : v4,
            last_update : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::new(v0),
        };
        let v6 = &v5.config;
        let v7 = InitReserveEvent{
            reserve                      : 0x2::object::id<Reserve<T0, T1>>(&v5),
            market_type                  : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>(),
            reserve_liquidity_mint       : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T1>(),
            reserve_collateral_mint      : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<CToken<T0, T1>>(),
            asset_tier                   : v6.asset_tier,
            base_fixed_interest_rate_bps : v6.base_fixed_interest_rate_bps,
            reserve_factor_rate_bps      : v6.reserve_factor_rate_bps,
            loan_to_value_bps            : v6.loan_to_value_bps,
            liquidation_penalty_bps      : v6.liquidation_penalty_bps,
            borrow_rate_at_optimal_bps   : v6.borrow_rate_at_optimal_bps,
            borrow_factor_bps            : v6.borrow_factor_bps,
            borrow_fee_bps               : v6.borrow_fee_bps,
            deposit_limit                : v6.deposit_limit,
            borrow_limit                 : v6.borrow_limit,
            utilization_optimal_bps      : v6.utilization_optimal_bps,
            min_net_value_in_obligation  : arg16,
        };
        0x2::event::emit<InitReserveEvent>(v7);
        v5
    }

    public(friend) fun is_stale<T0, T1>(arg0: &Reserve<T0, T1>, arg1: u64) : bool {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::is_stale(&arg0.last_update, arg1)
    }

    public(friend) fun mark_stale<T0, T1>(arg0: &mut Reserve<T0, T1>) {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::mark_stale(&mut arg0.last_update);
    }

    public(friend) fun price_status<T0, T1>(arg0: &Reserve<T0, T1>) : u8 {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::price_status(&arg0.last_update)
    }

    public(friend) fun accrue_interest<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::elapsed_ms(&arg0.last_update, 0x2::clock::timestamp_ms(arg1));
        if (v0 > 0) {
            let v1 = current_borrow_rate<T0, T1>(arg0);
            let v2 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((arg0.config.reserve_factor_rate_bps as u64));
            compound_interest<T0, T1>(arg0, v1, v2, v0);
        };
    }

    public(friend) fun accumulated_protocol_fees<T0, T1>(arg0: &Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        arg0.liquidity.accumulated_protocol_fees
    }

    public(friend) fun add_fee_balance<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.liquidity.fee_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    public(friend) fun asset_tier<T0, T1>(arg0: &Reserve<T0, T1>) : u8 {
        arg0.config.asset_tier
    }

    public(friend) fun asset_tier_isolated_collateral() : u8 {
        1
    }

    public(friend) fun asset_tier_isolated_debt() : u8 {
        2
    }

    public(friend) fun asset_tier_regular() : u8 {
        0
    }

    public(friend) fun available_amount<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        arg0.liquidity.available_amount
    }

    public(friend) fun borrow_factor_bps<T0, T1>(arg0: &Reserve<T0, T1>) : u16 {
        arg0.config.borrow_factor_bps
    }

    public(friend) fun borrow_fee(arg0: &ReserveConfig) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((arg0.borrow_fee_bps as u64))
    }

    public(friend) fun borrow_limit<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        arg0.config.borrow_limit
    }

    public(friend) fun borrow_limit_crossed_ts<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        arg0.liquidity.borrow_limit_crossed_ts
    }

    public(friend) fun borrow_liquidity<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) {
        let v0 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::floor(arg1);
        let v1 = arg0.liquidity.available_amount;
        assert!(v0 < v1, 1017);
        arg0.liquidity.available_amount = v1 - v0;
        arg0.liquidity.borrowed_amount = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(arg0.liquidity.borrowed_amount, arg1);
    }

    public(friend) fun borrowed_amount<T0, T1>(arg0: &Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        arg0.liquidity.borrowed_amount
    }

    public(friend) fun burn_ctokens<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64) {
        let v0 = &mut arg0.collateral;
        v0.mint_total_amount = v0.mint_total_amount - arg1;
        0x2::balance::decrease_supply<CToken<T0, T1>>(&mut arg0.collateral.ctoken_mint_total_supply, 0x2::balance::split<CToken<T0, T1>>(&mut arg0.collateral.ctoken_mint_total_balance, arg1));
    }

    public(friend) fun burn_ctokens_and_redeem_liquidity<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 > 0, 1010);
        assert!(!is_stale<T0, T1>(arg0, v0), 1011);
        let v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::collateral_exchange::collateral_to_liquidity(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg1), collateral_exchange_rate<T0, T1>(arg0));
        burn_ctokens<T0, T1>(arg0, arg1);
        let v2 = withdraw<T0, T1>(arg0, v1);
        update_deposit_limit_crossed_timestamp<T0, T1>(arg0, v0);
        update_borrow_limit_crossed_timestamp<T0, T1>(arg0, v0);
        mark_stale<T0, T1>(arg0);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::add_to_withdrawal_accum(&mut arg0.config.deposit_withdrawal_cap, v1, v0);
        (0x2::coin::from_balance<T1>(v2, arg3), v1)
    }

    public(friend) fun calculate_borrow<T0, T1>(arg0: &Reserve<T0, T1>, arg1: u64, arg2: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) : (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, u64, u64) {
        let v0 = calculate_borrow_fee<T0, T1>(arg0, arg1);
        let v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg1);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::lt(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(v1, market_price<T0, T1>(arg0)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::power(10, (mint_decimal<T0, T1>(arg0) as u64)))), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((borrow_factor_bps<T0, T1>(arg0) as u64))), arg2), 1015);
        (v1, arg1 - v0, v0)
    }

    public fun calculate_borrow_fee<T0, T1>(arg0: &Reserve<T0, T1>, arg1: u64) : u64 {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::ceil(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg1), borrow_fee(&arg0.config)))
    }

    public(friend) fun calculate_repay<T0, T1>(arg0: &Reserve<T0, T1>, arg1: u64, arg2: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) : (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, u64) {
        let v0 = if (arg1 == 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::max_of_u64()) {
            arg2
        } else {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::min(arg2, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg1))
        };
        (v0, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::ceil(v0))
    }

    public(friend) fun check_borrow_liquidity<T0, T1>(arg0: &Reserve<T0, T1>, arg1: u64) {
        assert!(!0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::saturating_sub(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg0.config.borrow_limit), arg0.liquidity.borrowed_amount), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)), 1016);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::le(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(arg0.liquidity.borrowed_amount, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg1)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg0.config.borrow_limit)), 1015);
    }

    public(friend) fun check_reserve_status_and_stale<T0, T1>(arg0: &Reserve<T0, T1>, arg1: u64) {
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T1>() == arg0.liquidity.mint_token_type, 1014);
        assert!(arg0.config.status == 0, 1013);
        assert!(is_stale<T0, T1>(arg0, arg1) == false, 1012);
    }

    public(friend) fun collateral_exchange_rate<T0, T1>(arg0: &Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        exchange_rate<T0, T1>(arg0, total_supply<T0, T1>(arg0))
    }

    public(friend) fun compound_interest<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg2: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg3: u64) {
        let v0 = borrowed_amount<T0, T1>(arg0);
        let v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::approximate_compounded_interest(arg1, arg3);
        let v2 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(v0, v1);
        let v3 = &mut arg0.liquidity;
        v3.cumulative_borrow_rate = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(cumulative_borrow_rate<T0, T1>(arg0), v1);
        v3.accumulated_protocol_fees = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(accumulated_protocol_fees<T0, T1>(arg0), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(v2, v0), arg2));
        v3.borrowed_amount = v2;
    }

    public(friend) fun contain<T0: copy + drop + store, T1: store, T2, T3>(arg0: &Reserve<T2, T3>, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun cumulative_borrow_rate<T0, T1>(arg0: &Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        arg0.liquidity.cumulative_borrow_rate
    }

    public(friend) fun current_borrow_rate<T0, T1>(arg0: &Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        let v0 = arg0.config.base_fixed_interest_rate_bps;
        let v1 = arg0.config.utilization_optimal_bps;
        let v2 = arg0.config.borrow_rate_at_optimal_bps;
        let v3 = utilization_rate<T0, T1>(arg0);
        if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(v3, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v1 as u64)))) {
            return 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v2 as u64))
        };
        if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::lt(v3, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v1 as u64)))) {
            return 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v0 as u64)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v2 as u64)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v0 as u64))), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v1 as u64)))), v3)
        };
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v0 as u64)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v2 as u64)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v0 as u64))), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v1 as u64))), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v1 as u64)))), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((arg0.config.max_interest_rate_bps as u64)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v2 as u64))), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((arg0.config.utilization_limit_block_borrowing_above_bps as u64)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v1 as u64)))), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(v3, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v1 as u64)))))
    }

    public(friend) fun current_supply_rate<T0, T1>(arg0: &Reserve<T0, T1>, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(utilization_rate<T0, T1>(arg0), arg1), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(1), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((arg0.config.utilization_limit_block_borrowing_above_bps as u64))))
    }

    public(friend) fun deposit_ctokens<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x2::balance::Balance<CToken<T0, T1>>) {
        0x2::balance::join<CToken<T0, T1>>(&mut arg0.collateral.ctoken_mint_total_balance, arg1);
    }

    public(friend) fun deposit_limit<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        arg0.config.deposit_limit
    }

    public(friend) fun deposit_limit_crossed_ts<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        arg0.liquidity.deposit_limit_crossed_ts
    }

    public(friend) fun deposit_reserve_liquidity_and_mint_ctokens<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CToken<T0, T1>> {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T1>() == arg0.liquidity.mint_token_type, 1001);
        assert!(arg0.config.status == 0, 1002);
        assert!(is_stale<T0, T1>(arg0, v0) == false, 1003);
        let v1 = 0x2::coin::into_balance<T1>(arg1);
        let v2 = 0x2::balance::value<T1>(&v1);
        assert!(v2 > 0, 1004);
        let v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v2);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::lt(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(total_supply<T0, T1>(arg0), v3), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg0.config.deposit_limit)), 1005);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::sub_from_withdrawal_accum(&mut arg0.config.deposit_withdrawal_cap, v2, v0);
        let v4 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::collateral_exchange::liquidity_to_collateral(v3, collateral_exchange_rate<T0, T1>(arg0));
        let v5 = &mut arg0.liquidity;
        v5.available_amount = v5.available_amount + v2;
        let v6 = v5.available_amount;
        let v7 = &mut arg0.collateral;
        v7.mint_total_amount = v7.mint_total_amount + v4;
        post_transfer_vault_balance_liquidity_reserve_checks(0x2::balance::join<T1>(&mut arg0.liquidity.supply_balance, v1), v6, 0x2::balance::value<T1>(&arg0.liquidity.supply_balance), v5.available_amount, 0, v2);
        0x2::coin::from_balance<CToken<T0, T1>>(0x2::balance::increase_supply<CToken<T0, T1>>(&mut arg0.collateral.ctoken_mint_total_supply, v4), arg3)
    }

    public(friend) fun exchange_rate<T0, T1>(arg0: &Reserve<T0, T1>, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        let v0 = &arg0.collateral;
        if (v0.mint_total_amount == 0 || 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(arg1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0))) {
            return 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::one()
        };
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v0.mint_total_amount), arg1)
    }

    public(friend) fun get_coin_borrow_liquidity<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 1010);
        assert!(!is_stale<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg4)), 1011);
        let v0 = arg2 + arg3;
        let v1 = 0x2::balance::split<T1>(&mut arg0.liquidity.supply_balance, v0);
        0x2::balance::join<T1>(&mut arg0.liquidity.fee_balance, 0x2::balance::split<T1>(&mut v1, arg3));
        post_transfer_vault_balance_liquidity_reserve_checks(0x2::balance::value<T1>(&arg0.liquidity.supply_balance), arg0.liquidity.available_amount, 0x2::balance::value<T1>(&arg0.liquidity.supply_balance), arg1, 1, v0);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public(friend) fun is_obsolete_status<T0, T1>(arg0: &Reserve<T0, T1>) : bool {
        arg0.config.status == 1
    }

    public(friend) fun liquidation_max_debt_close_factor_bps<T0, T1>(arg0: &Reserve<T0, T1>) : u16 {
        arg0.config.liquidation_max_debt_close_factor_bps
    }

    public(friend) fun liquidation_penalty_bps<T0, T1>(arg0: &Reserve<T0, T1>) : u16 {
        arg0.config.liquidation_penalty_bps
    }

    public(friend) fun liquidation_threshold_bps<T0, T1>(arg0: &Reserve<T0, T1>) : u16 {
        arg0.config.liquidation_threshold_bps
    }

    public(friend) fun loan_to_value_bps<T0, T1>(arg0: &Reserve<T0, T1>) : u16 {
        arg0.config.loan_to_value_bps
    }

    public(friend) fun market_price<T0, T1>(arg0: &Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        arg0.liquidity.market_price
    }

    public(friend) fun min_net_value_in_obligation<T0, T1>(arg0: &Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        arg0.config.min_net_value_in_obligation
    }

    public(friend) fun mint_decimal<T0, T1>(arg0: &Reserve<T0, T1>) : u8 {
        arg0.liquidity.mint_decimal
    }

    public(friend) fun mint_token_type<T0, T1>(arg0: &Reserve<T0, T1>) : 0x1::string::String {
        arg0.liquidity.mint_token_type
    }

    public(friend) fun mint_total_amount<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        arg0.collateral.mint_total_amount
    }

    public(friend) fun mut_debt_withdrawal_cap<T0, T1>(arg0: &mut Reserve<T0, T1>) : &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::WithdrawalCap {
        &mut arg0.config.debt_withdrawal_cap
    }

    public fun post_transfer_vault_balance_liquidity_reserve_checks(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64) {
        assert!(arg2 - arg3 == arg0 - arg1, 1006);
        if (arg4 == 0) {
            assert!(arg2 + arg5 == arg0, 1007);
            assert!(arg3 + arg5 == arg1, 1008);
            return
        };
        if (arg4 == 1) {
            assert!(arg2 - arg5 == arg0, 1007);
            assert!(arg3 - arg5 == arg1, 1008);
            return
        };
        if (arg4 == 2) {
            let v0 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::new(arg5, false);
            let v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::new(arg2, false);
            let v2 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::new(arg3, false);
            let v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::checked_sub(&v1, &v0);
            let v4 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::checked_sub(&v2, &v0);
            assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::get_magnitude_if_positive(&v3) == arg0, 1007);
            assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64::get_magnitude_if_positive(&v4) == arg1, 1008);
            return
        };
    }

    public(friend) fun refresh_reserve<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        accrue_interest<T0, T1>(arg0, arg2);
        let (v1, v2, v3) = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::price_feed::get_validated_price(arg1, &arg0.config.token_info, arg2);
        let v4 = &mut arg0.liquidity;
        v4.market_price = v1;
        v4.market_price_last_updated_ts = v2;
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::update(&mut arg0.last_update, v0, v3);
        update_deposit_limit_crossed_timestamp<T0, T1>(arg0, v0);
        update_borrow_limit_crossed_timestamp<T0, T1>(arg0, v0);
        let v5 = current_borrow_rate<T0, T1>(arg0);
        let v6 = RefreshReserveEvent{
            reserve               : 0x2::object::id<Reserve<T0, T1>>(arg0),
            total_supply_sf       : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(total_supply<T0, T1>(arg0)),
            total_borrow_sf       : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(borrowed_amount<T0, T1>(arg0)),
            total_mint_collateral : arg0.collateral.mint_total_amount,
            borrow_rate_sf        : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(v5),
            supply_rate_sf        : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(current_supply_rate<T0, T1>(arg0, v5)),
        };
        0x2::event::emit<RefreshReserveEvent>(v6);
    }

    public(friend) fun repay_coin_liquidate<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) {
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T1>() == arg0.liquidity.mint_token_type, 1019);
        assert!(arg0.config.status == 0, 1020);
        assert!(is_stale<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg2)) == false, 1021);
        assert!(0x2::coin::value<T1>(&arg1) > 0, 1022);
        0x2::balance::join<T1>(&mut arg0.liquidity.supply_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    public(friend) fun repay_coin_liquidity<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T1>() == arg0.liquidity.mint_token_type, 1019);
        assert!(arg0.config.status == 0, 1020);
        assert!(is_stale<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3)) == false, 1021);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 1022);
        0x2::balance::join<T1>(&mut arg0.liquidity.supply_balance, 0x2::coin::into_balance<T1>(arg1));
        post_transfer_vault_balance_liquidity_reserve_checks(0x2::balance::value<T1>(&arg0.liquidity.supply_balance), available_amount<T0, T1>(arg0), 0x2::balance::value<T1>(&arg0.liquidity.supply_balance), arg2, 0, v0);
    }

    public(friend) fun repay_liquidity<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64, arg2: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) {
        arg0.liquidity.available_amount = available_amount<T0, T1>(arg0) + arg1;
        let v0 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::min(arg2, borrowed_amount<T0, T1>(arg0));
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(borrowed_amount<T0, T1>(arg0), v0) || 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(borrowed_amount<T0, T1>(arg0), v0), 1018);
        arg0.liquidity.borrowed_amount = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(borrowed_amount<T0, T1>(arg0), v0);
    }

    public(friend) fun share_object<T0, T1>(arg0: Reserve<T0, T1>) {
        0x2::transfer::public_share_object<Reserve<T0, T1>>(arg0);
    }

    public(friend) fun status<T0, T1>(arg0: &Reserve<T0, T1>) : u8 {
        arg0.config.status
    }

    public(friend) fun supply_balance<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.liquidity.supply_balance)
    }

    public(friend) fun total_reserve_mint_collateral<T0, T1>(arg0: &Reserve<T0, T1>) : u64 {
        arg0.collateral.mint_total_amount
    }

    public(friend) fun total_supply<T0, T1>(arg0: &Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        let v0 = &arg0.liquidity;
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v0.available_amount), v0.borrowed_amount), v0.accumulated_protocol_fees)
    }

    public(friend) fun update_borrow_limit_crossed_timestamp<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64) {
        let v0 = &mut arg0.liquidity;
        if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(borrowed_amount<T0, T1>(arg0), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(borrow_limit<T0, T1>(arg0)))) {
            if (borrow_limit_crossed_ts<T0, T1>(arg0) == 0) {
                v0.borrow_limit_crossed_ts = arg1;
            };
        } else {
            v0.borrow_limit_crossed_ts = 0;
        };
    }

    public(friend) fun update_deposit_limit_crossed_timestamp<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64) {
        let v0 = &mut arg0.liquidity;
        if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(total_supply<T0, T1>(arg0), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(deposit_limit<T0, T1>(arg0)))) {
            if (deposit_limit_crossed_ts<T0, T1>(arg0) == 0) {
                v0.deposit_limit_crossed_ts = arg1;
            };
        } else {
            v0.deposit_limit_crossed_ts = 0;
        };
    }

    public(friend) fun update_reserve_config<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: 0x1::option::Option<u16>, arg2: 0x1::option::Option<u16>, arg3: 0x1::option::Option<u16>, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<u16>, arg6: 0x1::option::Option<u16>, arg7: 0x1::option::Option<u16>, arg8: 0x1::option::Option<u16>, arg9: 0x1::option::Option<u16>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<u64>, arg14: 0x1::option::Option<u64>, arg15: 0x1::option::Option<u16>, arg16: 0x1::option::Option<u16>, arg17: 0x1::option::Option<u128>, arg18: 0x1::option::Option<u16>, arg19: 0x1::option::Option<u64>, arg20: 0x1::option::Option<u64>, arg21: 0x1::option::Option<u64>, arg22: 0x1::option::Option<u64>, arg23: 0x1::option::Option<u64>, arg24: 0x1::option::Option<u64>, arg25: 0x1::option::Option<0x1::string::String>, arg26: 0x1::option::Option<0x1::string::String>) {
        let v0 = &mut arg0.config;
        let v1 = &mut v0.deposit_withdrawal_cap;
        let v2 = &mut v0.debt_withdrawal_cap;
        let v3 = &mut v0.token_info;
        if (0x1::option::is_some<u16>(&arg1)) {
            v0.base_fixed_interest_rate_bps = 0x1::option::destroy_some<u16>(arg1);
        };
        if (0x1::option::is_some<u16>(&arg2)) {
            v0.reserve_factor_rate_bps = 0x1::option::destroy_some<u16>(arg2);
        };
        if (0x1::option::is_some<u16>(&arg3)) {
            v0.max_interest_rate_bps = 0x1::option::destroy_some<u16>(arg3);
        };
        if (0x1::option::is_some<u16>(&arg4)) {
            v0.loan_to_value_bps = 0x1::option::destroy_some<u16>(arg4);
        };
        if (0x1::option::is_some<u16>(&arg5)) {
            v0.liquidation_threshold_bps = 0x1::option::destroy_some<u16>(arg5);
        };
        if (0x1::option::is_some<u16>(&arg6)) {
            v0.liquidation_penalty_bps = 0x1::option::destroy_some<u16>(arg6);
        };
        if (0x1::option::is_some<u16>(&arg7)) {
            v0.borrow_rate_at_optimal_bps = 0x1::option::destroy_some<u16>(arg7);
        };
        if (0x1::option::is_some<u16>(&arg8)) {
            v0.borrow_factor_bps = 0x1::option::destroy_some<u16>(arg8);
        };
        if (0x1::option::is_some<u16>(&arg9)) {
            v0.borrow_fee_bps = 0x1::option::destroy_some<u16>(arg9);
        };
        if (0x1::option::is_some<u64>(&arg10)) {
            v0.deposit_limit = 0x1::option::destroy_some<u64>(arg10);
        };
        if (0x1::option::is_some<u64>(&arg11)) {
            v0.borrow_limit = 0x1::option::destroy_some<u64>(arg11);
        };
        if (0x1::option::is_some<u64>(&arg12)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::update_config_capcity(v1, 0x1::option::destroy_some<u64>(arg12));
        };
        if (0x1::option::is_some<u64>(&arg13)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::update_config_capcity(v2, 0x1::option::destroy_some<u64>(arg13));
        };
        if (0x1::option::is_some<u64>(&arg14)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::update_config_interval_length_seconds(v1, 0x1::option::destroy_some<u64>(arg14));
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::update_config_interval_length_seconds(v2, 0x1::option::destroy_some<u64>(arg14));
        };
        if (0x1::option::is_some<u16>(&arg15)) {
            v0.utilization_optimal_bps = 0x1::option::destroy_some<u16>(arg15);
        };
        if (0x1::option::is_some<u16>(&arg16)) {
            v0.utilization_limit_block_borrowing_above_bps = 0x1::option::destroy_some<u16>(arg16);
        };
        if (0x1::option::is_some<u128>(&arg17)) {
            v0.min_net_value_in_obligation = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_u128(0x1::option::destroy_some<u128>(arg17));
        };
        if (0x1::option::is_some<u16>(&arg18)) {
            v0.liquidation_max_debt_close_factor_bps = 0x1::option::destroy_some<u16>(arg18);
        };
        if (0x1::option::is_some<u64>(&arg20)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::update_upper_heuristic(v3, 0x1::option::destroy_some<u64>(arg20));
        };
        if (0x1::option::is_some<u64>(&arg19)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::update_lower_heuristic(v3, 0x1::option::destroy_some<u64>(arg19));
        };
        if (0x1::option::is_some<u64>(&arg21)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::update_exp_heuristic(v3, 0x1::option::destroy_some<u64>(arg21));
        };
        if (0x1::option::is_some<u64>(&arg22)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::update_max_twap_divergence_bps(v3, 0x1::option::destroy_some<u64>(arg22));
        };
        if (0x1::option::is_some<u64>(&arg23)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::update_max_age_price_seconds(v3, 0x1::option::destroy_some<u64>(arg23));
        };
        if (0x1::option::is_some<u64>(&arg24)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::update_max_age_twap_seconds(v3, 0x1::option::destroy_some<u64>(arg24));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg25)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::update_pyth_price_feed_id(v3, arg25);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg26)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::update_switchboard_price(v3, arg26);
        };
        let v4 = UpdateReserveEvent{
            reserve                      : 0x2::object::id<Reserve<T0, T1>>(arg0),
            market_type                  : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>(),
            asset_tier                   : v0.asset_tier,
            base_fixed_interest_rate_bps : v0.base_fixed_interest_rate_bps,
            reserve_factor_rate_bps      : v0.reserve_factor_rate_bps,
            loan_to_value_bps            : v0.loan_to_value_bps,
            liquidation_penalty_bps      : v0.liquidation_penalty_bps,
            borrow_rate_at_optimal_bps   : v0.borrow_rate_at_optimal_bps,
            borrow_factor_bps            : v0.borrow_factor_bps,
            borrow_fee_bps               : v0.borrow_fee_bps,
            deposit_limit                : v0.deposit_limit,
            borrow_limit                 : v0.borrow_limit,
            utilization_optimal_bps      : v0.utilization_optimal_bps,
            min_net_value_in_obligation  : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_u128(v0.min_net_value_in_obligation),
        };
        0x2::event::emit<UpdateReserveEvent>(v4);
    }

    public(friend) fun utilization_limit<T0, T1>(arg0: &Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((arg0.config.utilization_limit_block_borrowing_above_bps as u64))
    }

    public(friend) fun utilization_rate<T0, T1>(arg0: &Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        let v0 = total_supply<T0, T1>(arg0);
        if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(v0, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0))) {
            return 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)
        };
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(borrowed_amount<T0, T1>(arg0), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((arg0.config.utilization_limit_block_borrowing_above_bps as u64))), v0)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = &mut arg0.liquidity;
        assert!(arg1 <= v0.available_amount, 1010);
        v0.available_amount = v0.available_amount - arg1;
        0x2::balance::split<T1>(&mut v0.supply_balance, arg1)
    }

    public(friend) fun withdraw_protocol_fee<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = &mut arg0.liquidity.fee_balance;
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v0, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(arg1, 0x2::balance::value<T1>(v0))), arg2)
    }

    // decompiled from Move bytecode v6
}

