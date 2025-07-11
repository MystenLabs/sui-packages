module 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs {
    struct BallOutcome has copy, drop, store {
        ball_index: u64,
        ball_path: vector<u8>,
    }

    struct BetResult<phantom T0> has copy, drop, store {
        player: address,
        bet_id: 0x1::option::Option<0x2::object::ID>,
        bet_size: u64,
        bet_returned: u64,
    }

    struct BlackjackHand has copy, drop, store {
        cards: vector<u8>,
        status: u64,
        current_sum: u8,
        bet_size: u64,
        is_natural_blackjack: bool,
        is_doubled: bool,
        is_settled: bool,
        bet_returned: u64,
    }

    struct RangeGame has copy, drop, store {
        bet_size: u64,
        bet_returned: u64,
        bet_type: u64,
        lower: u64,
        upper: u64,
        outcome: u64,
    }

    struct Placement has copy, drop, store {
        marble_id: u64,
        rank_index: u8,
    }

    public fun ball_outcome(arg0: u64, arg1: vector<u8>) : BallOutcome {
        abort 0
    }

    public(friend) fun ball_outcome_v2(arg0: u64, arg1: vector<u8>) : BallOutcome {
        BallOutcome{
            ball_index : arg0,
            ball_path  : arg1,
        }
    }

    public fun bet_result<T0>(arg0: address, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: u64) : BetResult<T0> {
        abort 0
    }

    public(friend) fun bet_result_v2<T0>(arg0: address, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: u64) : BetResult<T0> {
        BetResult<T0>{
            player       : arg0,
            bet_id       : arg1,
            bet_size     : arg2,
            bet_returned : arg3,
        }
    }

    public fun blackjack_hand(arg0: vector<u8>, arg1: u64, arg2: u8, arg3: u64, arg4: bool, arg5: bool, arg6: bool, arg7: u64) : BlackjackHand {
        abort 0
    }

    public(friend) fun blackjack_hand_v2(arg0: vector<u8>, arg1: u64, arg2: u8, arg3: u64, arg4: bool, arg5: bool, arg6: bool, arg7: u64) : BlackjackHand {
        BlackjackHand{
            cards                : arg0,
            status               : arg1,
            current_sum          : arg2,
            bet_size             : arg3,
            is_natural_blackjack : arg4,
            is_doubled           : arg5,
            is_settled           : arg6,
            bet_returned         : arg7,
        }
    }

    public fun create_placement(arg0: u64, arg1: u8) : Placement {
        Placement{
            marble_id  : arg0,
            rank_index : arg1,
        }
    }

    public fun range_game(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : RangeGame {
        abort 0
    }

    public(friend) fun range_game_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : RangeGame {
        RangeGame{
            bet_size     : arg0,
            bet_returned : arg1,
            bet_type     : arg2,
            lower        : arg3,
            upper        : arg4,
            outcome      : arg5,
        }
    }

    // decompiled from Move bytecode v6
}

