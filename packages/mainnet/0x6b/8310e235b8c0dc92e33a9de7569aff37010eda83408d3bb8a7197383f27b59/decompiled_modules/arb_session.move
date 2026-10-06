module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::arb_session {
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

    struct SearchDecision has copy, drop {
        tag: u128,
        sender: address,
        armed: bool,
        slot: u8,
        principal: u64,
        expected_out: u64,
        required_out: u64,
        hops: u8,
    }

    struct QuoteRecorded has copy, drop {
        tag: u128,
        sender: address,
        slot: u8,
        hop: u8,
        amount_in: u64,
        amount_out: u64,
    }

    struct ProfitEvent<phantom T0> has copy, drop {
        tag: u128,
        sender: address,
        rung: u8,
        principal: u64,
        expected_out: u64,
        profit: u64,
    }

    public fun sender(arg0: &Session) : address {
        arg0.sender
    }

    public fun arm(arg0: &mut Session, arg1: &0x2::clock::Clock) {
        assert!(!is_grid(arg0), 932);
        assert!(arg0.phase == 0, 922);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.deadline_ms, 925);
        arg0.phase = 1;
        arg0.armed = true;
        arg0.rung = 0;
        arg0.principal = principal_for_notional(arg0.notional, 0);
    }

    public fun armed(arg0: &Session) : bool {
        arg0.armed
    }

    fun assert_hops(arg0: u8) {
        assert!(arg0 > 0 && arg0 <= 8, 921);
    }

    fun assert_ready(arg0: &Session, arg1: &0x2::clock::Clock) {
        assert!(arg0.phase == 0, 922);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.deadline_ms, 925);
        let v0 = 0;
        while (v0 < 3) {
            assert!(*0x1::vector::borrow<u8>(&arg0.quoted, (v0 as u64)) == arg0.hops, 924);
            v0 = v0 + 1;
        };
    }

    public(friend) fun assert_round_complete(arg0: &Session, arg1: &0x2::clock::Clock) {
        assert!(is_grid(arg0), 933);
        assert_ready(arg0, arg1);
    }

    fun checked_required(arg0: u64, arg1: u64, arg2: u64) : u64 {
        checked_u128_to_u64((arg0 as u128) + (arg1 as u128) + (arg2 as u128))
    }

    fun checked_u128_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 934);
        (arg0 as u64)
    }

    fun choose_best(arg0: &Session, arg1: bool) : (bool, u8, u64, u64, u64) {
        let v0 = false;
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 3) {
            let v6 = if (arg1) {
                grid_at(arg0, v5)
            } else {
                principal_for_notional(arg0.notional, v5)
            };
            let v7 = if (arg1) {
                mul_div_ceil(arg0.flash_fee, v6, arg0.notional)
            } else {
                mul_div_ceil(arg0.flash_fee, ladder_bps(v5), 10000)
            };
            let v8 = checked_required(v6, v7, arg0.min_profit);
            let v9 = *0x1::vector::borrow<u64>(&arg0.expected, (v5 as u64));
            if (v9 >= v8) {
                let v10 = v9 - v6 - v7;
                if (!v0 || v10 > v1) {
                    v0 = true;
                    v2 = v10;
                    v3 = v9;
                    v4 = v8;
                };
            } else if (!v0 && v5 == 3 - 1) {
                v3 = v9;
                v4 = v8;
            };
            v5 = v5 + 1;
        };
        (v0, 0, v2, v3, v4)
    }

    public fun decide(arg0: &mut Session, arg1: &0x2::clock::Clock) {
        assert!(!is_grid(arg0), 932);
        assert_ready(arg0, arg1);
        let (v0, v1, _, v3, v4) = choose_best(arg0, false);
        arg0.phase = 1;
        arg0.armed = v0;
        if (v0) {
            arg0.rung = v1;
            arg0.principal = principal_for_notional(arg0.notional, v1);
        } else {
            let v5 = NoOpportunity{
                tag          : arg0.tag,
                sender       : arg0.sender,
                notional     : arg0.notional,
                expected_out : v3,
                required_out : v4,
                hops         : arg0.hops,
            };
            0x2::event::emit<NoOpportunity>(v5);
        };
    }

    public(friend) fun emit_search_decision(arg0: &Session, arg1: bool, arg2: u64, arg3: u64) {
        let v0 = SearchDecision{
            tag          : arg0.tag,
            sender       : arg0.sender,
            armed        : arg1,
            slot         : 0,
            principal    : arg0.principal,
            expected_out : arg2,
            required_out : arg3,
            hops         : arg0.hops,
        };
        0x2::event::emit<SearchDecision>(v0);
    }

    fun empty_quote_state() : (vector<u8>, vector<u64>) {
        (x"000000", vector[0, 0, 0])
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
            assert!(v10 == v7, 929);
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
            assert!(v10 == 0, 929);
            let v20 = 0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut v15, 255);
            assert!(0x2::balance::value<T0>(&v20) == 0, 928);
            0x2::coin::from_balance<T0>(v20, arg1)
        };
        0x2::bag::destroy_empty(v15);
        v17
    }

    public fun finish_quote<T0>(arg0: Session, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Session {
            tag         : _,
            sender      : _,
            notional    : _,
            rung        : _,
            principal   : _,
            flash_fee   : _,
            min_profit  : _,
            hops        : _,
            quoted      : _,
            expected    : _,
            executed    : v10,
            deadline_ms : _,
            phase       : v12,
            armed       : _,
            vault       : v14,
        } = arg0;
        let v15 = v14;
        assert!(v12 == 1, 922);
        assert!(v10 == 0, 929);
        let v16 = 0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut v15, 255);
        assert!(0x2::balance::value<T0>(&v16) == 0, 928);
        0x2::bag::destroy_empty(v15);
        0x2::coin::from_balance<T0>(v16, arg1)
    }

    public fun flash_fee(arg0: &Session) : u64 {
        arg0.flash_fee
    }

    fun grid_at(arg0: &Session, arg1: u8) : u64 {
        *0x1::vector::borrow<u64>(&arg0.expected, ((3 + arg1) as u64))
    }

    public fun grid_candidate(arg0: &Session, arg1: u8) : u64 {
        assert!(arg1 < 3, 920);
        if (is_grid(arg0)) {
            grid_at(arg0, arg1)
        } else {
            principal_for_notional(arg0.notional, arg1)
        }
    }

    public fun hops(arg0: &Session) : u8 {
        arg0.hops
    }

    fun is_grid(arg0: &Session) : bool {
        0x1::vector::length<u64>(&arg0.expected) == (3 as u64) * 2
    }

    public fun is_grid_session(arg0: &Session) : bool {
        is_grid(arg0)
    }

    public fun ladder_bps(arg0: u8) : u64 {
        if (arg0 == 0) {
            10000
        } else if (arg0 == 1) {
            5000
        } else {
            assert!(arg0 == 2, 920);
            2500
        }
    }

    public fun ladder_len() : u8 {
        3
    }

    public fun min_out_for_rung(arg0: u64, arg1: u8) : u64 {
        mul_div_floor(arg0, ladder_bps(arg1), 10000)
    }

    public fun min_profit(arg0: &Session) : u64 {
        arg0.min_profit
    }

    fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 930);
        if (arg0 == 0 || arg1 == 0) {
            0
        } else {
            checked_u128_to_u64(((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128))
        }
    }

    fun mul_div_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 930);
        checked_u128_to_u64((arg0 as u128) * (arg1 as u128) / (arg2 as u128))
    }

    public(friend) fun new_probe_session<T0>(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : Session {
        let v0 = if (arg2 > 0) {
            if (arg2 <= arg3) {
                if (arg3 <= arg4) {
                    arg4 <= arg1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 931);
        assert_hops(arg7);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0);
        0x1::vector::push_back<u64>(v2, 0);
        0x1::vector::push_back<u64>(v2, 0);
        0x1::vector::push_back<u64>(v2, arg2);
        0x1::vector::push_back<u64>(v2, arg3);
        0x1::vector::push_back<u64>(v2, arg4);
        let v3 = 0x2::tx_context::sender(arg9);
        Session{
            tag         : arg0,
            sender      : v3,
            notional    : arg1,
            rung        : 0,
            principal   : 0,
            flash_fee   : arg5,
            min_profit  : arg6,
            hops        : arg7,
            quoted      : x"000000",
            expected    : v1,
            executed    : 0,
            deadline_ms : arg8,
            phase       : 0,
            armed       : false,
            vault       : new_vault<T0>(arg9),
        }
    }

    fun new_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::bag::Bag {
        let v0 = 0x2::bag::new(arg0);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut v0, 255, 0x2::balance::zero<T0>());
        v0
    }

    public fun notional(arg0: &Session) : u64 {
        arg0.notional
    }

    public fun principal(arg0: &Session) : u64 {
        arg0.principal
    }

    public fun principal_for_notional(arg0: u64, arg1: u8) : u64 {
        let v0 = mul_div_floor(arg0, ladder_bps(arg1), 10000);
        assert!(v0 > 0, 930);
        v0
    }

    public(friend) fun probe_output(arg0: &Session, arg1: u8) : u64 {
        assert!(arg1 < 3, 920);
        *0x1::vector::borrow<u64>(&arg0.expected, (arg1 as u64))
    }

    public fun put<T0>(arg0: &mut Session, arg1: u8, arg2: 0x2::balance::Balance<T0>, arg3: u64) {
        assert!(arg0.armed, 926);
        assert!(arg0.phase == 1, 922);
        assert!(arg1 == arg0.executed, 923);
        let v0 = if (is_grid(arg0)) {
            scale_to_selected(arg0, arg3)
        } else {
            mul_div_floor(arg3, ladder_bps(arg0.rung), 10000)
        };
        let v1 = v0;
        if (arg1 + 1 == arg0.hops) {
            let v2 = checked_required(arg0.principal, mul_div_ceil(arg0.flash_fee, arg0.principal, arg0.notional), arg0.min_profit);
            if (v2 > v0) {
                v1 = v2;
            };
        };
        assert!(0x2::balance::value<T0>(&arg2) >= v1, 927);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg1 + 1, arg2);
        arg0.executed = arg1 + 1;
    }

    public fun quote_base_in(arg0: &Session) : u64 {
        if (is_grid(arg0)) {
            quote_in(arg0, 3 - 1)
        } else {
            quote_in(arg0, 0)
        }
    }

    public fun quote_in(arg0: &Session, arg1: u8) : u64 {
        assert!(arg1 < 3, 920);
        if (*0x1::vector::borrow<u8>(&arg0.quoted, (arg1 as u64)) == 0) {
            grid_candidate(arg0, arg1)
        } else {
            *0x1::vector::borrow<u64>(&arg0.expected, (arg1 as u64))
        }
    }

    public fun record_quote(arg0: &mut Session, arg1: u8, arg2: u8, arg3: u64) {
        assert!(arg0.phase == 0, 922);
        assert!(arg2 < 3, 920);
        assert!(arg1 < arg0.hops, 923);
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg0.quoted, (arg2 as u64));
        assert!(*v0 == arg1, 923);
        *0x1::vector::borrow_mut<u64>(&mut arg0.expected, (arg2 as u64)) = arg3;
        *v0 = *v0 + 1;
        let v1 = QuoteRecorded{
            tag        : arg0.tag,
            sender     : arg0.sender,
            slot       : arg2,
            hop        : arg1,
            amount_in  : quote_in(arg0, arg2),
            amount_out : arg3,
        };
        0x2::event::emit<QuoteRecorded>(v1);
    }

    public fun rung(arg0: &Session) : u8 {
        arg0.rung
    }

    fun scale_to_selected(arg0: &Session, arg1: u64) : u64 {
        mul_div_floor(arg1, arg0.principal, arg0.notional)
    }

    public fun search(arg0: &mut Session, arg1: &0x2::clock::Clock) {
        assert!(is_grid(arg0), 933);
        assert_ready(arg0, arg1);
        let (v0, v1, _, v3, v4) = choose_best(arg0, true);
        arg0.phase = 1;
        arg0.armed = v0;
        if (v0) {
            arg0.rung = v1;
            arg0.principal = grid_at(arg0, v1);
        };
        let v5 = SearchDecision{
            tag          : arg0.tag,
            sender       : arg0.sender,
            armed        : v0,
            slot         : v1,
            principal    : arg0.principal,
            expected_out : v3,
            required_out : v4,
            hops         : arg0.hops,
        };
        0x2::event::emit<SearchDecision>(v5);
    }

    public fun seed<T0>(arg0: &mut Session, arg1: 0x2::balance::Balance<T0>) {
        assert!(arg0.armed, 926);
        assert!(arg0.phase == 1, 922);
        assert!(arg0.executed == 0, 923);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, 0, arg1);
    }

    public(friend) fun set_probes(arg0: &mut Session, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0.phase == 0, 922);
        let v0 = if (arg1 > 0) {
            if (arg1 <= arg2) {
                if (arg2 <= arg3) {
                    arg3 <= arg0.notional
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 931);
        *0x1::vector::borrow_mut<u64>(&mut arg0.expected, 3) = arg1;
        *0x1::vector::borrow_mut<u64>(&mut arg0.expected, 4) = arg2;
        *0x1::vector::borrow_mut<u64>(&mut arg0.expected, 5) = arg3;
        let v1 = 0;
        while (v1 < 3) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.expected, (v1 as u64)) = 0;
            *0x1::vector::borrow_mut<u8>(&mut arg0.quoted, (v1 as u64)) = 0;
            v1 = v1 + 1;
        };
    }

    public fun settle<T0>(arg0: &mut Session, arg1: 0x2::balance::Balance<T0>) {
        assert!(arg0.armed, 926);
        assert!(arg0.phase == 1, 922);
        assert!(arg0.executed == arg0.hops, 929);
        let v0 = 0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, 255);
        0x2::balance::join<T0>(&mut v0, arg1);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, 255, v0);
    }

    public(friend) fun settle_probe_search(arg0: &mut Session, arg1: bool, arg2: u64, arg3: u64) {
        assert!(arg0.phase == 0, 922);
        arg0.phase = 1;
        arg0.armed = arg1;
        arg0.rung = 0;
        *0x1::vector::borrow_mut<u64>(&mut arg0.expected, 0) = arg3;
        if (arg1) {
            assert!(arg2 > 0, 930);
            arg0.principal = arg2;
        } else {
            arg0.principal = 0;
        };
    }

    public fun start<T0>(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Session {
        assert!(arg1 > 0, 930);
        assert_hops(arg4);
        let (v0, v1) = empty_quote_state();
        let v2 = 0x2::tx_context::sender(arg6);
        Session{
            tag         : arg0,
            sender      : v2,
            notional    : arg1,
            rung        : 0,
            principal   : 0,
            flash_fee   : arg2,
            min_profit  : arg3,
            hops        : arg4,
            quoted      : v0,
            expected    : v1,
            executed    : 0,
            deadline_ms : arg5,
            phase       : 0,
            armed       : false,
            vault       : new_vault<T0>(arg6),
        }
    }

    public fun start_grid<T0>(arg0: u128, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Session {
        assert_hops(arg4);
        assert!(0x1::vector::length<u64>(&arg1) == (3 as u64), 931);
        let v0 = *0x1::vector::borrow<u64>(&arg1, 0);
        let v1 = *0x1::vector::borrow<u64>(&arg1, 1);
        let v2 = *0x1::vector::borrow<u64>(&arg1, 2);
        let v3 = if (v0 > 0) {
            if (v0 < v1) {
                v1 < v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 931);
        let v4 = vector[0, 0, 0];
        0x1::vector::append<u64>(&mut v4, arg1);
        let v5 = 0x2::tx_context::sender(arg6);
        Session{
            tag         : arg0,
            sender      : v5,
            notional    : v2,
            rung        : 0,
            principal   : 0,
            flash_fee   : arg2,
            min_profit  : arg3,
            hops        : arg4,
            quoted      : x"000000",
            expected    : v4,
            executed    : 0,
            deadline_ms : arg5,
            phase       : 0,
            armed       : false,
            vault       : new_vault<T0>(arg6),
        }
    }

    public fun tag(arg0: &Session) : u128 {
        arg0.tag
    }

    public fun take<T0>(arg0: &mut Session, arg1: u8) : 0x2::balance::Balance<T0> {
        assert!(arg0.armed, 926);
        assert!(arg0.phase == 1, 922);
        assert!(arg1 == arg0.executed, 923);
        0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg1)
    }

    public fun take_final<T0>(arg0: &mut Session) : 0x2::balance::Balance<T0> {
        assert!(arg0.armed, 926);
        assert!(arg0.phase == 1, 922);
        assert!(arg0.executed == arg0.hops, 929);
        0x2::bag::remove<u8, 0x2::balance::Balance<T0>>(&mut arg0.vault, arg0.hops)
    }

    // decompiled from Move bytecode v7
}

