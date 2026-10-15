module 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue {
    struct MarketQueue has key {
        id: 0x2::object::UID,
        desk_id: 0x2::object::ID,
        expiry_market_id: 0x2::object::ID,
        book: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderBook,
        payouts_completed: bool,
    }

    public fun id(arg0: &MarketQueue) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun commit(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = &arg4;
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, channel_of(0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update>(v0, v2)));
            v2 = v2 + 1;
        };
        let v3 = &arg4;
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update>(v3)) {
            0x1::vector::push_back<u64>(&mut v4, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update>(v3, v5)));
            v5 = v5 + 1;
        };
        let v6 = 0x2::clock::timestamp_ms(arg5);
        let (v7, v8) = match_cohorts(arg0, arg1, arg2, &v1, &v4, v6);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v10)) {
            let v12 = *0x1::vector::borrow<u64>(&v10, v11);
            let v13 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::cohort(&arg0.book, v12);
            let v14 = vector[];
            let v15 = 0x1::vector::empty<0x1::option::Option<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>>();
            let v16 = true;
            let v17 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_first_id(&v13);
            while (v16 && v17 < 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_end_id(&v13)) {
                let v18 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::pending_feed(&arg0.book, v17);
                if (0x1::option::is_some<u32>(&v18)) {
                    let v19 = 0x1::option::destroy_some<u32>(v18);
                    let v20 = &v14;
                    let v21 = 0;
                    let v22;
                    while (v21 < 0x1::vector::length<u32>(v20)) {
                        if (*0x1::vector::borrow<u32>(v20, v21) == v19) {
                            v22 = 0x1::option::some<u64>(v21);
                            /* label 23 */
                            if (0x1::option::is_none<u64>(&v22)) {
                                0x1::vector::push_back<u32>(&mut v14, v19);
                                0x1::vector::push_back<0x1::option::Option<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>>(&mut v15, 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::from_update(0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update>(&arg4, *0x1::vector::borrow<u64>(&v9, v11)), v19));
                                0x1::option::fill<u64>(&mut v22, 0x1::vector::length<u32>(&v14) - 1);
                            };
                            v16 = price_fits(0x1::vector::borrow<0x1::option::Option<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>>(&v15, 0x1::option::destroy_some<u64>(v22)), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_tau_ms(&v13), v6);
                            /* label 26 */
                            v17 = v17 + 1;
                            /* goto 12 */
                            continue
                        };
                        v21 = v21 + 1;
                    };
                    v22 = 0x1::option::none<u64>();
                    /* goto 23 */
                } else {
                    0x1::option::destroy_none<u32>(v18);
                    /* goto 26 */
                };
            };
            if (v16 && !0x1::vector::is_empty<u32>(&v14)) {
                commit_cohort(arg0, arg1, arg3, v12, &v14, &v15, arg5, 0x2::tx_context::sender(arg6));
            };
            v11 = v11 + 1;
        };
    }

    public fun admin_refund(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg5: vector<u64>, arg6: &0x2::deny_list::DenyList, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_bound(arg0, arg3, arg1);
        0x1::vector::reverse<u64>(&mut arg5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg5)) {
            release_record(arg0, arg1, arg4, 0x1::vector::pop_back<u64>(&mut arg5), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::reason_admin(), true, true, arg6, arg8, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg7));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg5);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::advance_heads(&mut arg0.book);
    }

    fun assert_bound(arg0: &MarketQueue, arg1: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket) {
        assert_desk(arg0, arg1);
        assert!(arg0.expiry_market_id == 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::id(arg2), 1);
    }

    fun assert_desk(arg0: &MarketQueue, arg1: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk) {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::assert_version(arg1);
        assert!(arg0.desk_id == 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::id(arg1), 0);
    }

    fun assert_open(arg0: &MarketQueue, arg1: u64) {
        let v0 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::view(&arg0.book, arg1);
        assert!(0x1::option::is_some<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(&v0) && 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status(0x1::option::borrow<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(&v0)) == 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status_open(), 9);
    }

    fun begin_enqueue(arg0: &MarketQueue, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::DelayedExecutionPolicy, arg5: bool, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock) : 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderTiming {
        assert_bound(arg0, arg2, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = &arg0.book;
        assert!(!0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::is_stuck(v1, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::stuck_threshold_ms(arg4), v0), 2);
        let (v2, v3) = if (arg5) {
            (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::pending_mints(v1), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::mint_capacity(arg4))
        } else {
            (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::pending_sells(v1), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::sell_capacity(arg4))
        };
        assert!(v2 < v3, 3);
        assert!(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::account_waiting(v1, arg6) < 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::per_account_cap(arg4), 4);
        let v4 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::plan_timing(v1, arg4, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::expiry(arg1), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::no_trade_window_ms(arg3), v0);
        assert!(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::tau_ms(&v4) < 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::cutoff_ms(&v4), 5);
        v4
    }

    fun cash_figures(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket) : (u64, u64, u64) {
        let (v0, _, _) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::order_flow_state(arg0);
        (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::cash_balance(arg0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::required_cash(arg0), v0)
    }

    fun channel_of(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update) : u8 {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::channel(arg0);
        if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::is_fixed_rate_50ms(&v0)) {
            2
        } else if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::is_fixed_rate_200ms(&v0)) {
            3
        } else {
            1
        }
    }

    public fun claim_parked(arg0: &mut MarketQueue, arg1: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg2: u64, arg3: &0x2::deny_list::DenyList, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        assert_desk(arg0, arg1);
        let v0 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::view(&arg0.book, arg2);
        if (0x1::option::is_none<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(&v0)) {
            return 0
        };
        let v1 = 0x1::option::destroy_some<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(v0);
        let v2 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::receive_address(&v1);
        let v3 = if (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::is_unfinished(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status(&v1))) {
            true
        } else if (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::funds(&v1) == 0) {
            true
        } else {
            denied(arg3, v2, arg5)
        };
        if (v3) {
            return 0
        };
        let v4 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::take_parked(&mut arg0.book, arg2);
        let v5 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4);
        0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, v2);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_record_funds_claimed(arg0.expiry_market_id, arg2, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::account_id(&v1), v2, v5, 0x2::clock::timestamp_ms(arg4));
        v5
    }

    public fun cleanup(arg0: &mut MarketQueue, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg3: vector<u64>, arg4: &0x2::clock::Clock) {
        assert_bound(arg0, arg2, arg1);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::is_settled(arg1), 11);
        let v0 = &mut arg0.book;
        let v1 = vector[];
        0x1::vector::reverse<u64>(&mut arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg3)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg3);
            if (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::remove_finished_record(v0, v3)) {
                0x1::vector::push_back<u64>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg3);
        if (0x1::vector::is_empty<u64>(&v1)) {
            return
        };
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_queued_orders_cleaned(arg0.expiry_market_id, v1, 0x2::clock::timestamp_ms(arg4));
    }

    fun commit_cohort(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: u64, arg4: &vector<u32>, arg5: &vector<0x1::option::Option<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>>, arg6: &0x2::clock::Clock, arg7: address) {
        let v0 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::cohort(&arg0.book, arg3);
        let v1 = 0x1::option::none<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>();
        let v2 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_first_id(&v0);
        while (v2 < 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_end_id(&v0)) {
            let v3 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::pending_feed(&arg0.book, v2);
            if (0x1::option::is_some<u32>(&v3)) {
                let v4 = 0;
                let v5;
                while (v4 < 0x1::vector::length<u32>(arg4)) {
                    if (*0x1::vector::borrow<u32>(arg4, v4) == 0x1::option::destroy_some<u32>(v3)) {
                        v5 = 0x1::option::some<u64>(v4);
                        /* label 8 */
                        let v6 = *0x1::option::borrow<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>(0x1::vector::borrow<0x1::option::Option<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>>(arg5, 0x1::option::destroy_some<u64>(v5)));
                        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::commit_order(&mut arg0.book, v2, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::new_committed_price(0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::spot(&v6), 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::envelope_us(&v6) / 1000, 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::generation_us(&v6)), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_flow::commit(arg1, arg2, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::receipt_mut(&mut arg0.book, v2), &v6, arg6));
                        if (0x1::option::is_none<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>(&v1)) {
                            0x1::option::fill<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>(&mut v1, v6);
                        };
                        /* label 10 */
                        v2 = v2 + 1;
                        /* goto 1 */
                        continue
                    };
                    v4 = v4 + 1;
                };
                v5 = 0x1::option::none<u64>();
                /* goto 8 */
            } else {
                0x1::option::destroy_none<u32>(v3);
                /* goto 10 */
            };
        };
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::mark_cohort_committed(&mut arg0.book, arg3);
        let v7 = 0x1::option::destroy_some<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>(v1);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_cohort_committed(arg0.expiry_market_id, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_tau_ms(&v0), 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::envelope_us(&v7) / 1000, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_first_id(&v0), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_end_id(&v0) - 1, 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::spot(&v7), 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::generation_us(&v7), 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::feed_id(&v7), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_pyth_channel(&v0), arg7, 0x2::clock::timestamp_ms(arg6));
    }

    public fun create_and_share(arg0: &mut 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::QueueRegistry, arg1: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::assert_version(arg1);
        let v0 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::id(arg1);
        assert!(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::registry_desk_id(arg0) == v0, 0);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::id(arg2);
        let v2 = MarketQueue{
            id                : 0x2::derived_object::claim<0x2::object::ID>(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::registry_uid_mut(arg0), v1),
            desk_id           : v0,
            expiry_market_id  : v1,
            book              : 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::new_book(arg3),
            payouts_completed : false,
        };
        0x2::transfer::share_object<MarketQueue>(v2);
        id(&v2)
    }

    fun denied(arg0: &0x2::deny_list::DenyList, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::coin::deny_list_v2_contains_current_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2) || 0x2::coin::deny_list_v2_is_global_pause_enabled_current_epoch<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg2)
    }

    public fun desk_id(arg0: &MarketQueue) : 0x2::object::ID {
        arg0.desk_id
    }

    public fun enqueue_exact_amount(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg4: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::accumulator::AccumulatorRoot, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        enqueue_mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::kind_exact_amount(), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::new_request(arg10, arg11, 0, arg12, arg13, arg14, 0, 0, 0), arg15, arg16, arg17)
    }

    public fun enqueue_exact_cost(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg4: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::accumulator::AccumulatorRoot, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        enqueue_mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::kind_exact_cost(), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::new_request(arg10, arg11, 0, 0, arg13, arg12, 0, 0, 0), arg14, arg15, arg16)
    }

    public fun enqueue_exact_quantity(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg4: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::accumulator::AccumulatorRoot, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        enqueue_mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::kind_exact_quantity(), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::new_request(arg10, arg11, arg12, 0, 0, arg13, arg14, 0, 0), arg15, arg16, arg17)
    }

    fun enqueue_mint(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg4: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg10: u8, arg11: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderRequest, arg12: &0x2::accumulator::AccumulatorRoot, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = *0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::policy_ref(arg4);
        let v1 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg2));
        let v2 = begin_enqueue(arg0, arg1, arg4, arg5, &v0, true, v1, arg13);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg12, arg13);
        let v3 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg2, arg3);
        let v4 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::max_cost(&arg11);
        assert!(v4 > 0 && v4 != 18446744073709551615, 6);
        let v5 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::order_fee(&v0);
        let v6 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v3, arg12, arg13);
        assert!(v6 > v5, 7);
        let v7 = if (arg10 == 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::kind_exact_quantity()) {
            0x1::u64::min(0x1::u64::min(v4, v6 - v5), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::quantity(&arg11))
        } else {
            0x1::u64::min(v4, v6 - v5)
        };
        place(arg0, arg1, arg10, arg11, v1, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::receive_address(v3), v2, v7, v5, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::empty_position(), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_flow::admit_mint(arg1, arg5, v3, arg6, arg7, arg8, arg9, arg10, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::lower_tick(&arg11), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::higher_tick(&arg11), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::quantity(&arg11), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::max_premium(&arg11), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::min_quantity(&arg11), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::max_probability(&arg11), v7, v5, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::svi_max_age_ms(&v0), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::pyth_channel(&v2), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::tau_ms(&v2), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::deadline_ms(&v2), arg13, arg14), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v3, v7 + v5, arg14)), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(v3), 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::referrer_account_id(v3), 0x1::option::none<u64>(), arg13)
    }

    public fun enqueue_redeem_open(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg4: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::accumulator::AccumulatorRoot, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = *0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::policy_ref(arg4);
        let v1 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg2));
        let v2 = begin_enqueue(arg0, arg1, arg4, arg5, &v0, false, v1, arg15);
        assert_open(arg0, arg10);
        let v3 = 0x1::option::destroy_some<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::view(&arg0.book, arg10));
        assert!(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::account_id(&v3) == v1, 10);
        let v4 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::position(&v3);
        let (v5, v6, v7) = 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::order_terms(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::order_id(&v4));
        let v8 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::min_sell_quantity(&v0);
        assert!(arg11 >= v8, 8);
        assert!(arg11 >= v7 || v7 - arg11 >= v8, 8);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg14, arg15);
        let v9 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg2, arg3);
        let v10 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::order_fee(&v0);
        assert!(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9, arg14, arg15) >= v10, 7);
        let (v11, v12) = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::close_open_record(&mut arg0.book, arg10);
        let v13 = v11;
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_flow::admit_sell(arg1, arg5, v9, &mut v13, arg6, arg7, arg8, arg9, arg11, arg12, arg13, v10, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::svi_max_age_ms(&v0), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::pyth_channel(&v2), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::tau_ms(&v2), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::deadline_ms(&v2), arg15, arg16);
        let v14 = if (v10 > 0) {
            0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9, v10, arg16))
        } else {
            0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        };
        place(arg0, arg1, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::kind_redeem_open(), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::new_request(v5, v6, arg11, 0, 0, 0, 0, arg12, arg13), v1, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::receive_address(v9), v2, 0, v10, v12, v13, v14, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(v9), 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::referrer_account_id(v9), 0x1::option::some<u64>(arg10), arg15)
    }

    public fun expiry_market_id(arg0: &MarketQueue) : 0x2::object::ID {
        arg0.expiry_market_id
    }

    fun fee_returned(arg0: u8, arg1: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView) : u64 {
        if (arg0 == 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::reason_limits() || arg0 == 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::reason_admission()) {
            0
        } else {
            let v1 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::escrow(arg1);
            0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::order_fee(&v1)
        }
    }

    fun fill_record(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: u64, arg4: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView, arg5: &0x2::deny_list::DenyList, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext, arg8: address, arg9: u64) {
        let (v0, v1) = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::take_order(&mut arg0.book, arg3);
        let (v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_flow::try_fill(arg1, arg2, v0, v1, arg5, arg6, arg7);
        let v12 = v4;
        let v13 = v3;
        send_or_park(arg0, arg3, arg4, v12, arg5, arg7, arg9);
        if (v2 != 0) {
            let v14 = fee_returned(v2, arg4);
            finish_refund(arg0, arg1, arg3, arg4, v13, v2, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v12) - v14, v14, true, arg8, arg9);
            return
        };
        let v15 = if (0x1::option::is_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&v13)) {
            0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::empty_position()
        } else {
            let (_, _, _, v19, _, _, _, _) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::receipt_info(0x1::option::borrow<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&v13));
            if (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::is_mint(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::kind(arg4))) {
                let v24 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::price(arg4);
                0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::new_held_position(v19, v19, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::tick_ms(&v24))
            } else {
                let v25 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::position(arg4);
                0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::new_held_position(v19, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::root_id(&v25), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::opened_at_ms(&v25))
            }
        };
        let v26 = if (0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&v13)) {
            0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status_open()
        } else {
            0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status_closed()
        };
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::finish_order(&mut arg0.book, arg3, v26, v13, v15, 0, v5, v6, true, arg9);
        let (v27, v28, v29) = cash_figures(arg1);
        let v30 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::escrow(arg4);
        let v31 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::timing(arg4);
        let v32 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::price(arg4);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_queued_order_filled(v27, v28, v29, arg0.expiry_market_id, arg3, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::account_id(arg4), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::kind(arg4), v5, v6, v7, v8, v9, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::order_fee(&v30), v10, v11, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::tau_ms(&v31), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::tick_ms(&v32), v15, arg8, arg9);
    }

    fun find_update(arg0: &vector<u8>, arg1: &vector<u64>, arg2: u8, arg3: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg2 && *0x1::vector::borrow<u64>(arg1, v0) == arg3 * 1000) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun finish_refund(arg0: &mut MarketQueue, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: u64, arg3: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView, arg4: 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: address, arg10: u64) {
        let v0 = 0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&arg4);
        let v1 = if (v0) {
            0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status_open()
        } else {
            0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status_refunded()
        };
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::finish_order(&mut arg0.book, arg2, v1, arg4, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::position(arg3), arg5, 0, 0, arg8, arg10);
        let (v2, v3, v4) = cash_figures(arg1);
        let v5 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::escrow(arg3);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_queued_order_refunded(v2, v3, v4, arg0.expiry_market_id, arg2, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::account_id(arg3), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::kind(arg3), arg5, arg6, arg7, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::subsidy_reserved(&v5), v0, arg9, arg10);
    }

    fun match_cohorts(arg0: &MarketQueue, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg3: &vector<u8>, arg4: &vector<u64>, arg5: u64) : (vector<u64>, vector<u64>) {
        assert_bound(arg0, arg2, arg1);
        let v0 = vector[];
        let v1 = vector[];
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::is_settled(arg1)) {
            return (v0, v1)
        };
        let v2 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::policy_ref(arg2);
        let v3 = &arg0.book;
        let v4 = 0;
        while (v4 < 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::cohort_count(v3)) {
            let v5 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::cohort(v3, v4);
            let v6 = if (!0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_committed(&v5)) {
                if (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_unfinished(&v5) > 0) {
                    arg5 < 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_deadline_ms(&v5)
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                let v7 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_tau_ms(&v5);
                let v8 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_pyth_channel(&v5);
                let v9 = find_update(arg3, arg4, v8, v7);
                let v10 = if (0x1::option::is_none<u64>(&v9)) {
                    if (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::pyth_price_buffer_ms(v2) > 0) {
                        arg5 >= v7 + 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::gap_wait_ms(v2)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v10) {
                    v9 = find_update(arg3, arg4, v8, v7 + 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::channel_tick_ms(v8));
                };
                let v11 = v9;
                if (0x1::option::is_some<u64>(&v11)) {
                    0x1::vector::push_back<u64>(&mut v0, v4);
                    0x1::vector::push_back<u64>(&mut v1, 0x1::option::destroy_some<u64>(v11));
                } else {
                    0x1::option::destroy_none<u64>(v11);
                };
            };
            v4 = v4 + 1;
        };
        (v0, v1)
    }

    public fun oldest_unfinished_tau_ms(arg0: &MarketQueue) : 0x1::option::Option<u64> {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::oldest_unfinished_tau(&arg0.book)
    }

    public fun order(arg0: &MarketQueue, arg1: u64) : 0x1::option::Option<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView> {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::view(&arg0.book, arg1)
    }

    public fun pay_open(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u64, arg5: &0x2::deny_list::DenyList, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_bound(arg0, arg2, arg1);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::is_settled(arg1), 11);
        pay_open_record(arg0, arg1, arg3, arg4, arg5, arg7, 0x2::clock::timestamp_ms(arg6));
    }

    fun pay_open_record(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: u64, arg4: &0x2::deny_list::DenyList, arg5: &0x2::tx_context::TxContext, arg6: u64) {
        let v0 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::view(&arg0.book, arg3);
        if (0x1::option::is_none<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(&v0) || 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status(0x1::option::borrow<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(&v0)) != 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status_open()) {
            return
        };
        let v1 = 0x1::option::destroy_some<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(v0);
        let v2 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::position(&v1);
        let (v3, v4) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::try_pay_settled(arg1, arg2, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::take_open_receipt(&mut arg0.book, arg3), arg4, arg5);
        let v5 = v4;
        if (0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&v5)) {
            0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::restore_receipt(&mut arg0.book, arg3, 0x1::option::destroy_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(v5));
            0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_open_record_payout_skipped(arg0.expiry_market_id, arg3, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::account_id(&v1), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::order_id(&v2), v3, arg6);
            return
        };
        0x1::option::destroy_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(v5);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::finish_payout(&mut arg0.book, arg3);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_open_record_settled(arg0.expiry_market_id, arg3, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::account_id(&v1), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::order_id(&v2), v3, arg6);
    }

    public fun payout_progress(arg0: &MarketQueue) : (u64, u64, bool) {
        (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::payout_cursor(&arg0.book), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::next_id(&arg0.book), arg0.payouts_completed)
    }

    public fun pending_counts(arg0: &MarketQueue) : (u64, u64) {
        (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::pending_mints(&arg0.book), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::pending_sells(&arg0.book))
    }

    public fun phase_done() : u8 {
        2
    }

    public fun phase_drain() : u8 {
        0
    }

    public fun phase_pay() : u8 {
        1
    }

    fun place(arg0: &mut MarketQueue, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: u8, arg3: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderRequest, arg4: 0x2::object::ID, arg5: address, arg6: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderTiming, arg7: u64, arg8: u64, arg9: 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::HeldPosition, arg10: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt, arg11: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg12: 0x1::option::Option<0x2::object::ID>, arg13: 0x1::option::Option<0x2::object::ID>, arg14: 0x1::option::Option<u64>, arg15: &0x2::clock::Clock) : u64 {
        let (_, _, _, _, _, v5, v6, v7) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::receipt_info(&arg10);
        let v8 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::append(&mut arg0.book, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::new_order(arg2, arg3, arg4, arg5, arg6, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::new_escrow(arg7, arg8, v6, v5), arg9, arg10, arg11));
        let (v9, v10, v11) = cash_figures(arg1);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_order_enqueued(arg0.expiry_market_id, v8, arg4, arg2, arg3, arg9, arg6, v7, arg7, arg8, v5, v6, arg12, arg13, arg14, v9, v10, v11, 0x2::clock::timestamp_ms(arg15));
        v8
    }

    fun price_fits(arg0: &0x1::option::Option<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>, arg1: u64, arg2: u64) : bool {
        if (0x1::option::is_none<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>(arg0)) {
            return false
        };
        let v0 = 0x1::option::borrow<0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::LazerPrice>(arg0);
        0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::generation_us(v0) >= arg1 * 1000 && 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price::envelope_us(v0) <= arg2 * 1000
    }

    public fun queue_heads(arg0: &MarketQueue) : (u64, u64, u64, u64) {
        let v0 = &arg0.book;
        (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::resolve_head(v0), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::next_id(v0), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::last_tau_ms(v0), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::last_committed_tau_ms(v0))
    }

    public fun queue_id(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : 0x2::object::ID {
        0x2::object::id_from_address(0x2::derived_object::derive_address<0x2::object::ID>(arg0, arg1))
    }

    public fun queue_stuck(arg0: &MarketQueue, arg1: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg2: &0x2::clock::Clock) : bool {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::is_stuck(&arg0.book, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::stuck_threshold_ms(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::policy_ref(arg1)), 0x2::clock::timestamp_ms(arg2))
    }

    public fun quote_redeem_open(arg0: &MarketQueue, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::RedeemQuote {
        assert!(arg0.expiry_market_id == 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::id(arg1), 1);
        assert_open(arg0, arg4);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::quote_close(arg1, arg3, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::receipt(&arg0.book, arg4), arg5, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::builder_code_id(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg2)), arg6)
    }

    public fun refund(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u64, arg5: &0x2::deny_list::DenyList, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : u64 {
        assert_bound(arg0, arg2, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        refund_walk(arg0, arg1, arg3, v0, 0x1::u64::min(arg4, 450), true, true, arg5, arg7, v0)
    }

    fun refund_walk(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: &0x2::deny_list::DenyList, arg8: &0x2::tx_context::TxContext, arg9: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::cohort_count(&arg0.book) && v0 < arg4) {
            let v3 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::cohort(&arg0.book, v2);
            if (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_deadline_ms(&v3) > arg3) {
                break
            };
            let v4 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_first_id(&v3);
            let v5 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_unfinished(&v3);
            let v6 = v4;
            loop {
                let v7 = if (v6 < 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_end_id(&v3)) {
                    if (v5 > 0) {
                        v0 < arg4
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v7) {
                    v0 = v0 + 1;
                    if (release_record(arg0, arg1, arg2, v6, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::reason_deadline(), arg5, arg6, arg7, arg8, 0x2::tx_context::sender(arg8), arg9)) {
                        v1 = v1 + 1;
                        v5 = v5 - 1;
                    };
                    v6 = v6 + 1;
                } else {
                    break
                };
            };
            if (v5 > 0 && v6 > v4) {
                0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::set_cohort_first_id(&mut arg0.book, v2, v6);
            };
            v2 = v2 + 1;
        };
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::advance_heads(&mut arg0.book);
        v1
    }

    fun release_record(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: u64, arg4: u8, arg5: bool, arg6: bool, arg7: &0x2::deny_list::DenyList, arg8: &0x2::tx_context::TxContext, arg9: address, arg10: u64) : bool {
        let v0 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::view(&arg0.book, arg3);
        if (0x1::option::is_none<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(&v0)) {
            return false
        };
        let v1 = 0x1::option::destroy_some<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(v0);
        let v2 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status(&v1);
        if (!0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::is_unfinished(v2)) {
            return false
        };
        let v3 = if (v2 == 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status_refund_due()) {
            let v4 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::result(&v1);
            0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::reason(&v4)
        } else {
            arg4
        };
        let (v5, v6) = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::take_order(&mut arg0.book, arg3);
        let (v7, v8) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::release(arg1, arg2, v5, v6, v3, arg5);
        let v9 = v8;
        send_or_park(arg0, arg3, &v1, v9, arg7, arg8, arg10);
        let v10 = fee_returned(v3, &v1);
        finish_refund(arg0, arg1, arg3, &v1, v7, v3, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v9) - v10, v10, arg6, arg9, arg10);
        true
    }

    public fun resolve(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u64, arg5: &0x2::deny_list::DenyList, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : u64 {
        assert_bound(arg0, arg2, arg1);
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::is_settled(arg1)) {
            return 0
        };
        let v0 = 0x1::u64::min(arg4, 450);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::cohort_count(&arg0.book) && v2 < v0) {
            let v5 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::cohort(&arg0.book, v4);
            let v6 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_unfinished(&v5);
            let v7 = v6;
            if (v6 > 0 && (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_committed(&v5) || v1 >= 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_deadline_ms(&v5))) {
                let v8 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_end_id(&v5);
                let v9 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::span_first_id(&v5);
                loop {
                    let v10 = if (v7 > 0) {
                        if (v9 < v8) {
                            v2 < v0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v10) {
                        v2 = v2 + 1;
                        if (resolve_record(arg0, arg1, arg3, v9, arg5, arg6, arg7, 0x2::tx_context::sender(arg7), v1)) {
                            v3 = v3 + 1;
                            v7 = v7 - 1;
                        };
                        v9 = v9 + 1;
                    } else {
                        break
                    };
                };
                if (v7 > 0 && v9 < v8) {
                    0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::set_cohort_first_id(&mut arg0.book, v4, v9);
                };
            };
            v4 = v4 + 1;
        };
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::advance_heads(&mut arg0.book);
        v3
    }

    fun resolve_record(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: u64, arg4: &0x2::deny_list::DenyList, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext, arg7: address, arg8: u64) : bool {
        let v0 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::view(&arg0.book, arg3);
        if (0x1::option::is_none<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(&v0)) {
            return false
        };
        let v1 = 0x1::option::destroy_some<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(v0);
        let v2 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status(&v1);
        let v3 = if (v2 == 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status_refund_due()) {
            true
        } else if (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::is_unfinished(v2)) {
            let v4 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::timing(&v1);
            arg8 >= 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::deadline_ms(&v4)
        } else {
            false
        };
        if (v3) {
            return release_record(arg0, arg1, arg2, arg3, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::reason_deadline(), true, true, arg4, arg6, arg7, arg8)
        };
        if (v2 != 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::status_committed()) {
            return false
        };
        fill_record(arg0, arg1, arg2, arg3, &v1, arg4, arg5, arg6, arg7, arg8);
        true
    }

    fun send_or_park(arg0: &mut MarketQueue, arg1: u64, arg2: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView, arg3: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::deny_list::DenyList, arg5: &0x2::tx_context::TxContext, arg6: u64) {
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
            return
        };
        let v1 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::receive_address(arg2);
        if (!denied(arg4, v1, arg5)) {
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v1);
            return
        };
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::park_funds(&mut arg0.book, arg1, arg3);
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_record_funds_parked(arg0.expiry_market_id, arg1, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::account_id(arg2), v1, v0, arg6);
    }

    public fun settle_step(arg0: &mut MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0x2::deny_list::DenyList, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : u8 {
        assert_bound(arg0, arg2, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::expiry(arg1), 12);
        if (arg0.payouts_completed) {
            return 2
        };
        let v1 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::policy_ref(arg2);
        let v2 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::oldest_unfinished_tau(&arg0.book);
        if (0x1::option::is_some<u64>(&v2)) {
            refund_walk(arg0, arg1, arg3, 18446744073709551615, 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::settle_refund_batch(v1), false, false, arg4, arg6, v0);
            let v3 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::oldest_unfinished_tau(&arg0.book);
            return if (0x1::option::is_some<u64>(&v3)) {
                0
            } else {
                1
            }
        };
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::is_settled(arg1)) {
            return 1
        };
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::settle_queue(&mut arg0.book);
        let v5 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::payout_cursor(&arg0.book);
        let v6 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::next_id(&arg0.book);
        let v7 = v5 + 0x1::u64::min(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::settle_payout_batch(v1), v6 - v5);
        while (v5 < v7) {
            pay_open_record(arg0, arg1, arg3, v5, arg4, arg6, v0);
            v5 = v5 + 1;
        };
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::set_payout_cursor(&mut arg0.book, v7);
        if (v7 < v6) {
            return 1
        };
        arg0.payouts_completed = true;
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue_events::emit_market_payouts_completed(arg0.expiry_market_id, v0);
        2
    }

    public fun waiting_cohorts(arg0: &MarketQueue) : (u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        let v0 = &arg0.book;
        (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::cohort_count(v0), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::oldest_uncommitted_tau(v0), 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::oldest_uncommitted_tau_above_committed(v0))
    }

    public fun waiting_orders(arg0: &MarketQueue, arg1: 0x2::object::ID) : u64 {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::account_waiting(&arg0.book, arg1)
    }

    // decompiled from Move bytecode v7
}

