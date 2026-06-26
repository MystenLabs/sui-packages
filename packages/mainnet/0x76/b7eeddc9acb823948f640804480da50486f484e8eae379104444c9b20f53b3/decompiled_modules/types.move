module 0x76b7eeddc9acb823948f640804480da50486f484e8eae379104444c9b20f53b3::types {
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
        winner: u8,
        stacks_after: vector<u32>,
    }

    public fun action_check() : u8 {
        1
    }

    public fun action_commit_to() : u8 {
        2
    }

    public fun action_fold() : u8 {
        0
    }

    public fun action_type(arg0: &ActionLogEntry) : u8 {
        arg0.action_type
    }

    public fun amount(arg0: &ActionLogEntry) : u32 {
        arg0.amount
    }

    public fun button(arg0: &HandSummary) : u8 {
        arg0.button
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

    public fun hand_index(arg0: &HandSummary) : u32 {
        arg0.hand_index
    }

    public fun new_action_log_entry(arg0: u8, arg1: u8, arg2: u8, arg3: u32) : ActionLogEntry {
        ActionLogEntry{
            street      : arg0,
            seat        : arg1,
            action_type : arg2,
            amount      : arg3,
        }
    }

    public fun new_hand_summary(arg0: u32, arg1: u8, arg2: u32, arg3: u8, arg4: vector<u32>) : HandSummary {
        HandSummary{
            hand_index   : arg0,
            button       : arg1,
            pot          : arg2,
            winner       : arg3,
            stacks_after : arg4,
        }
    }

    public fun no_seat() : u8 {
        255
    }

    public fun pot(arg0: &HandSummary) : u32 {
        arg0.pot
    }

    public fun preflop() : u8 {
        0
    }

    public fun river() : u8 {
        3
    }

    public fun seat(arg0: &ActionLogEntry) : u8 {
        arg0.seat
    }

    public fun stack(arg0: &HandSummary, arg1: u8) : u32 {
        *0x1::vector::borrow<u32>(&arg0.stacks_after, (arg1 as u64))
    }

    public fun street(arg0: &ActionLogEntry) : u8 {
        arg0.street
    }

    public fun turn() : u8 {
        2
    }

    public fun winner(arg0: &HandSummary) : u8 {
        arg0.winner
    }

    // decompiled from Move bytecode v7
}

