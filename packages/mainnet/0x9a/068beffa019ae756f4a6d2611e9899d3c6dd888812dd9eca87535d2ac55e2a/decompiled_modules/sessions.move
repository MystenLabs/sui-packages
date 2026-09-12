module 0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::sessions {
    struct SessionsApp has drop {
        dummy_field: bool,
    }

    struct SessionsData has store {
        sessions: 0x2::vec_map::VecMap<address, u64>,
    }

    struct SessionAuthorized has copy, drop {
        account_id: 0x2::object::ID,
        session: address,
        expires_at_ms: u64,
    }

    struct SessionRevoked has copy, drop {
        account_id: 0x2::object::ID,
        session: address,
        expires_at_ms: u64,
    }

    public fun mint_exact_amount(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::accumulator::AccumulatorRoot, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u256 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::mint_exact_amount(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg12, arg13), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun mint_exact_quantity(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::accumulator::AccumulatorRoot, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u256 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::mint_exact_quantity(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg12, arg13), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun redeem_live(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg6: u256, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::accumulator::AccumulatorRoot, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<u256> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::redeem_live(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg11, arg12), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun redeem_settled(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg5: u256, arg6: &0x2::accumulator::AccumulatorRoot, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::redeem_settled(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg7, arg8), arg4, arg5, arg6, arg7, arg8);
    }

    public fun authorize_session(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::assert_version(arg1);
        assert!(arg3 > 0 && arg3 <= 2592000000, 0);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg3;
        let v1 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg0, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth(arg5));
        if (!0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::has_data<SessionsApp>(v1)) {
            let v2 = SessionsData{sessions: 0x2::vec_map::empty<address, u64>()};
            0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::attach<SessionsApp, SessionsData>(v1, 0x1::internal::permit<SessionsApp>(), v2);
        };
        let v3 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data_mut<SessionsApp, SessionsData>(v1, 0x1::internal::permit<SessionsApp>());
        if (0x2::vec_map::contains<address, u64>(&v3.sessions, &arg2)) {
            *0x2::vec_map::get_mut<address, u64>(&mut v3.sessions, &arg2) = v0;
        } else {
            assert!(0x2::vec_map::length<address, u64>(&v3.sessions) < 20, 2);
            0x2::vec_map::insert<address, u64>(&mut v3.sessions, arg2, v0);
        };
        let v4 = SessionAuthorized{
            account_id    : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(v1),
            session       : arg2,
            expires_at_ms : v0,
        };
        0x2::event::emit<SessionAuthorized>(v4);
    }

    public fun cancel_live_order<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::deepbook_core_account::cancel_live_order<T0, T1>(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg5, arg6), arg4, arg5, arg6);
    }

    public fun cancel_live_orders<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: vector<u128>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::deepbook_core_account::cancel_live_orders<T0, T1>(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg5, arg6), arg4, arg5, arg6);
    }

    fun generate_auth_as_session(arg0: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth {
        0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::assert_version(arg0);
        let v0 = session_expiration_ms(arg2, 0x2::tx_context::sender(arg4));
        assert!(0x1::option::is_some<u64>(&v0), 1);
        assert!(0x2::clock::timestamp_ms(arg3) < *0x1::option::borrow<u64>(&v0), 1);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::generate_auth_as_app<SessionsApp>(arg1, 0x1::internal::permit<SessionsApp>())
    }

    public fun place_limit_order<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: u64, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: u64, arg13: &0x2::accumulator::AccumulatorRoot, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::deepbook_core_account::place_limit_order<T0, T1>(arg0, arg1, arg3, generate_auth_as_session(arg4, arg2, arg3, arg14, arg15), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    public fun place_market_order<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: &0x2::accumulator::AccumulatorRoot, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::deepbook_core_account::place_market_order<T0, T1>(arg0, arg1, arg3, generate_auth_as_session(arg4, arg2, arg3, arg12, arg13), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun revoke_session(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg0, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth(arg2));
        if (!0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::has_data<SessionsApp>(v0)) {
            return
        };
        let v1 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data_mut<SessionsApp, SessionsData>(v0, 0x1::internal::permit<SessionsApp>());
        if (!0x2::vec_map::contains<address, u64>(&v1.sessions, &arg1)) {
            return
        };
        let (_, v3) = 0x2::vec_map::remove<address, u64>(&mut v1.sessions, &arg1);
        let v4 = SessionRevoked{
            account_id    : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(v0),
            session       : arg1,
            expires_at_ms : v3,
        };
        0x2::event::emit<SessionRevoked>(v4);
    }

    public fun session_expiration_ms(arg0: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: address) : 0x1::option::Option<u64> {
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg0);
        if (!0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::has_data<SessionsApp>(v0)) {
            return 0x1::option::none<u64>()
        };
        0x2::vec_map::try_get<address, u64>(&0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data<SessionsApp, SessionsData>(v0).sessions, &arg1)
    }

    public fun withdraw_settled_amounts<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::deepbook_core_account::withdraw_settled_amounts<T0, T1>(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg4, arg5), arg5);
    }

    // decompiled from Move bytecode v7
}

