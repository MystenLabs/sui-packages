module 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_request_router {
    struct RequestRouter has key {
        id: 0x2::object::UID,
        admin: address,
        offer_book: 0x2::object::ID,
        factory: 0x2::object::ID,
        settlement_engine: 0x2::object::ID,
    }

    public fun create_router(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RequestRouter{
            id                : 0x2::object::new(arg4),
            admin             : arg0,
            offer_book        : arg1,
            factory           : arg2,
            settlement_engine : arg3,
        };
        0x2::transfer::share_object<RequestRouter>(v0);
    }

    public fun get_admin(arg0: &RequestRouter) : address {
        arg0.admin
    }

    public fun get_factory(arg0: &RequestRouter) : 0x2::object::ID {
        arg0.factory
    }

    public fun get_offer_book(arg0: &RequestRouter) : 0x2::object::ID {
        arg0.offer_book
    }

    public fun get_settlement_engine(arg0: &RequestRouter) : 0x2::object::ID {
        arg0.settlement_engine
    }

    public fun route_full_request_bundle<T0, T1, T2: key>(arg0: &RequestRouter, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault_factory::LendingVaultFactory, arg3: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_settlement_engine::SettlementEngine, arg4: address, arg5: address, arg6: u8, arg7: u8, arg8: u64, arg9: vector<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: 0x1::option::Option<u64>, arg15: bool, arg16: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg17: 0x2::coin::TreasuryCap<T2>, arg18: &0x2::coin_registry::Currency<T2>, arg19: 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_share_metadata::ShareRegistrationProof, arg20: 0x2::coin::Coin<T1>, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook>(arg1) == arg0.offer_book, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault_factory::LendingVaultFactory>(arg2) == arg0.factory, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_settlement_engine::SettlementEngine>(arg3) == arg0.settlement_engine, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let v0 = 0x2::tx_context::sender(arg22);
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::create_request_with_window_and_coins(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg21, arg22);
        if (arg15) {
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::set_oracle(arg1, v0, v1, arg16, arg22);
        };
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault_factory::create_lending_vault_for_request<T0, T1, T2>(arg2, arg1, v1, arg17, arg18, arg19, arg21, arg22);
        let v2 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::new_collateral_vault_with_token<T1>(v1, v0, arg5, arg12, arg22);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_settlement_engine::pledge_collateral<T1>(arg3, arg1, &mut v2, v1, arg20, arg21, arg22);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::share<T1>(v2);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_router_request_routed(v1, v0, 0x2::clock::timestamp_ms(arg21));
        v1
    }

    public fun route_request_and_create_vault_with_coins<T0, T1, T2: key>(arg0: &RequestRouter, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault_factory::LendingVaultFactory, arg3: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_settlement_engine::SettlementEngine, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::coin::TreasuryCap<T2>, arg12: &0x2::coin_registry::Currency<T2>, arg13: 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_share_metadata::ShareRegistrationProof, arg14: 0x2::coin::Coin<T1>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook>(arg1) == arg0.offer_book, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault_factory::LendingVaultFactory>(arg2) == arg0.factory, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_settlement_engine::SettlementEngine>(arg3) == arg0.settlement_engine, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::token_decimals(arg1, arg4);
        let v2 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::token_decimals(arg1, arg5);
        assert!(0x1::option::is_some<u8>(&v1) && 0x1::option::is_some<u8>(&v2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::token_decimals_not_registered());
        let v3 = 0x1::vector::empty<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>();
        0x1::vector::push_back<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(&mut v3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::new_interest_rate_tier(0, arg7));
        let v4 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::create_request_with_window_and_coins(arg1, arg4, arg5, *0x1::option::borrow<u8>(&v1), *0x1::option::borrow<u8>(&v2), arg6, v3, arg8, arg9, arg10, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::collateral_policy_direct_claim(), 0x1::option::none<u64>(), arg15, arg16);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault_factory::create_lending_vault_for_request<T0, T1, T2>(arg2, arg1, v4, arg11, arg12, arg13, arg15, arg16);
        let v5 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::new_collateral_vault_with_token<T1>(v4, v0, arg5, arg10, arg16);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_settlement_engine::pledge_collateral<T1>(arg3, arg1, &mut v5, v4, arg14, arg15, arg16);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::share<T1>(v5);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_router_request_routed(v4, v0, 0x2::clock::timestamp_ms(arg15));
        v4
    }

    // decompiled from Move bytecode v7
}

