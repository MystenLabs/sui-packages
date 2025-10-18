module 0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::pred_option {
    struct PredOption has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        name: 0x1::string::String,
        status: u8,
        resolution_round: u64,
        max_resolvers_and_disputers: u64,
        winner_answer: 0x1::option::Option<u8>,
        timestamp: u64,
    }

    struct OptionCreated has copy, drop {
        id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        name: 0x1::string::String,
        status: u8,
        resolution_round: u64,
        max_resolvers_and_disputers: u64,
        winner_answer: 0x1::option::Option<u8>,
        timestamp: u64,
    }

    struct OptionEnded has copy, drop {
        id: 0x2::object::ID,
        resolution_round: u64,
        winner_answer: 0x1::option::Option<u8>,
        timestamp: u64,
    }

    struct RewardClaimed has copy, drop {
        account: address,
        option_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        is_yes: bool,
        amount: u64,
        timestamp: u64,
    }

    public(friend) fun create_option(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : PredOption {
        let v0 = PredOption{
            id                          : 0x2::object::new(arg5),
            market_id                   : arg0,
            name                        : arg1,
            status                      : 0,
            resolution_round            : arg2,
            max_resolvers_and_disputers : arg3,
            winner_answer               : 0x1::option::none<u8>(),
            timestamp                   : arg4,
        };
        emit_option_created(&v0);
        0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::resolutions::emit_resolution_created(arg0, 0x2::object::id<PredOption>(&v0), arg2, 0, 0x1::option::none<u8>(), 0x1::option::none<u8>(), 0x1::option::none<u64>(), arg4);
        v0
    }

    public(friend) fun emit_option_created(arg0: &PredOption) {
        let v0 = OptionCreated{
            id                          : 0x2::object::id<PredOption>(arg0),
            market_id                   : arg0.market_id,
            name                        : arg0.name,
            status                      : arg0.status,
            resolution_round            : arg0.resolution_round,
            max_resolvers_and_disputers : arg0.max_resolvers_and_disputers,
            winner_answer               : arg0.winner_answer,
            timestamp                   : arg0.timestamp,
        };
        0x2::event::emit<OptionCreated>(v0);
    }

    public(friend) fun emit_option_ended(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::option::Option<u8>, arg3: u64) {
        let v0 = OptionEnded{
            id               : arg0,
            resolution_round : arg1,
            winner_answer    : arg2,
            timestamp        : arg3,
        };
        0x2::event::emit<OptionEnded>(v0);
    }

    public(friend) fun emit_reward_claimed(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: u64) {
        let v0 = RewardClaimed{
            account   : arg0,
            option_id : arg1,
            market_id : arg2,
            is_yes    : arg3,
            amount    : arg4,
            timestamp : arg5,
        };
        0x2::event::emit<RewardClaimed>(v0);
    }

    // decompiled from Move bytecode v6
}

