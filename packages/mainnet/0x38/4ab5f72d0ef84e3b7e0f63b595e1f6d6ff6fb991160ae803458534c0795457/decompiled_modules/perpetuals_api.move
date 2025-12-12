module 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::perpetuals_api {
    public(friend) fun cancel_orders<T0, T1>(arg0: &0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &vector<u128>) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::cancel_orders<T1>(arg1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg2);
    }

    public(friend) fun create_market_position<T0, T1>(arg0: &0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0);
        if (!0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::exists_position<T1>(arg1, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(v0))) {
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::create_market_position<T1>(arg1, v0);
        };
    }

    public(friend) fun create_stop_order_ticket<T0, T1>(arg0: &mut 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::registry::Registry, arg2: vector<address>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::create_stop_order_ticket<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::add_stop_order_ticket_dof<T0, T1>(arg0, v0);
        0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::stop_orders::StopOrderTicket<T1>>(&v0)
    }

    public(friend) fun delete_stop_order_ticket<T0, T1>(arg0: &mut 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::delete_stop_order_ticket<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::remove_stop_order_ticket_dof<T0, T1>(arg0, arg1), arg2)
    }

    public(friend) fun edit_stop_order_ticket_details<T0, T1>(arg0: &mut 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: 0x2::object::ID, arg2: vector<u8>) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::remove_stop_order_ticket_dof<T0, T1>(arg0, arg1);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::edit_stop_order_ticket_details<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), &mut v0, arg2);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::add_stop_order_ticket_dof<T0, T1>(arg0, v0);
    }

    public(friend) fun edit_stop_order_ticket_executors<T0, T1>(arg0: &mut 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: 0x2::object::ID, arg2: vector<address>) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::remove_stop_order_ticket_dof<T0, T1>(arg0, arg1);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::edit_stop_order_ticket_executors<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), &mut v0, arg2);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::add_stop_order_ticket_dof<T0, T1>(arg0, v0);
    }

    public(friend) fun liquidate<T0, T1>(arg0: &0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg2: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg5: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg6: &0x2::clock::Clock, arg7: u64, arg8: &vector<u128>, arg9: &0x2::tx_context::TxContext) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::start_session<T1>(arg2, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg3, arg4, arg5, arg6, arg9);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::liquidate<T1>(&mut v0, arg7, arg8);
        let (v1, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::end_session<T1>(v0, arg1, false, 0x1::option::none<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::IntegratorInfo>());
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::share_clearing_house<T1>(v1);
    }

    public(friend) fun place_limit_order<T0, T1>(arg0: &0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg2: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg5: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg6: &0x2::clock::Clock, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: 0x1::option::Option<u64>, arg13: &0x2::tx_context::TxContext) : 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1> {
        assert!(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_pending_orders_counter(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_position<T1>(&arg2, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0)))) < 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::max_pending_orders_per_position<T0, T1>(arg0), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::max_pending_orders_exceeded());
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::start_session<T1>(arg2, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg3, arg4, arg5, arg6, arg13);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::place_limit_order<T1>(&mut v0, arg7, arg8, arg9, arg10, arg11, arg12);
        let (v1, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::end_session<T1>(v0, arg1, false, 0x1::option::none<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::IntegratorInfo>());
        v1
    }

    public(friend) fun place_market_order<T0, T1>(arg0: &0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg2: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg5: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg6: &0x2::clock::Clock, arg7: bool, arg8: u64, arg9: bool, arg10: &0x2::tx_context::TxContext) : 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1> {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::start_session<T1>(arg2, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg3, arg4, arg5, arg6, arg10);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::place_market_order<T1>(&mut v0, arg7, arg8, arg9);
        let (v1, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::end_session<T1>(v0, arg1, false, 0x1::option::none<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::IntegratorInfo>());
        v1
    }

    public(friend) fun place_stop_order_sltp<T0, T1>(arg0: &mut 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg8: 0x1::option::Option<u64>, arg9: bool, arg10: 0x1::option::Option<u256>, arg11: 0x1::option::Option<u256>, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: 0x1::option::Option<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::IntegratorInfo>, arg18: &mut 0x2::tx_context::TxContext) : (0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>) {
        let v0 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0);
        if (!0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::exists_position<T1>(&arg1, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(v0))) {
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::create_market_position<T1>(&mut arg1, v0);
        };
        let (v1, v2, v3) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::place_stop_order_sltp<T1>(arg1, arg2, arg3, arg4, arg5, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::remove_stop_order_ticket_dof<T0, T1>(arg0, arg6), arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v4 = v3;
        let v5 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_collateral_value<T1>(arg7);
        if (v5 != 0) {
            0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::add_collateral_to_vault<T0, T1>(arg0, 0x2::coin::into_balance<T1>(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::withdraw_collateral<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg7, v5, arg18)));
        };
        let v6 = 0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>>(&v4);
        let v7 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_position<T1>(&v4, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0)));
        let (v8, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_amounts(v7);
        let v10 = if (0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::abs(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_collateral(v7)), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_scaling_factor(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&v4))) == 0) {
            if (v8 == 0) {
                0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_pending_orders_counter(v7) == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v10) {
            let v11 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids<T0, T1>(arg0);
            let (v12, v13) = 0x1::vector::index_of<0x2::object::ID>(&v11, &v6);
            assert!(v12, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::clearing_house_id_not_found());
            0x1::vector::remove<0x2::object::ID>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids_mut<T0, T1>(arg0), v13);
        };
        (v1, v2, v4)
    }

    public(friend) fun place_stop_order_standalone<T0, T1>(arg0: &mut 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg8: 0x1::option::Option<u64>, arg9: bool, arg10: u256, arg11: bool, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: vector<u8>, arg18: 0x1::option::Option<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::IntegratorInfo>, arg19: &mut 0x2::tx_context::TxContext) : (0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>) {
        let v0 = 0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>>(&arg1);
        let v1 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids<T0, T1>(arg0);
        if (!0x1::vector::contains<0x2::object::ID>(&v1, &v0)) {
            let v2 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids<T0, T1>(arg0);
            assert!(0x1::vector::length<0x2::object::ID>(&v2) < 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::max_markets_in_vault<T0, T1>(arg0), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::max_markets_exceeded());
            0x1::vector::push_back<0x2::object::ID>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids_mut<T0, T1>(arg0), v0);
        };
        if (!arg16) {
            if (0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::collateral_balance<T0, T1>(arg0) != 0) {
                0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::deposit_collateral<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg7, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::available_balance_coin<T0, T1>(arg0, arg19));
            };
        };
        let (v3, v4, v5) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::place_stop_order_standalone<T1>(arg1, arg2, arg3, arg4, arg5, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::remove_stop_order_ticket_dof<T0, T1>(arg0, arg6), arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        let v6 = v5;
        let v7 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_collateral_value<T1>(arg7);
        if (v7 != 0) {
            0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::add_collateral_to_vault<T0, T1>(arg0, 0x2::coin::into_balance<T1>(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::withdraw_collateral<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg7, v7, arg19)));
        };
        let v8 = 0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>>(&v6);
        let v9 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_position<T1>(&v6, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0)));
        let (v10, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_amounts(v9);
        let v12 = if (0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::abs(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_collateral(v9)), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_scaling_factor(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&v6))) == 0) {
            if (v10 == 0) {
                0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_pending_orders_counter(v9) == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v12) {
            let v13 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids<T0, T1>(arg0);
            let (v14, v15) = 0x1::vector::index_of<0x2::object::ID>(&v13, &v8);
            assert!(v14, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::clearing_house_id_not_found());
            0x1::vector::remove<0x2::object::ID>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids_mut<T0, T1>(arg0), v15);
        };
        (v3, v4, v6)
    }

    public(friend) fun set_position_initial_margin_ratio<T0, T1>(arg0: &0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: u256) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::set_position_initial_margin_ratio<T1>(arg1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg2);
    }

    public(friend) fun deposit_into_perpetuals<T0, T1>(arg0: &mut 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(arg3 <= 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::collateral_balance<T0, T1>(arg0), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::not_enough_collateral_balance());
        let v0 = 0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>>(arg2);
        let v1 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids<T0, T1>(arg0);
        if (!0x1::vector::contains<0x2::object::ID>(&v1, &v0)) {
            let v2 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids<T0, T1>(arg0);
            assert!(0x1::vector::length<0x2::object::ID>(&v2) < 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::max_markets_in_vault<T0, T1>(arg0), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::max_markets_exceeded());
            0x1::vector::push_back<0x2::object::ID>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids_mut<T0, T1>(arg0), v0);
            let v3 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0);
            if (!0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::exists_position<T1>(arg2, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(v3))) {
                0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::create_market_position<T1>(arg2, v3);
            };
        };
        let v4 = 0x2::balance::split<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::collateral_balance_mut<T0, T1>(arg0), arg3);
        let v5 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::deposit_collateral<T1>(v5, arg1, 0x2::coin::from_balance<T1>(v4, arg4));
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::allocate_collateral<T1>(arg2, v5, arg1, 0x2::balance::value<T1>(&v4));
    }

    public(friend) fun end_perpetuals_session<T0, T1>(arg0: &mut 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg2: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionHotPotato<T1>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1> {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0)) == 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_account_id_in_session<T1>(&arg2), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::wrong_vault_for_session());
        let v0 = if (arg3) {
            let v1 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::collateral_balance<T0, T1>(arg0);
            if (v1 != 0) {
                0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::deposit_collateral<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::available_balance_coin<T0, T1>(arg0, arg4));
            };
            v1
        } else {
            0
        };
        let (v2, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::end_session<T1>(arg2, arg1, arg3, 0x1::option::none<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::IntegratorInfo>());
        let v4 = v2;
        if (arg3) {
            let v5 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_collateral_value<T1>(arg1);
            if (v5 != v0) {
                let v6 = 0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>>(&v4);
                let v7 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids<T0, T1>(arg0);
                if (!0x1::vector::contains<0x2::object::ID>(&v7, &v6)) {
                    let v8 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids<T0, T1>(arg0);
                    assert!(0x1::vector::length<0x2::object::ID>(&v8) < 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::max_markets_in_vault<T0, T1>(arg0), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::max_markets_exceeded());
                    0x1::vector::push_back<0x2::object::ID>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids_mut<T0, T1>(arg0), v6);
                };
            };
            if (v5 != 0) {
                0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::add_collateral_to_vault<T0, T1>(arg0, 0x2::coin::into_balance<T1>(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::withdraw_collateral<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg1, v5, arg4)));
            };
        };
        v4
    }

    public(friend) fun liquidate_session<T0, T1>(arg0: &0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionHotPotato<T1>, arg2: u64, arg3: &vector<u128>) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0)) == 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_account_id_in_session<T1>(arg1), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::wrong_vault_for_session());
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::liquidate<T1>(arg1, arg2, arg3);
    }

    public(friend) fun place_limit_order_session<T0, T1>(arg0: &0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionHotPotato<T1>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: 0x1::option::Option<u64>) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0)) == 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_account_id_in_session<T1>(arg1), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::wrong_vault_for_session());
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::place_limit_order<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun place_market_order_session<T0, T1>(arg0: &0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionHotPotato<T1>, arg2: bool, arg3: u64, arg4: bool) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0)) == 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_account_id_in_session<T1>(arg1), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::wrong_vault_for_session());
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::place_market_order<T1>(arg1, arg2, arg3, arg4);
    }

    public(friend) fun start_perpetuals_session<T0, T1>(arg0: &0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionHotPotato<T1> {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::start_session<T1>(arg1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun withdraw_from_perpetuals<T0, T1>(arg0: &mut 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::Vault<T0, T1>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg5: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg6: &0x2::clock::Clock, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::account_cap<T0, T1>(arg0);
        if (0x1::option::is_some<u64>(&arg7)) {
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::deallocate_collateral<T1>(arg2, v0, arg1, arg3, arg4, arg5, arg6, 0x1::option::destroy_some<u64>(arg7));
        } else {
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::deallocate_free_collateral<T1>(arg2, v0, arg1, arg3, arg4, arg5, arg6);
        };
        let v1 = 0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>>(arg2);
        let v2 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_position<T1>(arg2, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(v0));
        let v3 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_collateral_value<T1>(arg1);
        if (v3 != 0) {
            let v4 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::withdraw_collateral<T1>(v0, arg1, v3, arg8);
            0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::add_collateral_to_vault<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v4));
        };
        let (v5, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_amounts(v2);
        let v7 = if (0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::abs(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_collateral(v2)), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_scaling_factor(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(arg2))) == 0) {
            if (v5 == 0) {
                0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_pending_orders_counter(v2) == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v7) {
            let v8 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids<T0, T1>(arg0);
            let (v9, v10) = 0x1::vector::index_of<0x2::object::ID>(&v8, &v1);
            assert!(v9, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::clearing_house_id_not_found());
            0x1::vector::remove<0x2::object::ID>(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault::ch_ids_mut<T0, T1>(arg0), v10);
        };
    }

    // decompiled from Move bytecode v6
}

