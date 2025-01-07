module 0x8011111bda5f6df303604624f3e0aa8f8a78f82967b1d0d3118f36289a3742::game_structs {
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

    public fun ball_outcome(arg0: u64, arg1: vector<u8>) : BallOutcome {
        BallOutcome{
            ball_index : arg0,
            ball_path  : arg1,
        }
    }

    public fun bet_result<T0>(arg0: address, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: u64) : BetResult<T0> {
        BetResult<T0>{
            player       : arg0,
            bet_id       : arg1,
            bet_size     : arg2,
            bet_returned : arg3,
        }
    }

    public fun blackjack_hand(arg0: vector<u8>, arg1: u64, arg2: u8, arg3: u64, arg4: bool, arg5: bool, arg6: bool, arg7: u64) : BlackjackHand {
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

    public fun range_game(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : RangeGame {
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

