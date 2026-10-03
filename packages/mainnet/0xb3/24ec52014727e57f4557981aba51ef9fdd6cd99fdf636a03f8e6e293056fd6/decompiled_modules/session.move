module 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session {
    struct Session {
        hops: u8,
        fee_ppm: u64,
        min_profit: u64,
        unit: u64,
        left: u64,
        fib_low: u64,
        fib_high: u64,
        stage: u8,
        score_c: u128,
        score_d: u128,
        amounts: vector<u64>,
        filled: u8,
        evals: u16,
        best_x: u64,
        best_out: u64,
        best_score: u128,
        principal: u64,
    }

    struct QuoteRefunds has drop {
        amount: u64,
    }

    struct Sized has copy, drop {
        principal: u64,
        expected_out: u64,
        expected_profit: u64,
        evals: u16,
    }

    struct Skipped has copy, drop {
        best_profit: u64,
        evals: u16,
    }

    public fun advance(arg0: &mut Session) {
        if (!quoting(arg0)) {
            return
        };
        if (arg0.stage == 0) {
            arg0.stage = 1;
            let v0 = point(arg0, arg0.fib_low);
            set_probe(arg0, v0);
            return
        };
        assert!(arg0.filled == arg0.hops, 2);
        let v1 = *0x1::vector::borrow<u64>(&arg0.amounts, 0);
        let v2 = *0x1::vector::borrow<u64>(&arg0.amounts, (arg0.hops as u64));
        let v3 = observe(arg0, v1, v2);
        let v4 = arg0.stage;
        if (v4 == 1) {
            arg0.score_c = v3;
            arg0.stage = 2;
            let v5 = point(arg0, arg0.fib_high);
            set_probe(arg0, v5);
        } else if (v4 == 2 || v4 == 4) {
            arg0.score_d = v3;
            narrow(arg0);
        } else {
            arg0.score_c = v3;
            narrow(arg0);
        };
    }

    public fun advance_refunded(arg0: &mut Session, arg1: &mut QuoteRefunds) {
        if (quoting(arg0) && arg0.stage != 0) {
            assert!(arg0.filled == arg0.hops, 2);
            let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, (arg0.hops as u64));
            *v0 = *v0 + arg1.amount;
        };
        arg1.amount = 0;
        advance(arg0);
    }

    fun clears_min_profit(arg0: &Session) : bool {
        arg0.best_score > origin() && expected_profit(arg0) >= arg0.min_profit
    }

    public fun conclude(arg0: &mut Session) {
        assert!(arg0.stage == 5, 2);
        assert!(clears_min_profit(arg0), 1);
        size(arg0);
    }

    public fun conclude_or_skip(arg0: &mut Session) {
        assert!(arg0.stage == 5, 2);
        if (clears_min_profit(arg0)) {
            size(arg0);
        } else {
            arg0.stage = 7;
            let v0 = Skipped{
                best_profit : expected_profit(arg0),
                evals       : arg0.evals,
            };
            0x2::event::emit<Skipped>(v0);
        };
    }

    public fun deliver<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    fun expected_profit(arg0: &Session) : u64 {
        if (arg0.best_score <= origin()) {
            return 0
        };
        ((arg0.best_score - origin()) as u64)
    }

    public fun live(arg0: &Session) : bool {
        arg0.stage == 6
    }

    public fun live_principal(arg0: &Session) : u64 {
        if (arg0.stage == 7) {
            return 0
        };
        principal(arg0)
    }

    fun narrow(arg0: &mut Session) {
        if (arg0.fib_high == 2) {
            arg0.stage = 5;
            return
        };
        let v0 = arg0.fib_low;
        arg0.fib_high = v0;
        arg0.fib_low = arg0.fib_high - arg0.fib_low;
        if (arg0.score_c >= arg0.score_d) {
            arg0.score_d = arg0.score_c;
            arg0.stage = 3;
            let v1 = point(arg0, arg0.fib_low);
            set_probe(arg0, v1);
        } else {
            arg0.left = arg0.left + v0 * arg0.unit;
            arg0.score_c = arg0.score_d;
            arg0.stage = 4;
            let v2 = point(arg0, arg0.fib_high);
            set_probe(arg0, v2);
        };
    }

    fun observe(arg0: &mut Session, arg1: u64, arg2: u64) : u128 {
        arg0.evals = arg0.evals + 1;
        let v0 = (arg2 as u128) + origin() - (owed(arg0, arg1) as u128);
        if (v0 > arg0.best_score) {
            arg0.best_score = v0;
            arg0.best_x = arg1;
            arg0.best_out = arg2;
        };
        v0
    }

    fun origin() : u128 {
        1208925819614629174706176
    }

    fun owed(arg0: &Session, arg1: u64) : u64 {
        arg1 + ((((arg1 as u128) * (arg0.fee_ppm as u128) + 1000000 - 1) / 1000000) as u64)
    }

    fun point(arg0: &Session, arg1: u64) : u64 {
        arg0.left + arg1 * arg0.unit
    }

    public fun principal(arg0: &Session) : u64 {
        assert!(arg0.stage == 6, 6);
        arg0.principal
    }

    public fun quote_input(arg0: &Session, arg1: u8) : u64 {
        assert!(arg0.stage != 0 && arg1 == arg0.filled, 5);
        *0x1::vector::borrow<u64>(&arg0.amounts, (arg1 as u64))
    }

    public fun quote_refunds() : QuoteRefunds {
        QuoteRefunds{amount: 0}
    }

    public fun quoting(arg0: &Session) : bool {
        arg0.stage < 5
    }

    public fun record_quote(arg0: &mut Session, arg1: u64) {
        arg0.filled = arg0.filled + 1;
        *0x1::vector::borrow_mut<u64>(&mut arg0.amounts, (arg0.filled as u64)) = arg1;
    }

    public fun record_refund(arg0: &mut QuoteRefunds, arg1: u64) {
        arg0.amount = arg0.amount + arg1;
    }

    fun set_probe(arg0: &mut Session, arg1: u64) {
        *0x1::vector::borrow_mut<u64>(&mut arg0.amounts, 0) = arg1;
        arg0.filled = 0;
    }

    public fun settle<T0>(arg0: Session, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::coin::Coin<T0>) {
        let Session {
            hops       : _,
            fee_ppm    : _,
            min_profit : v2,
            unit       : _,
            left       : _,
            fib_low    : _,
            fib_high   : _,
            stage      : v7,
            score_c    : _,
            score_d    : _,
            amounts    : _,
            filled     : _,
            evals      : _,
            best_x     : _,
            best_out   : _,
            best_score : _,
            principal  : _,
        } = arg0;
        assert!(v7 == 6, 6);
        assert!((0x2::balance::value<T0>(&arg1) as u128) >= (arg2 as u128) + (v2 as u128), 7);
        (0x2::balance::split<T0>(&mut arg1, arg2), 0x2::coin::from_balance<T0>(arg1, arg3))
    }

    public fun settle_or_skip<T0>(arg0: Session, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::coin::Coin<T0>) {
        if (arg0.stage != 7) {
            return settle<T0>(arg0, arg1, arg2, arg3)
        };
        let Session {
            hops       : _,
            fee_ppm    : _,
            min_profit : _,
            unit       : _,
            left       : _,
            fib_low    : _,
            fib_high   : _,
            stage      : _,
            score_c    : _,
            score_d    : _,
            amounts    : _,
            filled     : _,
            evals      : _,
            best_x     : _,
            best_out   : _,
            best_score : _,
            principal  : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(arg1);
        (0x2::balance::zero<T0>(), 0x2::coin::zero<T0>(arg3))
    }

    fun size(arg0: &mut Session) {
        arg0.stage = 6;
        arg0.principal = arg0.best_x;
        let v0 = Sized{
            principal       : arg0.best_x,
            expected_out    : arg0.best_out,
            expected_profit : expected_profit(arg0),
            evals           : arg0.evals,
        };
        0x2::event::emit<Sized>(v0);
    }

    public fun start(arg0: u64, arg1: u64, arg2: u8, arg3: u8, arg4: u64, arg5: u64) : Session {
        assert!(arg3 >= 2 && arg3 <= 5, 4);
        assert!(arg2 >= 2 && arg1 > arg0, 3);
        let v0 = 1;
        let v1 = 1;
        let v2 = 1;
        while (v2 < arg2) {
            v1 = v0 + v1;
            v2 = v2 + 1;
        };
        let v3 = (arg1 - arg0) / (v0 + v1);
        assert!(v3 > 0, 3);
        let v4 = vector[0];
        let v5 = 0;
        while (v5 < arg3) {
            0x1::vector::push_back<u64>(&mut v4, 0);
            v5 = v5 + 1;
        };
        Session{
            hops       : arg3,
            fee_ppm    : arg4,
            min_profit : arg5,
            unit       : v3,
            left       : arg0,
            fib_low    : v0,
            fib_high   : v1,
            stage      : 0,
            score_c    : 0,
            score_d    : 0,
            amounts    : v4,
            filled     : 0,
            evals      : 0,
            best_x     : 0,
            best_out   : 0,
            best_score : origin(),
            principal  : 0,
        }
    }

    // decompiled from Move bytecode v7
}

