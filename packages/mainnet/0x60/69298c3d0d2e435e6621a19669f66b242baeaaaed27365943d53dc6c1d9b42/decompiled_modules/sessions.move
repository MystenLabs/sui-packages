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

    struct SessionBuildersApp has drop {
        dummy_field: bool,
    }

    struct SessionBuilders has store {
        approvals: 0x2::vec_map::VecMap<address, SessionBuilder>,
    }

    struct SessionBuilder has copy, drop, store {
        code_id: 0x2::object::ID,
        max_fee_per_contract: u64,
    }

    struct SessionBuilderApproved has copy, drop {
        account_id: 0x2::object::ID,
        session: address,
        code_id: 0x2::object::ID,
        max_fee_per_contract: u64,
    }

    struct SessionBuilderCleared has copy, drop {
        account_id: 0x2::object::ID,
        session: address,
    }

    public fun enqueue_exact_amount(arg0: &mut 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg6: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg10: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::accumulator::AccumulatorRoot, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : u64 {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::enqueue_exact_amount(arg0, arg1, arg3, generate_auth_as_session(arg4, arg2, arg3, arg17, arg18), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    }

    public fun enqueue_exact_amount_with_builder(arg0: &mut 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg6: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg10: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg11: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::BuilderCode, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &0x2::accumulator::AccumulatorRoot, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : u64 {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::enqueue_exact_amount_with_builder(arg0, arg1, arg3, session_auth_with_builder(arg4, arg2, arg3, arg11, arg12, arg19, arg20), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20)
    }

    public fun enqueue_exact_cost(arg0: &mut 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg6: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg10: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::accumulator::AccumulatorRoot, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::enqueue_exact_cost(arg0, arg1, arg3, generate_auth_as_session(arg4, arg2, arg3, arg16, arg17), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
    }

    public fun enqueue_exact_cost_with_builder(arg0: &mut 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg6: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg10: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg11: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::BuilderCode, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::accumulator::AccumulatorRoot, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : u64 {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::enqueue_exact_cost_with_builder(arg0, arg1, arg3, session_auth_with_builder(arg4, arg2, arg3, arg11, arg12, arg18, arg19), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    }

    public fun enqueue_exact_quantity(arg0: &mut 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg6: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg10: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::accumulator::AccumulatorRoot, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : u64 {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::enqueue_exact_quantity(arg0, arg1, arg3, generate_auth_as_session(arg4, arg2, arg3, arg17, arg18), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    }

    public fun enqueue_exact_quantity_with_builder(arg0: &mut 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg6: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg10: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg11: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::BuilderCode, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &0x2::accumulator::AccumulatorRoot, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : u64 {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::enqueue_exact_quantity_with_builder(arg0, arg1, arg3, session_auth_with_builder(arg4, arg2, arg3, arg11, arg12, arg19, arg20), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20)
    }

    public fun enqueue_redeem_open(arg0: &mut 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg6: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg10: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::accumulator::AccumulatorRoot, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::enqueue_redeem_open(arg0, arg1, arg3, generate_auth_as_session(arg4, arg2, arg3, arg16, arg17), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
    }

    public fun enqueue_redeem_open_with_builder(arg0: &mut 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg6: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg10: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg11: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::BuilderCode, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::accumulator::AccumulatorRoot, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : u64 {
        0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::enqueue_redeem_open_with_builder(arg0, arg1, arg3, session_auth_with_builder(arg4, arg2, arg3, arg11, arg12, arg18, arg19), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    }

    public fun mint_exact_amount(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::accumulator::AccumulatorRoot, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u256 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::mint_exact_amount(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg12, arg13), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun mint_exact_cost(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::accumulator::AccumulatorRoot, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u256 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::mint_exact_cost(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg11, arg12), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
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

    public fun approve_session_builder(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::assert_version(arg1);
        assert!(0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::version_watermark(arg1) >= 4, 5);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg0, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth(arg5));
        assert!(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::has_data<SessionsApp>(v0) && 0x2::vec_map::contains<address, u64>(&0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data<SessionsApp, SessionsData>(v0).sessions, &arg2), 1);
        if (!0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::has_data<SessionBuildersApp>(v0)) {
            let v1 = SessionBuilders{approvals: 0x2::vec_map::empty<address, SessionBuilder>()};
            0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::attach<SessionBuildersApp, SessionBuilders>(v0, 0x1::internal::permit<SessionBuildersApp>(), v1);
        };
        let v2 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data_mut<SessionBuildersApp, SessionBuilders>(v0, 0x1::internal::permit<SessionBuildersApp>());
        let v3 = SessionBuilder{
            code_id              : arg3,
            max_fee_per_contract : arg4,
        };
        if (0x2::vec_map::contains<address, SessionBuilder>(&v2.approvals, &arg2)) {
            *0x2::vec_map::get_mut<address, SessionBuilder>(&mut v2.approvals, &arg2) = v3;
        } else {
            0x2::vec_map::insert<address, SessionBuilder>(&mut v2.approvals, arg2, v3);
        };
        let v4 = SessionBuilderApproved{
            account_id           : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(v0),
            session              : arg2,
            code_id              : arg3,
            max_fee_per_contract : arg4,
        };
        0x2::event::emit<SessionBuilderApproved>(v4);
    }

    public fun approved_code_id(arg0: &SessionBuilder) : 0x2::object::ID {
        arg0.code_id
    }

    public fun approved_max_fee_per_contract(arg0: &SessionBuilder) : u64 {
        arg0.max_fee_per_contract
    }

    public fun authorize_session(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::assert_version(arg1);
        assert!(arg3 > 0 && arg3 <= 2592000000, 0);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg3;
        let v1 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg0, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth(arg5));
        let v2 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(v1);
        if (!0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::has_data<SessionsApp>(v1)) {
            let v3 = SessionsData{sessions: 0x2::vec_map::empty<address, u64>()};
            0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::attach<SessionsApp, SessionsData>(v1, 0x1::internal::permit<SessionsApp>(), v3);
        };
        let v4 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data_mut<SessionsApp, SessionsData>(v1, 0x1::internal::permit<SessionsApp>());
        let v5 = !0x2::vec_map::contains<address, u64>(&v4.sessions, &arg2);
        if (v5) {
            assert!(0x2::vec_map::length<address, u64>(&v4.sessions) < 20, 2);
            0x2::vec_map::insert<address, u64>(&mut v4.sessions, arg2, v0);
        } else {
            *0x2::vec_map::get_mut<address, u64>(&mut v4.sessions, &arg2) = v0;
        };
        if (v5) {
            clear_builder(v1, v2, arg2);
        };
        let v6 = SessionAuthorized{
            account_id    : v2,
            session       : arg2,
            expires_at_ms : v0,
        };
        0x2::event::emit<SessionAuthorized>(v6);
    }

    public fun cancel_live_order<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::deepbook_core_account::cancel_live_order<T0, T1>(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg5, arg6), arg4, arg5, arg6);
    }

    public fun cancel_live_orders<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg4: vector<u128>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::deepbook_core_account::cancel_live_orders<T0, T1>(arg0, arg2, generate_auth_as_session(arg3, arg1, arg2, arg5, arg6), arg4, arg5, arg6);
    }

    fun clear_builder(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg1: 0x2::object::ID, arg2: address) {
        if (!0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::has_data<SessionBuildersApp>(arg0)) {
            return
        };
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data_mut<SessionBuildersApp, SessionBuilders>(arg0, 0x1::internal::permit<SessionBuildersApp>());
        if (!0x2::vec_map::contains<address, SessionBuilder>(&v0.approvals, &arg2)) {
            return
        };
        let (_, _) = 0x2::vec_map::remove<address, SessionBuilder>(&mut v0.approvals, &arg2);
        let v3 = SessionBuilderCleared{
            account_id : arg1,
            session    : arg2,
        };
        0x2::event::emit<SessionBuilderCleared>(v3);
    }

    fun generate_auth_as_session(arg0: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth {
        0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::assert_version(arg0);
        let v0 = session_expiration_ms(arg2, 0x2::tx_context::sender(arg4));
        assert!(0x1::option::is_some<u64>(&v0), 1);
        assert!(0x2::clock::timestamp_ms(arg3) < *0x1::option::borrow<u64>(&v0), 1);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::generate_auth_as_app<SessionsApp>(arg1, 0x1::internal::permit<SessionsApp>())
    }

    public fun place_limit_order<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: u64, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: u64, arg13: &0x2::accumulator::AccumulatorRoot, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::assert_pool_allowed(arg4, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg0));
        0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::deepbook_core_account::place_limit_order<T0, T1>(arg0, arg1, arg3, generate_auth_as_session(arg4, arg2, arg3, arg14, arg15), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    public fun place_market_order<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: &0x2::accumulator::AccumulatorRoot, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::assert_pool_allowed(arg4, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg0));
        0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::deepbook_core_account::place_market_order<T0, T1>(arg0, arg1, arg3, generate_auth_as_session(arg4, arg2, arg3, arg12, arg13), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun revoke_session(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg0, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth(arg2));
        let v1 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(v0);
        clear_builder(v0, v1, arg1);
        if (!0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::has_data<SessionsApp>(v0)) {
            return
        };
        let v2 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data_mut<SessionsApp, SessionsData>(v0, 0x1::internal::permit<SessionsApp>());
        if (!0x2::vec_map::contains<address, u64>(&v2.sessions, &arg1)) {
            return
        };
        let (_, v4) = 0x2::vec_map::remove<address, u64>(&mut v2.sessions, &arg1);
        let v5 = SessionRevoked{
            account_id    : v1,
            session       : arg1,
            expires_at_ms : v4,
        };
        0x2::event::emit<SessionRevoked>(v5);
    }

    fun session_auth_with_builder(arg0: &0x9a068beffa019ae756f4a6d2611e9899d3c6dd888812dd9eca87535d2ac55e2a::session_config::SessionsConfig, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::BuilderCode, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth {
        let v0 = session_builder(arg2, 0x2::tx_context::sender(arg6));
        assert!(0x1::option::is_some<SessionBuilder>(&v0) && 0x1::option::borrow<SessionBuilder>(&v0).code_id == 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::id(arg3), 3);
        assert!(arg4 <= 0x1::option::borrow<SessionBuilder>(&v0).max_fee_per_contract, 4);
        generate_auth_as_session(arg0, arg1, arg2, arg5, arg6)
    }

    public fun session_builder(arg0: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: address) : 0x1::option::Option<SessionBuilder> {
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg0);
        if (!0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::has_data<SessionBuildersApp>(v0)) {
            return 0x1::option::none<SessionBuilder>()
        };
        0x2::vec_map::try_get<address, SessionBuilder>(&0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data<SessionBuildersApp, SessionBuilders>(v0).approvals, &arg1)
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

