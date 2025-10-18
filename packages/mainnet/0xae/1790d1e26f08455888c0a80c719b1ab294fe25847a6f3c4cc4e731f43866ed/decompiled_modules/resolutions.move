module 0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::resolutions {
    struct ResolutionCreated has copy, drop {
        market_id: 0x2::object::ID,
        option_id: 0x2::object::ID,
        resolution_round: u64,
        state: u8,
        resolvers_consensus: 0x1::option::Option<u8>,
        winner_answer: 0x1::option::Option<u8>,
        dispute_end_time: 0x1::option::Option<u64>,
        timestamp: u64,
    }

    struct ResolutionStateChanged has copy, drop {
        market_id: 0x2::object::ID,
        option_id: 0x2::object::ID,
        resolution_round: u64,
        state: u8,
        resolvers_consensus: 0x1::option::Option<u8>,
        winner_answer: 0x1::option::Option<u8>,
        dispute_end_time: 0x1::option::Option<u64>,
        timestamp: u64,
    }

    struct ResolverProposeAnswer has copy, drop {
        market_id: 0x2::object::ID,
        option_id: 0x2::object::ID,
        resolution_round: u64,
        sender: address,
        chosen_answer: u8,
        collateral_amount: u64,
        ref_source: 0x1::option::Option<0x2::url::Url>,
        message: 0x1::option::Option<0x1::string::String>,
        timestamp: u64,
    }

    struct DisputerProposeAnswer has copy, drop {
        market_id: 0x2::object::ID,
        option_id: 0x2::object::ID,
        resolution_round: u64,
        sender: address,
        chosen_answer: u8,
        collateral_amount: u64,
        ref_source: 0x1::option::Option<0x2::url::Url>,
        message: 0x1::option::Option<0x1::string::String>,
        timestamp: u64,
    }

    public(friend) fun emit_disputer_propose_answer(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u8, arg5: u64, arg6: 0x1::option::Option<0x2::url::Url>, arg7: 0x1::option::Option<0x1::string::String>, arg8: u64) {
        let v0 = DisputerProposeAnswer{
            market_id         : arg0,
            option_id         : arg1,
            resolution_round  : arg2,
            sender            : arg3,
            chosen_answer     : arg4,
            collateral_amount : arg5,
            ref_source        : arg6,
            message           : arg7,
            timestamp         : arg8,
        };
        0x2::event::emit<DisputerProposeAnswer>(v0);
    }

    public(friend) fun emit_resolution_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: 0x1::option::Option<u8>, arg5: 0x1::option::Option<u8>, arg6: 0x1::option::Option<u64>, arg7: u64) {
        let v0 = ResolutionCreated{
            market_id           : arg0,
            option_id           : arg1,
            resolution_round    : arg2,
            state               : arg3,
            resolvers_consensus : arg4,
            winner_answer       : arg5,
            dispute_end_time    : arg6,
            timestamp           : arg7,
        };
        0x2::event::emit<ResolutionCreated>(v0);
    }

    public(friend) fun emit_resolution_state_changed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: 0x1::option::Option<u8>, arg5: 0x1::option::Option<u8>, arg6: 0x1::option::Option<u64>, arg7: u64) {
        let v0 = ResolutionStateChanged{
            market_id           : arg0,
            option_id           : arg1,
            resolution_round    : arg2,
            state               : arg3,
            resolvers_consensus : arg4,
            winner_answer       : arg5,
            dispute_end_time    : arg6,
            timestamp           : arg7,
        };
        0x2::event::emit<ResolutionStateChanged>(v0);
    }

    public(friend) fun emit_resolver_propose_answer(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u8, arg5: u64, arg6: 0x1::option::Option<0x2::url::Url>, arg7: 0x1::option::Option<0x1::string::String>, arg8: u64) {
        let v0 = ResolverProposeAnswer{
            market_id         : arg0,
            option_id         : arg1,
            resolution_round  : arg2,
            sender            : arg3,
            chosen_answer     : arg4,
            collateral_amount : arg5,
            ref_source        : arg6,
            message           : arg7,
            timestamp         : arg8,
        };
        0x2::event::emit<ResolverProposeAnswer>(v0);
    }

    // decompiled from Move bytecode v6
}

