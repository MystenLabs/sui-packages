module 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::stop_orders {
    struct StopOrderTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        executors: vector<address>,
        execution_domain: 0x1::option::Option<address>,
        gas: 0x2::balance::Balance<0x2::sui::SUI>,
        account_id: u64,
        stop_order_type: u64,
        encrypted_details: vector<u8>,
    }

    fun assert_stop_order_trigger_price_type(arg0: u8) {
        assert!(arg0 < 3, 6207);
    }

    fun assert_valid_ticket_executor<T0>(arg0: &StopOrderTicket<T0>, arg1: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::Executor) {
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::executor_sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.executors, &v0), 6204);
        assert!(arg0.execution_domain == 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::executor_domain(arg1), 6204);
    }

    public fun cancel<T0, T1>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::assert_order_ticket_exists<T0>(arg0, arg2);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::assert_is_admin_or_assistant<T1>();
        let StopOrderTicket {
            id                : v0,
            executors         : _,
            execution_domain  : _,
            gas               : v3,
            account_id        : v4,
            stop_order_type   : _,
            encrypted_details : _,
        } = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::remove_order_ticket<T0, StopOrderTicket<T0>>(arg0, arg2);
        let v7 = v0;
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_deleted_stop_order_ticket<T0>(0x2::object::uid_to_inner(&v7), v4, 0x2::tx_context::sender(arg3));
        0x2::object::delete(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg3)
    }

    public fun cancel_stop_order_ticket<T0>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg1: 0x2::object::ID, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::Executor, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::assert_order_ticket_exists<T0>(arg0, arg1);
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::remove_order_ticket<T0, StopOrderTicket<T0>>(arg0, arg1);
        assert_valid_ticket_executor<T0>(&v0, arg2);
        let StopOrderTicket {
            id                : v1,
            executors         : _,
            execution_domain  : _,
            gas               : v4,
            account_id        : v5,
            stop_order_type   : _,
            encrypted_details : _,
        } = v0;
        let v8 = v1;
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_deleted_stop_order_ticket<T0>(0x2::object::uid_to_inner(&v8), v5, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::executor_sender(arg2));
        0x2::object::delete(v8);
        0x2::coin::from_balance<0x2::sui::SUI>(v4, arg3)
    }

    public fun create_stop_order_ticket<T0, T1>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, T1>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: vector<address>, arg4: 0x1::option::Option<address>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_package_version(arg2);
        assert!(arg6 < 2, 6205);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::stop_order_mist_cost(arg2), 6203);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T0>(arg0);
        let v1 = StopOrderTicket<T0>{
            id                : 0x2::object::new(arg8),
            executors         : arg3,
            execution_domain  : arg4,
            gas               : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            account_id        : v0,
            stop_order_type   : arg6,
            encrypted_details : arg7,
        };
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_created_stop_order_ticket<T0>(0x2::object::uid_to_inner(&v1.id), v0, arg3, arg4, 0x2::coin::value<0x2::sui::SUI>(&arg5), arg6, v1.encrypted_details);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::add_order_ticket<T0, StopOrderTicket<T0>>(arg0, v1)
    }

    fun derive_stop_order_trigger_price<T0>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg1: u256, arg2: u256, arg3: u8, arg4: u64) : u256 {
        assert_stop_order_trigger_price_type(arg3);
        if (arg3 == 0) {
            return arg1
        };
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::orderbook::book_price_or_index(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::orderbook<T0>(arg0), arg1);
        if (arg3 == 1) {
            return v0
        };
        let v1 = 0x2::object::id<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>>(arg0);
        let (v2, v3) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::borrow_mut_market_objects<T0>(arg0);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::assert_index_twap_divergence_within_limit(v2, arg1, arg2);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::try_update_fundings_and_twaps(v2, v3, arg4, arg1, v0, &v1);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::calculate_mark_price(v3, v2, arg2, v0, arg4)
    }

    public fun edit_stop_order_ticket_details<T0, T1>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, T1>, arg2: 0x2::object::ID, arg3: vector<u8>) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::assert_order_ticket_exists<T0>(arg0, arg2);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::assert_is_admin_or_assistant<T1>();
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::borrow_mut_order_ticket<T0, StopOrderTicket<T0>>(arg0, arg2).encrypted_details = arg3;
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_edited_stop_order_ticket_details<T0>(arg2, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T0>(arg0), arg3);
    }

    public fun edit_stop_order_ticket_executors<T0, T1>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, T1>, arg2: 0x2::object::ID, arg3: vector<address>) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::assert_authority_cap_is_valid<T0, T1>(arg0, arg1);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::assert_order_ticket_exists<T0>(arg0, arg2);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::assert_is_admin_or_assistant<T1>();
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::borrow_mut_order_ticket<T0, StopOrderTicket<T0>>(arg0, arg2).executors = arg3;
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_edited_stop_order_ticket_executors<T0>(arg2, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T0>(arg0), arg3);
    }

    public fun place_stop_order_sltp<T0>(arg0: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock, arg4: 0x2::object::ID, arg5: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg6: 0x1::option::Option<u64>, arg7: bool, arg8: u8, arg9: 0x1::option::Option<u256>, arg10: 0x1::option::Option<u256>, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: 0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>, arg17: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::Executor, arg18: &mut 0x2::tx_context::TxContext) : (0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::assert_package_version<T0>(&arg0);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::assert_market_is_not_paused<T0>(&arg0);
        assert!(0x2::tx_context::gas_price(arg18) == 0x2::tx_context::reference_gas_price(arg18), 6210);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::assert_order_ticket_exists<T0>(arg5, arg4);
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::remove_order_ticket<T0, StopOrderTicket<T0>>(arg5, arg4);
        assert_valid_ticket_executor<T0>(&v0, arg17);
        let StopOrderTicket {
            id                : v1,
            executors         : _,
            execution_domain  : _,
            gas               : v4,
            account_id        : v5,
            stop_order_type   : v6,
            encrypted_details : v7,
        } = v0;
        let v8 = v1;
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_executed_stop_order_ticket<T0>(0x2::object::uid_to_inner(&v8), v5, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::executor_sender(arg17));
        0x2::object::delete(v8);
        let v9 = v7;
        assert!(v6 == 0, 6208);
        assert_stop_order_trigger_price_type(arg8);
        let v10 = b"";
        let v11 = 0x2::object::id<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>>(&arg0);
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<0x2::object::ID>(&v11));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<0x1::option::Option<u64>>(&arg6));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<bool>(&arg7));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u8>(&arg8));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<0x1::option::Option<u256>>(&arg9));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<0x1::option::Option<u256>>(&arg10));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<bool>(&arg11));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u64>(&arg12));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u64>(&arg13));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u64>(&arg14));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>>(&arg16));
        0x1::vector::append<u8>(&mut v10, arg15);
        assert!(0x2::hash::blake2b256(&v10) == v9, 6202);
        let v12 = 0x2::clock::timestamp_ms(arg3);
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(v12 < *0x1::option::borrow<u64>(&arg6), 6200);
        };
        let (v13, v14) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::base_oracle_price_and_twap_price(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_params<T0>(&arg0), arg1, arg3);
        let v15 = &mut arg0;
        let v16 = derive_stop_order_trigger_price<T0>(v15, v13, v14, arg8, v12);
        let v17 = if (0x1::option::is_some<u256>(&arg9)) {
            let v18 = 0x1::option::borrow<u256>(&arg9);
            arg11 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v16, *v18) || !arg11 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v16, *v18)
        } else {
            false
        };
        let v19 = if (0x1::option::is_some<u256>(&arg10)) {
            let v20 = 0x1::option::borrow<u256>(&arg10);
            arg11 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v16, *v20) || !arg11 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v16, *v20)
        } else {
            false
        };
        assert!(v17 || v19, 6201);
        let (v21, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::position<T0>(&arg0, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T0>(arg5)));
        assert!(v21 != 0 && arg11 == 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v21), 6206);
        let v23 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::start_session_<T0>(arg0, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T0>(arg5), arg1, arg2, false, arg16, arg3);
        if (arg7) {
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::place_limit_order<T0>(&mut v23, !arg11, 0x1::u64::min(arg12, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v21), 1000000000)), arg13, arg14, 0x1::option::none<u64>(), true, arg6);
        } else {
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::place_market_order<T0>(&mut v23, !arg11, 0x1::u64::min(arg12, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v21), 1000000000)), false);
        };
        let v24 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::summary<T0>(&v23);
        let v25 = if (0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::base_filled_ask(v24) != 0) {
            true
        } else if (0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::base_filled_bid(v24) != 0) {
            true
        } else {
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::posted_orders(v24) != 0
        };
        assert!(v25, 6209);
        let (v26, v27) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::end_session_<T0>(v23, arg5, false, true, false);
        (v27, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg18), v26)
    }

    public fun place_stop_order_standalone<T0>(arg0: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock, arg4: 0x2::object::ID, arg5: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg6: 0x1::option::Option<u64>, arg7: bool, arg8: u8, arg9: u256, arg10: bool, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: vector<u8>, arg17: 0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>, arg18: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::Executor, arg19: &mut 0x2::tx_context::TxContext) : (0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::assert_package_version<T0>(&arg0);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::assert_market_is_not_paused<T0>(&arg0);
        assert!(0x2::tx_context::gas_price(arg19) == 0x2::tx_context::reference_gas_price(arg19), 6210);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::assert_order_ticket_exists<T0>(arg5, arg4);
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::remove_order_ticket<T0, StopOrderTicket<T0>>(arg5, arg4);
        assert_valid_ticket_executor<T0>(&v0, arg18);
        let StopOrderTicket {
            id                : v1,
            executors         : _,
            execution_domain  : _,
            gas               : v4,
            account_id        : v5,
            stop_order_type   : v6,
            encrypted_details : v7,
        } = v0;
        let v8 = v1;
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_executed_stop_order_ticket<T0>(0x2::object::uid_to_inner(&v8), v5, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::executor_sender(arg18));
        0x2::object::delete(v8);
        let v9 = v7;
        assert!(v6 == 1, 6208);
        assert_stop_order_trigger_price_type(arg8);
        let v10 = b"";
        let v11 = 0x2::object::id<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>>(&arg0);
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<0x2::object::ID>(&v11));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<0x1::option::Option<u64>>(&arg6));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<bool>(&arg7));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u8>(&arg8));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u256>(&arg9));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<bool>(&arg10));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<bool>(&arg11));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u64>(&arg12));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u64>(&arg13));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<u64>(&arg14));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<bool>(&arg15));
        0x1::vector::append<u8>(&mut v10, 0x2::bcs::to_bytes<0x1::option::Option<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>>(&arg17));
        0x1::vector::append<u8>(&mut v10, arg16);
        assert!(0x2::hash::blake2b256(&v10) == v9, 6202);
        let v12 = 0x2::clock::timestamp_ms(arg3);
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(v12 < *0x1::option::borrow<u64>(&arg6), 6200);
        };
        let (v13, v14) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::base_oracle_price_and_twap_price(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_params<T0>(&arg0), arg1, arg3);
        let v15 = &mut arg0;
        let v16 = derive_stop_order_trigger_price<T0>(v15, v13, v14, arg8, v12);
        assert!(arg10 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v16, arg9) || !arg10 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v16, arg9), 6201);
        let v17 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::start_session_<T0>(arg0, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T0>(arg5), arg1, arg2, false, arg17, arg3);
        if (arg7) {
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::place_limit_order<T0>(&mut v17, arg11, arg12, arg13, arg14, 0x1::option::none<u64>(), arg15, arg6);
        } else {
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::place_market_order<T0>(&mut v17, arg11, arg12, arg15);
        };
        let v18 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::summary<T0>(&v17);
        let v19 = if (0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::base_filled_ask(v18) != 0) {
            true
        } else if (0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::base_filled_bid(v18) != 0) {
            true
        } else {
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::posted_orders(v18) != 0
        };
        assert!(v19, 6209);
        let (v20, v21) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::end_session_<T0>(v17, arg5, !arg15, true, false);
        (v21, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg19), v20)
    }

    // decompiled from Move bytecode v7
}

