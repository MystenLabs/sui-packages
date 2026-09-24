module 0x7deffb0e17c6d09424d0ca2c35d3ed57a334255721a0fbe52988c8520a54cca2::volume_guard {
    struct GuardedMint has copy, drop {
        expiry_market_id: 0x2::object::ID,
        order_id: u256,
        lower_tick: u64,
        higher_tick: u64,
        quantity: u64,
        entry_probability: u64,
        premium: u64,
        trading_fee: u64,
        fee_incentive_subsidy: u64,
        net_fee: u64,
        all_in_cost: u64,
        min_probability: u64,
        max_probability: u64,
        max_net_fee: u64,
        max_all_in_cost: u64,
    }

    public fun assert_quote_within_limits(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::MintQuote, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        check_limits(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::quantity(arg0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::entry_probability(arg0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::premium(arg0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::all_in_cost(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun check_limits(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        assert!(arg5 <= arg6, 6);
        assert!(arg0 == arg4, 5);
        assert!(arg1 >= arg5, 1);
        assert!(arg1 <= arg6, 2);
        assert!(arg3 <= arg8, 4);
        assert!(arg3 >= arg2 && arg3 - arg2 <= arg7, 3);
    }

    public fun guarded_mint_exact_quantity(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::accumulator::AccumulatorRoot, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::quote_mint_for_account(arg0, arg1, arg2, arg3, arg4, arg5, 0, arg6, true, arg11, arg12, arg13);
        assert_quote_within_limits(&v0, arg6, arg7, arg8, arg9, arg10);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::mint_exact_quantity(arg0, arg1, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth(arg13), arg2, arg3, arg4, arg5, arg6, arg10, arg8, arg11, arg12, arg13);
        let v2 = GuardedMint{
            expiry_market_id      : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::id(arg0),
            order_id              : v1,
            lower_tick            : arg4,
            higher_tick           : arg5,
            quantity              : arg6,
            entry_probability     : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::entry_probability(&v0),
            premium               : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::premium(&v0),
            trading_fee           : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::trading_fee(&v0),
            fee_incentive_subsidy : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::fee_incentive_subsidy(&v0),
            net_fee               : net_fee(&v0),
            all_in_cost           : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::all_in_cost(&v0),
            min_probability       : arg7,
            max_probability       : arg8,
            max_net_fee           : arg9,
            max_all_in_cost       : arg10,
        };
        0x2::event::emit<GuardedMint>(v2);
        v1
    }

    public fun net_fee(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::MintQuote) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::all_in_cost(arg0) - 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::premium(arg0)
    }

    // decompiled from Move bytecode v7
}

