module 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_request_router {
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

    public fun route_request_and_create_vault_with_coins<T0, T1, T2: key>(arg0: &RequestRouter, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault_factory::LendingVaultFactory, arg3: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_settlement_engine::SettlementEngine, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::coin::TreasuryCap<T2>, arg12: 0x2::coin::Coin<T1>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook>(arg1) == arg0.offer_book, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault_factory::LendingVaultFactory>(arg2) == arg0.factory, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_settlement_engine::SettlementEngine>(arg3) == arg0.settlement_engine, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = 0x1::vector::empty<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>();
        0x1::vector::push_back<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(&mut v1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::new_interest_rate_tier(0, arg7));
        let v2 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::create_request_with_window_and_coins(arg1, arg4, arg5, arg6, v1, arg8, arg9, arg10, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::collateral_policy_direct_claim(), 0x1::option::none<u64>(), arg13, arg14);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault_factory::create_lending_vault_for_request<T0, T1, T2>(arg2, arg1, v2, arg11, arg13, arg14);
        let v3 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::new_collateral_vault_with_token<T1>(v2, v0, arg5, arg10, arg14);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_settlement_engine::pledge_collateral<T1>(arg3, arg1, &mut v3, v2, arg12, arg13, arg14);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::share<T1>(v3);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_router_request_routed(v2, v0, 0x2::clock::timestamp_ms(arg13));
        v2
    }

    // decompiled from Move bytecode v7
}

