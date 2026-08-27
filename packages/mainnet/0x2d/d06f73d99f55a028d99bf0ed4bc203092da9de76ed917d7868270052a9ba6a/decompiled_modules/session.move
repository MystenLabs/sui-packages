module 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session {
    struct Session {
        id: 0x2::object::UID,
        ladder: vector<u64>,
        rung: u64,
        carry: u64,
        scratch: vector<u64>,
        best_in: u64,
        best_out: u64,
        best_hops: vector<u64>,
        decided: bool,
        step: u8,
        min_profit: u64,
        deadline_ms: u64,
        mode: u8,
        blo: u64,
        bhi: u64,
        bx: u64,
        bfx: u64,
        pm: u64,
        hop_tolerance_bp: u64,
    }

    public fun abort_search(arg0: Session) {
        let Session {
            id               : v0,
            ladder           : _,
            rung             : _,
            carry            : _,
            scratch          : _,
            best_in          : _,
            best_out         : _,
            best_hops        : _,
            decided          : v8,
            step             : _,
            min_profit       : _,
            deadline_ms      : _,
            mode             : _,
            blo              : _,
            bhi              : _,
            bx               : _,
            bfx              : _,
            pm               : _,
            hop_tolerance_bp : _,
        } = arg0;
        assert!(!v8, 34);
        0x2::object::delete(v0);
    }

    public fun advance(arg0: &mut Session) {
        assert!(!arg0.decided, 34);
        if (arg0.mode == 1) {
            advance_bracket(arg0);
            return
        };
        if (arg0.rung >= 0x1::vector::length<u64>(&arg0.ladder)) {
            return
        };
        let v0 = *0x1::vector::borrow<u64>(&arg0.ladder, arg0.rung);
        let v1 = arg0.carry;
        if (arg0.best_in == 0 || 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v0, v1) > 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg0.best_in, arg0.best_out)) {
            arg0.best_in = v0;
            arg0.best_out = v1;
            arg0.best_hops = arg0.scratch;
        };
        arg0.rung = arg0.rung + 1;
        arg0.scratch = vector[];
        let v2 = if (arg0.rung < 0x1::vector::length<u64>(&arg0.ladder)) {
            *0x1::vector::borrow<u64>(&arg0.ladder, arg0.rung)
        } else {
            0
        };
        arg0.carry = v2;
    }

    fun advance_bracket(arg0: &mut Session) {
        let v0 = arg0.pm;
        let v1 = arg0.carry;
        if (arg0.best_in == 0 || 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v0, v1) > 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg0.best_in, arg0.best_out)) {
            arg0.best_in = v0;
            arg0.best_out = v1;
            arg0.best_hops = arg0.scratch;
        };
        if (arg0.bfx == 0 && arg0.bx == v0) {
            arg0.bfx = v1;
        } else if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v0, v1) > 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg0.bx, arg0.bfx)) {
            if (v0 > arg0.bx) {
                arg0.blo = arg0.bx;
            } else {
                arg0.bhi = arg0.bx;
            };
            arg0.bx = v0;
            arg0.bfx = v1;
        } else if (v0 > arg0.bx) {
            arg0.bhi = v0;
        } else {
            arg0.blo = v0;
        };
        arg0.rung = arg0.rung + 1;
        arg0.scratch = vector[];
        let v2 = if (arg0.bhi <= arg0.blo + 1) {
            0
        } else if (arg0.bhi / arg0.bx >= arg0.bx / arg0.blo) {
            geo_mid(arg0.bx, arg0.bhi)
        } else {
            geo_mid(arg0.blo, arg0.bx)
        };
        let v3 = if (v2 == 0 || v2 == arg0.bx) {
            arg0.bx
        } else {
            v2
        };
        arg0.pm = v3;
        arg0.carry = arg0.pm;
    }

    public fun bracket(arg0: &Session) : (u64, u64) {
        (arg0.blo, arg0.bhi)
    }

    public fun bracketing(arg0: &Session) : bool {
        arg0.mode == 1
    }

    public fun carry(arg0: &Session) : u64 {
        arg0.carry
    }

    public fun carrying(arg0: &Session) : bool {
        0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"carry")
    }

    public fun deadline_ms(arg0: &Session) : u64 {
        arg0.deadline_ms
    }

    public fun decide(arg0: &mut Session, arg1: &0x2::clock::Clock) {
        assert!(!arg0.decided, 34);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg1, arg0.deadline_ms);
        assert!(arg0.best_in > 0, 20);
        assert!(arg0.best_out > arg0.best_in, 20);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_min(arg0.best_out - arg0.best_in, arg0.min_profit);
        arg0.decided = true;
        arg0.step = 0;
    }

    public fun decided(arg0: &Session) : bool {
        arg0.decided
    }

    public fun expected(arg0: &Session) : u64 {
        assert!(arg0.decided, 34);
        arg0.best_out
    }

    public fun expected_out(arg0: &Session, arg1: u8) : u64 {
        assert!(arg0.decided, 34);
        let v0 = (arg1 as u64);
        assert!(v0 < 0x1::vector::length<u64>(&arg0.best_hops), 36);
        *0x1::vector::borrow<u64>(&arg0.best_hops, v0)
    }

    public fun feed(arg0: &mut Session, arg1: u64) {
        assert!(!arg0.decided, 34);
        arg0.carry = arg1;
        0x1::vector::push_back<u64>(&mut arg0.scratch, arg1);
    }

    public fun finish<T0>(arg0: Session, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Session {
            id               : v0,
            ladder           : _,
            rung             : _,
            carry            : _,
            scratch          : _,
            best_in          : v5,
            best_out         : _,
            best_hops        : _,
            decided          : v8,
            step             : _,
            min_profit       : v10,
            deadline_ms      : _,
            mode             : _,
            blo              : _,
            bhi              : _,
            bx               : _,
            bfx              : _,
            pm               : _,
            hop_tolerance_bp : _,
        } = arg0;
        let v19 = v0;
        assert!(v8, 34);
        let v20 = 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut v19, b"carry");
        0x2::object::delete(v19);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_min(0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::profit(v5, 0x2::balance::value<T0>(&v20)), v10);
        0x2::coin::from_balance<T0>(v20, arg1)
    }

    public fun geo_mid(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= arg0) {
            return arg0
        };
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (v0 + 1) / 2;
        while (v1 < v0) {
            let v2 = v1 + v0 / v1;
            v1 = v2 / 2;
        };
        let v3 = (v0 as u64);
        if (v3 <= arg0) {
            arg0 + 1
        } else if (v3 >= arg1) {
            arg1
        } else {
            v3
        }
    }

    public fun hop_done(arg0: &mut Session, arg1: u8, arg2: u64) {
        assert!(arg0.decided, 34);
        let v0 = arg0.hop_tolerance_bp;
        let v1 = if (v0 >= 10000) {
            0
        } else {
            (((expected_out(arg0, arg1) as u128) * ((10000 - v0) as u128) / 10000) as u64)
        };
        assert!(arg2 >= v1, 35);
        arg0.step = arg1 + 1;
    }

    public fun hops(arg0: &Session) : u8 {
        (0x1::vector::length<u64>(&arg0.best_hops) as u8)
    }

    public fun land<T0>(arg0: &mut Session, arg1: 0x2::balance::Balance<T0>, arg2: u8) {
        put<T0>(arg0, arg1);
        hop_done(arg0, arg2, 0x2::balance::value<T0>(&arg1));
    }

    public fun min_out_for_rung(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= 10000) {
            return arg0
        };
        (((arg0 as u128) * ((10000 + arg1) as u128) / 10000) as u64)
    }

    public fun min_profit(arg0: &Session) : u64 {
        arg0.min_profit
    }

    public fun mode_bracket() : u8 {
        1
    }

    public fun mode_ladder() : u8 {
        0
    }

    public fun open(arg0: vector<u64>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Session {
        open_mode(arg0, arg1, arg2, arg3, 0, arg4)
    }

    public fun open_mode(arg0: vector<u64>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : Session {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 > 0, 31);
        assert!(v0 <= (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes() as u64), 32);
        let v1 = 0;
        while (v1 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg0, v1) > 0, 33);
            v1 = v1 + 1;
        };
        let v2 = *0x1::vector::borrow<u64>(&arg0, 0);
        let v3 = *0x1::vector::borrow<u64>(&arg0, v0 - 1);
        let v4 = if (arg4 == 1) {
            geo_mid(v2, v3)
        } else {
            v2
        };
        Session{
            id               : 0x2::object::new(arg5),
            ladder           : arg0,
            rung             : 0,
            carry            : v4,
            scratch          : vector[],
            best_in          : 0,
            best_out         : 0,
            best_hops        : vector[],
            decided          : false,
            step             : 0,
            min_profit       : arg1,
            deadline_ms      : arg2,
            mode             : arg4,
            blo              : v2,
            bhi              : v3,
            bx               : v4,
            bfx              : 0,
            pm               : v4,
            hop_tolerance_bp : arg3,
        }
    }

    public fun principal_for_notional(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (((arg0 as u128) * 10000 / (arg1 as u128)) as u64)
    }

    public fun put<T0>(arg0: &mut Session, arg1: 0x2::balance::Balance<T0>) {
        assert!(arg0.decided, 34);
        if (0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"carry")) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"carry"), arg1);
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"carry", arg1);
        };
    }

    public fun size(arg0: &Session) : u64 {
        assert!(arg0.decided, 34);
        arg0.best_in
    }

    public fun stash<T0>(arg0: &mut Session, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"fee")) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.id, b"fee"), arg1);
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.id, b"fee", arg1);
        };
    }

    public fun stashed(arg0: &Session) : bool {
        0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"fee")
    }

    public fun take<T0>(arg0: &mut Session) : 0x2::balance::Balance<T0> {
        assert!(arg0.decided, 34);
        0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"carry")
    }

    public fun unstash<T0>(arg0: &mut Session) : 0x2::coin::Coin<T0> {
        0x2::dynamic_field::remove<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.id, b"fee")
    }

    // decompiled from Move bytecode v7
}

