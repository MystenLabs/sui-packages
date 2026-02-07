module 0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::credit_score {
    struct CreditScore has store, key {
        id: 0x2::object::UID,
        user: address,
        score: u64,
        tier: u8,
        on_time_repayments: u64,
        late_repayments: u64,
        liquidations: u64,
        total_volume: u64,
        last_updated: u64,
    }

    struct ScoreUpdated has copy, drop {
        user: address,
        new_score: u64,
        new_tier: u8,
        event_type: u8,
    }

    public fun calculate_tier(arg0: u64) : u8 {
        if (arg0 >= 900) {
            5
        } else if (arg0 >= 750) {
            4
        } else if (arg0 >= 500) {
            3
        } else if (arg0 >= 300) {
            2
        } else {
            1
        }
    }

    public fun create_credit_score(arg0: &mut 0x2::tx_context::TxContext) : CreditScore {
        CreditScore{
            id                 : 0x2::object::new(arg0),
            user               : 0x2::tx_context::sender(arg0),
            score              : 500,
            tier               : 3,
            on_time_repayments : 0,
            late_repayments    : 0,
            liquidations       : 0,
            total_volume       : 0,
            last_updated       : 0,
        }
    }

    public fun get_fee_discount(arg0: u8) : u64 {
        if (arg0 == 5) {
            500
        } else if (arg0 == 4) {
            300
        } else if (arg0 == 3) {
            200
        } else if (arg0 == 2) {
            100
        } else {
            0
        }
    }

    public fun get_score(arg0: &CreditScore) : u64 {
        arg0.score
    }

    public fun get_tier(arg0: &CreditScore) : u8 {
        arg0.tier
    }

    public(friend) fun update_credit_score(arg0: &mut CreditScore, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) {
        if (arg1 == 0) {
            let v0 = if (arg0.score + 10 > 1000) {
                1000
            } else {
                arg0.score + 10
            };
            arg0.score = v0;
            arg0.on_time_repayments = arg0.on_time_repayments + 1;
        } else if (arg1 == 1) {
            let v1 = if (arg0.score < 20) {
                0
            } else {
                arg0.score - 20
            };
            arg0.score = v1;
            arg0.late_repayments = arg0.late_repayments + 1;
        } else if (arg1 == 2) {
            let v2 = if (arg0.score < 100) {
                0
            } else {
                arg0.score - 100
            };
            arg0.score = v2;
            arg0.liquidations = arg0.liquidations + 1;
        };
        arg0.total_volume = arg0.total_volume + arg2;
        arg0.tier = calculate_tier(arg0.score);
        arg0.last_updated = 0x2::clock::timestamp_ms(arg3);
        let v3 = ScoreUpdated{
            user       : arg0.user,
            new_score  : arg0.score,
            new_tier   : arg0.tier,
            event_type : arg1,
        };
        0x2::event::emit<ScoreUpdated>(v3);
    }

    // decompiled from Move bytecode v6
}

