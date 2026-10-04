module 0x10010f82554c2f0e7825e2262c839aac9c2d3c5267b2fa600841ee197b06da68::plan {
    struct Plan {
        index: u64,
        amounts: vector<u64>,
        quotes: vector<u64>,
        min_profit: u64,
        decided: bool,
        amount_in: u64,
        quoted_out: u64,
    }

    struct CandidateJudged has copy, drop {
        index: u64,
        amount_in: u64,
        quoted_out: u64,
        amount_out: u64,
        executed: bool,
    }

    public fun begin(arg0: u64, arg1: vector<u64>, arg2: u64) : Plan {
        assert!(!0x1::vector::is_empty<u64>(&arg1), 3);
        Plan{
            index      : arg0,
            amounts    : arg1,
            quotes     : arg1,
            min_profit : arg2,
            decided    : false,
            amount_in  : 0,
            quoted_out : 0,
        }
    }

    public fun decide(arg0: &mut Plan) {
        assert!(!arg0.decided, 1);
        arg0.decided = true;
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.amounts)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.amounts, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg0.quotes, v0);
            if (v2 > v1) {
                let v3 = v2 - v1;
                if (v3 >= arg0.min_profit && v3 > 0) {
                    arg0.amount_in = v1;
                    arg0.quoted_out = v2;
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun executing(arg0: &Plan) : bool {
        assert!(arg0.decided, 2);
        arg0.amount_in > 0
    }

    public fun finish<T0>(arg0: Plan, arg1: &mut 0x2::coin::Coin<T0>, arg2: 0x2::balance::Balance<T0>) {
        let v0 = executing(&arg0);
        let Plan {
            index      : v1,
            amounts    : _,
            quotes     : _,
            min_profit : v4,
            decided    : _,
            amount_in  : v6,
            quoted_out : v7,
        } = arg0;
        let v8 = 0x2::balance::value<T0>(&arg2);
        if (v0) {
            assert!(v8 >= v6 && v8 - v6 >= v4, 4);
        };
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg1), arg2);
        let v9 = CandidateJudged{
            index      : v1,
            amount_in  : v6,
            quoted_out : v7,
            amount_out : v8,
            executed   : v0,
        };
        0x2::event::emit<CandidateJudged>(v9);
    }

    public(friend) fun quote_at(arg0: &Plan, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.quotes, arg1)
    }

    public(friend) fun quote_count(arg0: &Plan) : u64 {
        0x1::vector::length<u64>(&arg0.quotes)
    }

    public(friend) fun set_quote_at(arg0: &mut Plan, arg1: u64, arg2: u64) {
        assert!(!arg0.decided, 1);
        *0x1::vector::borrow_mut<u64>(&mut arg0.quotes, arg1) = arg2;
    }

    public fun take<T0>(arg0: &Plan, arg1: &mut 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        if (executing(arg0)) {
            0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg0.amount_in)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    // decompiled from Move bytecode v7
}

