module 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        total_borrow: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        borrow_index: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ProtocolApp, arg1: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::ObligationOwnerCap, arg2: &mut 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::Market<T0>, arg3: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x660203619d4bdf97f39224f2555d0a3796d3525c1cfd1f4415704d3e061b2d54::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ensure_version_matches(arg0);
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::validate_market<T0>(arg0, arg2);
        assert!(!0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::has_circuit_break_triggered<T0>(arg2), 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let (v1, v2, v3) = 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::handle_borrow<T0, T1>(arg2, 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::id(arg1), arg4, arg3, arg5, arg6, v0);
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::borrow_liquidity_mining_mut<T0>(arg2), 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::liquidity_miner::get_borrow_reward_type(), 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::id(arg1), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(v3), arg6);
        let v4 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg7),
            market       : 0x1::type_name::with_defining_ids<T0>(),
            obligation   : 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::obligation::id(arg1),
            asset        : 0x1::type_name::with_defining_ids<T1>(),
            amount       : arg4,
            total_borrow : v3,
            borrow_index : v2,
            time         : v0,
        };
        0x2::event::emit<BorrowEvent>(v4);
        0x2::coin::from_balance<T1>(v1, arg7)
    }

    // decompiled from Move bytecode v6
}

