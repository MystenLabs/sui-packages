module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market {
    struct ExpiryMarket has key {
        id: 0x2::object::UID,
        propbook_underlying_id: u32,
        expiry: u64,
        cash: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::ExpiryCash,
        fee_incentive_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        strike_exposure: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::StrikeExposure,
        ewma: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma::EwmaState,
        mint_paused: bool,
        valuation_stamp: 0x1::option::Option<ValuationStamp>,
    }

    struct ValuationStamp has drop, store {
        flush_seq: u64,
        snapshot_cash: u64,
        snapshot_impact_reserve: u64,
    }

    struct MintQuote has copy, drop {
        quantity: u64,
        entry_probability: u64,
        premium: u64,
        trading_fee: u64,
        fee_incentive_subsidy: u64,
        builder_fee: u64,
        penalty_fee: u64,
        inventory_impact_charge: u64,
        all_in_cost: u64,
    }

    public fun penalty_fee(arg0: &MintQuote) : u64 {
        arg0.penalty_fee
    }

    public fun inventory_impact_reserve(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::inventory_impact_reserve(&arg0.cash)
    }

    public fun required_cash(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::required_cash(&arg0.cash, payout_liability(arg0))
    }

    public fun admission_tick_size(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::admission_tick_size(&arg0.strike_exposure)
    }

    public fun all_in_cost(arg0: &MintQuote) : u64 {
        arg0.all_in_cost
    }

    fun assert_cash_backing(arg0: &ExpiryMarket) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::assert_backing(&arg0.cash, payout_liability(arg0));
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::inventory_impact_reserve(&arg0.cash) >= 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::inventory_impact_potential(&arg0.strike_exposure), 13906839865175048191);
    }

    fun assert_live_flow_allowed(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg3: &0x2::clock::Clock) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_snapshot_not_in_progress(arg1);
        assert_pricer_bound(arg0, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_trade_window_open(arg1, arg0.expiry, arg3);
    }

    fun assert_live_mint_allowed(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg3: &0x2::clock::Clock) {
        assert_live_flow_allowed(arg0, arg1, arg2, arg3);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_trading_allowed(arg1);
        assert!(!arg0.mint_paused, 0);
    }

    fun assert_pricer_bound(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer) {
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::expiry_market_id(arg1) == id(arg0), 4);
    }

    fun assert_settled_flow_allowed(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_snapshot_not_in_progress(arg1);
        assert!(is_settled(arg0), 1);
    }

    public fun backing_buffer_lambda(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::backing_buffer_lambda(&arg0.strike_exposure)
    }

    public fun builder_fee(arg0: &MintQuote) : u64 {
        arg0.builder_fee
    }

    fun builder_fee_amount(arg0: &0x1::option::Option<0x2::object::ID>, arg1: u64, arg2: u64) : u64 {
        if (0x1::option::is_some<0x2::object::ID>(arg0)) {
            0x1::u64::min(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg1, 100000000), 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg2, 5000000))
        } else {
            0
        }
    }

    public fun cash_balance(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::balance(&arg0.cash)
    }

    public(friend) fun clear_valuation_stamp(arg0: &mut ExpiryMarket) {
        arg0.valuation_stamp = 0x1::option::none<ValuationStamp>();
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::release_valuation_snapshot(&mut arg0.strike_exposure);
    }

    fun compute_mint_quote(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintTerms, arg2: &0x1::option::Option<0x2::object::ID>, arg3: u64, arg4: &0x2::clock::Clock) : MintQuote {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::quantity(arg1);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::trading_fee(&arg0.strike_exposure, arg0.expiry, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::mint_price(arg1), v0, arg4);
        let v2 = fee_incentive_subsidy_amount(arg0, v1);
        let v3 = builder_fee_amount(arg2, v1, v0);
        let v4 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::premium(arg1);
        let v5 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::inventory_impact_charge(arg1);
        let v6 = v4 + v1 - v2 + v3 + arg3 + v5;
        assert!(v6 <= v0, 11);
        MintQuote{
            quantity                : v0,
            entry_probability       : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::entry_probability(arg1),
            premium                 : v4,
            trading_fee             : v1,
            fee_incentive_subsidy   : v2,
            builder_fee             : v3,
            penalty_fee             : arg3,
            inventory_impact_charge : v5,
            all_in_cost             : v6,
        }
    }

    public(friend) fun create_and_share(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg1: u32, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = ExpiryMarket{
            id                     : v0,
            propbook_underlying_id : arg1,
            expiry                 : arg2,
            cash                   : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::new(),
            fee_incentive_balance  : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            strike_exposure        : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::new(v1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::strike_exposure_config_snapshot(arg0), arg3, arg4, arg5, arg6, arg7),
            ewma                   : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma::new(arg7),
            mint_paused            : false,
            valuation_stamp        : 0x1::option::none<ValuationStamp>(),
        };
        0x2::transfer::share_object<ExpiryMarket>(v2);
        v1
    }

    public fun current_nav(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer) : u64 {
        assert_pricer_bound(arg0, arg1);
        0x1::u64::saturating_sub(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::free_cash(&arg0.cash), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::live_marked_liability(&arg0.strike_exposure, arg1))
    }

    public fun entry_probability(arg0: &MintQuote) : u64 {
        arg0.entry_probability
    }

    fun ewma_penalty(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::EwmaConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma::update(&mut arg0.ewma, arg1, arg3, arg4);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma::penalty_fee(&arg0.ewma, arg1, arg2, arg4)
    }

    public fun expiry(arg0: &ExpiryMarket) : u64 {
        arg0.expiry
    }

    public fun expiry_fee_max_multiplier(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::expiry_fee_max_multiplier(&arg0.strike_exposure)
    }

    public fun expiry_fee_window_ms(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::expiry_fee_window_ms(&arg0.strike_exposure)
    }

    public fun fee_incentive_balance(arg0: &ExpiryMarket) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_balance)
    }

    public fun fee_incentive_subsidy(arg0: &MintQuote) : u64 {
        arg0.fee_incentive_subsidy
    }

    fun fee_incentive_subsidy_amount(arg0: &ExpiryMarket, arg1: u64) : u64 {
        0x1::u64::min(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg1, 200000000), 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_balance))
    }

    public fun id(arg0: &ExpiryMarket) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun inventory_impact_charge(arg0: &MintQuote) : u64 {
        arg0.inventory_impact_charge
    }

    public fun inventory_impact_max_rate(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::inventory_impact_max_rate(&arg0.strike_exposure)
    }

    public fun inventory_impact_scale(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::inventory_impact_scale(&arg0.strike_exposure)
    }

    public fun is_pending_valuation(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig) : bool {
        0x1::option::is_some<ValuationStamp>(&arg0.valuation_stamp) && 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::is_current_flush(arg1, 0x1::option::borrow<ValuationStamp>(&arg0.valuation_stamp).flush_seq)
    }

    public fun is_settled(arg0: &ExpiryMarket) : bool {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::is_settled(&arg0.strike_exposure)
    }

    public fun live_order_value(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: u256) : u64 {
        assert_pricer_bound(arg0, arg1);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_order_id(arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::live_order_value(&arg0.strike_exposure, arg1, &v0)
    }

    public fun load_live_pricer(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg5: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::load_live_pricer(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::pricing_config(arg1), arg2, arg3, arg4, arg5, id(arg0), arg0.propbook_underlying_id, arg0.expiry, arg6, arg7)
    }

    public fun mint_exact_amount(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::accumulator::AccumulatorRoot, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u256 {
        assert_live_mint_allowed(arg0, arg3, arg4, arg11);
        assert!(arg9 > 0, 9);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg10, arg11);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg1, arg2);
        mint_prepared(arg0, v0, arg3, arg4, arg5, arg6, 0x1::u64::min(arg7, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg1), arg10, arg11)), arg8, false, arg9, 18446744073709551615, arg11, arg12)
    }

    public fun mint_exact_quantity(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::accumulator::AccumulatorRoot, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u256 {
        assert_live_mint_allowed(arg0, arg3, arg4, arg11);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg10, arg11);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg1, arg2);
        mint_prepared(arg0, v0, arg3, arg4, arg5, arg6, 0, arg7, true, arg8, arg9, arg11, arg12)
    }

    public fun mint_paused(arg0: &ExpiryMarket) : bool {
        arg0.mint_paused
    }

    fun mint_prepared(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u256 {
        reconcile_stale_valuation_stamp(arg0, arg2);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::quote_mint_terms(&arg0.strike_exposure, arg3, arg4, arg5, arg6, arg7, arg8);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::entry_probability(&v0) <= arg10, 3);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(arg1);
        let v2 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::referrer_account_id(arg1);
        let v3 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::referrer_receive_address(arg1);
        let v4 = compute_mint_quote(arg0, &v0, &v1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma::penalty_fee(&arg0.ewma, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ewma_config(arg2), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::quantity(&v0), arg12), arg11);
        assert!(v4.all_in_cost <= arg9, 2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma::update(&mut arg0.ewma, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ewma_config(arg2), arg11, arg12);
        let v5 = if (0x1::option::is_some<address>(&v3)) {
            0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v4.trading_fee - v4.fee_incentive_subsidy + v4.penalty_fee, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::referral_fee_rate(arg2))
        } else {
            0
        };
        let v6 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::allocate_mint_order(&mut arg0.strike_exposure, v0);
        settle_mint_payment(arg0, arg1, &v6, &v4, v1, v3, v5, arg11, arg12);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order_events::emit_order_minted(id(arg0), 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(arg1), 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::owner(arg1), v1, v2, &v6, arg3, v4.entry_probability, v4.premium, v4.trading_fee, v4.fee_incentive_subsidy, v4.builder_fee, v4.penalty_fee, v5, v4.inventory_impact_charge, 0x2::clock::timestamp_ms(arg11));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(&v6)
    }

    public(friend) fun pause_mint(arg0: &mut ExpiryMarket) {
        arg0.mint_paused = true;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::emit_expiry_market_mint_paused_updated(id(arg0), true);
    }

    public fun payout_liability(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::payout_liability(&arg0.strike_exposure)
    }

    public fun premium(arg0: &MintQuote) : u64 {
        arg0.premium
    }

    public fun propbook_underlying_id(arg0: &ExpiryMarket) : u32 {
        arg0.propbook_underlying_id
    }

    public fun quantity(arg0: &MintQuote) : u64 {
        arg0.quantity
    }

    public fun quote_mint(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : MintQuote {
        assert_live_mint_allowed(arg0, arg1, arg2, arg8);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::quote_mint_terms(&arg0.strike_exposure, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x1::option::none<0x2::object::ID>();
        compute_mint_quote(arg0, &v0, &v1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma::penalty_fee(&arg0.ewma, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ewma_config(arg1), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::quantity(&v0), arg9), arg8)
    }

    public fun quote_mint_for_account(arg0: &ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::accumulator::AccumulatorRoot, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : MintQuote {
        assert_live_mint_allowed(arg0, arg2, arg3, arg10);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg1);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::quote_mint_terms(&arg0.strike_exposure, arg3, arg4, arg5, 0x1::u64::min(arg6, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg9, arg10)), arg7, arg8);
        let v2 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(v0);
        compute_mint_quote(arg0, &v1, &v2, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma::penalty_fee(&arg0.ewma, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ewma_config(arg2), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::quantity(&v1), arg11), arg10)
    }

    public(friend) fun receive_fee_incentives(arg0: &mut ExpiryMarket, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_balance, arg1);
    }

    public(friend) fun receive_pool_cash(arg0: &mut ExpiryMarket, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::receive(&mut arg0.cash, arg1);
        assert_cash_backing(arg0);
    }

    fun reconcile_stale_valuation_stamp(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig) {
        if (0x1::option::is_none<ValuationStamp>(&arg0.valuation_stamp)) {
            return
        };
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::is_current_flush(arg1, 0x1::option::borrow<ValuationStamp>(&arg0.valuation_stamp).flush_seq)) {
            arg0.valuation_stamp = 0x1::option::none<ValuationStamp>();
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::deactivate_valuation_snapshot(&mut arg0.strike_exposure);
        };
    }

    public fun redeem_live(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg5: u256, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::accumulator::AccumulatorRoot, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<u256> {
        assert_live_flow_allowed(arg0, arg3, arg4, arg10);
        redeem_live_with_auth(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    fun redeem_live_with_auth(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg5: u256, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::accumulator::AccumulatorRoot, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<u256> {
        reconcile_stale_valuation_stamp(arg0, arg3);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg9, arg10);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg1, arg2);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_order_id(arg5);
        let v2 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::quote_live_close(&arg0.strike_exposure, arg4, &v1, arg6);
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::position_opened_at_ms(v0, id(arg0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(&v1));
        assert!(0x2::clock::timestamp_ms(arg10) != v3, 6);
        let v4 = ewma_penalty(arg0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ewma_config(arg3), arg6, arg10, arg11);
        let v5 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::redeem_amount(&v2);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::range_probability(&v2) >= arg7, 7);
        let v6 = 0x1::u64::min(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::trading_fee(&arg0.strike_exposure, arg0.expiry, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::close_price(&v2), arg6, arg10), v5);
        let v7 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(v0);
        let v8 = 0x1::u64::min(builder_fee_amount(&v7, v6, arg6), v5 - v6);
        let v9 = 0x1::u64::min(v4, v5 - v6 - v8);
        let v10 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::inventory_impact_rebate(&v2);
        assert!(v5 + v10 - v6 - v8 - v9 >= arg8, 8);
        let v11 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::remove_position(v0, id(arg0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(&v1), arg11);
        let v12 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::process_live_close(&mut arg0.strike_exposure, v2);
        let v13 = if (0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order>(&v12)) {
            let v14 = 0x1::option::destroy_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order>(v12);
            let v15 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(&v14);
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::add_position(v0, id(arg0), v15, v11, v3, arg11);
            0x1::option::some<u256>(v15)
        } else {
            0x1::option::destroy_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order>(v12);
            0x1::option::none<u256>()
        };
        settle_live_redeem_payment(arg0, v0, v5, v6, v8, v9, v10, v7, arg11);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order_events::emit_live_order_redeemed(id(arg0), 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(v0), 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::owner(v0), v7, &v1, arg4, v11, arg6, v13, v5, v6, v8, v9, v10, 0x2::clock::timestamp_ms(arg10));
        v13
    }

    public fun redeem_settled(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u256, arg5: &0x2::accumulator::AccumulatorRoot, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_settled_flow_allowed(arg0, arg3);
        redeem_settled_with_auth(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    public fun redeem_settled_permissionless(arg0: &mut ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u256, arg5: &0x2::accumulator::AccumulatorRoot, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_settled_flow_allowed(arg0, arg3);
        redeem_settled_with_auth(arg0, arg2, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::generate_auth_as_app(arg1), arg4, arg5, arg6, arg7);
    }

    fun redeem_settled_with_auth(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: u256, arg4: &0x2::accumulator::AccumulatorRoot, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg4, arg5);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg1, arg2);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_order_id(arg3);
        let v2 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::process_settled_close(&mut arg0.strike_exposure, &v1);
        if (v2 > 0) {
            0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::pay_authorized(&mut arg0.cash, v2), arg6));
        };
        assert_cash_backing(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order_events::emit_settled_order_redeemed(id(arg0), 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(v0), 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::owner(v0), &v1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::remove_position(v0, id(arg0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(&v1), arg6), v2, 0x2::clock::timestamp_ms(arg5));
    }

    public fun reference_tick(arg0: &ExpiryMarket) : 0x1::option::Option<u64> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::reference_tick(&arg0.strike_exposure)
    }

    public fun reference_tick_source_timestamp_ms(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::reference_tick_source_timestamp_ms(&arg0.strike_exposure)
    }

    public(friend) fun release_fee_incentives(arg0: &mut ExpiryMarket) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_balance);
        if (v0 == 0) {
            return 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        };
        0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_balance, v0)
    }

    public(friend) fun release_pool_cash(arg0: &mut ExpiryMarket, arg1: u64) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        if (arg1 == 0) {
            return 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        };
        assert_cash_backing(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::release_surplus(&mut arg0.cash, arg1, payout_liability(arg0))
    }

    public(friend) fun release_settled_pool_cash(arg0: &mut ExpiryMarket) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = payout_liability(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::assert_backing(&arg0.cash, v0);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::balance(&arg0.cash) - 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::required_cash(&arg0.cash, v0);
        release_pool_cash(arg0, v1)
    }

    fun send_builder_fee(arg0: 0x1::option::Option<0x2::object::ID>, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) == 0) {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
            return
        };
        let v0 = 0x1::option::destroy_some<0x2::object::ID>(arg0);
        0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::object::id_to_address(&v0));
    }

    fun send_referral_fee(arg0: 0x1::option::Option<address>, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) == 0) {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
            return
        };
        0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x1::option::destroy_some<address>(arg0));
    }

    public fun set_mint_paused(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: bool) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg1);
        arg0.mint_paused = arg3;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::emit_expiry_market_mint_paused_updated(id(arg0), arg3);
    }

    public fun set_reference_tick(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg4: &0x2::clock::Clock) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg1);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::reference_tick_source_timestamp_ms(&arg0.strike_exposure);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::load_exact_spot(arg2, arg3, arg0.propbook_underlying_id, v0);
        assert!(0x1::option::is_some<u64>(&v1), 5);
        let v2 = 0x1::option::destroy_some<u64>(v1);
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::grid_tick(v2, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::tick_size(&arg0.strike_exposure));
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::set_reference_tick(&mut arg0.strike_exposure, v3)) {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::emit_reference_tick_set(id(arg0), arg0.propbook_underlying_id, v0, v2, v3, 0x2::clock::timestamp_ms(arg4));
        };
        v3
    }

    fun settle_live_redeem_payment(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<0x2::object::ID>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::pay_authorized(&mut arg0.cash, arg2 - arg5);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::pay_inventory_impact_rebate(&mut arg0.cash, arg6));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::receive(&mut arg0.cash, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0, arg3));
        send_builder_fee(arg7, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0, arg4));
        assert_cash_backing(arg0);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg8));
    }

    fun settle_mint_payment(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order, arg3: &MintQuote, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<address>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::add_position(arg1, id(arg0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(arg2), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(arg2), 0x2::clock::timestamp_ms(arg7), arg8);
        let v0 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3.all_in_cost, arg8));
        send_builder_fee(arg4, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0, arg3.builder_fee));
        send_referral_fee(arg5, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0, arg6));
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_balance, arg3.fee_incentive_subsidy));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::receive(&mut arg0.cash, v0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::credit_inventory_impact_reserve(&mut arg0.cash, arg3.inventory_impact_charge);
        assert_cash_backing(arg0);
    }

    public fun settled_order_payout(arg0: &ExpiryMarket, arg1: u256) : u64 {
        assert!(is_settled(arg0), 1);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_order_id(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::settled_order_payout(&arg0.strike_exposure, &v0)
    }

    public fun settlement_price(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::settlement_price(&arg0.strike_exposure)
    }

    public(friend) fun snapshot_nav(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer) : u64 {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::thaw(arg1);
        assert_pricer_bound(arg0, &v0);
        assert!(0x1::option::is_some<ValuationStamp>(&arg0.valuation_stamp), 10);
        let v1 = 0x1::option::borrow<ValuationStamp>(&arg0.valuation_stamp);
        0x1::u64::saturating_sub(0x1::u64::saturating_sub(v1.snapshot_cash, v1.snapshot_impact_reserve), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::frozen_marked_liability(&arg0.strike_exposure, &v0, v1.flush_seq))
    }

    public(friend) fun stamp_for_valuation(arg0: &mut ExpiryMarket, arg1: u64) {
        let v0 = ValuationStamp{
            flush_seq               : arg1,
            snapshot_cash           : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::balance(&arg0.cash),
            snapshot_impact_reserve : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::inventory_impact_reserve(&arg0.cash),
        };
        arg0.valuation_stamp = 0x1::option::some<ValuationStamp>(v0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::activate_valuation_snapshot(&mut arg0.strike_exposure, arg1);
    }

    public fun tick_size(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::tick_size(&arg0.strike_exposure)
    }

    public fun trading_fee(arg0: &MintQuote) : u64 {
        arg0.trading_fee
    }

    public fun try_settle(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg5: &0x2::clock::Clock) : bool {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg1);
        reconcile_stale_valuation_stamp(arg0, arg1);
        if (is_settled(arg0)) {
            return true
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        if (v0 < arg0.expiry) {
            return false
        };
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::load_exact_spot(arg2, arg3, arg0.propbook_underlying_id, arg0.expiry);
        let (v2, v3) = if (0x1::option::is_some<u64>(&v1)) {
            (0x1::option::destroy_some<u64>(v1), 0)
        } else {
            if (v0 - arg0.expiry < 30000) {
                return false
            };
            let v4 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::load_exact_block_scholes_spot(arg2, arg4, arg0.propbook_underlying_id, arg0.expiry);
            if (0x1::option::is_none<u64>(&v4)) {
                return false
            };
            (0x1::option::destroy_some<u64>(v4), 1)
        };
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::record_settlement(&mut arg0.strike_exposure, v2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::release_inventory_impact_reserve(&mut arg0.cash);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::emit_market_settled(id(arg0), arg0.propbook_underlying_id, arg0.expiry, v2, v3, v0);
        true
    }

    public fun try_settlement_price(arg0: &ExpiryMarket) : 0x1::option::Option<u64> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::try_settlement_price(&arg0.strike_exposure)
    }

    // decompiled from Move bytecode v7
}

