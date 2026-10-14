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

    struct RedeemQuote has copy, drop {
        close_quantity: u64,
        probability: u64,
        proceeds: u64,
        trading_fee: u64,
        builder_fee: u64,
        inventory_impact_rebate: u64,
    }

    struct OrderReceipt has store {
        expiry_market_id: 0x2::object::ID,
        stage: u8,
        kind: u8,
        parties: OrderParties,
        lower_tick: u64,
        higher_tick: u64,
        quantity: u64,
        max_premium: u64,
        min_quantity: u64,
        max_probability: u64,
        min_probability: u64,
        min_proceeds: u64,
        tau_ms: u64,
        deadline_ms: u64,
        channel: u8,
        vol: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::VolSnapshot,
        budget: u64,
        order_fee: u64,
        cash_need: u64,
        subsidy_bound: u64,
        subsidy_rate: u64,
        subsidy_reserved: u64,
        spot: u64,
        tick_ms: u64,
        generation_us: u64,
        order_id: u256,
        root_id: u256,
        opened_at_ms: u64,
        held_quantity: u64,
    }

    struct OrderParties has copy, drop, store {
        account_id: 0x2::object::ID,
        owner: address,
        receive_address: address,
        referrer_account_id: 0x1::option::Option<0x2::object::ID>,
        referrer_receive_address: 0x1::option::Option<address>,
        builder_code_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct OrderFlowLedgerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OrderFlowLedger has store {
        pins: 0x2::vec_map::VecMap<u64, u64>,
        waiting_cash_need: u64,
    }

    public fun builder_fee(arg0: &MintQuote) : u64 {
        arg0.builder_fee
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

    fun admit_gates(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: bool, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg5: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) : (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::VolSnapshot, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_cutover(arg1);
        if (arg2) {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_trading(arg1);
            assert!(!arg0.mint_paused, 0);
        };
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_no_snap(arg1);
        reconcile(arg0, arg1);
        let v0 = arg0.expiry;
        let v1 = if (arg8 == 2) {
            50
        } else {
            200
        };
        let v2 = if (arg8 == 2 || arg8 == 3) {
            if (arg9 % v1 == 0) {
                if (0x2::clock::timestamp_ms(arg11) <= arg9 + v1) {
                    if (arg9 < arg10) {
                        if (arg9 + 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::no_trade_window_ms(arg1) < v0) {
                            arg10 + 5000 <= v0
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 16);
        assert!(arg7 <= 120000, 17);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::load_vol(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::pricing_cfg(arg1), arg3, arg4, arg5, arg6, id(arg0), arg0.propbook_underlying_id, v0, arg7, arg11, arg12)
    }

    public fun admit_mint<T0: drop>(arg0: T0, arg1: &mut ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg5: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u8, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &0x2::tx_context::TxContext) : OrderReceipt {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_flow<T0>(arg2);
        let (v0, v1) = admit_gates(arg1, arg2, true, arg4, arg5, arg6, arg7, arg17, arg18, arg19, arg20, arg21, arg22);
        let v2 = v1;
        assert!(arg15 > 0, 9);
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(arg3);
        let (_, v5, _, v7) = price_mint(arg1, &v2, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg14, &v3, 0, 0, 0x2::clock::timestamp_ms(arg21));
        let v8 = v5;
        assert!(v7 == 0, 14);
        let v9 = if (arg8 == 0) {
            0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::need_qty(arg11, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::min_prob(&arg1.strike_exposure))
        } else if (arg8 == 1) {
            0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::need_budget(0x1::u64::min(arg12, arg15), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::min_prob(&arg1.strike_exposure))
        } else {
            0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::need_budget(arg15, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::min_prob(&arg1.strike_exposure))
        };
        assert!(v9 <= 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::balance(&arg1.cash) - required_cash(arg1), 15);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::ensure_nodes(&mut arg1.strike_exposure, arg9, arg10);
        let v10 = ledger_mut(arg1);
        let v11 = &mut v10.pins;
        pin(v11, arg9);
        let v12 = &mut v10.pins;
        pin(v12, arg10);
        v10.waiting_cash_need = v10.waiting_cash_need + v9;
        let v13 = 0;
        OrderReceipt{
            expiry_market_id : id(arg1),
            stage            : 1,
            kind             : arg8,
            parties          : parties(arg3, v3),
            lower_tick       : arg9,
            higher_tick      : arg10,
            quantity         : arg11,
            max_premium      : arg12,
            min_quantity     : arg13,
            max_probability  : arg14,
            min_probability  : v13,
            min_proceeds     : v13,
            tau_ms           : arg19,
            deadline_ms      : arg20,
            channel          : arg18,
            vol              : v0,
            budget           : arg15,
            order_fee        : arg16,
            cash_need        : v9,
            subsidy_bound    : 0x1::u64::min(v8.trading_fee, arg15),
            subsidy_rate     : v13,
            subsidy_reserved : v13,
            spot             : v13,
            tick_ms          : v13,
            generation_us    : v13,
            order_id         : (v13 as u256),
            root_id          : (v13 as u256),
            opened_at_ms     : v13,
            held_quantity    : v13,
        }
    }

    public fun admit_sell<T0: drop>(arg0: T0, arg1: &mut ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg4: &mut OrderReceipt, arg5: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &0x2::tx_context::TxContext) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_flow<T0>(arg2);
        let (v0, v1) = admit_gates(arg1, arg2, false, arg5, arg6, arg7, arg8, arg13, arg14, arg15, arg16, arg17, arg18);
        let v2 = v1;
        assert!(arg4.expiry_market_id == id(arg1), 18);
        assert!(arg4.stage == 2, 19);
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_id(arg4.order_id);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::quantity(&v3) == arg4.held_quantity, 19);
        assert!(arg4.parties.account_id == 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(arg3), 20);
        let v4 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(arg3);
        let (_, _, v7) = price_close(arg1, &v2, &v3, arg9, arg10, arg11, &v4, 0x2::clock::timestamp_ms(arg17));
        assert!(v7 == 0, 14);
        let v8 = 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::need_sell(arg9, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::backing_buffer_lambda(&arg1.strike_exposure));
        let v9 = ledger_mut(arg1);
        v9.waiting_cash_need = v9.waiting_cash_need + v8;
        arg4.stage = 3;
        arg4.kind = 4;
        arg4.parties = parties(arg3, v4);
        arg4.quantity = arg9;
        arg4.min_probability = arg10;
        arg4.min_proceeds = arg11;
        arg4.tau_ms = arg15;
        arg4.deadline_ms = arg16;
        arg4.channel = arg14;
        arg4.vol = v0;
        arg4.order_fee = arg12;
        arg4.cash_need = v8;
    }

    public fun all_in_cost(arg0: &MintQuote) : u64 {
        arg0.all_in_cost
    }

    public fun backing_buffer_lambda(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::backing_buffer_lambda(&arg0.strike_exposure)
    }

    fun bldr_fee_amt(arg0: &0x1::option::Option<0x2::object::ID>, arg1: u64, arg2: u64) : u64 {
        if (0x1::option::is_some<0x2::object::ID>(arg0)) {
            0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::builder_fee(arg1, arg2, 100000000, 5000000)
        } else {
            0
        }
    }

    public fun cash_balance(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::balance(&arg0.cash)
    }

    fun chk_backed(arg0: &ExpiryMarket) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::chk_backing(&arg0.cash, payout_liability(arg0));
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::inventory_impact_reserve(&arg0.cash) >= 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::impact_pot(&arg0.strike_exposure), 13906847591821213695);
    }

    fun chk_price(arg0: &OrderReceipt, arg1: &0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice, arg2: u64) {
        let v0 = arg0.tau_ms * 1000;
        let v1 = 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::envelope_us(arg1);
        let v2 = 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::generation_us(arg1);
        let v3 = if (0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::feed_id(arg1) == 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::pyth_source_id(&arg0.vol)) {
            if (0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::channel(arg1) == arg0.channel) {
                let v4 = if (v1 == v0) {
                    true
                } else {
                    let v5 = if (arg0.channel == 2) {
                        50
                    } else {
                        200
                    };
                    v1 == v0 + v5 * 1000
                };
                if (v4) {
                    if (v0 <= v2) {
                        if (v2 <= v1) {
                            if (v1 <= arg2 * 1000) {
                                0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::safe_spot(0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::spot(arg1))
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 22);
    }

    fun chk_pricer(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer) {
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::expiry_market_id(arg1) == id(arg0), 4);
    }

    fun chk_settled(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_no_snap(arg1);
        assert!(is_settled(arg0), 1);
    }

    public(friend) fun clear_stamp(arg0: &mut ExpiryMarket) {
        arg0.valuation_stamp = 0x1::option::none<ValuationStamp>();
        let v0 = 0x2::vec_map::empty<u64, u64>();
        let v1 = OrderFlowLedgerKey{dummy_field: false};
        let v2 = if (0x2::dynamic_field::exists<OrderFlowLedgerKey>(&arg0.id, v1)) {
            let v3 = OrderFlowLedgerKey{dummy_field: false};
            &0x2::dynamic_field::borrow<OrderFlowLedgerKey, OrderFlowLedger>(&arg0.id, v3).pins
        } else {
            &v0
        };
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::drop_snap(&mut arg0.strike_exposure, v2);
    }

    public fun commit<T0: drop>(arg0: T0, arg1: &mut ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &mut OrderReceipt, arg4: &0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_flow<T0>(arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg2);
        assert!(arg3.expiry_market_id == id(arg1), 18);
        let v0 = arg3.stage == 1;
        assert!((v0 || arg3.stage == 3) && arg3.spot == 0, 19);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 < arg3.deadline_ms, 16);
        chk_price(arg3, arg4, v1);
        arg3.spot = 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::spot(arg4);
        arg3.tick_ms = 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::envelope_us(arg4) / 1000;
        arg3.generation_us = 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::generation_us(arg4);
        if (!v0) {
            return 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        };
        let v2 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::fee_incentive_subsidy_rate(arg2);
        let v3 = 0x1::u64::min(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg3.subsidy_bound, v2), 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.fee_incentive_balance));
        arg3.subsidy_rate = v2;
        arg3.subsidy_reserved = v3;
        0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.fee_incentive_balance, v3)
    }

    fun cost_at_tick(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintRange, arg2: &0x1::option::Option<0x2::object::ID>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = mint_q_at(arg0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::range_px(arg1), arg3, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::range_prem(arg1, arg3), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::mint_impact(&arg0.strike_exposure, arg1, arg3), arg2, arg4, arg5, arg6);
        let v1 = if (0x1::option::is_some<MintQuote>(&v0)) {
            let v2 = 0x1::option::destroy_some<MintQuote>(v0);
            0x1::option::some<u64>(v2.all_in_cost)
        } else {
            0x1::option::destroy_none<MintQuote>(v0);
            0x1::option::none<u64>()
        };
        let v3 = v1;
        if (0x1::option::is_some<u64>(&v3)) {
            0x1::option::destroy_some<u64>(v3)
        } else {
            0x1::option::destroy_none<u64>(v3);
            18446744073709551615
        }
    }

    fun cost_qty_at(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintRange, arg2: &0x1::option::Option<0x2::object::ID>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = 10000;
        let v1 = 0;
        let v2 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::qty_for_prem(arg1, arg3) / v0;
        while (v1 < v2) {
            let v3 = (v1 + v2 + 1) / 2;
            if (cost_at_tick(arg0, arg1, arg2, v3 * v0, arg4, arg5, arg6) <= arg3) {
                v1 = v3;
                continue
            };
            v2 = v3 - 1;
        };
        let v4 = v1 * v0;
        if (v1 == 0 || cost_at_tick(arg0, arg1, arg2, v4, arg4, arg5, arg6) <= v4) {
            return v4
        };
        let v5 = v1 - 1;
        let v6 = 0;
        while (v6 < v5) {
            let v7 = (v6 + v5 + 1) / 2;
            let v8 = v7 * v0;
            if (cost_at_tick(arg0, arg1, arg2, v8, arg4, arg5, arg6) <= v8) {
                v6 = v7;
                continue
            };
            v5 = v7 - 1;
        };
        if (v6 == 0) {
            v4
        } else {
            v6 * v0
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
            strike_exposure        : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::new(v1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::se_snapshot(arg0), arg3, arg4, arg5, arg6, arg7),
            ewma                   : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma::new(arg7),
            mint_paused            : false,
            valuation_stamp        : 0x1::option::none<ValuationStamp>(),
        };
        0x2::transfer::share_object<ExpiryMarket>(v2);
        v1
    }

    public fun current_nav(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer) : u64 {
        chk_pricer(arg0, arg1);
        0x1::u64::saturating_sub(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::free_cash(&arg0.cash), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::marked_liab(&arg0.strike_exposure, arg1))
    }

    fun denied(arg0: &0x2::deny_list::DenyList, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::coin::deny_list_v2_contains_current_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2) || 0x2::coin::deny_list_v2_is_global_pause_enabled_current_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg2)
    }

    fun drop_receipt(arg0: OrderReceipt) {
        let OrderReceipt {
            expiry_market_id : _,
            stage            : _,
            kind             : _,
            parties          : _,
            lower_tick       : _,
            higher_tick      : _,
            quantity         : _,
            max_premium      : _,
            min_quantity     : _,
            max_probability  : _,
            min_probability  : _,
            min_proceeds     : _,
            tau_ms           : _,
            deadline_ms      : _,
            channel          : _,
            vol              : _,
            budget           : _,
            order_fee        : _,
            cash_need        : _,
            subsidy_bound    : _,
            subsidy_rate     : _,
            subsidy_reserved : _,
            spot             : _,
            tick_ms          : _,
            generation_us    : _,
            order_id         : _,
            root_id          : _,
            opened_at_ms     : _,
            held_quantity    : _,
        } = arg0;
    }

    fun empty_mint_q() : MintQuote {
        MintQuote{
            quantity                : 0,
            entry_probability       : 0,
            premium                 : 0,
            trading_fee             : 0,
            fee_incentive_subsidy   : 0,
            builder_fee             : 0,
            penalty_fee             : 0,
            inventory_impact_charge : 0,
            all_in_cost             : 0,
        }
    }

    fun empty_rdm_q(arg0: u64) : RedeemQuote {
        RedeemQuote{
            close_quantity          : arg0,
            probability             : 0,
            proceeds                : 0,
            trading_fee             : 0,
            builder_fee             : 0,
            inventory_impact_rebate : 0,
        }
    }

    public fun entry_probability(arg0: &MintQuote) : u64 {
        arg0.entry_probability
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

    fun fill_close(arg0: &mut ExpiryMarket, arg1: &mut OrderReceipt, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg3: &mut 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::deny_list::DenyList, arg5: u64, arg6: &0x2::tx_context::TxContext) : (u8, bool, RedeemQuote) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_id(arg1.order_id);
        let v1 = arg1.quantity;
        let (v2, v3, v4) = price_close(arg0, arg2, &v0, v1, arg1.min_probability, arg1.min_proceeds, &arg1.parties.builder_code_id, arg1.tick_ms);
        let v5 = v3;
        if (v4 != 0) {
            return (v4, false, v5)
        };
        let v6 = 0x1::option::destroy_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::LiveCloseTerms>(v2);
        let v7 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::redeem_amt(&v6);
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::balance(&arg0.cash) + v5.trading_fee + arg1.order_fee < 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::liab_closed(&arg0.strike_exposure, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::lower_tick(&v0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::higher_tick(&v0), v1) + 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::inventory_impact_reserve(&arg0.cash) + v7) {
            return (8, false, v5)
        };
        let v8 = OrderFlowLedgerKey{dummy_field: false};
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::receive(&mut arg0.cash, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg1.order_fee));
        let v9 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::pay_out(&mut arg0.cash, v7);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v9, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::pay_rebate(&mut arg0.cash, v5.inventory_impact_rebate));
        let v10 = 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v9, v5.trading_fee + v5.builder_fee);
        let v11 = arg1.parties.builder_code_id;
        let v12 = if (0x1::option::is_some<0x2::object::ID>(&v11)) {
            let v13 = 0x1::option::destroy_some<0x2::object::ID>(v11);
            0x1::option::some<address>(0x2::object::id_to_address(&v13))
        } else {
            0x1::option::destroy_none<0x2::object::ID>(v11);
            0x1::option::none<address>()
        };
        let v14 = &mut v10;
        pay_fee(v14, v5.builder_fee, v12, arg4, arg6);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::receive(&mut arg0.cash, v10);
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v9) > 0) {
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9, arg1.parties.receive_address);
        } else {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9);
        };
        chk_backed(arg0);
        let v15 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::apply_close(&mut arg0.strike_exposure, v6, &0x2::dynamic_field::borrow<OrderFlowLedgerKey, OrderFlowLedger>(&arg0.id, v8).pins);
        let v16 = if (0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order>(&v15)) {
            let v17 = 0x1::option::destroy_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order>(v15);
            0x1::option::some<u256>(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(&v17))
        } else {
            0x1::option::destroy_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order>(v15);
            0x1::option::none<u256>()
        };
        let v18 = v16;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order_events::redeemed(id(arg0), arg1.parties.account_id, arg1.parties.owner, arg1.parties.builder_code_id, &v0, arg2, arg1.root_id, v1, v18, v7, v5.trading_fee, v5.builder_fee, 0, v5.inventory_impact_rebate, arg5);
        let v19 = 0x1::option::is_some<u256>(&v18);
        if (v19) {
            arg1.order_id = 0x1::option::destroy_some<u256>(v18);
            arg1.held_quantity = arg1.held_quantity - v1;
        };
        (0, v19, v5)
    }

    fun fill_mint(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &mut OrderReceipt, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg4: &mut 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::deny_list::DenyList, arg6: u64, arg7: &0x2::tx_context::TxContext) : (u8, MintQuote, u64) {
        let v0 = arg2.tick_ms;
        let (v1, v2, v3, v4) = price_mint(arg0, arg3, arg2.kind, arg2.lower_tick, arg2.higher_tick, arg2.quantity, arg2.max_premium, arg2.min_quantity, arg2.budget, arg2.max_probability, &arg2.parties.builder_code_id, arg2.subsidy_rate, arg2.subsidy_reserved, v0);
        let v5 = v2;
        if (v4 != 0) {
            return (v4, v5, 0)
        };
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::nodes_exist(&arg0.strike_exposure, arg2.lower_tick, arg2.higher_tick)) {
            return (4, v5, 0)
        };
        let v6 = if (0x1::option::is_some<address>(&arg2.parties.referrer_receive_address)) {
            0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v5.trading_fee - v5.fee_incentive_subsidy, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::referral_fee_rate(arg1))
        } else {
            0
        };
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::balance(&arg0.cash) + v5.premium + v5.inventory_impact_charge + v5.trading_fee - v6 + arg2.order_fee < v3 + 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::inventory_impact_reserve(&arg0.cash) + v5.inventory_impact_charge) {
            return (8, v5, 0)
        };
        let v7 = 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v5.all_in_cost);
        let v8 = arg2.parties.builder_code_id;
        let v9 = if (0x1::option::is_some<0x2::object::ID>(&v8)) {
            let v10 = 0x1::option::destroy_some<0x2::object::ID>(v8);
            0x1::option::some<address>(0x2::object::id_to_address(&v10))
        } else {
            0x1::option::destroy_none<0x2::object::ID>(v8);
            0x1::option::none<address>()
        };
        let v11 = &mut v7;
        pay_fee(v11, v5.builder_fee, v9, arg5, arg7);
        let v12 = &mut v7;
        pay_fee(v12, v6, arg2.parties.referrer_receive_address, arg5, arg7);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v7, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v5.fee_incentive_subsidy));
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v7, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg2.order_fee));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::receive(&mut arg0.cash, v7);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::add_impact(&mut arg0.cash, v5.inventory_impact_charge);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_balance, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg2.subsidy_reserved - v5.fee_incentive_subsidy));
        let v13 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::allocate(&mut arg0.strike_exposure, 0x1::option::destroy_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintTerms>(v1));
        chk_backed(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order_events::minted(id(arg0), arg2.parties.account_id, arg2.parties.owner, arg2.parties.builder_code_id, arg2.parties.referrer_account_id, &v13, arg3, v5.entry_probability, v5.premium, v5.trading_fee, v5.fee_incentive_subsidy, v5.builder_fee, 0, v6, v5.inventory_impact_charge, arg6);
        let v14 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(&v13);
        arg2.order_id = v14;
        arg2.root_id = v14;
        arg2.opened_at_ms = v0;
        arg2.held_quantity = v5.quantity;
        (0, v5, v6)
    }

    public(friend) fun free_incent(arg0: &mut ExpiryMarket) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_balance);
        if (v0 == 0) {
            return 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        };
        0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_balance, v0)
    }

    public(friend) fun free_settled(arg0: &mut ExpiryMarket) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = payout_liability(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::chk_backing(&arg0.cash, v0);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::balance(&arg0.cash) - 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::required_cash(&arg0.cash, v0);
        release_cash(arg0, v1)
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
        0x1::option::is_some<ValuationStamp>(&arg0.valuation_stamp) && 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::is_cur_flush(arg1, 0x1::option::borrow<ValuationStamp>(&arg0.valuation_stamp).flush_seq)
    }

    public fun is_settled(arg0: &ExpiryMarket) : bool {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::is_settled(&arg0.strike_exposure)
    }

    fun ledger_mut(arg0: &mut ExpiryMarket) : &mut OrderFlowLedger {
        let v0 = OrderFlowLedgerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<OrderFlowLedgerKey>(&arg0.id, v0)) {
            let v1 = OrderFlowLedgerKey{dummy_field: false};
            let v2 = OrderFlowLedger{
                pins              : 0x2::vec_map::empty<u64, u64>(),
                waiting_cash_need : 0,
            };
            0x2::dynamic_field::add<OrderFlowLedgerKey, OrderFlowLedger>(&mut arg0.id, v1, v2);
        };
        let v3 = OrderFlowLedgerKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<OrderFlowLedgerKey, OrderFlowLedger>(&mut arg0.id, v3)
    }

    public fun live_order_value(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: u256) : u64 {
        chk_pricer(arg0, arg1);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_id(arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::live_order_value(&arg0.strike_exposure, arg1, &v0)
    }

    public fun load_live_pricer(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg5: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::load_live_pricer(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::pricing_cfg(arg1), arg2, arg3, arg4, arg5, id(arg0), arg0.propbook_underlying_id, arg0.expiry, arg6, arg7)
    }

    public fun mint_exact_amount(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::accumulator::AccumulatorRoot, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u256 {
        abort 13
    }

    public fun mint_exact_cost(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::accumulator::AccumulatorRoot, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : u256 {
        abort 13
    }

    public fun mint_exact_quantity(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::accumulator::AccumulatorRoot, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u256 {
        abort 13
    }

    public fun mint_paused(arg0: &ExpiryMarket) : bool {
        arg0.mint_paused
    }

    fun mint_q_at(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice, arg2: u64, arg3: u64, arg4: u64, arg5: &0x1::option::Option<0x2::object::ID>, arg6: u64, arg7: u64, arg8: u64) : 0x1::option::Option<MintQuote> {
        if (arg8 >= arg0.expiry) {
            return 0x1::option::none<MintQuote>()
        };
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::fee_at(&arg0.strike_exposure, arg0.expiry, arg1, arg2, arg8);
        let v1 = 0x1::u64::min(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v0, arg6), arg7);
        let v2 = bldr_fee_amt(arg5, v0, arg2);
        let v3 = MintQuote{
            quantity                : arg2,
            entry_probability       : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::probability(arg1),
            premium                 : arg3,
            trading_fee             : v0,
            fee_incentive_subsidy   : v1,
            builder_fee             : v2,
            penalty_fee             : 0,
            inventory_impact_charge : arg4,
            all_in_cost             : arg3 + v0 - v1 + v2 + arg4,
        };
        0x1::option::some<MintQuote>(v3)
    }

    public fun order_flow_state(arg0: &ExpiryMarket) : (u64, u64, u64) {
        (wait_need(arg0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::tree_nodes(&arg0.strike_exposure), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::min_prob(&arg0.strike_exposure))
    }

    fun parties(arg0: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg1: 0x1::option::Option<0x2::object::ID>) : OrderParties {
        OrderParties{
            account_id               : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(arg0),
            owner                    : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::owner(arg0),
            receive_address          : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::receive_address(arg0),
            referrer_account_id      : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::referrer_account_id(arg0),
            referrer_receive_address : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::referrer_receive_address(arg0),
            builder_code_id          : arg1,
        }
    }

    public(friend) fun pause_mint(arg0: &mut ExpiryMarket) {
        arg0.mint_paused = true;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::mkt_paused(id(arg0), true);
    }

    fun pay_fee(arg0: &mut 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: u64, arg2: 0x1::option::Option<address>, arg3: &0x2::deny_list::DenyList, arg4: &0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        let v0 = 0x1::option::destroy_some<address>(arg2);
        if (!denied(arg3, v0, arg4)) {
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1), v0);
        };
    }

    public fun payout_liability(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::payout_liability(&arg0.strike_exposure)
    }

    public fun penalty_fee(arg0: &MintQuote) : u64 {
        arg0.penalty_fee
    }

    fun pin(arg0: &mut 0x2::vec_map::VecMap<u64, u64>, arg1: u64) {
        if (arg1 == 0 || arg1 == 1073741823) {
            return
        };
        if (0x2::vec_map::contains<u64, u64>(arg0, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u64, u64>(arg0, &arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::vec_map::insert<u64, u64>(arg0, arg1, 1);
        };
    }

    public fun premium(arg0: &MintQuote) : u64 {
        arg0.premium
    }

    fun price_close(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order, arg3: u64, arg4: u64, arg5: u64, arg6: &0x1::option::Option<0x2::object::ID>, arg7: u64) : (0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::LiveCloseTerms>, RedeemQuote, u8) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::try_close(&arg0.strike_exposure, arg1, arg2, arg3);
        if (0x1::option::is_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::LiveCloseTerms>(&v0)) {
            return (v0, empty_rdm_q(arg3), 2)
        };
        let v1 = rdm_q_at(arg0, 0x1::option::borrow<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::LiveCloseTerms>(&v0), arg6, arg3, arg7);
        if (v1.probability < arg4 || v1.proceeds < arg5) {
            return (0x1::option::none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::LiveCloseTerms>(), v1, 1)
        };
        (v0, v1, 0)
    }

    fun price_mint(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x1::option::Option<0x2::object::ID>, arg11: u64, arg12: u64, arg13: u64) : (0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintTerms>, MintQuote, u64, u8) {
        assert!(arg2 <= 2, 17);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::try_mint_rng(&arg0.strike_exposure, arg1, arg3, arg4);
        if (0x1::option::is_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintRange>(&v0)) {
            return (0x1::option::none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintTerms>(), empty_mint_q(), 0, 2)
        };
        let v1 = 0x1::option::destroy_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintRange>(v0);
        let v2 = arg2 == 0;
        let v3 = if (v2) {
            arg5
        } else if (arg2 == 1) {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::qty_for_prem(&v1, arg6)
        } else {
            cost_qty_at(arg0, &v1, arg10, arg8, arg11, arg12, arg13)
        };
        let v4 = if (v2) {
            v3
        } else {
            arg7
        };
        let (v5, v6) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::try_terms(&arg0.strike_exposure, v1, v3, v4);
        let v7 = v5;
        if (0x1::option::is_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintTerms>(&v7)) {
            return (v7, empty_mint_q(), 0, v6)
        };
        let v8 = 0x1::option::borrow<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintTerms>(&v7);
        let v9 = mint_q_at(arg0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::mint_price(v8), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::quantity(v8), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::premium(v8), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::inventory_impact_charge(v8), arg10, arg11, arg12, arg13);
        if (0x1::option::is_none<MintQuote>(&v9)) {
            return (0x1::option::none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintTerms>(), empty_mint_q(), 0, 2)
        };
        let v10 = 0x1::option::destroy_some<MintQuote>(v9);
        if (v2 && v10.entry_probability > arg9) {
            return (0x1::option::none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintTerms>(), v10, 0, 1)
        };
        if (v10.all_in_cost > v10.quantity) {
            return (0x1::option::none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintTerms>(), v10, 0, 2)
        };
        if (v10.all_in_cost > arg8) {
            return (0x1::option::none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::MintTerms>(), v10, 0, 1)
        };
        (v7, v10, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::liab_minted(&arg0.strike_exposure, &v1, v3), 0)
    }

    public fun propbook_underlying_id(arg0: &ExpiryMarket) : u32 {
        arg0.propbook_underlying_id
    }

    public fun quantity(arg0: &MintQuote) : u64 {
        arg0.quantity
    }

    public fun quote_close(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: &OrderReceipt, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &0x2::clock::Clock) : RedeemQuote {
        chk_pricer(arg0, arg1);
        assert!(arg2.expiry_market_id == id(arg0), 18);
        assert!(arg2.stage == 2, 19);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 < arg0.expiry, 16);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_id(arg2.order_id);
        let (_, v3, v4) = price_close(arg0, arg1, &v1, arg3, 0, 0, &arg4, v0);
        assert!(v4 == 0, 14);
        v3
    }

    public fun quote_mint(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : MintQuote {
        let v0 = if (arg7) {
            0
        } else {
            1
        };
        let v1 = 0x1::option::none<0x2::object::ID>();
        quote_now(arg0, arg1, arg2, v0, arg3, arg4, arg5, arg6, 18446744073709551615, &v1, arg8)
    }

    public fun quote_mint_exact_cost_for_account(arg0: &ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::accumulator::AccumulatorRoot, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : MintQuote {
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg1);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(v0);
        quote_now(arg0, arg2, arg3, 2, arg4, arg5, 0, arg7, 0x1::u64::min(arg6, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg8, arg9)), &v1, arg9)
    }

    public fun quote_mint_for_account(arg0: &ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::accumulator::AccumulatorRoot, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : MintQuote {
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg1);
        let v1 = if (arg8) {
            0
        } else {
            1
        };
        let v2 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(v0);
        quote_now(arg0, arg2, arg3, v1, arg4, arg5, 0x1::u64::min(arg6, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg9, arg10)), arg7, 18446744073709551615, &v2, arg10)
    }

    fun quote_now(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x1::option::Option<0x2::object::ID>, arg10: &0x2::clock::Clock) : MintQuote {
        chk_pricer(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        assert!(v0 < arg0.expiry, 16);
        let (_, v2, _, v4) = price_mint(arg0, arg2, arg3, arg4, arg5, arg7, arg6, arg7, arg8, 18446744073709551615, arg9, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::fee_incentive_subsidy_rate(arg1), 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_balance), v0);
        assert!(v4 == 0, 14);
        v2
    }

    fun rdm_q_at(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::LiveCloseTerms, arg2: &0x1::option::Option<0x2::object::ID>, arg3: u64, arg4: u64) : RedeemQuote {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::redeem_amt(arg1);
        let v1 = 0x1::u64::min(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::fee_at(&arg0.strike_exposure, arg0.expiry, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::close_price(arg1), arg3, arg4), v0);
        let v2 = 0x1::u64::min(bldr_fee_amt(arg2, v1, arg3), v0 - v1);
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::rebate(arg1);
        RedeemQuote{
            close_quantity          : arg3,
            probability             : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::close_prob(arg1),
            proceeds                : v0 + v3 - v1 - v2,
            trading_fee             : v1,
            builder_fee             : v2,
            inventory_impact_rebate : v3,
        }
    }

    fun rdm_settled(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: u256, arg4: &0x2::accumulator::AccumulatorRoot, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg4, arg5);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg1, arg2);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_id(arg3);
        let v2 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::settle_close(&mut arg0.strike_exposure, &v1);
        if (v2 > 0) {
            0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::pay_out(&mut arg0.cash, v2), arg6));
        };
        chk_backed(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order_events::settled_rdm(id(arg0), 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(v0), 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::owner(v0), &v1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::remove_pos(v0, id(arg0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(&v1), arg6), v2, 0x2::clock::timestamp_ms(arg5));
    }

    public fun receipt_info(arg0: &OrderReceipt) : (0x2::object::ID, u8, 0x2::object::ID, u256, u32, u64, u64, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::VolSnapshot) {
        (arg0.expiry_market_id, arg0.stage, arg0.parties.account_id, arg0.order_id, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::pyth_source_id(&arg0.vol), arg0.cash_need, arg0.subsidy_bound, arg0.vol)
    }

    fun reconcile(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig) {
        if (0x1::option::is_none<ValuationStamp>(&arg0.valuation_stamp)) {
            return
        };
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::is_cur_flush(arg1, 0x1::option::borrow<ValuationStamp>(&arg0.valuation_stamp).flush_seq)) {
            arg0.valuation_stamp = 0x1::option::none<ValuationStamp>();
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::stop_snap(&mut arg0.strike_exposure);
        };
    }

    public(friend) fun recv_cash(arg0: &mut ExpiryMarket, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::receive(&mut arg0.cash, arg1);
        chk_backed(arg0);
    }

    public(friend) fun recv_incent(arg0: &mut ExpiryMarket, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_balance, arg1);
    }

    public fun redeem_builder_fee(arg0: &RedeemQuote) : u64 {
        arg0.builder_fee
    }

    public fun redeem_close_quantity(arg0: &RedeemQuote) : u64 {
        arg0.close_quantity
    }

    public fun redeem_inventory_impact_rebate(arg0: &RedeemQuote) : u64 {
        arg0.inventory_impact_rebate
    }

    public fun redeem_live(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg5: u256, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::accumulator::AccumulatorRoot, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<u256> {
        abort 13
    }

    public fun redeem_probability(arg0: &RedeemQuote) : u64 {
        arg0.probability
    }

    public fun redeem_proceeds(arg0: &RedeemQuote) : u64 {
        arg0.proceeds
    }

    public fun redeem_settled(arg0: &mut ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u256, arg5: &0x2::accumulator::AccumulatorRoot, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        chk_settled(arg0, arg3);
        rdm_settled(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
    }

    public fun redeem_settled_permissionless(arg0: &mut ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u256, arg5: &0x2::accumulator::AccumulatorRoot, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        chk_settled(arg0, arg3);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::is_keeper(arg3, 0x2::tx_context::sender(arg7)), 12);
        rdm_settled(arg0, arg2, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::generate_auth_as_app(arg1), arg4, arg5, arg6, arg7);
    }

    public fun redeem_trading_fee(arg0: &RedeemQuote) : u64 {
        arg0.trading_fee
    }

    public fun reference_tick(arg0: &ExpiryMarket) : 0x1::option::Option<u64> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::reference_tick(&arg0.strike_exposure)
    }

    public fun reference_tick_source_timestamp_ms(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::reference_tick_source_timestamp_ms(&arg0.strike_exposure)
    }

    fun refund_order(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: OrderReceipt, arg3: &mut 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u8, arg5: bool) : 0x1::option::Option<OrderReceipt> {
        if (arg4 == 1 || arg4 == 2) {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_no_snap(arg1);
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::receive(&mut arg0.cash, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2.order_fee));
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_balance, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2.subsidy_reserved));
        unwind(arg0, &arg2, arg5);
        reopen(arg2)
    }

    public fun release(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: OrderReceipt, arg3: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u8, arg5: bool) : (0x1::option::Option<OrderReceipt>, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_floor(arg1);
        assert!(arg2.expiry_market_id == id(arg0), 18);
        assert!(arg2.stage == 1 || arg2.stage == 3, 19);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) >= arg2.budget + arg2.order_fee + arg2.subsidy_reserved, 21);
        let v0 = &mut arg3;
        (refund_order(arg0, arg1, arg2, v0, arg4, arg5), arg3)
    }

    public(friend) fun release_cash(arg0: &mut ExpiryMarket, arg1: u64) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        if (arg1 == 0) {
            return 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        };
        chk_backed(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::free_surplus(&mut arg0.cash, arg1, payout_liability(arg0))
    }

    fun reopen(arg0: OrderReceipt) : 0x1::option::Option<OrderReceipt> {
        if (arg0.stage == 1) {
            drop_receipt(arg0);
            return 0x1::option::none<OrderReceipt>()
        };
        0x1::option::some<OrderReceipt>(to_open(arg0))
    }

    public fun set_mint_paused(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: bool) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        arg0.mint_paused = arg3;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::mkt_paused(id(arg0), arg3);
    }

    public fun set_reference_tick(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg4: &0x2::clock::Clock) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::reference_tick_source_timestamp_ms(&arg0.strike_exposure);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::exact_spot(arg2, arg3, arg0.propbook_underlying_id, v0);
        assert!(0x1::option::is_some<u64>(&v1), 5);
        let v2 = 0x1::option::destroy_some<u64>(v1);
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::grid_tick(v2, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::tick_size(&arg0.strike_exposure));
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::set_reference_tick(&mut arg0.strike_exposure, v3)) {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::ref_tick_set(id(arg0), arg0.propbook_underlying_id, v0, v2, v3, 0x2::clock::timestamp_ms(arg4));
        };
        v3
    }

    public fun settled_order_payout(arg0: &ExpiryMarket, arg1: u256) : u64 {
        assert!(is_settled(arg0), 1);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_id(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::settled_order_payout(&arg0.strike_exposure, &v0)
    }

    public fun settlement_price(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::settlement_price(&arg0.strike_exposure)
    }

    public(friend) fun snapshot_nav(arg0: &ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer) : u64 {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::thaw(arg1);
        chk_pricer(arg0, &v0);
        assert!(0x1::option::is_some<ValuationStamp>(&arg0.valuation_stamp), 10);
        let v1 = 0x1::option::borrow<ValuationStamp>(&arg0.valuation_stamp);
        0x1::u64::saturating_sub(0x1::u64::saturating_sub(v1.snapshot_cash, v1.snapshot_impact_reserve), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::frozen_liab(&arg0.strike_exposure, &v0, v1.flush_seq))
    }

    public(friend) fun stamp_val(arg0: &mut ExpiryMarket, arg1: u64) {
        let v0 = ValuationStamp{
            flush_seq               : arg1,
            snapshot_cash           : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::balance(&arg0.cash),
            snapshot_impact_reserve : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::inventory_impact_reserve(&arg0.cash),
        };
        arg0.valuation_stamp = 0x1::option::some<ValuationStamp>(v0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::start_snap(&mut arg0.strike_exposure, arg1);
    }

    public fun tick_size(arg0: &ExpiryMarket) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::tick_size(&arg0.strike_exposure)
    }

    fun to_open(arg0: OrderReceipt) : OrderReceipt {
        let OrderReceipt {
            expiry_market_id : v0,
            stage            : _,
            kind             : _,
            parties          : v3,
            lower_tick       : v4,
            higher_tick      : v5,
            quantity         : _,
            max_premium      : _,
            min_quantity     : _,
            max_probability  : _,
            min_probability  : _,
            min_proceeds     : _,
            tau_ms           : _,
            deadline_ms      : _,
            channel          : _,
            vol              : v15,
            budget           : _,
            order_fee        : _,
            cash_need        : _,
            subsidy_bound    : _,
            subsidy_rate     : _,
            subsidy_reserved : _,
            spot             : _,
            tick_ms          : _,
            generation_us    : _,
            order_id         : v25,
            root_id          : v26,
            opened_at_ms     : v27,
            held_quantity    : v28,
        } = arg0;
        let v29 = 0;
        OrderReceipt{
            expiry_market_id : v0,
            stage            : 2,
            kind             : (v29 as u8),
            parties          : v3,
            lower_tick       : v4,
            higher_tick      : v5,
            quantity         : v29,
            max_premium      : v29,
            min_quantity     : v29,
            max_probability  : v29,
            min_probability  : v29,
            min_proceeds     : v29,
            tau_ms           : v29,
            deadline_ms      : v29,
            channel          : (v29 as u8),
            vol              : v15,
            budget           : v29,
            order_fee        : v29,
            cash_need        : v29,
            subsidy_bound    : v29,
            subsidy_rate     : v29,
            subsidy_reserved : v29,
            spot             : v29,
            tick_ms          : v29,
            generation_us    : v29,
            order_id         : v25,
            root_id          : v26,
            opened_at_ms     : v27,
            held_quantity    : v28,
        }
    }

    public fun trading_fee(arg0: &MintQuote) : u64 {
        arg0.trading_fee
    }

    public fun try_fill<T0: drop>(arg0: T0, arg1: &mut ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: OrderReceipt, arg4: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::deny_list::DenyList, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (u8, 0x1::option::Option<OrderReceipt>, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, u64, u64, u64, u64, u64, u64, u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_flow<T0>(arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_no_snap(arg2);
        reconcile(arg1, arg2);
        assert!(arg3.expiry_market_id == id(arg1), 18);
        let v0 = arg3.stage == 1;
        assert!((v0 || arg3.stage == 3) && arg3.spot > 0, 19);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) >= arg3.budget + arg3.order_fee + arg3.subsidy_reserved, 21);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 5;
        if (v1 < arg3.deadline_ms) {
            v2 = 9;
            if (!denied(arg5, arg3.parties.receive_address, arg7)) {
                let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::pricer_at(&arg3.vol, arg3.spot, arg3.generation_us / 1000, arg3.tick_ms, id(arg1), arg1.expiry);
                v2 = 2;
                if (0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer>(&v3) && v0) {
                    let v4 = &mut arg3;
                    let v5 = &mut arg4;
                    let (v6, v7, v8) = fill_mint(arg1, arg2, v4, 0x1::option::borrow<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer>(&v3), v5, arg5, v1, arg7);
                    let v9 = v7;
                    if (v6 == 0) {
                        unwind(arg1, &arg3, false);
                        return (0, 0x1::option::some<OrderReceipt>(to_open(arg3)), arg4, v9.quantity, v9.all_in_cost, v9.trading_fee, v9.builder_fee, v8, v9.fee_incentive_subsidy, v9.inventory_impact_charge)
                    };
                    v2 = v6;
                } else if (0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer>(&v3)) {
                    let v10 = &mut arg3;
                    let v11 = &mut arg4;
                    let (v12, v13, v14) = fill_close(arg1, v10, 0x1::option::borrow<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer>(&v3), v11, arg5, v1, arg7);
                    let v15 = v14;
                    if (v12 == 0) {
                        unwind(arg1, &arg3, false);
                        let v16 = if (v13) {
                            0x1::option::some<OrderReceipt>(to_open(arg3))
                        } else {
                            drop_receipt(arg3);
                            0x1::option::none<OrderReceipt>()
                        };
                        return (0, v16, arg4, v15.close_quantity, v15.proceeds, v15.trading_fee, v15.builder_fee, 0, 0, v15.inventory_impact_rebate)
                    };
                    v2 = v12;
                };
            };
        };
        let v17 = &mut arg4;
        let v18 = 0;
        (v2, refund_order(arg1, arg2, arg3, v17, v2, true), arg4, v18, v18, v18, v18, v18, v18, v18)
    }

    public fun try_pay_settled(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: OrderReceipt, arg3: &0x2::deny_list::DenyList, arg4: &0x2::tx_context::TxContext) : (u64, 0x1::option::Option<OrderReceipt>) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_floor(arg1);
        assert!(arg2.expiry_market_id == id(arg0), 18);
        assert!(arg2.stage == 2, 19);
        assert!(is_settled(arg0), 1);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_id(arg2.order_id);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::settled_order_payout(&arg0.strike_exposure, &v0);
        let v2 = if (v1 > 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::balance(&arg0.cash)) {
            true
        } else if (v1 > 0 && denied(arg3, arg2.parties.receive_address, arg4)) {
            true
        } else {
            let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::try_settled(&mut arg0.strike_exposure, &v0);
            0x1::option::is_none<u64>(&v3)
        };
        if (v2) {
            return (v1, 0x1::option::some<OrderReceipt>(arg2))
        };
        if (v1 > 0) {
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::pay_out(&mut arg0.cash, v1), arg2.parties.receive_address);
        };
        drop_receipt(arg2);
        (v1, 0x1::option::none<OrderReceipt>())
    }

    public fun try_settle(arg0: &mut ExpiryMarket, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg5: &0x2::clock::Clock) : bool {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        reconcile(arg0, arg1);
        if (is_settled(arg0)) {
            return true
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        if (v0 < arg0.expiry) {
            return false
        };
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::exact_spot(arg2, arg3, arg0.propbook_underlying_id, arg0.expiry);
        let (v2, v3) = if (0x1::option::is_some<u64>(&v1)) {
            (0x1::option::destroy_some<u64>(v1), 0)
        } else {
            if (v0 - arg0.expiry < 30000) {
                return false
            };
            let v4 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::bs_spot_at(arg2, arg4, arg0.propbook_underlying_id, arg0.expiry);
            if (0x1::option::is_none<u64>(&v4)) {
                return false
            };
            (0x1::option::destroy_some<u64>(v4), 1)
        };
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::set_settled(&mut arg0.strike_exposure, v2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_cash::free_impact(&mut arg0.cash);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::mkt_settled(id(arg0), arg0.propbook_underlying_id, arg0.expiry, v2, v3, v0);
        true
    }

    public fun try_settlement_price(arg0: &ExpiryMarket) : 0x1::option::Option<u64> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::try_settlement_price(&arg0.strike_exposure)
    }

    fun unpin(arg0: &mut 0x2::vec_map::VecMap<u64, u64>, arg1: u64) {
        if (!0x2::vec_map::contains<u64, u64>(arg0, &arg1)) {
            return
        };
        let v0 = *0x2::vec_map::get<u64, u64>(arg0, &arg1);
        if (v0 > 1) {
            *0x2::vec_map::get_mut<u64, u64>(arg0, &arg1) = v0 - 1;
        } else {
            let (_, _) = 0x2::vec_map::remove<u64, u64>(arg0, &arg1);
        };
    }

    fun unwind(arg0: &mut ExpiryMarket, arg1: &OrderReceipt, arg2: bool) {
        let v0 = arg2 && !is_settled(arg0);
        let v1 = OrderFlowLedgerKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<OrderFlowLedgerKey, OrderFlowLedger>(&mut arg0.id, v1);
        v2.waiting_cash_need = v2.waiting_cash_need - arg1.cash_need;
        if (arg1.stage != 1) {
            return
        };
        let v3 = &mut v2.pins;
        unpin(v3, arg1.lower_tick);
        let v4 = &mut v2.pins;
        unpin(v4, arg1.higher_tick);
        if (v0) {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::prune_node(&mut arg0.strike_exposure, arg1.lower_tick, &v2.pins);
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure::prune_node(&mut arg0.strike_exposure, arg1.higher_tick, &v2.pins);
        };
    }

    public(friend) fun wait_need(arg0: &ExpiryMarket) : u64 {
        let v0 = OrderFlowLedgerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<OrderFlowLedgerKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = OrderFlowLedgerKey{dummy_field: false};
        0x2::dynamic_field::borrow<OrderFlowLedgerKey, OrderFlowLedger>(&arg0.id, v1).waiting_cash_need
    }

    // decompiled from Move bytecode v7
}

