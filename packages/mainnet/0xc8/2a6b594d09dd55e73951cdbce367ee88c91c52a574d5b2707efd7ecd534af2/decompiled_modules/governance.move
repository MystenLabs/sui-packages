module 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance {
    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        index: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        locked_ms: u64,
        votes: vector<0x2::object::ID>,
    }

    struct Ballot has copy, drop, store {
        yes: bool,
        weight: u64,
    }

    struct Proposal<phantom T0> has key {
        id: 0x2::object::UID,
        index: 0x2::object::ID,
        kind: u8,
        coin: 0x1::type_name::TypeName,
        bps: u64,
        proposer: address,
        position: 0x2::object::ID,
        yes: u64,
        no: u64,
        ballots: 0x2::table::Table<0x2::object::ID, Ballot>,
        opened_ms: u64,
        closed_ms: u64,
        applies_ms: u64,
        applied_ms: u64,
        supply_at_close: u64,
        state: u8,
    }

    struct UnlockTicket<phantom T0> {
        position: 0x2::object::ID,
        index: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        remaining: vector<0x2::object::ID>,
    }

    struct Locked has copy, drop {
        index: 0x2::object::ID,
        position: 0x2::object::ID,
        amount: u64,
    }

    struct Unlocked has copy, drop {
        index: 0x2::object::ID,
        position: 0x2::object::ID,
        amount: u64,
    }

    struct Proposed has copy, drop {
        index: 0x2::object::ID,
        proposal: 0x2::object::ID,
        kind: u8,
        coin: 0x1::type_name::TypeName,
        bps: u64,
        proposer: address,
        position: 0x2::object::ID,
    }

    struct Voted has copy, drop {
        proposal: 0x2::object::ID,
        position: 0x2::object::ID,
        yes: bool,
        weight: u64,
        total_yes: u64,
        total_no: u64,
    }

    struct Closed has copy, drop {
        proposal: 0x2::object::ID,
        passed: bool,
        yes: u64,
        no: u64,
        supply: u64,
    }

    struct Applied has copy, drop {
        proposal: 0x2::object::ID,
        ok: bool,
    }

    struct Vetoed has copy, drop {
        proposal: 0x2::object::ID,
    }

    public fun applies_ms<T0>(arg0: &Proposal<T0>) : u64 {
        arg0.applies_ms
    }

    public fun apply<T0, T1>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &mut Proposal<T0>, arg2: &0x2::clock::Clock) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        assert!(arg1.index == 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0), 101);
        assert!(arg1.state == 1, 111);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.applies_ms, 112);
        assert!(0x1::type_name::with_defining_ids<T1>() == arg1.coin, 113);
        let (v1, v2) = compute<T0>(arg0, arg1.kind, arg1.coin, arg1.bps, v0);
        if (v1) {
            if (arg1.kind == 0) {
                0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::add_coin<T0, T1>(arg0, v0);
            };
            if (arg1.kind == 0 || arg1.kind == 2) {
                0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::set_raised<T0>(arg0, arg1.coin, v0);
            };
            0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::set_targets<T0>(arg0, v2);
            if (arg1.kind == 1) {
                0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::mark_retiring<T0, T1>(arg0);
            };
            arg1.state = 4;
            arg1.applied_ms = v0;
        } else {
            arg1.state = 5;
        };
        let v3 = Applied{
            proposal : 0x2::object::id<Proposal<T0>>(arg1),
            ok       : v1,
        };
        0x2::event::emit<Applied>(v3);
    }

    public fun begin_unlock<T0>(arg0: Position<T0>) : UnlockTicket<T0> {
        let Position {
            id        : v0,
            index     : v1,
            balance   : v2,
            locked_ms : _,
            votes     : v4,
        } = arg0;
        0x2::object::delete(v0);
        UnlockTicket<T0>{
            position  : 0x2::object::id<Position<T0>>(&arg0),
            index     : v1,
            balance   : v2,
            remaining : v4,
        }
    }

    fun cast<T0>(arg0: &mut Proposal<T0>, arg1: &mut Position<T0>, arg2: bool) {
        let v0 = 0x2::object::id<Position<T0>>(arg1);
        let v1 = 0x2::balance::value<T0>(&arg1.balance);
        if (0x2::table::contains<0x2::object::ID, Ballot>(&arg0.ballots, v0)) {
            let v2 = 0x2::table::remove<0x2::object::ID, Ballot>(&mut arg0.ballots, v0);
            if (v2.yes) {
                arg0.yes = arg0.yes - v2.weight;
            } else {
                arg0.no = arg0.no - v2.weight;
            };
        } else {
            assert!(0x1::vector::length<0x2::object::ID>(&arg1.votes) < 32, 109);
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.votes, 0x2::object::id<Proposal<T0>>(arg0));
        };
        let v3 = Ballot{
            yes    : arg2,
            weight : v1,
        };
        0x2::table::add<0x2::object::ID, Ballot>(&mut arg0.ballots, v0, v3);
        if (arg2) {
            arg0.yes = arg0.yes + v1;
        } else {
            arg0.no = arg0.no + v1;
        };
        let v4 = Voted{
            proposal  : 0x2::object::id<Proposal<T0>>(arg0),
            position  : v0,
            yes       : arg2,
            weight    : v1,
            total_yes : arg0.yes,
            total_no  : arg0.no,
        };
        0x2::event::emit<Voted>(v4);
    }

    fun close<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &mut Proposal<T0>, arg2: bool, arg3: u64) {
        let v0 = if (arg2) {
            1
        } else {
            2
        };
        arg1.state = v0;
        arg1.closed_ms = arg3;
        let v1 = if (arg2) {
            arg3 + 86400000
        } else {
            0
        };
        arg1.applies_ms = v1;
        arg1.supply_at_close = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::clear_proposer<T0>(arg0, arg1.proposer, 0x2::object::id<Proposal<T0>>(arg1));
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::clear_proposer<T0>(arg0, 0x2::object::id_to_address(&arg1.position), 0x2::object::id<Proposal<T0>>(arg1));
        let v2 = Closed{
            proposal : 0x2::object::id<Proposal<T0>>(arg1),
            passed   : arg2,
            yes      : arg1.yes,
            no       : arg1.no,
            supply   : arg1.supply_at_close,
        };
        0x2::event::emit<Closed>(v2);
    }

    fun compute<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: u8, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64) : (bool, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::targets<T0>(arg0);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = vector[];
        let v3 = 0;
        let (v4, v5) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, u64>(v0);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x1::type_name::TypeName>(&v7)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(&v7, v8) == arg2) {
                v3 = *0x1::vector::borrow<u64>(&v6, v8);
            } else {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, *0x1::vector::borrow<0x1::type_name::TypeName>(&v7, v8));
                0x1::vector::push_back<u64>(&mut v2, *0x1::vector::borrow<u64>(&v6, v8));
            };
            v8 = v8 + 1;
        };
        if (arg1 == 0) {
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0, &arg2) || 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::held_contains<T0>(arg0, &arg2)) {
                return (false, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
            };
            if (0x1::vector::length<0x1::type_name::TypeName>(&v7) >= 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::max_coins()) {
                return (false, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
            };
            if (arg3 < 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::min_bps() || arg3 > 500) {
                return (false, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
            };
            v3 = arg3;
        } else if (arg1 == 1) {
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0, &arg2) || 0x1::vector::length<0x1::type_name::TypeName>(&v7) < 2) {
                return (false, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
            };
        } else if (arg1 == 2) {
            let v9 = if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0, &arg2)) {
                true
            } else if (arg3 == 0) {
                true
            } else {
                arg3 > 500
            };
            if (v9) {
                return (false, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
            };
            let v10 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::raised_ms<T0>(arg0, &arg2);
            if (v10 > 0 && arg4 < v10 + 604800000) {
                return (false, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
            };
            let v11 = v3 + arg3;
            v3 = v11;
            if (v11 > 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::high_for<T0>(arg0, &arg2, arg4)) {
                return (false, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
            };
        } else if (arg1 == 3) {
            let v12 = if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0, &arg2)) {
                true
            } else if (arg3 == 0) {
                true
            } else {
                v3 < arg3 + 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::min_bps()
            };
            if (v12) {
                return (false, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
            };
            v3 = v3 - arg3;
        } else {
            return (false, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
        };
        let v13 = if (arg1 == 1) {
            0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::bps()
        } else {
            0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::bps() - v3
        };
        let (v14, v15) = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::absorb(v2, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::highs<T0>(arg0, &v1, arg4), v13);
        if (!v14) {
            return (false, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
        };
        let v16 = 0x2::vec_map::from_keys_values<0x1::type_name::TypeName, u64>(v1, v15);
        if (arg1 != 1) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v16, arg2, v3);
        };
        (true, v16)
    }

    public fun finalize<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &mut Proposal<T0>, arg2: &0x2::clock::Clock) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        assert!(arg1.index == 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0), 101);
        assert!(arg1.state == 0, 107);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (try_close_early<T0>(arg0, arg1, v0)) {
            return
        };
        assert!(v0 >= arg1.opened_ms + 604800000, 110);
        let v1 = if (arg1.yes > arg1.no) {
            (arg1.yes as u128) * 10000 > (0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0) as u128) * (2000 as u128)
        } else {
            false
        };
        close<T0>(arg0, arg1, v1, v0);
    }

    public fun finish_unlock<T0>(arg0: UnlockTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let UnlockTicket {
            position  : v0,
            index     : v1,
            balance   : v2,
            remaining : v3,
        } = arg0;
        let v4 = v3;
        let v5 = v2;
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v4), 117);
        let v6 = Unlocked{
            index    : v1,
            position : v0,
            amount   : 0x2::balance::value<T0>(&v5),
        };
        0x2::event::emit<Unlocked>(v6);
        0x2::coin::from_balance<T0>(v5, arg1)
    }

    public fun lock<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Position<T0> {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::version_ok<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 102);
        let v1 = Position<T0>{
            id        : 0x2::object::new(arg3),
            index     : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            balance   : 0x2::coin::into_balance<T0>(arg1),
            locked_ms : 0x2::clock::timestamp_ms(arg2),
            votes     : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v2 = Locked{
            index    : v1.index,
            position : 0x2::object::id<Position<T0>>(&v1),
            amount   : v0,
        };
        0x2::event::emit<Locked>(v2);
        v1
    }

    public fun position_amount<T0>(arg0: &Position<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun position_locked_ms<T0>(arg0: &Position<T0>) : u64 {
        arg0.locked_ms
    }

    public fun position_votes<T0>(arg0: &Position<T0>) : vector<0x2::object::ID> {
        arg0.votes
    }

    public fun preview<T0, T1>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) : (bool, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        compute<T0>(arg0, arg1, 0x1::type_name::with_defining_ids<T1>(), arg2, 0x2::clock::timestamp_ms(arg3))
    }

    public fun propose<T0, T1>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &mut Position<T0>, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg1.index == 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0), 101);
        assert!(v0 >= arg1.locked_ms + 86400000, 103);
        assert!((0x2::balance::value<T0>(&arg1.balance) as u128) * 10000 >= (0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0) as u128) * (100 as u128), 104);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::object::id<Position<T0>>(arg1);
        assert!(!0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::proposer_open<T0>(arg0, v1), 105);
        assert!(!0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::proposer_open<T0>(arg0, 0x2::object::id_to_address(&v2)), 105);
        assert!(arg2 <= 3, 118);
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let (v4, _) = compute<T0>(arg0, arg2, v3, arg3, v0);
        assert!(v4, 106);
        let v6 = if (arg2 == 1) {
            0
        } else {
            arg3
        };
        let v7 = Proposal<T0>{
            id              : 0x2::object::new(arg5),
            index           : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            kind            : arg2,
            coin            : v3,
            bps             : v6,
            proposer        : v1,
            position        : v2,
            yes             : 0,
            no              : 0,
            ballots         : 0x2::table::new<0x2::object::ID, Ballot>(arg5),
            opened_ms       : v0,
            closed_ms       : 0,
            applies_ms      : 0,
            applied_ms      : 0,
            supply_at_close : 0,
            state           : 0,
        };
        let v8 = 0x2::object::id<Proposal<T0>>(&v7);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::set_proposer_open<T0>(arg0, v1, v8);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::set_proposer_open<T0>(arg0, 0x2::object::id_to_address(&v2), v8);
        let v9 = Proposed{
            index    : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            proposal : v8,
            kind     : arg2,
            coin     : v3,
            bps      : v7.bps,
            proposer : v1,
            position : 0x2::object::id<Position<T0>>(arg1),
        };
        0x2::event::emit<Proposed>(v9);
        let v10 = &mut v7;
        cast<T0>(v10, arg1, true);
        let v11 = &mut v7;
        try_close_early<T0>(arg0, v11, v0);
        0x2::transfer::share_object<Proposal<T0>>(v7);
    }

    public fun prune<T0>(arg0: &mut Position<T0>, arg1: &mut Proposal<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.state != 0, 107);
        let v0 = 0x2::object::id<Proposal<T0>>(arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.votes, &v0);
        assert!(v1, 116);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.votes, v2);
        release<T0>(arg1, 0x2::object::id<Position<T0>>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    fun release<T0>(arg0: &mut Proposal<T0>, arg1: 0x2::object::ID, arg2: u64) {
        if (!0x2::table::contains<0x2::object::ID, Ballot>(&arg0.ballots, arg1)) {
            return
        };
        let v0 = *0x2::table::borrow<0x2::object::ID, Ballot>(&arg0.ballots, arg1);
        if (arg0.state == 0) {
            0x2::table::remove<0x2::object::ID, Ballot>(&mut arg0.ballots, arg1);
            if (v0.yes) {
                arg0.yes = arg0.yes - v0.weight;
            } else {
                arg0.no = arg0.no - v0.weight;
            };
            let v1 = Voted{
                proposal  : 0x2::object::id<Proposal<T0>>(arg0),
                position  : arg1,
                yes       : v0.yes,
                weight    : 0,
                total_yes : arg0.yes,
                total_no  : arg0.no,
            };
            0x2::event::emit<Voted>(v1);
        } else if (v0.yes) {
            assert!(arg0.state != 1, 115);
            if (arg0.state == 4) {
                assert!(arg2 >= arg0.applied_ms + 604800000, 115);
            };
        };
    }

    public fun state<T0>(arg0: &Proposal<T0>) : u8 {
        arg0.state
    }

    public fun tally<T0>(arg0: &Proposal<T0>) : (u64, u64) {
        (arg0.yes, arg0.no)
    }

    fun try_close_early<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &mut Proposal<T0>, arg2: u64) : bool {
        let v0 = (0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0) as u128);
        if ((arg1.yes as u128) * 2 > v0) {
            close<T0>(arg0, arg1, true, arg2);
            true
        } else if ((arg1.no as u128) * 2 > v0) {
            close<T0>(arg0, arg1, false, arg2);
            true
        } else {
            false
        }
    }

    public fun unlock_proposal<T0>(arg0: &mut UnlockTicket<T0>, arg1: &mut Proposal<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<Proposal<T0>>(arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.remaining, &v0);
        assert!(v1, 116);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.remaining, v2);
        release<T0>(arg1, arg0.position, 0x2::clock::timestamp_ms(arg2));
    }

    public fun veto<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::GuardianCap, arg2: &mut Proposal<T0>, arg3: &0x2::clock::Clock) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_guardian<T0>(arg0, arg1);
        assert!(arg2.index == 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0), 101);
        assert!(arg2.state == 1, 111);
        assert!(0x2::clock::timestamp_ms(arg3) < arg2.applies_ms, 114);
        arg2.state = 3;
        let v0 = Vetoed{proposal: 0x2::object::id<Proposal<T0>>(arg2)};
        0x2::event::emit<Vetoed>(v0);
    }

    public fun vote<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &mut Position<T0>, arg2: &mut Proposal<T0>, arg3: bool, arg4: &0x2::clock::Clock) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg1.index == 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0) && arg2.index == 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0), 101);
        assert!(arg2.state == 0, 107);
        assert!(v0 < arg2.opened_ms + 604800000, 108);
        assert!(v0 >= arg1.locked_ms + 86400000, 103);
        cast<T0>(arg2, arg1, arg3);
        try_close_early<T0>(arg0, arg2, v0);
    }

    // decompiled from Move bytecode v7
}

