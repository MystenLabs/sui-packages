module 0xf70ec3e74c3e0004bc627d34e6f5cea59a8696396145a20368d4978b1816c234::groupbets {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        treasury: address,
        fee_bps: u64,
        min_stake: u64,
        dispute_ms: u64,
        vote_ms: u64,
        settle_grace_ms: u64,
        paused: bool,
    }

    struct Entry has copy, drop, store {
        side: u8,
        amount: u64,
        claimed: bool,
    }

    struct Terms has copy, drop, store {
        treasury: address,
        fee_bps: u64,
        min_stake: u64,
        dispute_ms: u64,
        vote_ms: u64,
        settle_grace_ms: u64,
    }

    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        ref: vector<u8>,
        created_ms: u64,
        close_ms: u64,
        closed: bool,
        terms: Terms,
        pot: 0x2::balance::Balance<T0>,
        yes_total: u64,
        no_total: u64,
        yes_count: u64,
        no_count: u64,
        entries: 0x2::table::Table<address, Entry>,
        status: u8,
        proposal: u8,
        proposed_ms: u64,
        disputer: address,
        vote_end_ms: u64,
        votes: 0x2::table::Table<address, u8>,
        yes_votes: u64,
        no_votes: u64,
        void_votes: u64,
        outcome: u8,
        refund: bool,
        fee: u64,
        distributable: u64,
        winners_left: u64,
        paid: u64,
    }

    struct MarketCreated has copy, drop {
        market: 0x2::object::ID,
        creator: address,
        ref: vector<u8>,
        close_ms: u64,
        fee_bps: u64,
        min_stake: u64,
    }

    struct Staked has copy, drop {
        market: 0x2::object::ID,
        user: address,
        side: u8,
        amount: u64,
        stake: u64,
        yes_total: u64,
        no_total: u64,
    }

    struct Closed has copy, drop {
        market: 0x2::object::ID,
        close_ms: u64,
    }

    struct ResolutionProposed has copy, drop {
        market: 0x2::object::ID,
        outcome: u8,
        proposed_ms: u64,
        dispute_end_ms: u64,
    }

    struct Disputed has copy, drop {
        market: 0x2::object::ID,
        by: address,
        vote_end_ms: u64,
    }

    struct VoteStarted has copy, drop {
        market: 0x2::object::ID,
        by: address,
        vote_end_ms: u64,
    }

    struct Voted has copy, drop {
        market: 0x2::object::ID,
        user: address,
        outcome: u8,
        yes_votes: u64,
        no_votes: u64,
        void_votes: u64,
    }

    struct Finalized has copy, drop {
        market: 0x2::object::ID,
        outcome: u8,
        refund: bool,
        by_vote: bool,
        yes_total: u64,
        no_total: u64,
        fee: u64,
        distributable: u64,
    }

    struct Claimed has copy, drop {
        market: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    struct DustSwept has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
    }

    struct Voided has copy, drop {
        market: 0x2::object::ID,
        by_admin: bool,
    }

    struct ConfigChanged has copy, drop {
        treasury: address,
        fee_bps: u64,
        min_stake: u64,
        dispute_ms: u64,
        vote_ms: u64,
        settle_grace_ms: u64,
        paused: bool,
    }

    public fun admin_void<T0>(arg0: &AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status != 3, 9);
        arg1.closed = true;
        settle<T0>(arg1, 2, false, arg2);
        let v0 = Voided{
            market   : 0x2::object::id<Market<T0>>(arg1),
            by_admin : true,
        };
        0x2::event::emit<Voided>(v0);
    }

    fun changed(arg0: &Config) {
        let v0 = ConfigChanged{
            treasury        : arg0.treasury,
            fee_bps         : arg0.fee_bps,
            min_stake       : arg0.min_stake,
            dispute_ms      : arg0.dispute_ms,
            vote_ms         : arg0.vote_ms,
            settle_grace_ms : arg0.settle_grace_ms,
            paused          : arg0.paused,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun claim<T0>(arg0: &mut Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        claim_for<T0>(arg0, v0, arg1);
    }

    public fun claim_for<T0>(arg0: &mut Market<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3, 16);
        assert!(0x2::table::contains<address, Entry>(&arg0.entries, arg1), 17);
        assert!(!0x2::table::borrow<address, Entry>(&arg0.entries, arg1).claimed, 18);
        let v0 = owed<T0>(arg0, arg1);
        assert!(v0 > 0, 17);
        0x2::table::borrow_mut<address, Entry>(&mut arg0.entries, arg1).claimed = true;
        arg0.paid = arg0.paid + v0;
        let v1 = 0x2::object::id<Market<T0>>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.pot, v0, arg2), arg1);
        let v2 = Claimed{
            market : v1,
            user   : arg1,
            amount : v0,
        };
        0x2::event::emit<Claimed>(v2);
        if (!arg0.refund) {
            arg0.winners_left = arg0.winners_left - 1;
            if (arg0.winners_left == 0) {
                let v3 = 0x2::balance::value<T0>(&arg0.pot);
                if (v3 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.pot, v3, arg2), arg0.terms.treasury);
                    let v4 = DustSwept{
                        market : v1,
                        amount : v3,
                    };
                    0x2::event::emit<DustSwept>(v4);
                };
            };
        };
    }

    public fun close<T0>(arg0: &mut Market<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0 && !arg0.closed, 9);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.close_ms) {
            assert!(0x2::tx_context::sender(arg2) == arg0.creator, 7);
            arg0.close_ms = v0;
        };
        arg0.closed = true;
        let v1 = Closed{
            market   : 0x2::object::id<Market<T0>>(arg0),
            close_ms : arg0.close_ms,
        };
        0x2::event::emit<Closed>(v1);
    }

    public fun close_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.close_ms
    }

    public fun config_terms(arg0: &Config) : (address, u64, u64, bool) {
        (arg0.treasury, arg0.fee_bps, arg0.min_stake, arg0.paused)
    }

    public fun counts<T0>(arg0: &Market<T0>) : (u64, u64) {
        (arg0.yes_count, arg0.no_count)
    }

    public fun create<T0>(arg0: &Config, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Market<T0> {
        assert!(!arg0.paused, 1);
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 > 0 && v0 <= 64, 20);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2 > v1, 2);
        let v2 = Terms{
            treasury        : arg0.treasury,
            fee_bps         : arg0.fee_bps,
            min_stake       : arg0.min_stake,
            dispute_ms      : arg0.dispute_ms,
            vote_ms         : arg0.vote_ms,
            settle_grace_ms : arg0.settle_grace_ms,
        };
        let v3 = Market<T0>{
            id            : 0x2::object::new(arg4),
            creator       : 0x2::tx_context::sender(arg4),
            ref           : arg1,
            created_ms    : v1,
            close_ms      : arg2,
            closed        : false,
            terms         : v2,
            pot           : 0x2::balance::zero<T0>(),
            yes_total     : 0,
            no_total      : 0,
            yes_count     : 0,
            no_count      : 0,
            entries       : 0x2::table::new<address, Entry>(arg4),
            status        : 0,
            proposal      : 255,
            proposed_ms   : 0,
            disputer      : @0x0,
            vote_end_ms   : 0,
            votes         : 0x2::table::new<address, u8>(arg4),
            yes_votes     : 0,
            no_votes      : 0,
            void_votes    : 0,
            outcome       : 255,
            refund        : false,
            fee           : 0,
            distributable : 0,
            winners_left  : 0,
            paid          : 0,
        };
        let v4 = MarketCreated{
            market    : 0x2::object::id<Market<T0>>(&v3),
            creator   : v3.creator,
            ref       : v3.ref,
            close_ms  : arg2,
            fee_bps   : v3.terms.fee_bps,
            min_stake : v3.terms.min_stake,
        };
        0x2::event::emit<MarketCreated>(v4);
        v3
    }

    public fun creator<T0>(arg0: &Market<T0>) : address {
        arg0.creator
    }

    public fun deadlines<T0>(arg0: &Market<T0>) : (u64, u64, u64) {
        (arg0.proposed_ms + arg0.terms.dispute_ms, arg0.vote_end_ms, arg0.close_ms + arg0.terms.settle_grace_ms)
    }

    public fun dispute<T0>(arg0: &mut Market<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 9);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 < arg0.proposed_ms + arg0.terms.dispute_ms, 11);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v1 != arg0.creator, 13);
        assert!(0x2::table::contains<address, Entry>(&arg0.entries, v1), 12);
        arg0.status = 2;
        arg0.disputer = v1;
        arg0.vote_end_ms = v0 + arg0.terms.vote_ms;
        let v2 = Disputed{
            market      : 0x2::object::id<Market<T0>>(arg0),
            by          : v1,
            vote_end_ms : arg0.vote_end_ms,
        };
        0x2::event::emit<Disputed>(v2);
    }

    public fun entry<T0>(arg0: &Market<T0>, arg1: address) : (bool, u8, u64, bool) {
        if (!0x2::table::contains<address, Entry>(&arg0.entries, arg1)) {
            return (false, 255, 0, false)
        };
        let v0 = *0x2::table::borrow<address, Entry>(&arg0.entries, arg1);
        (true, v0.side, v0.amount, v0.claimed)
    }

    public fun finalize<T0>(arg0: &mut Market<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.status == 1) {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.proposed_ms + arg0.terms.dispute_ms, 14);
            let v0 = arg0.proposal;
            settle<T0>(arg0, v0, false, arg2);
        } else {
            assert!(arg0.status == 2, 9);
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.vote_end_ms || votes_cast<T0>(arg0) == voters<T0>(arg0), 14);
            let v1 = tally(arg0.yes_votes, arg0.no_votes, arg0.void_votes, arg0.proposal);
            settle<T0>(arg0, v1, true, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id              : 0x2::object::new(arg0),
            treasury        : 0x2::tx_context::sender(arg0),
            fee_bps         : 200,
            min_stake       : 1000000,
            dispute_ms      : 86400000,
            vote_ms         : 86400000,
            settle_grace_ms : 7 * 86400000,
            paused          : false,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    fun is_voter<T0>(arg0: &Market<T0>, arg1: address) : bool {
        arg1 == arg0.creator || 0x2::table::contains<address, Entry>(&arg0.entries, arg1)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun outcome<T0>(arg0: &Market<T0>) : (u8, bool, u64, u64) {
        (arg0.outcome, arg0.refund, arg0.fee, arg0.distributable)
    }

    fun owed<T0>(arg0: &Market<T0>, arg1: address) : u64 {
        let v0 = *0x2::table::borrow<address, Entry>(&arg0.entries, arg1);
        if (v0.claimed) {
            return 0
        };
        if (arg0.refund) {
            return v0.amount
        };
        if (v0.side != arg0.outcome) {
            return 0
        };
        let v1 = if (arg0.outcome == 0) {
            arg0.yes_total
        } else {
            arg0.no_total
        };
        v0.amount + mul_div(v0.amount, arg0.distributable, v1)
    }

    public fun payout_of<T0>(arg0: &Market<T0>, arg1: address) : u64 {
        if (arg0.status != 3 || !0x2::table::contains<address, Entry>(&arg0.entries, arg1)) {
            0
        } else {
            owed<T0>(arg0, arg1)
        }
    }

    public fun pools<T0>(arg0: &Market<T0>) : (u64, u64) {
        (arg0.yes_total, arg0.no_total)
    }

    public fun pot_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    public fun proposal<T0>(arg0: &Market<T0>) : u8 {
        arg0.proposal
    }

    public fun propose_resolution<T0>(arg0: &mut Market<T0>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 7);
        assert!(arg0.status == 0, 9);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.close_ms, 8);
        assert!(arg1 <= 2, 10);
        arg0.closed = true;
        arg0.status = 1;
        arg0.proposal = arg1;
        arg0.proposed_ms = v0;
        let v1 = ResolutionProposed{
            market         : 0x2::object::id<Market<T0>>(arg0),
            outcome        : arg1,
            proposed_ms    : v0,
            dispute_end_ms : v0 + arg0.terms.dispute_ms,
        };
        0x2::event::emit<ResolutionProposed>(v1);
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 1000, 19);
        arg1.fee_bps = arg2;
        changed(arg1);
    }

    public fun set_min_stake(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 > 0, 21);
        arg1.min_stake = arg2;
        changed(arg1);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        changed(arg1);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.treasury = arg2;
        changed(arg1);
    }

    public fun set_windows(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 21);
        arg1.dispute_ms = arg2;
        arg1.vote_ms = arg3;
        arg1.settle_grace_ms = arg4;
        changed(arg1);
    }

    fun settle<T0>(arg0: &mut Market<T0>, arg1: u8, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.status = 3;
        arg0.closed = true;
        arg0.outcome = arg1;
        let (v0, v1, v2) = if (arg1 == 0) {
            (arg0.yes_total, arg0.no_total, arg0.yes_count)
        } else if (arg1 == 1) {
            (arg0.no_total, arg0.yes_total, arg0.no_count)
        } else {
            (0, 0, 0)
        };
        if (v0 == 0 || v1 == 0) {
            arg0.refund = true;
        } else {
            let v3 = mul_div(v1, arg0.terms.fee_bps, 10000);
            arg0.fee = v3;
            arg0.distributable = v1 - v3;
            arg0.winners_left = v2;
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.pot, v3, arg3), arg0.terms.treasury);
            };
        };
        let v4 = Finalized{
            market        : 0x2::object::id<Market<T0>>(arg0),
            outcome       : arg1,
            refund        : arg0.refund,
            by_vote       : arg2,
            yes_total     : arg0.yes_total,
            no_total      : arg0.no_total,
            fee           : arg0.fee,
            distributable : arg0.distributable,
        };
        0x2::event::emit<Finalized>(v4);
    }

    public fun share<T0>(arg0: Market<T0>) {
        0x2::transfer::share_object<Market<T0>>(arg0);
    }

    public fun stake<T0>(arg0: &Config, arg1: &mut Market<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = if (arg1.status == 0) {
            if (!arg1.closed) {
                0x2::clock::timestamp_ms(arg4) < arg1.close_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        assert!(arg2 == 0 || arg2 == 1, 4);
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 >= arg1.terms.min_stake, 5);
        let v2 = 0x2::tx_context::sender(arg5);
        if (0x2::table::contains<address, Entry>(&arg1.entries, v2)) {
            let v3 = 0x2::table::borrow_mut<address, Entry>(&mut arg1.entries, v2);
            assert!(v3.side == arg2, 6);
            v3.amount = v3.amount + v1;
        } else {
            let v4 = Entry{
                side    : arg2,
                amount  : v1,
                claimed : false,
            };
            0x2::table::add<address, Entry>(&mut arg1.entries, v2, v4);
            if (arg2 == 0) {
                arg1.yes_count = arg1.yes_count + 1;
            } else {
                arg1.no_count = arg1.no_count + 1;
            };
        };
        if (arg2 == 0) {
            arg1.yes_total = arg1.yes_total + v1;
        } else {
            arg1.no_total = arg1.no_total + v1;
        };
        0x2::balance::join<T0>(&mut arg1.pot, 0x2::coin::into_balance<T0>(arg3));
        let v5 = Staked{
            market    : 0x2::object::id<Market<T0>>(arg1),
            user      : v2,
            side      : arg2,
            amount    : v1,
            stake     : 0x2::table::borrow<address, Entry>(&arg1.entries, v2).amount,
            yes_total : arg1.yes_total,
            no_total  : arg1.no_total,
        };
        0x2::event::emit<Staked>(v5);
    }

    public fun start_vote<T0>(arg0: &mut Market<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 9);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.close_ms + arg0.terms.settle_grace_ms, 14);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Entry>(&arg0.entries, v1), 12);
        arg0.closed = true;
        arg0.status = 2;
        arg0.vote_end_ms = v0 + arg0.terms.vote_ms;
        let v2 = VoteStarted{
            market      : 0x2::object::id<Market<T0>>(arg0),
            by          : v1,
            vote_end_ms : arg0.vote_end_ms,
        };
        0x2::event::emit<VoteStarted>(v2);
    }

    public fun status<T0>(arg0: &Market<T0>) : u8 {
        arg0.status
    }

    public fun tallies<T0>(arg0: &Market<T0>) : (u64, u64, u64) {
        (arg0.yes_votes, arg0.no_votes, arg0.void_votes)
    }

    fun tally(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : u8 {
        if (arg0 > arg1 && arg0 > arg2) {
            0
        } else if (arg1 > arg0 && arg1 > arg2) {
            1
        } else if (arg2 > arg0 && arg2 > arg1) {
            2
        } else if (arg3 <= 2) {
            arg3
        } else {
            2
        }
    }

    public fun void<T0>(arg0: &mut Market<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 7);
        let v0 = if (arg0.status == 0) {
            if (!arg0.closed) {
                0x2::clock::timestamp_ms(arg1) < arg0.close_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9);
        arg0.closed = true;
        settle<T0>(arg0, 2, false, arg2);
        let v1 = Voided{
            market   : 0x2::object::id<Market<T0>>(arg0),
            by_admin : false,
        };
        0x2::event::emit<Voided>(v1);
    }

    public fun vote<T0>(arg0: &mut Market<T0>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 9);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.vote_end_ms, 11);
        assert!(arg1 <= 2, 10);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_voter<T0>(arg0, v0), 12);
        assert!(!0x2::table::contains<address, u8>(&arg0.votes, v0), 15);
        0x2::table::add<address, u8>(&mut arg0.votes, v0, arg1);
        if (arg1 == 0) {
            arg0.yes_votes = arg0.yes_votes + 1;
        } else if (arg1 == 1) {
            arg0.no_votes = arg0.no_votes + 1;
        } else {
            arg0.void_votes = arg0.void_votes + 1;
        };
        let v1 = Voted{
            market     : 0x2::object::id<Market<T0>>(arg0),
            user       : v0,
            outcome    : arg1,
            yes_votes  : arg0.yes_votes,
            no_votes   : arg0.no_votes,
            void_votes : arg0.void_votes,
        };
        0x2::event::emit<Voted>(v1);
    }

    public fun vote_of<T0>(arg0: &Market<T0>, arg1: address) : u8 {
        if (0x2::table::contains<address, u8>(&arg0.votes, arg1)) {
            *0x2::table::borrow<address, u8>(&arg0.votes, arg1)
        } else {
            255
        }
    }

    public fun voters<T0>(arg0: &Market<T0>) : u64 {
        let v0 = if (0x2::table::contains<address, Entry>(&arg0.entries, arg0.creator)) {
            0
        } else {
            1
        };
        arg0.yes_count + arg0.no_count + v0
    }

    public fun votes_cast<T0>(arg0: &Market<T0>) : u64 {
        arg0.yes_votes + arg0.no_votes + arg0.void_votes
    }

    public fun winners_left<T0>(arg0: &Market<T0>) : u64 {
        arg0.winners_left
    }

    // decompiled from Move bytecode v7
}

