module 0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::game {
    struct Contest has key {
        id: 0x2::object::UID,
        tier: u8,
        title: vector<u8>,
        advertised_prize_sui_mist: u64,
        puzzle_commitment: vector<u8>,
        fund_kaku: 0x2::balance::Balance<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>,
        fund_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        entries: u64,
        entrants: 0x2::vec_set::VecSet<address>,
        starts_ms: u64,
        ends_ms: u64,
        active: bool,
        best_elapsed_ms: u64,
        best_player: address,
        settled: bool,
    }

    struct PlayTicket has store, key {
        id: 0x2::object::UID,
        contest_id: 0x2::object::ID,
        player: address,
        start_ms: u64,
        tier: u8,
    }

    struct ContestCreated has copy, drop {
        contest_id: 0x2::object::ID,
        tier: u8,
        ends_ms: u64,
        advertised_prize_sui_mist: u64,
    }

    struct Entered has copy, drop {
        contest_id: 0x2::object::ID,
        player: address,
        paid_kaku: u64,
        paid_sui_mist: u64,
        to_prize: u64,
        to_ops: u64,
        at_ms: u64,
    }

    struct PlayStarted has copy, drop {
        contest_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        player: address,
        start_ms: u64,
    }

    struct PlaySubmitted has copy, drop {
        contest_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        player: address,
        start_ms: u64,
        end_ms: u64,
        elapsed_ms: u64,
        solution_digest: vector<u8>,
        is_best: bool,
    }

    struct ContestSettled has copy, drop {
        contest_id: 0x2::object::ID,
        winner: address,
        payout_kaku: u64,
        payout_sui_mist: u64,
        elapsed_ms: u64,
    }

    public fun best_elapsed_ms(arg0: &Contest) : u64 {
        arg0.best_elapsed_ms
    }

    public fun best_player(arg0: &Contest) : address {
        arg0.best_player
    }

    fun contest_id(arg0: &PlayTicket) : 0x2::object::ID {
        arg0.contest_id
    }

    public fun create_contest(arg0: &0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::AdminCap, arg1: u8, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 3, 9);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::object::new(arg7);
        let v2 = Contest{
            id                        : v1,
            tier                      : arg1,
            title                     : arg2,
            advertised_prize_sui_mist : arg3,
            puzzle_commitment         : arg4,
            fund_kaku                 : 0x2::balance::zero<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>(),
            fund_sui                  : 0x2::balance::zero<0x2::sui::SUI>(),
            entries                   : 0,
            entrants                  : 0x2::vec_set::empty<address>(),
            starts_ms                 : v0,
            ends_ms                   : v0 + arg5,
            active                    : true,
            best_elapsed_ms           : 0,
            best_player               : @0x0,
            settled                   : false,
        };
        let v3 = ContestCreated{
            contest_id                : 0x2::object::uid_to_inner(&v1),
            tier                      : arg1,
            ends_ms                   : v2.ends_ms,
            advertised_prize_sui_mist : arg3,
        };
        0x2::event::emit<ContestCreated>(v3);
        0x2::transfer::share_object<Contest>(v2);
    }

    public fun ends_ms(arg0: &Contest) : u64 {
        arg0.ends_ms
    }

    public fun enter_with_kaku(arg0: &mut Contest, arg1: &0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::OpsConfig, arg2: 0x2::coin::Coin<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active && !arg0.settled, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 <= arg0.ends_ms, 6);
        let v1 = 0x2::coin::value<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>(&arg2);
        assert!(v1 == entry_kaku(arg0.tier), 2);
        let v2 = v1 * 0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::prize_bps(arg1) / 10000;
        let v3 = 0x2::coin::into_balance<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>(arg2);
        0x2::balance::join<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>(&mut arg0.fund_kaku, 0x2::balance::split<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>(&mut v3, v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>>(0x2::coin::from_balance<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>(v3, arg4), 0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::ops_wallet(arg1));
        arg0.entries = arg0.entries + 1;
        let v4 = 0x2::tx_context::sender(arg4);
        record_entrant(arg0, v4);
        let v5 = Entered{
            contest_id    : 0x2::object::id<Contest>(arg0),
            player        : v4,
            paid_kaku     : v1,
            paid_sui_mist : 0,
            to_prize      : v2,
            to_ops        : v1 - v2,
            at_ms         : v0,
        };
        0x2::event::emit<Entered>(v5);
    }

    public fun enter_with_sui(arg0: &mut Contest, arg1: &0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::OpsConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active && !arg0.settled, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 <= arg0.ends_ms, 6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 == entry_mist(arg0.tier), 2);
        let v2 = v1 * 0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::prize_bps(arg1) / 10000;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fund_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4), 0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::ops_wallet(arg1));
        arg0.entries = arg0.entries + 1;
        let v4 = 0x2::tx_context::sender(arg4);
        record_entrant(arg0, v4);
        let v5 = Entered{
            contest_id    : 0x2::object::id<Contest>(arg0),
            player        : v4,
            paid_kaku     : 0,
            paid_sui_mist : v1,
            to_prize      : v2,
            to_ops        : v1 - v2,
            at_ms         : v0,
        };
        0x2::event::emit<Entered>(v5);
    }

    public fun entries(arg0: &Contest) : u64 {
        arg0.entries
    }

    fun entry_kaku(arg0: u8) : u64 {
        if (arg0 == 1) {
            100
        } else if (arg0 == 2) {
            200
        } else {
            assert!(arg0 == 3, 9);
            300
        }
    }

    fun entry_mist(arg0: u8) : u64 {
        if (arg0 == 1) {
            1000000000
        } else if (arg0 == 2) {
            2000000000
        } else {
            assert!(arg0 == 3, 9);
            3000000000
        }
    }

    public fun fund_kaku(arg0: &Contest) : u64 {
        0x2::balance::value<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>(&arg0.fund_kaku)
    }

    public fun fund_sui(arg0: &Contest) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fund_sui)
    }

    public fun has_entered(arg0: &Contest, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.entrants, &arg1)
    }

    fun record_entrant(arg0: &mut Contest, arg1: address) {
        if (!0x2::vec_set::contains<address>(&arg0.entrants, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.entrants, arg1);
        };
    }

    public fun settle(arg0: &mut Contest, arg1: &0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.settled, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.ends_ms, 6);
        assert!(arg0.best_player != @0x0, 8);
        let v0 = arg0.best_player;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fund_sui);
        let v2 = v1;
        if (arg0.advertised_prize_sui_mist > 0 && v1 >= arg0.advertised_prize_sui_mist) {
            v2 = arg0.advertised_prize_sui_mist;
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fund_sui, v2), arg3), v0);
        };
        arg0.settled = true;
        arg0.active = false;
        let v3 = ContestSettled{
            contest_id      : 0x2::object::id<Contest>(arg0),
            winner          : v0,
            payout_kaku     : 0,
            payout_sui_mist : v2,
            elapsed_ms      : arg0.best_elapsed_ms,
        };
        0x2::event::emit<ContestSettled>(v3);
    }

    public fun start_play(arg0: &Contest, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : PlayTicket {
        assert!(arg0.active && !arg0.settled, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 <= arg0.ends_ms, 6);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.entrants, &v1), 3);
        let v2 = PlayTicket{
            id         : 0x2::object::new(arg2),
            contest_id : 0x2::object::id<Contest>(arg0),
            player     : v1,
            start_ms   : v0,
            tier       : arg0.tier,
        };
        let v3 = PlayStarted{
            contest_id : contest_id(&v2),
            ticket_id  : 0x2::object::id<PlayTicket>(&v2),
            player     : v2.player,
            start_ms   : v0,
        };
        0x2::event::emit<PlayStarted>(v3);
        v2
    }

    public fun submit_play(arg0: &mut Contest, arg1: PlayTicket, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active && !arg0.settled, 1);
        let PlayTicket {
            id         : v0,
            contest_id : v1,
            player     : v2,
            start_ms   : v3,
            tier       : _,
        } = arg1;
        let v5 = v0;
        assert!(v1 == 0x2::object::id<Contest>(arg0), 4);
        assert!(v2 == 0x2::tx_context::sender(arg4), 4);
        let v6 = 0x2::clock::timestamp_ms(arg3);
        assert!(v6 >= v3, 5);
        let v7 = v6 - v3;
        assert!(v7 >= 10000, 5);
        let v8 = arg0.best_elapsed_ms == 0 || v7 < arg0.best_elapsed_ms;
        if (v8) {
            arg0.best_elapsed_ms = v7;
            arg0.best_player = v2;
        };
        let v9 = PlaySubmitted{
            contest_id      : v1,
            ticket_id       : 0x2::object::uid_to_inner(&v5),
            player          : v2,
            start_ms        : v3,
            end_ms          : v6,
            elapsed_ms      : v7,
            solution_digest : arg2,
            is_best         : v8,
        };
        0x2::event::emit<PlaySubmitted>(v9);
        0x2::object::delete(v5);
    }

    public fun sweep_remainder_to_ops(arg0: &mut Contest, arg1: &0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::OpsConfig, arg2: &0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.settled, 1);
        let v0 = 0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::ops_wallet(arg1);
        let v1 = 0x2::balance::value<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>(&arg0.fund_kaku);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>>(0x2::coin::from_balance<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>(0x2::balance::split<0x6c0ac8c0e86b8f43a1d8710af3829e05c7284d202752c24a9576c42a756934b0::kaku::KAKU>(&mut arg0.fund_kaku, v1), arg3), v0);
        };
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fund_sui);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fund_sui, v2), arg3), v0);
        };
    }

    // decompiled from Move bytecode v7
}

