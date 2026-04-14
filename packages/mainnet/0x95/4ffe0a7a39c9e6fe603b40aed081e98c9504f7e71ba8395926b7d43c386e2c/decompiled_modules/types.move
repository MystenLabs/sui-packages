module 0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::types {
    struct ActionLogEntry has copy, drop, store {
        street: u8,
        seat: u8,
        action_type: u8,
        amount: u32,
    }

    struct HandSummary has copy, drop, store {
        hand_index: u32,
        button: u8,
        pot: u32,
        ended_by: u8,
        winner_0: bool,
        winner_1: bool,
        stacks_after_0: u32,
        stacks_after_1: u32,
    }

    public fun action_bet_to() : u8 {
        3
    }

    public fun action_call() : u8 {
        2
    }

    public fun action_check() : u8 {
        1
    }

    public fun action_fold() : u8 {
        0
    }

    public fun action_raise_to() : u8 {
        4
    }

    public fun ale_action_type(arg0: &ActionLogEntry) : u8 {
        arg0.action_type
    }

    public fun ale_amount(arg0: &ActionLogEntry) : u32 {
        arg0.amount
    }

    public fun ale_seat(arg0: &ActionLogEntry) : u8 {
        arg0.seat
    }

    public fun ale_street(arg0: &ActionLogEntry) : u8 {
        arg0.street
    }

    public fun card_encode(arg0: u8, arg1: u8) : u8 {
        (arg0 - 2) * 4 + arg1
    }

    public fun card_name(arg0: u8) : vector<u8> {
        let v0 = card_rank(arg0);
        let v1 = card_suit(arg0);
        let v2 = if (v0 <= 9) {
            v0 + 48
        } else if (v0 == 10) {
            84
        } else if (v0 == 11) {
            74
        } else if (v0 == 12) {
            81
        } else if (v0 == 13) {
            75
        } else {
            65
        };
        let v3 = if (v1 == 0) {
            99
        } else if (v1 == 1) {
            100
        } else if (v1 == 2) {
            104
        } else {
            115
        };
        let v4 = 0x1::vector::empty<u8>();
        let v5 = &mut v4;
        0x1::vector::push_back<u8>(v5, v2);
        0x1::vector::push_back<u8>(v5, v3);
        v4
    }

    public fun card_rank(arg0: u8) : u8 {
        arg0 / 4 + 2
    }

    public fun card_suit(arg0: u8) : u8 {
        arg0 % 4
    }

    public fun flop() : u8 {
        1
    }

    public fun hand_end_fold() : u8 {
        0
    }

    public fun hand_end_showdown() : u8 {
        1
    }

    public fun hs_button(arg0: &HandSummary) : u8 {
        arg0.button
    }

    public fun hs_ended_by(arg0: &HandSummary) : u8 {
        arg0.ended_by
    }

    public fun hs_hand_index(arg0: &HandSummary) : u32 {
        arg0.hand_index
    }

    public fun hs_pot(arg0: &HandSummary) : u32 {
        arg0.pot
    }

    public fun hs_stacks_after_0(arg0: &HandSummary) : u32 {
        arg0.stacks_after_0
    }

    public fun hs_stacks_after_1(arg0: &HandSummary) : u32 {
        arg0.stacks_after_1
    }

    public fun hs_winner_0(arg0: &HandSummary) : bool {
        arg0.winner_0
    }

    public fun hs_winner_1(arg0: &HandSummary) : bool {
        arg0.winner_1
    }

    public fun new_action_log_entry(arg0: u8, arg1: u8, arg2: u8, arg3: u32) : ActionLogEntry {
        ActionLogEntry{
            street      : arg0,
            seat        : arg1,
            action_type : arg2,
            amount      : arg3,
        }
    }

    public fun new_hand_summary(arg0: u32, arg1: u8, arg2: u32, arg3: u8, arg4: bool, arg5: bool, arg6: u32, arg7: u32) : HandSummary {
        HandSummary{
            hand_index     : arg0,
            button         : arg1,
            pot            : arg2,
            ended_by       : arg3,
            winner_0       : arg4,
            winner_1       : arg5,
            stacks_after_0 : arg6,
            stacks_after_1 : arg7,
        }
    }

    public fun no_winner() : u8 {
        255
    }

    public fun preflop() : u8 {
        0
    }

    public fun river() : u8 {
        3
    }

    public fun street_next(arg0: u8) : u8 {
        assert!(arg0 < 3, 1);
        arg0 + 1
    }

    public fun turn() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

