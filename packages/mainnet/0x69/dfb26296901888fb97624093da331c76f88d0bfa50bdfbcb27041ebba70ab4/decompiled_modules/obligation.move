module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation {
    struct ObligationOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation: address,
    }

    struct ObligationCollateralKey has copy, drop, store {
        reserve: address,
    }

    struct ObligationLiquidityKey has copy, drop, store {
        reserve: address,
    }

    struct ObligationCollateral has store, key {
        id: 0x2::object::UID,
        deposited_amount: u64,
        market_value: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
    }

    struct ObligationLiquidity has store, key {
        id: 0x2::object::UID,
        borrowed_amount: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        cumulative_borrow_rate: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        market_value: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        borrow_factor_adjusted_market_value: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
    }

    struct Obligation<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        deposits: vector<address>,
        borrows: vector<address>,
        lowest_reserve_deposit_liquidation_ltv: u64,
        total_deposited_value: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        borrow_factor_adjusted_debt_value: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        borrowed_assets_market_value: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        highest_borrow_factor_bps: u16,
        allowed_borrow_value: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        unhealthy_borrow_value: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        deposits_token_type: 0x2::table::Table<address, 0x1::string::String>,
        borrows_token_type: 0x2::table::Table<address, 0x1::string::String>,
        deposits_tier: 0x2::table::Table<address, u8>,
        borrows_tier: 0x2::table::Table<address, u8>,
        num_of_obsolete_reserves: u8,
        has_debt: bool,
        last_update: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::LastUpdate,
        locking: bool,
        liquidating_asset_reserve: u8,
    }

    struct InitObligationEvent has copy, drop {
        obligation_owner: address,
        market_type: 0x1::string::String,
    }

    public(friend) fun borrow<T0: copy + drop + store, T1: store + key, T2>(arg0: &Obligation<T2>, arg1: T0) : &T1 {
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut<T0: copy + drop + store, T1: store + key, T2>(arg0: &mut Obligation<T2>, arg1: T0) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun remove<T0: copy + drop + store, T1: store + key, T2>(arg0: &mut Obligation<T2>, arg1: T0) : T1 {
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun add<T0: copy + drop + store, T1: store + key, T2>(arg0: &mut Obligation<T2>, arg1: T0, arg2: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun id<T0>(arg0: &Obligation<T0>) : 0x2::object::ID {
        0x2::object::id<Obligation<T0>>(arg0)
    }

    public(friend) fun new<T0>(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (Obligation<T0>, ObligationOwnerCap<T0>) {
        let v0 = Obligation<T0>{
            id                                     : 0x2::object::new(arg2),
            owner                                  : arg0,
            deposits                               : 0x1::vector::empty<address>(),
            borrows                                : 0x1::vector::empty<address>(),
            lowest_reserve_deposit_liquidation_ltv : 0,
            total_deposited_value                  : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            borrow_factor_adjusted_debt_value      : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            borrowed_assets_market_value           : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            highest_borrow_factor_bps              : 0,
            allowed_borrow_value                   : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            unhealthy_borrow_value                 : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            deposits_token_type                    : 0x2::table::new<address, 0x1::string::String>(arg2),
            borrows_token_type                     : 0x2::table::new<address, 0x1::string::String>(arg2),
            deposits_tier                          : 0x2::table::new<address, u8>(arg2),
            borrows_tier                           : 0x2::table::new<address, u8>(arg2),
            num_of_obsolete_reserves               : 0,
            has_debt                               : false,
            last_update                            : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::new(0x2::clock::timestamp_ms(arg1)),
            locking                                : false,
            liquidating_asset_reserve              : 0,
        };
        let v1 = 0x2::object::id<Obligation<T0>>(&v0);
        let v2 = InitObligationEvent{
            obligation_owner : arg0,
            market_type      : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>(),
        };
        0x2::event::emit<InitObligationEvent>(v2);
        (v0, new_obligation_owner_cap<T0>(0x2::object::id_to_address(&v1), arg2))
    }

    public(friend) fun is_stale<T0>(arg0: &Obligation<T0>, arg1: u64) : bool {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::is_stale(&arg0.last_update, arg1)
    }

    public(friend) fun mark_stale<T0>(arg0: &mut Obligation<T0>) {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::mark_stale(&mut arg0.last_update);
    }

    public(friend) fun price_status<T0>(arg0: &Obligation<T0>) : u8 {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::price_status(&arg0.last_update)
    }

    public(friend) fun accrue_interest(arg0: &mut ObligationLiquidity, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) {
        let v0 = arg0.cumulative_borrow_rate;
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(arg1, v0) || 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(arg1, v0), 2002);
        arg0.borrowed_amount = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(arg0.borrowed_amount, arg1), v0);
        arg0.cumulative_borrow_rate = arg1;
    }

    public(friend) fun borrow_request<T0, T1>(arg0: &mut Obligation<T0>, arg1: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::check_reserve_status_and_stale<T0, T1>(arg1, v0);
        assert!(arg2 > 0, 2023);
        assert!(!is_stale<T0>(arg0, v0), 2024);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.deposits_token_type, 0x2::object::id_to_address(&v1)), 2025);
        let v2 = remaining_borrow_value<T0>(arg0);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(v2, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)), 2026);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::check_borrow_liquidity<T0, T1>(arg1, arg2);
        let (v3, v4, v5) = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::calculate_borrow<T0, T1>(arg1, arg2, v2);
        assert!(v4 > 0, 2027);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::add_to_withdrawal_accum(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mut_debt_withdrawal_cap<T0, T1>(arg1), arg2, v0);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::borrow_liquidity<T0, T1>(arg1, v3);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mark_stale<T0, T1>(arg1);
        let v6 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::market_price<T0, T1>(arg1), v3), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from((0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::power(10, (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mint_decimal<T0, T1>(arg1) as u64)) as u64)));
        let v7 = find_or_add_liquidity_to_borrows<T0, T1>(arg0, arg1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::cumulative_borrow_rate<T0, T1>(arg1), v6, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(v6, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::borrow_factor_bps<T0, T1>(arg1) as u64))), arg4);
        v7.borrowed_amount = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v7.borrowed_amount, v3);
        arg0.has_debt = true;
        mark_stale<T0>(arg0);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::lt(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::utilization_rate<T0, T1>(arg1), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::utilization_limit<T0, T1>(arg1)), 2028);
        validate_obligation_asset_tiers<T0>(arg0);
        (v4, v5, v7.borrowed_amount)
    }

    public(friend) fun borrowed_amount<T0>(arg0: &Obligation<T0>, arg1: address) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        let v0 = ObligationLiquidityKey{reserve: arg1};
        borrow<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v0).borrowed_amount
    }

    public(friend) fun calculate_borrow_liquidity<T0, T1>(arg0: &Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        let v0 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v1 = ObligationLiquidityKey{reserve: 0x2::object::id_to_address(&v0)};
        if (contain<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v1)) {
            borrow<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v1).borrowed_amount
        } else {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)
        }
    }

    public(friend) fun calculate_deposit_liquidity<T0, T1>(arg0: &Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        let v0 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v1 = ObligationCollateralKey{reserve: 0x2::object::id_to_address(&v0)};
        if (contain<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v1)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::collateral_exchange::collateral_to_liquidity_decimal(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(borrow<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v1).deposited_amount), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::collateral_exchange_rate<T0, T1>(arg1))
        } else {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)
        }
    }

    public(friend) fun calculate_liquidate<T0, T1>(arg0: &mut Obligation<T0>, arg1: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = *0x1::vector::borrow<address>(&arg0.deposits, ((arg0.liquidating_asset_reserve - 1) as u64));
        let v1 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        assert!(v0 == 0x2::object::id_to_address(&v1), 2030);
        let v2 = ObligationCollateralKey{reserve: v0};
        let v3 = borrow_mut<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v2);
        let v4 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::collateral_exchange_rate<T0, T1>(arg1);
        let v5 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::collateral_exchange::collateral_to_liquidity_decimal(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v3.deposited_amount), v4), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::liquidation_max_debt_close_factor_bps<T0, T1>(arg1) as u64)));
        let v6 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v5, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(v5, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::liquidation_penalty_bps<T0, T1>(arg1) as u64))));
        let v7 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::collateral_exchange::liquidity_to_collateral(v6, v4);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::burn_ctokens<T0, T1>(arg1, v7);
        v3.deposited_amount = v3.deposited_amount - v7;
        refresh_liquidating_position<T0>(arg0);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mark_stale<T0, T1>(arg1);
        0x2::coin::from_balance<T1>(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::withdraw<T0, T1>(arg1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::floor(v6)), arg2)
    }

    public(friend) fun calculate_market_value_from_liquidity_amount<T0, T1>(arg0: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(arg1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::market_price<T0, T1>(arg0)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::power(10, (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mint_decimal<T0, T1>(arg0) as u64))))
    }

    public(friend) fun calculate_obligation_collateral_market_value<T0, T1>(arg0: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg1: &ObligationCollateral) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        calculate_market_value_from_liquidity_amount<T0, T1>(arg0, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::collateral_exchange::collateral_to_liquidity_decimal(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg1.deposited_amount), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::collateral_exchange_rate<T0, T1>(arg0)))
    }

    public(friend) fun check_obligation_with_obligation_owner_cap<T0>(arg0: &Obligation<T0>, arg1: &ObligationOwnerCap<T0>) {
        let v0 = 0x2::object::id<Obligation<T0>>(arg0);
        assert!(0x2::object::id_to_address(&v0) == arg1.obligation, 2037);
    }

    public(friend) fun contain<T0: copy + drop + store, T1: store + key, T2>(arg0: &Obligation<T2>, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun deposit_ctokens_into_obligation<T0, T1>(arg0: &mut Obligation<T0>, arg1: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: 0x2::coin::Coin<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::CToken<T0, T1>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.borrows_token_type, 0x2::object::id_to_address(&v1)), 2003);
        let v2 = 0x2::coin::into_balance<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::CToken<T0, T1>>(arg2);
        let v3 = 0x2::balance::value<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::CToken<T0, T1>>(&v2);
        assert!(v3 > 0, 2004);
        assert!(!0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::is_stale<T0, T1>(arg1, v0), 2005);
        assert!(!is_stale<T0>(arg0, v0), 2006);
        let v4 = find_or_add_collateral_to_deposits<T0, T1>(arg0, arg1, arg4);
        v4.deposited_amount = v4.deposited_amount + v3;
        let v5 = v4.market_value;
        let v6 = v4.deposited_amount;
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::deposit_ctokens<T0, T1>(arg1, v2);
        mark_stale<T0>(arg0);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mark_stale<T0, T1>(arg1);
        validate_obligation_asset_tiers<T0>(arg0);
        let v7 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::collateral_exchange::collateral_to_liquidity_decimal(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v3), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::collateral_exchange_rate<T0, T1>(arg1));
        post_deposit_obligation_invariants<T0, T1>(arg0, arg1, v5, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::min_net_value_in_obligation<T0, T1>(arg1), v7);
        (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::floor(v7), v3, v6)
    }

    public(friend) fun deposited_amount<T0>(arg0: &Obligation<T0>, arg1: address) : u64 {
        let v0 = ObligationCollateralKey{reserve: arg1};
        borrow<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v0).deposited_amount
    }

    public(friend) fun find_liquidity_in_borrows_mut<T0, T1>(arg0: &mut Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>) : &mut ObligationLiquidity {
        let v0 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v1 = ObligationLiquidityKey{reserve: 0x2::object::id_to_address(&v0)};
        assert!(contain<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v1), 2034);
        borrow_mut<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v1)
    }

    public(friend) fun find_or_add_collateral_to_deposits<T0, T1>(arg0: &mut Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : &mut ObligationCollateral {
        let v0 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = ObligationCollateralKey{reserve: v1};
        if (!contain<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v2)) {
            let v3 = ObligationCollateral{
                id               : 0x2::object::new(arg2),
                deposited_amount : 0,
                market_value     : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            };
            add<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v2, v3);
            0x1::vector::push_back<address>(&mut arg0.deposits, v1);
            0x2::table::add<address, 0x1::string::String>(&mut arg0.deposits_token_type, v1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mint_token_type<T0, T1>(arg1));
            0x2::table::add<address, u8>(&mut arg0.deposits_tier, v1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier<T0, T1>(arg1));
        };
        borrow_mut<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v2)
    }

    public(friend) fun find_or_add_liquidity_to_borrows<T0, T1>(arg0: &mut Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg3: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg4: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg5: &mut 0x2::tx_context::TxContext) : &mut ObligationLiquidity {
        let v0 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = ObligationLiquidityKey{reserve: v1};
        if (!contain<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v2)) {
            let v3 = ObligationLiquidity{
                id                                  : 0x2::object::new(arg5),
                borrowed_amount                     : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
                cumulative_borrow_rate              : arg2,
                market_value                        : arg3,
                borrow_factor_adjusted_market_value : arg4,
            };
            add<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v2, v3);
            0x1::vector::push_back<address>(&mut arg0.borrows, v1);
            0x2::table::add<address, 0x1::string::String>(&mut arg0.borrows_token_type, v1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mint_token_type<T0, T1>(arg1));
            0x2::table::add<address, u8>(&mut arg0.borrows_tier, v1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier<T0, T1>(arg1));
        };
        borrow_mut<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v2)
    }

    public(friend) fun has_debt<T0>(arg0: &Obligation<T0>) : bool {
        arg0.has_debt
    }

    public(friend) fun loan_to_value<T0>(arg0: &Obligation<T0>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(arg0.borrow_factor_adjusted_debt_value, arg0.total_deposited_value)
    }

    public(friend) fun lock_to_liquidate<T0>(arg0: &mut Obligation<T0>) {
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(loan_to_value<T0>(arg0), unhealthy_loan_to_value<T0>(arg0)), 2029);
        arg0.locking = true;
        refresh_liquidating_position<T0>(arg0);
    }

    public(friend) fun max_withdraw_value(arg0: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg2: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg3: u64, arg4: u64) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::lt(arg1, arg2) || 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(arg1, arg2)) {
            return 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)
        };
        if (arg4 == 0) {
            return arg0
        };
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(arg1, arg2), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps(arg4))
    }

    public(friend) fun new_obligation_owner_cap<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : ObligationOwnerCap<T0> {
        ObligationOwnerCap<T0>{
            id         : 0x2::object::new(arg1),
            obligation : arg0,
        }
    }

    public(friend) fun owner<T0>(arg0: &Obligation<T0>) : address {
        arg0.owner
    }

    public(friend) fun post_deposit_obligation_invariants<T0, T1>(arg0: &Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg3: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg4: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) {
        let v0 = calculate_market_value_from_liquidity_amount<T0, T1>(arg1, arg4);
        let v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(arg2, v0);
        let v2 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(arg0.borrow_factor_adjusted_debt_value, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(arg0.total_deposited_value, v0));
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(v1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)) && 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(v1, arg3), 2014);
        if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(arg0.total_deposited_value, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0))) {
            assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::lt(v2, loan_to_value<T0>(arg0)) || 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(v2, loan_to_value<T0>(arg0)), 2015);
        };
    }

    public(friend) fun refresh_liquidating_position<T0>(arg0: &mut Obligation<T0>) {
        if ((arg0.liquidating_asset_reserve as u64) < 0x1::vector::length<address>(&arg0.deposits)) {
            arg0.liquidating_asset_reserve = arg0.liquidating_asset_reserve + 1;
        } else {
            arg0.liquidating_asset_reserve = 0;
            arg0.locking = false;
        };
    }

    public(friend) fun refresh_obligation<T0, T1, T2, T3, T4>(arg0: &mut Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T2>, arg3: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T3>, arg4: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T4>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let (v1, v2, v3, v4, v5, v6) = refresh_obligation_deposits<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, v0);
        let (v7, v8, v9, v10) = refresh_obligation_borrows<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, v0);
        arg0.borrowed_assets_market_value = v8;
        arg0.total_deposited_value = v3;
        arg0.borrow_factor_adjusted_debt_value = v9;
        arg0.allowed_borrow_value = v4;
        arg0.unhealthy_borrow_value = v5;
        arg0.lowest_reserve_deposit_liquidation_ltv = (v1 as u64);
        arg0.highest_borrow_factor_bps = v7;
        arg0.num_of_obsolete_reserves = v2;
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::update(&mut arg0.last_update, v0, (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64((v6 as u64), (v10 as u64)) as u8));
    }

    public(friend) fun refresh_obligation_borrow<T0, T1>(arg0: &mut Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: u64) : (u16, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, u8) {
        assert!(!0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::is_stale<T0, T1>(arg1, arg2), 2001);
        let v0 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = ObligationLiquidityKey{reserve: v1};
        let v3 = borrow_mut<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v2);
        accrue_interest(v3, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::cumulative_borrow_rate<T0, T1>(arg1));
        let v4 = calculate_market_value_from_liquidity_amount<T0, T1>(arg1, v3.borrowed_amount);
        v3.market_value = v4;
        let v5 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::borrow_factor_bps<T0, T1>(arg1);
        let v6 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(v4, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v5 as u64)));
        v3.borrow_factor_adjusted_market_value = v6;
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.borrows_token_type, v1)) {
            let v7 = 0x2::table::borrow_mut<address, 0x1::string::String>(&mut arg0.borrows_token_type, v1);
            if (*v7 != 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mint_token_type<T0, T1>(arg1)) {
                *v7 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mint_token_type<T0, T1>(arg1);
            };
        } else {
            0x2::table::add<address, 0x1::string::String>(&mut arg0.borrows_token_type, v1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mint_token_type<T0, T1>(arg1));
        };
        if (0x2::table::contains<address, u8>(&arg0.borrows_tier, v1)) {
            let v8 = 0x2::table::borrow_mut<address, u8>(&mut arg0.borrows_tier, v1);
            if (*v8 != 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier<T0, T1>(arg1)) {
                *v8 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier<T0, T1>(arg1);
            };
        } else {
            0x2::table::add<address, u8>(&mut arg0.borrows_tier, v1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier<T0, T1>(arg1));
        };
        arg0.has_debt = true;
        (v5, v4, v6, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::price_status<T0, T1>(arg1))
    }

    public(friend) fun refresh_obligation_borrows<T0, T1, T2, T3, T4>(arg0: &mut Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T2>, arg3: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T3>, arg4: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T4>, arg5: u64) : (u16, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, u8) {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0);
        let v3 = v2;
        let v4 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0);
        let v5 = v4;
        let v6 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::all_checks();
        let v7 = v6;
        let v8 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v9 = 0x2::object::id_to_address(&v8);
        if (0x1::vector::contains<address>(&arg0.borrows, &v9)) {
            let (v10, v11, v12, v13) = refresh_obligation_borrow<T0, T1>(arg0, arg1, arg5);
            v1 = (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::max_u64((v0 as u64), (v10 as u64)) as u16);
            v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v2, v11);
            v5 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v4, v12);
            v7 = (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64((v6 as u64), (v13 as u64)) as u8);
        };
        let v14 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T2>>(arg2);
        let v15 = 0x2::object::id_to_address(&v14);
        if (0x1::vector::contains<address>(&arg0.borrows, &v15)) {
            let (v16, v17, v18, v19) = refresh_obligation_borrow<T0, T2>(arg0, arg2, arg5);
            let v20 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::max_u64((v1 as u64), (v16 as u64));
            v1 = (v20 as u16);
            v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v3, v17);
            v5 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v5, v18);
            let v21 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64((v7 as u64), (v19 as u64));
            v7 = (v21 as u8);
        };
        let v22 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T3>>(arg3);
        let v23 = 0x2::object::id_to_address(&v22);
        if (0x1::vector::contains<address>(&arg0.borrows, &v23)) {
            let (v24, v25, v26, v27) = refresh_obligation_borrow<T0, T3>(arg0, arg3, arg5);
            let v28 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::max_u64((v1 as u64), (v24 as u64));
            v1 = (v28 as u16);
            v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v3, v25);
            v5 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v5, v26);
            let v29 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64((v7 as u64), (v27 as u64));
            v7 = (v29 as u8);
        };
        let v30 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T4>>(arg4);
        let v31 = 0x2::object::id_to_address(&v30);
        if (0x1::vector::contains<address>(&arg0.borrows, &v31)) {
            let (v32, v33, v34, v35) = refresh_obligation_borrow<T0, T4>(arg0, arg4, arg5);
            let v36 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::max_u64((v1 as u64), (v32 as u64));
            v1 = (v36 as u16);
            v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v3, v33);
            v5 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v5, v34);
            let v37 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64((v7 as u64), (v35 as u64));
            v7 = (v37 as u8);
        };
        (v1, v3, v5, v7)
    }

    public(friend) fun refresh_obligation_deposit<T0, T1>(arg0: &mut Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: u64) : (u16, u8, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, u8) {
        let v0 = 0;
        let v1 = v0;
        assert!(!0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::is_stale<T0, T1>(arg1, arg2), 2001);
        if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::is_obsolete_status<T0, T1>(arg1)) {
            v1 = v0 + 1;
        };
        let v2 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v3 = 0x2::object::id_to_address(&v2);
        let v4 = ObligationCollateralKey{reserve: v3};
        let v5 = borrow_mut<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v4);
        let v6 = calculate_obligation_collateral_market_value<T0, T1>(arg1, v5);
        v5.market_value = v6;
        let v7 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::liquidation_threshold_bps<T0, T1>(arg1);
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.deposits_token_type, v3)) {
            let v8 = 0x2::table::borrow_mut<address, 0x1::string::String>(&mut arg0.deposits_token_type, v3);
            if (*v8 != 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mint_token_type<T0, T1>(arg1)) {
                *v8 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mint_token_type<T0, T1>(arg1);
            };
        } else {
            0x2::table::add<address, 0x1::string::String>(&mut arg0.deposits_token_type, v3, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mint_token_type<T0, T1>(arg1));
        };
        if (0x2::table::contains<address, u8>(&arg0.deposits_tier, v3)) {
            let v9 = 0x2::table::borrow_mut<address, u8>(&mut arg0.deposits_tier, v3);
            if (*v9 != 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier<T0, T1>(arg1)) {
                *v9 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier<T0, T1>(arg1);
            };
        } else {
            0x2::table::add<address, u8>(&mut arg0.deposits_tier, v3, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier<T0, T1>(arg1));
        };
        (v7, v1, v6, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(v6, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::loan_to_value_bps<T0, T1>(arg1) as u64))), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(v6, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((v7 as u64))), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::price_status<T0, T1>(arg1))
    }

    public(friend) fun refresh_obligation_deposits<T0, T1, T2, T3, T4>(arg0: &mut Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T2>, arg3: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T3>, arg4: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T4>, arg5: u64) : (u64, u8, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, u8) {
        let v0 = ((100 * 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::default_rate_factor_bps()) as u64);
        let v1 = v0;
        let v2 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0);
        let v3 = v2;
        let v4 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0);
        let v5 = v4;
        let v6 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0);
        let v7 = v6;
        let v8 = 0;
        let v9 = v8;
        let v10 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::all_checks();
        let v11 = v10;
        let v12 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v13 = 0x2::object::id_to_address(&v12);
        if (0x1::vector::contains<address>(&arg0.deposits, &v13)) {
            let (v14, v15, v16, v17, v18, v19) = refresh_obligation_deposit<T0, T1>(arg0, arg1, arg5);
            v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(v0, (v14 as u64));
            v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v2, v16);
            v5 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v4, v17);
            v7 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v6, v18);
            v9 = v8 + v15;
            v11 = (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64((v10 as u64), (v19 as u64)) as u8);
        };
        let v20 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T2>>(arg2);
        let v21 = 0x2::object::id_to_address(&v20);
        if (0x1::vector::contains<address>(&arg0.deposits, &v21)) {
            let (v22, v23, v24, v25, v26, v27) = refresh_obligation_deposit<T0, T2>(arg0, arg2, arg5);
            v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(v1, (v22 as u64));
            v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v3, v24);
            v5 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v5, v25);
            v7 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v7, v26);
            v9 = v9 + v23;
            let v28 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64((v11 as u64), (v27 as u64));
            v11 = (v28 as u8);
        };
        let v29 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T3>>(arg3);
        let v30 = 0x2::object::id_to_address(&v29);
        if (0x1::vector::contains<address>(&arg0.deposits, &v30)) {
            let (v31, v32, v33, v34, v35, v36) = refresh_obligation_deposit<T0, T3>(arg0, arg3, arg5);
            v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(v1, (v31 as u64));
            v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v3, v33);
            v5 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v5, v34);
            v7 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v7, v35);
            v9 = v9 + v32;
            let v37 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64((v11 as u64), (v36 as u64));
            v11 = (v37 as u8);
        };
        let v38 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T4>>(arg4);
        let v39 = 0x2::object::id_to_address(&v38);
        if (0x1::vector::contains<address>(&arg0.deposits, &v39)) {
            let (v40, v41, v42, v43, v44, v45) = refresh_obligation_deposit<T0, T4>(arg0, arg4, arg5);
            v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(v1, (v40 as u64));
            v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v3, v42);
            v5 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v5, v43);
            v7 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v7, v44);
            v9 = v9 + v41;
            let v46 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64((v11 as u64), (v45 as u64));
            v11 = (v46 as u8);
        };
        (v1, v9, v3, v5, v7, v11)
    }

    public(friend) fun remaining_borrow_value<T0>(arg0: &Obligation<T0>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::saturating_sub(arg0.allowed_borrow_value, arg0.borrow_factor_adjusted_debt_value)
    }

    public(friend) fun repay<T0>(arg0: &mut Obligation<T0>, arg1: address, arg2: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        let v0 = ObligationLiquidityKey{reserve: arg1};
        let v1 = remove<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v0);
        if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(v1.borrowed_amount, arg2)) {
            let (_, v4) = 0x1::vector::index_of<address>(&arg0.borrows, &arg1);
            0x1::vector::remove<address>(&mut arg0.borrows, v4);
            0x2::table::remove<address, 0x1::string::String>(&mut arg0.borrows_token_type, arg1);
            0x2::table::remove<address, u8>(&mut arg0.borrows_tier, arg1);
            let ObligationLiquidity {
                id                                  : v5,
                borrowed_amount                     : _,
                cumulative_borrow_rate              : _,
                market_value                        : _,
                borrow_factor_adjusted_market_value : _,
            } = v1;
            0x2::object::delete(v5);
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)
        } else {
            add<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v0, v1);
            let v10 = borrow_mut<ObligationLiquidityKey, ObligationLiquidity, T0>(arg0, v0);
            v10.borrowed_amount = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(v10.borrowed_amount, arg2);
            v10.cumulative_borrow_rate = v1.cumulative_borrow_rate;
            v10.market_value = v1.market_value;
            v10.borrowed_amount
        }
    }

    public(friend) fun repay_liquidate_reserve<T0, T1>(arg0: &mut Obligation<T0>, arg1: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::repay_coin_liquidate<T0, T1>(arg1, arg2, arg3);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::repay_liquidity<T0, T1>(arg1, v0, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v0));
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::add_fee_balance<T0, T1>(arg1, 0x2::coin::split<T1>(&mut arg2, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::floor(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0x2::coin::value<T1>(&arg2)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from_bps((0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::liquidation_penalty_bps<T0, T1>(arg1) as u64)))), arg4));
        let v1 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        repay<T0>(arg0, 0x2::object::id_to_address(&v1), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v0));
        mark_stale<T0>(arg0);
    }

    public(friend) fun repay_request<T0, T1>(arg0: &mut Obligation<T0>, arg1: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: &0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock) : (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, u64, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) {
        assert!(0x2::coin::value<T1>(arg2) > 0, 2031);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::check_reserve_status_and_stale<T0, T1>(arg1, v0);
        assert!(!is_stale<T0>(arg0, v0), 2032);
        let v1 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v2 = 0x2::object::id_to_address(&v1);
        assert!(0x2::table::contains<address, 0x1::string::String>(&arg0.borrows_token_type, v2), 2033);
        let v3 = find_liquidity_in_borrows_mut<T0, T1>(arg0, arg1);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(v3.borrowed_amount, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)), 2035);
        accrue_interest(v3, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::cumulative_borrow_rate<T0, T1>(arg1));
        let (v4, v5) = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::calculate_repay<T0, T1>(arg1, arg3, v3.borrowed_amount);
        assert!(v5 > 0, 2036);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::withdrawal_cap::add_to_withdrawal_accum(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mut_debt_withdrawal_cap<T0, T1>(arg1), v5, v0);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::repay_liquidity<T0, T1>(arg1, v5, v4);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::mark_stale<T0, T1>(arg1);
        let v6 = repay<T0>(arg0, v2, v4);
        update_has_debt<T0>(arg0);
        mark_stale<T0>(arg0);
        (v4, v5, v6)
    }

    public(friend) fun share_object<T0>(arg0: Obligation<T0>) {
        0x2::transfer::public_share_object<Obligation<T0>>(arg0);
    }

    public(friend) fun unhealthy_loan_to_value<T0>(arg0: &Obligation<T0>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(arg0.unhealthy_borrow_value, arg0.total_deposited_value)
    }

    public(friend) fun update_has_debt<T0>(arg0: &mut Obligation<T0>) {
        if (0x1::vector::is_empty<address>(&arg0.borrows)) {
            arg0.has_debt = false;
        } else {
            arg0.has_debt = true;
        };
    }

    public(friend) fun validate_obligation_asset_tiers<T0>(arg0: &Obligation<T0>) {
        let v0 = &arg0.deposits;
        let v1 = &arg0.deposits_tier;
        let v2 = &arg0.borrows;
        let v3 = &arg0.borrows_tier;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(v0)) {
            let v6 = *0x2::table::borrow<address, u8>(v1, *0x1::vector::borrow<address>(v0, v5));
            assert!(v6 != 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier_isolated_debt(), 2012);
            if (v6 == 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier_isolated_collateral()) {
                v4 = v4 + 1;
            };
            v5 = v5 + 1;
        };
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(v2)) {
            let v9 = *0x2::table::borrow<address, u8>(v3, *0x1::vector::borrow<address>(v2, v8));
            assert!(v9 != 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier_isolated_collateral(), 2013);
            if (v9 == 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::asset_tier_isolated_debt()) {
                v7 = v7 + 1;
            };
            v8 = v8 + 1;
        };
        assert!(v4 <= 1, 2007);
        assert!(v7 <= 1, 2008);
        let v10 = v4 > 0 && v7 > 0;
        assert!(!v10, 2009);
        let v11 = 0x2::table::length<address, u8>(v1) > 1 && v4 > 1;
        assert!(!v11, 2010);
        let v12 = 0x2::table::length<address, u8>(v3) > 1 && v7 > 1;
        assert!(!v12, 2011);
    }

    public(friend) fun withdraw_ctoken_from_obligation<T0, T1>(arg0: &mut Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2 > 0, 2016);
        let v1 = 0x1::vector::is_empty<address>(&arg0.borrows);
        let v2 = if (v1) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::none()
        } else {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::all_checks()
        };
        assert!(!0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::is_stale<T0, T1>(arg1, v0) && 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::price_status<T0, T1>(arg1) >= v2, 2005);
        assert!(!is_stale<T0>(arg0, v0) && price_status<T0>(arg0) >= v2, 2006);
        let v3 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v4 = 0x2::object::id_to_address(&v3);
        let v5 = ObligationCollateralKey{reserve: v4};
        let v6 = borrow<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v5);
        assert!(v6.deposited_amount >= 0, 2017);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(arg0.total_deposited_value, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)), 2017);
        let v7 = v6.deposited_amount;
        let v8 = v6.market_value;
        let v9 = if (v1) {
            if (arg2 == 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::max_of_u64()) {
                v7
            } else {
                0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(v7, arg2)
            }
        } else {
            let v10 = max_withdraw_value(v8, arg0.unhealthy_borrow_value, arg0.borrow_factor_adjusted_debt_value, (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::loan_to_value_bps<T0, T1>(arg1) as u64), (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::liquidation_threshold_bps<T0, T1>(arg1) as u64));
            assert!(!0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(v10, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)), 2018);
            if (arg2 == 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::max_of_u64()) {
                0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(arg2, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::floor(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::min(v8, v10), v8), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v7))))
            } else {
                let v11 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(v7, arg2);
                assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::le(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(v8, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v11), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v7))), v10), 2019);
                v11
            }
        };
        assert!(v9 > 0, 2020);
        let v12 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(v9, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::collateral_exchange::liquidity_to_collateral(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::available_amount<T0, T1>(arg1)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::collateral_exchange_rate<T0, T1>(arg1)));
        let (_, v14) = withdraw_obligation_collateral<T0>(arg0, v4, v12);
        mark_stale<T0>(arg0);
        (v12, v14)
    }

    public(friend) fun withdraw_obligation_collateral<T0>(arg0: &mut Obligation<T0>, arg1: address, arg2: u64) : (bool, u64) {
        let v0 = ObligationCollateralKey{reserve: arg1};
        let v1 = remove<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v0);
        if (arg2 == v1.deposited_amount) {
            let (_, v3) = 0x1::vector::index_of<address>(&arg0.deposits, &arg1);
            0x1::vector::remove<address>(&mut arg0.deposits, v3);
            0x2::table::remove<address, 0x1::string::String>(&mut arg0.deposits_token_type, arg1);
            0x2::table::remove<address, u8>(&mut arg0.deposits_tier, arg1);
            let ObligationCollateral {
                id               : v4,
                deposited_amount : _,
                market_value     : _,
            } = v1;
            0x2::object::delete(v4);
            return (true, 0)
        };
        add<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v0, v1);
        let v7 = borrow_mut<ObligationCollateralKey, ObligationCollateral, T0>(arg0, v0);
        v7.deposited_amount = v7.deposited_amount - arg2;
        (false, v7.deposited_amount)
    }

    // decompiled from Move bytecode v6
}

