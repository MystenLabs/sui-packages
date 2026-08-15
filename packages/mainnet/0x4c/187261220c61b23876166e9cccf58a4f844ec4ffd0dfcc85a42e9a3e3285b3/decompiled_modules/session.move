module 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session {
    struct Session {
        tag: u128,
        sender: address,
        notional: u64,
        rung: u8,
        principal: u64,
        flash_fee: u64,
        min_profit: u64,
        hops: u8,
        quoted: vector<u8>,
        expected: vector<u64>,
        executed: u8,
        deadline_ms: u64,
        phase: u8,
        armed: bool,
        vault: 0x2::bag::Bag,
    }

    struct NoOpportunity has copy, drop {
        tag: u128,
        sender: address,
        notional: u64,
        expected_out: u64,
        required_out: u64,
        hops: u8,
    }

    struct ProfitEvent<phantom T0> has copy, drop {
        tag: u128,
        sender: address,
        rung: u8,
        principal: u64,
        expected_out: u64,
        profit: u64,
    }

    public fun armed(arg0: &Session) : bool {
        arg0.armed
    }

    public fun decide(arg0: &mut Session, arg1: &0x2::clock::Clock) {
        assert!(arg0.phase == 0, 103);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.deadline_ms, 106);
        let v0 = 0;
        while (v0 < 3) {
            assert!(*0x1::vector::borrow<u8>(&arg0.quoted, (v0 as u64)) == arg0.hops, 105);
            v0 = v0 + 1;
        };
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        v0 = 0;
        while (v0 < 3) {
            let v5 = principal_for_notional(arg0.notional, v0) + arg0.flash_fee * ladder_bps(v0) / 10000 + arg0.min_profit;
            let v6 = *0x1::vector::borrow<u64>(&arg0.expected, (v0 as u64));
            if (v0 == 0) {
                v3 = v6;
                v4 = v5;
            };
            if (!v1 && v6 >= v5) {
                v1 = true;
                v3 = v6;
                v4 = v5;
            };
            v0 = v0 + 1;
        };
        arg0.phase = 1;
        if (v1) {
            arg0.rung = v2;
            arg0.principal = principal_for_notional(arg0.notional, v2);
            arg0.armed = true;
        } else {
            arg0.armed = false;
            let v7 = NoOpportunity{
                tag          : arg0.tag,
                sender       : arg0.sender,
                notional     : arg0.notional,
                expected_out : v3,
                required_out : v4,
                hops         : arg0.hops,
            };
            0x2::event::emit<NoOpportunity>(v7);
        };
    }

    public fun executed(arg0: &Session) : u8 {
        arg0.executed
    }

    public fun expected_out(arg0: &Session) : u64 {
        if (arg0.armed) {
            *0x1::vector::borrow<u64>(&arg0.expected, (arg0.rung as u64))
        } else {
            *0x1::vector::borrow<u64>(&arg0.expected, 0)
        }
    }

    public fun finish<T0>(arg0: Session, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Session {
            tag         : v0,
            sender      : v1,
            notional    : _,
            rung        : v3,
            principal   : v4,
            flash_fee   : _,
            min_profit  : _,
            hops        : v7,
            quoted      : _,
            expected    : v9,
            executed    : v10,
            deadline_ms : _,
            phase       : _,
            armed       : v13,
            vault       : v14,
        } = arg0;
        let v15 = v14;
        let v16 = v9;
        let v17 = if (v13) {
            assert!(v10 == v7, 110);
            let v18 = 0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut v15, 255);
            let v19 = ProfitEvent<T0>{
                tag          : v0,
                sender       : v1,
                rung         : v3,
                principal    : v4,
                expected_out : *0x1::vector::borrow<u64>(&v16, (v3 as u64)),
                profit       : 0x2::balance::value<T0>(&v18),
            };
            0x2::event::emit<ProfitEvent<T0>>(v19);
            0x2::coin::from_balance<T0>(v18, arg1)
        } else {
            assert!(v10 == 0, 110);
            let v20 = 0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut v15, 255);
            assert!(0x2::balance::value<T0>(&v20) == 0, 109);
            0x2::coin::from_balance<T0>(v20, arg1)
        };
        0x2::bag::destroy_empty(v15);
        v17
    }

    public fun hops(arg0: &Session) : u8 {
        arg0.hops
    }

    public fun ladder_bps(arg0: u8) : u64 {
        if (arg0 == 0) {
            10000
        } else if (arg0 == 1) {
            5000
        } else {
            assert!(arg0 == 2, 101);
            2500
        }
    }

    public fun ladder_len() : u8 {
        3
    }

    public fun principal(arg0: &Session) : u64 {
        arg0.principal
    }

    public fun principal_for_notional(arg0: u64, arg1: u8) : u64 {
        let v0 = arg0 * ladder_bps(arg1) / 10000;
        assert!(v0 > 0, 112);
        v0
    }

    public fun put<T0>(arg0: &mut Session, arg1: u8, arg2: 0x2::balance::Balance<T0>, arg3: u64) {
        assert!(arg0.armed, 107);
        assert!(arg0.phase == 1, 103);
        assert!(arg1 == arg0.executed, 104);
        assert!(0x2::balance::value<T0>(&arg2) >= arg3, 108);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg1 + 1, arg2);
        arg0.executed = arg1 + 1;
    }

    public fun quote_in(arg0: &Session, arg1: u8) : u64 {
        assert!(arg1 < 3, 113);
        if (*0x1::vector::borrow<u8>(&arg0.quoted, (arg1 as u64)) == 0) {
            principal_for_notional(arg0.notional, arg1)
        } else {
            *0x1::vector::borrow<u64>(&arg0.expected, (arg1 as u64))
        }
    }

    public fun record_quote(arg0: &mut Session, arg1: u8, arg2: u8, arg3: u64) {
        assert!(arg0.phase == 0, 103);
        assert!(arg2 < 3, 113);
        assert!(arg1 < arg0.hops, 104);
        let v0 = *0x1::vector::borrow<u8>(&arg0.quoted, (arg2 as u64));
        assert!(arg1 == v0, 104);
        *0x1::vector::borrow_mut<u64>(&mut arg0.expected, (arg2 as u64)) = arg3;
        *0x1::vector::borrow_mut<u8>(&mut arg0.quoted, (arg2 as u64)) = v0 + 1;
    }

    public fun rung(arg0: &Session) : u8 {
        arg0.rung
    }

    public fun seed<T0>(arg0: &mut Session, arg1: 0x2::balance::Balance<T0>) {
        assert!(arg0.armed, 107);
        assert!(arg0.phase == 1, 103);
        assert!(arg0.executed == 0, 104);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, 0, arg1);
    }

    public fun settle<T0>(arg0: &mut Session, arg1: 0x2::balance::Balance<T0>) {
        assert!(arg0.armed, 107);
        assert!(arg0.phase == 1, 103);
        assert!(arg0.executed == arg0.hops, 110);
        let v0 = 0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, 255);
        0x2::balance::join<T0>(&mut v0, arg1);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, 255, v0);
    }

    public fun start<T0>(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Session {
        assert!(arg1 > 0, 112);
        assert!(arg4 > 0 && arg4 <= 8, 102);
        let v0 = 0x2::bag::new(arg6);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut v0, 255, 0x2::balance::zero<T0>());
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 3) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            0x1::vector::push_back<u64>(&mut v2, 0);
            v3 = v3 + 1;
        };
        Session{
            tag         : arg0,
            sender      : 0x2::tx_context::sender(arg6),
            notional    : arg1,
            rung        : 0,
            principal   : 0,
            flash_fee   : arg2,
            min_profit  : arg3,
            hops        : arg4,
            quoted      : v1,
            expected    : v2,
            executed    : 0,
            deadline_ms : arg5,
            phase       : 0,
            armed       : false,
            vault       : v0,
        }
    }

    public fun tag(arg0: &Session) : u128 {
        arg0.tag
    }

    public fun take<T0>(arg0: &mut Session, arg1: u8) : 0x2::balance::Balance<T0> {
        assert!(arg0.armed, 107);
        assert!(arg0.phase == 1, 103);
        assert!(arg1 == arg0.executed, 104);
        0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg1)
    }

    public fun take_final<T0>(arg0: &mut Session) : 0x2::balance::Balance<T0> {
        assert!(arg0.armed, 107);
        assert!(arg0.phase == 1, 103);
        assert!(arg0.executed == arg0.hops, 110);
        0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg0.hops)
    }

    // decompiled from Move bytecode v7
}

