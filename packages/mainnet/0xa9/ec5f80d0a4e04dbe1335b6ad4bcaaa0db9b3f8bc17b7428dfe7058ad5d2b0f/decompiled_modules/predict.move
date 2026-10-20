module 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict {
    struct PredictAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CouncilCap has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        holder: address,
    }

    struct Seat has copy, drop, store {
        cap_id: 0x2::object::ID,
        holder: address,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        council: vector<Seat>,
        council_holders: vector<address>,
        treasury: address,
        markets: 0x2::table::Table<u64, 0x2::object::ID>,
        market_count: u64,
        creation_fee_mist: u64,
        council_fees_id: 0x2::object::ID,
        revoked_caps: vector<0x2::object::ID>,
    }

    struct CouncilFees has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        owed: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct Market has key {
        id: 0x2::object::UID,
        index: u64,
        question: 0x1::string::String,
        details: 0x1::string::String,
        source: 0x1::string::String,
        created_ms: u64,
        close_ms: u64,
        resolve_by_ms: u64,
        void_at_ms: u64,
        committee: vector<Seat>,
        treasury: address,
        creator: address,
        reviewed: bool,
        threshold: u64,
        dispute_window_ms: u64,
        votes: vector<u8>,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_yes: u64,
        pool_no: u64,
        open_tickets_yes: u64,
        open_tickets_no: u64,
        status: u8,
        outcome: u8,
        resolved_ms: u64,
        dispute_used: bool,
        fee_paid: u64,
        net_pot: u64,
        payout_base: u64,
        paid_cursor: u64,
        council_fee_bps: u64,
    }

    struct Ticket has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        amount: u64,
        placed_ms: u64,
    }

    struct CouncilCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        holder: address,
        active_seats: u64,
        by: address,
        ts: u64,
    }

    struct CouncilCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        holder: address,
        active_seats: u64,
        by: address,
        ts: u64,
    }

    struct TreasurySet has copy, drop {
        treasury: address,
        by: address,
        ts: u64,
    }

    struct Migrated has copy, drop {
        from_version: u64,
        to_version: u64,
        by: address,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        index: u64,
        question: 0x1::string::String,
        close_ms: u64,
        resolve_by_ms: u64,
        void_at_ms: u64,
        committee: vector<address>,
        council_caps: vector<0x2::object::ID>,
        threshold: u64,
        dispute_window_ms: u64,
        treasury: address,
        creator: address,
        creation_fee: u64,
        council_fee_bps: u64,
        reviewed: bool,
        by: address,
        ts: u64,
    }

    struct CreationFeeSet has copy, drop {
        fee_mist: u64,
        by: address,
        ts: u64,
    }

    struct Revoked has copy, drop {
        market_id: 0x2::object::ID,
        reason: 0x1::string::String,
        pool_yes: u64,
        pool_no: u64,
        by: address,
        ts: u64,
    }

    struct Reviewed has copy, drop {
        market_id: 0x2::object::ID,
        by: address,
        ts: u64,
    }

    struct BettingClosed has copy, drop {
        market_id: 0x2::object::ID,
        scheduled_close_ms: u64,
        close_ms: u64,
        by: address,
    }

    struct BetPlaced has copy, drop {
        market_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        amount: u64,
        pool_yes: u64,
        pool_no: u64,
        ts: u64,
    }

    struct VoteCast has copy, drop {
        market_id: 0x2::object::ID,
        member: address,
        cap_id: 0x2::object::ID,
        outcome: u8,
        ts: u64,
    }

    struct Resolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        by: address,
        cap_id: 0x2::object::ID,
        resolved_ms: u64,
        finalizes_at_ms: u64,
    }

    struct Disputed has copy, drop {
        market_id: 0x2::object::ID,
        member: address,
        cap_id: 0x2::object::ID,
        ts: u64,
        void_at_ms: u64,
    }

    struct Finalized has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        winning_pool: u64,
        losing_pool: u64,
        fee: u64,
        council_fee: u64,
        treasury_fee: u64,
        net_pot: u64,
        ts: u64,
    }

    struct OneSided has copy, drop {
        market_id: 0x2::object::ID,
        total: u64,
        fee: u64,
        council_fee: u64,
        treasury_fee: u64,
        ts: u64,
    }

    struct CouncilFeesAccrued has copy, drop {
        market_id: 0x2::object::ID,
        seats: vector<0x2::object::ID>,
        per_seat: u64,
        total: u64,
        ts: u64,
    }

    struct CouncilFeesClaimed has copy, drop {
        cap_id: 0x2::object::ID,
        holder: address,
        amount: u64,
        ts: u64,
    }

    struct Voided has copy, drop {
        market_id: 0x2::object::ID,
        invalid: bool,
        ts: u64,
    }

    struct Claimed has copy, drop {
        market_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        stake: u64,
        payout: u64,
        ts: u64,
    }

    struct Refunded has copy, drop {
        market_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        stake: u64,
        refund: u64,
        kind: u8,
        ts: u64,
    }

    struct TicketBurned has copy, drop {
        market_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        stake: u64,
        ts: u64,
    }

    fun accrue_council(arg0: &Config, arg1: &mut Market, arg2: &mut CouncilFees, arg3: u64, arg4: u64, arg5: u64) {
        if (arg3 == 0) {
            return
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.pool, arg4));
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Seat>(&arg1.committee)) {
            let v2 = 0x1::vector::borrow<Seat>(&arg1.committee, v1).cap_id;
            if (!0x1::vector::contains<0x2::object::ID>(&arg0.revoked_caps, &v2)) {
                if (0x2::table::contains<0x2::object::ID, u64>(&arg2.owed, v2)) {
                    let v3 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg2.owed, v2);
                    *v3 = *v3 + arg3;
                } else {
                    0x2::table::add<0x2::object::ID, u64>(&mut arg2.owed, v2, arg3);
                };
                0x1::vector::push_back<0x2::object::ID>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        let v4 = CouncilFeesAccrued{
            market_id : 0x2::object::id<Market>(arg1),
            seats     : v0,
            per_seat  : arg3,
            total     : arg4,
            ts        : arg5,
        };
        0x2::event::emit<CouncilFeesAccrued>(v4);
    }

    fun allocate(arg0: &mut Market, arg1: u64) : u64 {
        arg0.paid_cursor = arg0.paid_cursor + arg1;
        share_at(arg0.paid_cursor, arg1, arg0.net_pot, arg0.payout_base)
    }

    fun assert_fees(arg0: &Config, arg1: &CouncilFees) {
        assert!(0x2::object::id<CouncilFees>(arg1) == arg0.council_fees_id, 44);
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun bet(arg0: &Config, arg1: &mut Market, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.status == 0, 9);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg1.close_ms, 10);
        assert!(arg2 == 1 || arg2 == 2, 11);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= 100000000, 12);
        let v2 = 0x2::tx_context::sender(arg5);
        assert!(!holds_seat(&arg1.committee, v2), 13);
        assert!(!0x1::vector::contains<address>(&arg0.council_holders, &v2), 13);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        if (arg2 == 1) {
            arg1.pool_yes = arg1.pool_yes + v1;
            arg1.open_tickets_yes = arg1.open_tickets_yes + 1;
        } else {
            arg1.pool_no = arg1.pool_no + v1;
            arg1.open_tickets_no = arg1.open_tickets_no + 1;
        };
        let v3 = Ticket{
            id        : 0x2::object::new(arg5),
            market_id : 0x2::object::id<Market>(arg1),
            bettor    : v2,
            side      : arg2,
            amount    : v1,
            placed_ms : v0,
        };
        let v4 = BetPlaced{
            market_id : 0x2::object::id<Market>(arg1),
            ticket_id : 0x2::object::id<Ticket>(&v3),
            bettor    : v2,
            side      : arg2,
            amount    : v1,
            pool_yes  : arg1.pool_yes,
            pool_no   : arg1.pool_no,
            ts        : v0,
        };
        0x2::event::emit<BetPlaced>(v4);
        0x2::transfer::transfer<Ticket>(v3, v2);
    }

    public fun burn_losing_ticket(arg0: &Config, arg1: &mut Market, arg2: &mut CouncilFees, arg3: Ticket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_fees(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        try_finalize(arg0, arg1, arg2, v0, arg5);
        assert!(arg1.status == 2, 28);
        let (v1, v2, v3, v4) = consume(arg1, arg3, arg5);
        assert!(v3 != arg1.outcome, 30);
        let v5 = TicketBurned{
            market_id : 0x2::object::id<Market>(arg1),
            ticket_id : v1,
            bettor    : v2,
            side      : v3,
            stake     : v4,
            ts        : v0,
        };
        0x2::event::emit<TicketBurned>(v5);
    }

    public fun cap_config_id(arg0: &CouncilCap) : 0x2::object::ID {
        arg0.config_id
    }

    public fun cap_holder(arg0: &CouncilCap) : address {
        arg0.holder
    }

    public fun claim(arg0: &Config, arg1: &mut Market, arg2: &mut CouncilFees, arg3: Ticket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_fees(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        try_finalize(arg0, arg1, arg2, v0, arg5);
        assert!(arg1.status == 2, 28);
        let (v1, v2, v3, v4) = consume(arg1, arg3, arg5);
        assert!(v3 == arg1.outcome, 29);
        let v5 = allocate(arg1, v4);
        pay(arg1, v5, v2, arg5);
        let v6 = Claimed{
            market_id : 0x2::object::id<Market>(arg1),
            ticket_id : v1,
            bettor    : v2,
            side      : v3,
            stake     : v4,
            payout    : v5,
            ts        : v0,
        };
        0x2::event::emit<Claimed>(v6);
    }

    public fun claim_council_fees(arg0: &Config, arg1: &mut CouncilFees, arg2: &CouncilCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_fees(arg0, arg1);
        let v0 = arg2.holder;
        assert!(0x2::tx_context::sender(arg4) == v0, 43);
        let v1 = 0x2::object::id<CouncilCap>(arg2);
        let v2 = council_owed(arg1, v1);
        assert!(v2 > 0, 42);
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg1.owed, v1) = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.pool, v2), arg4), v0);
        let v3 = CouncilFeesClaimed{
            cap_id : v1,
            holder : v0,
            amount : v2,
            ts     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CouncilFeesClaimed>(v3);
    }

    public fun close_betting(arg0: &PredictAdminCap, arg1: &Config, arg2: &mut Market, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2.status == 0, 9);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg2.close_ms, 10);
        assert!(arg2.pool_yes > 0 && arg2.pool_no > 0, 16);
        arg2.close_ms = v0;
        let v1 = BettingClosed{
            market_id          : 0x2::object::id<Market>(arg2),
            scheduled_close_ms : arg2.close_ms,
            close_ms           : v0,
            by                 : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<BettingClosed>(v1);
    }

    public fun close_ms(arg0: &Market) : u64 {
        arg0.close_ms
    }

    public fun committee(arg0: &Config) : vector<address> {
        seat_holders(&arg0.council)
    }

    public fun committee_size() : u64 {
        5
    }

    fun consume(arg0: &mut Market, arg1: Ticket, arg2: &0x2::tx_context::TxContext) : (0x2::object::ID, address, u8, u64) {
        let Ticket {
            id        : v0,
            market_id : v1,
            bettor    : v2,
            side      : v3,
            amount    : v4,
            placed_ms : _,
        } = arg1;
        let v6 = v0;
        assert!(v1 == 0x2::object::id<Market>(arg0), 26);
        assert!(v2 == 0x2::tx_context::sender(arg2), 27);
        0x2::object::delete(v6);
        if (v3 == 1) {
            arg0.open_tickets_yes = arg0.open_tickets_yes - 1;
        } else {
            arg0.open_tickets_no = arg0.open_tickets_no - 1;
        };
        (0x2::object::uid_to_inner(&v6), v2, v3, v4)
    }

    public fun council(arg0: &Config) : vector<Seat> {
        arg0.council
    }

    public fun council_base(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 < arg1) {
            arg0
        } else {
            arg1
        };
        let v1 = fee_for(arg0 + arg1);
        if (v1 < v0) {
            v1
        } else {
            v0
        }
    }

    public fun council_caps(arg0: &Config) : vector<0x2::object::ID> {
        seat_caps(&arg0.council)
    }

    public fun council_fee_bps() : u64 {
        5000
    }

    public fun council_fees_id(arg0: &Config) : 0x2::object::ID {
        arg0.council_fees_id
    }

    public fun council_holders(arg0: &Config) : vector<address> {
        arg0.council_holders
    }

    public fun council_owed(arg0: &CouncilFees, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.owed, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.owed, arg1)
        } else {
            0
        }
    }

    public fun council_pool_value(arg0: &CouncilFees) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pool)
    }

    fun count_votes(arg0: &Config, arg1: &Market, arg2: u8) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg1.votes)) {
            if (*0x1::vector::borrow<u8>(&arg1.votes, v1) == arg2 && !0x1::vector::contains<0x2::object::ID>(&arg0.revoked_caps, &0x1::vector::borrow<Seat>(&arg1.committee, v1).cap_id)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun create_instance(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = PredictAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PredictAdminCap>(v1, v0);
        let v2 = CouncilFees{
            id   : 0x2::object::new(arg0),
            pool : 0x2::balance::zero<0x2::sui::SUI>(),
            owed : 0x2::table::new<0x2::object::ID, u64>(arg0),
        };
        let v3 = 0x2::object::id<CouncilFees>(&v2);
        0x2::transfer::share_object<CouncilFees>(v2);
        let v4 = Config{
            id                : 0x2::object::new(arg0),
            version           : 1,
            council           : 0x1::vector::empty<Seat>(),
            council_holders   : vector[],
            treasury          : v0,
            markets           : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            market_count      : 0,
            creation_fee_mist : 10000000000,
            council_fees_id   : v3,
            revoked_caps      : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Config>(v4);
        (0x2::object::id<PredictAdminCap>(&v1), 0x2::object::id<Config>(&v4), v3)
    }

    public fun create_market(arg0: &mut Config, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        assert!(v0 == arg0.creation_fee_mist, 36);
        let v1 = 0x2::tx_context::sender(arg8);
        assert!(!0x1::vector::contains<address>(&arg0.council_holders, &v1), 39);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg0.treasury);
        new_market(arg0, arg1, arg2, arg3, arg4, arg5, 86400000, v0, false, arg7, arg8);
    }

    public fun create_market_admin(arg0: &PredictAdminCap, arg1: &mut Config, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        new_market(arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0, true, arg8, arg9);
    }

    public fun creation_fee_mist(arg0: &Config) : u64 {
        arg0.creation_fee_mist
    }

    public fun default_creation_fee_mist() : u64 {
        10000000000
    }

    public fun default_dispute_window_ms() : u64 {
        86400000
    }

    public fun dispute(arg0: &Config, arg1: &mut Market, arg2: &CouncilCap, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.status == 1, 20);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg2.holder, 43);
        let v1 = 0x2::object::id<CouncilCap>(arg2);
        let (v2, v3) = seat_index(&arg1.committee, v1);
        assert!(v2, 17);
        assert!(*0x1::vector::borrow<u8>(&arg1.votes, v3) != arg1.outcome, 41);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.revoked_caps, &v1), 45);
        assert!(!arg1.dispute_used, 21);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        assert!(v4 < arg1.resolved_ms + arg1.dispute_window_ms, 22);
        arg1.dispute_used = true;
        arg1.votes = zero_votes(0x1::vector::length<u8>(&arg1.votes));
        arg1.outcome = 0;
        arg1.resolved_ms = 0;
        arg1.status = 0;
        let v5 = v4 + 86400000;
        if (v5 > arg1.void_at_ms) {
            arg1.void_at_ms = v5;
        };
        let v6 = Disputed{
            market_id  : 0x2::object::id<Market>(arg1),
            member     : v0,
            cap_id     : v1,
            ts         : v4,
            void_at_ms : arg1.void_at_ms,
        };
        0x2::event::emit<Disputed>(v6);
    }

    public fun dispute_used(arg0: &Market) : bool {
        arg0.dispute_used
    }

    public fun fee_bps() : u64 {
        200
    }

    public fun fee_for(arg0: u64) : u64 {
        arg0 - mul_div(arg0, 10000 - 200, 10000)
    }

    public fun fee_paid(arg0: &Market) : u64 {
        arg0.fee_paid
    }

    public fun final_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = fee_for(arg0);
        if (v0 < arg1) {
            v0
        } else {
            arg1
        }
    }

    public fun finalize(arg0: &Config, arg1: &mut Market, arg2: &mut CouncilFees, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_fees(arg0, arg2);
        assert!(try_finalize(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3), arg4), 23);
    }

    fun holds_seat(arg0: &vector<Seat>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Seat>(arg0)) {
            if (0x1::vector::borrow<Seat>(arg0, v0).holder == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (_, _, _) = create_instance(arg0);
    }

    public fun is_revoked(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.revoked_caps, &arg1)
    }

    public fun issue_council_cap(arg0: &PredictAdminCap, arg1: &mut Config, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2 != @0x0, 4);
        assert!(0x1::vector::length<Seat>(&arg1.council) < 5, 1);
        assert!(!holds_seat(&arg1.council, arg2), 2);
        let v0 = CouncilCap{
            id        : 0x2::object::new(arg4),
            config_id : 0x2::object::id<Config>(arg1),
            holder    : arg2,
        };
        let v1 = 0x2::object::id<CouncilCap>(&v0);
        let v2 = Seat{
            cap_id : v1,
            holder : arg2,
        };
        0x1::vector::push_back<Seat>(&mut arg1.council, v2);
        if (!0x1::vector::contains<address>(&arg1.council_holders, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.council_holders, arg2);
        };
        0x2::transfer::transfer<CouncilCap>(v0, arg2);
        let v3 = CouncilCapIssued{
            cap_id       : v1,
            holder       : arg2,
            active_seats : 0x1::vector::length<Seat>(&arg1.council),
            by           : 0x2::tx_context::sender(arg4),
            ts           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CouncilCapIssued>(v3);
    }

    public fun mark_reviewed(arg0: &PredictAdminCap, arg1: &Config, arg2: &mut Market, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(!arg2.reviewed, 40);
        arg2.reviewed = true;
        let v0 = Reviewed{
            market_id : 0x2::object::id<Market>(arg2),
            by        : 0x2::tx_context::sender(arg4),
            ts        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Reviewed>(v0);
    }

    public fun market_at(arg0: &Config, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.markets, arg1)
    }

    public fun market_committee(arg0: &Market) : vector<address> {
        seat_holders(&arg0.committee)
    }

    public fun market_council_caps(arg0: &Market) : vector<0x2::object::ID> {
        seat_caps(&arg0.committee)
    }

    public fun market_council_fee_bps(arg0: &Market) : u64 {
        arg0.council_fee_bps
    }

    public fun market_count(arg0: &Config) : u64 {
        arg0.market_count
    }

    public fun market_creator(arg0: &Market) : address {
        arg0.creator
    }

    public fun market_dispute_window_ms(arg0: &Market) : u64 {
        arg0.dispute_window_ms
    }

    public fun market_threshold(arg0: &Market) : u64 {
        arg0.threshold
    }

    public fun market_treasury(arg0: &Market) : address {
        arg0.treasury
    }

    fun matured(arg0: &Market, arg1: u64) : bool {
        if (arg0.status != 1) {
            return false
        };
        if (arg1 < arg0.resolved_ms + arg0.dispute_window_ms) {
            return false
        };
        true
    }

    public fun max_dispute_window_ms() : u64 {
        604800000
    }

    public fun migrate(arg0: &PredictAdminCap, arg1: &mut Config, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 32);
        arg1.version = 1;
        let v0 = Migrated{
            from_version : arg1.version,
            to_version   : 1,
            by           : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Migrated>(v0);
    }

    public fun min_bet_mist() : u64 {
        100000000
    }

    public fun min_dispute_window_ms() : u64 {
        3600000
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 34);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun net_pot(arg0: &Market) : u64 {
        arg0.net_pot
    }

    fun new_market(arg0: &mut Config, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<Seat>(&arg0.council) == 5, 3);
        let v0 = 5000;
        assert!(0x1::vector::length<u8>(&arg1) > 0 && 0x1::vector::length<u8>(&arg3) > 0, 6);
        assert!(0x1::vector::length<u8>(&arg1) <= 200, 5);
        assert!(0x1::vector::length<u8>(&arg2) <= 1000, 5);
        assert!(0x1::vector::length<u8>(&arg3) <= 300, 5);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg4 > v1, 7);
        assert!(arg5 > arg4, 8);
        assert!(arg5 - v1 <= 31622400000, 33);
        assert!(arg6 >= 3600000 && arg6 <= 604800000, 35);
        let v2 = arg0.council;
        let v3 = arg0.treasury;
        let v4 = arg0.market_count;
        let v5 = arg5 + 86400000;
        let v6 = Market{
            id                : 0x2::object::new(arg10),
            index             : v4,
            question          : 0x1::string::utf8(arg1),
            details           : 0x1::string::utf8(arg2),
            source            : 0x1::string::utf8(arg3),
            created_ms        : v1,
            close_ms          : arg4,
            resolve_by_ms     : arg5,
            void_at_ms        : v5,
            committee         : v2,
            treasury          : v3,
            creator           : 0x2::tx_context::sender(arg10),
            reviewed          : arg8,
            threshold         : 3,
            dispute_window_ms : arg6,
            votes             : zero_votes(5),
            pool              : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_yes          : 0,
            pool_no           : 0,
            open_tickets_yes  : 0,
            open_tickets_no   : 0,
            status            : 0,
            outcome           : 0,
            resolved_ms       : 0,
            dispute_used      : false,
            fee_paid          : 0,
            net_pot           : 0,
            payout_base       : 0,
            paid_cursor       : 0,
            council_fee_bps   : v0,
        };
        let v7 = 0x2::object::id<Market>(&v6);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.markets, v4, v7);
        arg0.market_count = v4 + 1;
        let v8 = MarketCreated{
            market_id         : v7,
            index             : v4,
            question          : v6.question,
            close_ms          : arg4,
            resolve_by_ms     : arg5,
            void_at_ms        : v5,
            committee         : seat_holders(&v2),
            council_caps      : seat_caps(&v2),
            threshold         : 3,
            dispute_window_ms : arg6,
            treasury          : v3,
            creator           : 0x2::tx_context::sender(arg10),
            creation_fee      : arg7,
            council_fee_bps   : v0,
            reviewed          : arg8,
            by                : 0x2::tx_context::sender(arg10),
            ts                : v1,
        };
        0x2::event::emit<MarketCreated>(v8);
        0x2::transfer::share_object<Market>(v6);
    }

    public fun open_tickets_no(arg0: &Market) : u64 {
        arg0.open_tickets_no
    }

    public fun open_tickets_yes(arg0: &Market) : u64 {
        arg0.open_tickets_yes
    }

    public fun outcome(arg0: &Market) : u8 {
        arg0.outcome
    }

    public fun outcome_invalid() : u8 {
        3
    }

    public fun paid_cursor(arg0: &Market) : u64 {
        arg0.paid_cursor
    }

    fun pay(arg0: &mut Market, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool, arg1), arg3), arg2);
    }

    fun pay_fee(arg0: &Config, arg1: &mut Market, arg2: &mut CouncilFees, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1, v2) = split_fee(arg3, arg4, arg1.council_fee_bps, 0x1::vector::length<Seat>(&arg1.committee));
        let v3 = v0 * usable_seats(arg0, arg1);
        let v4 = v2 + v1 - v3;
        let v5 = arg1.treasury;
        pay(arg1, v4, v5, arg6);
        accrue_council(arg0, arg1, arg2, v0, v3, arg5);
        (v3, v4)
    }

    public fun payout_base(arg0: &Market) : u64 {
        arg0.payout_base
    }

    public fun pool_no(arg0: &Market) : u64 {
        arg0.pool_no
    }

    public fun pool_value(arg0: &Market) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pool)
    }

    public fun pool_yes(arg0: &Market) : u64 {
        arg0.pool_yes
    }

    public fun refund_one_sided(arg0: &Config, arg1: &mut Market, arg2: &mut CouncilFees, arg3: Ticket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_fees(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        try_settle_one_sided(arg0, arg1, arg2, v0, arg5);
        assert!(arg1.status == 3, 24);
        let (v1, v2, v3, v4) = consume(arg1, arg3, arg5);
        let v5 = allocate(arg1, v4);
        pay(arg1, v5, v2, arg5);
        let v6 = Refunded{
            market_id : 0x2::object::id<Market>(arg1),
            ticket_id : v1,
            bettor    : v2,
            side      : v3,
            stake     : v4,
            refund    : v5,
            kind      : 3,
            ts        : v0,
        };
        0x2::event::emit<Refunded>(v6);
    }

    public fun refund_void(arg0: &Config, arg1: &mut Market, arg2: Ticket, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg1.outcome == 3) {
            try_finalize_invalid(arg1, v0);
        };
        try_void(arg1, v0);
        let v1 = arg1.status == 5;
        assert!(arg1.status == 4 || v1, 31);
        let (v2, v3, v4, v5) = consume(arg1, arg2, arg4);
        pay(arg1, v5, v3, arg4);
        let v6 = if (v1) {
            5
        } else {
            4
        };
        let v7 = Refunded{
            market_id : 0x2::object::id<Market>(arg1),
            ticket_id : v2,
            bettor    : v3,
            side      : v4,
            stake     : v5,
            refund    : v5,
            kind      : v6,
            ts        : v0,
        };
        0x2::event::emit<Refunded>(v7);
    }

    public fun resolve_by_ms(arg0: &Market) : u64 {
        arg0.resolve_by_ms
    }

    public fun resolve_threshold() : u64 {
        3
    }

    public fun resolved_ms(arg0: &Market) : u64 {
        arg0.resolved_ms
    }

    public fun reviewed(arg0: &Market) : bool {
        arg0.reviewed
    }

    public fun revoke_council_cap(arg0: &PredictAdminCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        let (v0, v1) = seat_index(&arg1.council, arg2);
        assert!(v0, 17);
        let v2 = 0x1::vector::remove<Seat>(&mut arg1.council, v1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.revoked_caps, arg2);
        let v3 = CouncilCapRevoked{
            cap_id       : arg2,
            holder       : v2.holder,
            active_seats : 0x1::vector::length<Seat>(&arg1.council),
            by           : 0x2::tx_context::sender(arg4),
            ts           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CouncilCapRevoked>(v3);
    }

    public fun revoke_market(arg0: &PredictAdminCap, arg1: &Config, arg2: &mut Market, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2.status == 0, 38);
        assert!(!arg2.dispute_used, 38);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (v0 >= arg2.close_ms) {
            assert!(arg2.pool_yes > 0 && arg2.pool_no > 0, 38);
            assert!(v0 < arg2.void_at_ms, 38);
        };
        assert!(0x1::vector::length<u8>(&arg3) > 0, 6);
        assert!(0x1::vector::length<u8>(&arg3) <= 300, 5);
        arg2.status = 5;
        arg2.outcome = 0;
        arg2.resolved_ms = 0;
        let v1 = Revoked{
            market_id : 0x2::object::id<Market>(arg2),
            reason    : 0x1::string::utf8(arg3),
            pool_yes  : arg2.pool_yes,
            pool_no   : arg2.pool_no,
            by        : 0x2::tx_context::sender(arg5),
            ts        : v0,
        };
        0x2::event::emit<Revoked>(v1);
    }

    public fun revoked_caps(arg0: &Config) : vector<0x2::object::ID> {
        arg0.revoked_caps
    }

    public fun revote_window_ms() : u64 {
        86400000
    }

    public fun seat_cap_id(arg0: &Seat) : 0x2::object::ID {
        arg0.cap_id
    }

    fun seat_caps(arg0: &vector<Seat>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Seat>(arg0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x1::vector::borrow<Seat>(arg0, v1).cap_id);
            v1 = v1 + 1;
        };
        v0
    }

    public fun seat_holder(arg0: &Seat) : address {
        arg0.holder
    }

    fun seat_holders(arg0: &vector<Seat>) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<Seat>(arg0)) {
            0x1::vector::push_back<address>(&mut v0, 0x1::vector::borrow<Seat>(arg0, v1).holder);
            v1 = v1 + 1;
        };
        v0
    }

    fun seat_index(arg0: &vector<Seat>, arg1: 0x2::object::ID) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Seat>(arg0)) {
            if (0x1::vector::borrow<Seat>(arg0, v0).cap_id == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun set_creation_fee(arg0: &PredictAdminCap, arg1: &mut Config, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2 > 0 && arg2 <= 10000000000000, 36);
        arg1.creation_fee_mist = arg2;
        let v0 = CreationFeeSet{
            fee_mist : arg2,
            by       : 0x2::tx_context::sender(arg4),
            ts       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CreationFeeSet>(v0);
    }

    public fun set_treasury(arg0: &PredictAdminCap, arg1: &mut Config, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2 != @0x0, 4);
        arg1.treasury = arg2;
        let v0 = TreasurySet{
            treasury : arg2,
            by       : 0x2::tx_context::sender(arg4),
            ts       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasurySet>(v0);
    }

    public fun settle_one_sided(arg0: &Config, arg1: &mut Market, arg2: &mut CouncilFees, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_fees(arg0, arg2);
        assert!(try_settle_one_sided(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3), arg4), 24);
    }

    public fun share_at(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        mul_div(arg0 + arg1, arg2, arg3) - mul_div(arg0, arg2, arg3)
    }

    public fun side_no() : u8 {
        2
    }

    public fun side_yes() : u8 {
        1
    }

    public fun split_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        let v0 = mul_div(arg1, arg2, 10000) / arg3;
        let v1 = v0 * arg3;
        (v0, v1, arg0 - v1)
    }

    public fun status(arg0: &Market) : u8 {
        arg0.status
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_final() : u8 {
        2
    }

    public fun status_one_sided() : u8 {
        3
    }

    public fun status_resolving() : u8 {
        1
    }

    public fun status_revoked() : u8 {
        5
    }

    public fun status_void() : u8 {
        4
    }

    public fun ticket_amount(arg0: &Ticket) : u64 {
        arg0.amount
    }

    public fun ticket_bettor(arg0: &Ticket) : address {
        arg0.bettor
    }

    public fun ticket_market(arg0: &Ticket) : 0x2::object::ID {
        arg0.market_id
    }

    public fun ticket_side(arg0: &Ticket) : u8 {
        arg0.side
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    fun try_finalize(arg0: &Config, arg1: &mut Market, arg2: &mut CouncilFees, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : bool {
        if (!matured(arg1, arg3)) {
            return false
        };
        if (arg1.outcome == 3) {
            return try_finalize_invalid(arg1, arg3)
        };
        let (v0, v1) = if (arg1.outcome == 1) {
            let v1 = arg1.pool_no;
            let v0 = arg1.pool_yes;
            (v0, v1)
        } else {
            let v1 = arg1.pool_yes;
            let v0 = arg1.pool_no;
            (v0, v1)
        };
        let v2 = v0 + v1;
        let v3 = final_fee(v2, v1);
        arg1.status = 2;
        arg1.fee_paid = v3;
        arg1.net_pot = v2 - v3;
        arg1.payout_base = v0;
        let v4 = council_base(arg1.pool_yes, arg1.pool_no);
        let (v5, v6) = pay_fee(arg0, arg1, arg2, v3, v4, arg3, arg4);
        let v7 = Finalized{
            market_id    : 0x2::object::id<Market>(arg1),
            outcome      : arg1.outcome,
            winning_pool : v0,
            losing_pool  : v1,
            fee          : v3,
            council_fee  : v5,
            treasury_fee : v6,
            net_pot      : arg1.net_pot,
            ts           : arg3,
        };
        0x2::event::emit<Finalized>(v7);
        true
    }

    fun try_finalize_invalid(arg0: &mut Market, arg1: u64) : bool {
        if (!matured(arg0, arg1)) {
            return false
        };
        if (arg0.outcome == 3) {
            arg0.status = 4;
            let v0 = Voided{
                market_id : 0x2::object::id<Market>(arg0),
                invalid   : true,
                ts        : arg1,
            };
            0x2::event::emit<Voided>(v0);
            return true
        };
        false
    }

    fun try_settle_one_sided(arg0: &Config, arg1: &mut Market, arg2: &mut CouncilFees, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : bool {
        if (arg1.status != 0) {
            return false
        };
        if (arg3 < arg1.close_ms) {
            return false
        };
        if (arg1.pool_yes > 0 && arg1.pool_no > 0) {
            return false
        };
        let v0 = arg1.pool_yes + arg1.pool_no;
        let v1 = fee_for(v0);
        arg1.status = 3;
        arg1.fee_paid = v1;
        arg1.net_pot = v0 - v1;
        arg1.payout_base = v0;
        let v2 = council_base(arg1.pool_yes, arg1.pool_no);
        let (v3, v4) = pay_fee(arg0, arg1, arg2, v1, v2, arg3, arg4);
        let v5 = OneSided{
            market_id    : 0x2::object::id<Market>(arg1),
            total        : v0,
            fee          : v1,
            council_fee  : v3,
            treasury_fee : v4,
            ts           : arg3,
        };
        0x2::event::emit<OneSided>(v5);
        true
    }

    fun try_void(arg0: &mut Market, arg1: u64) : bool {
        if (arg0.status != 0) {
            return false
        };
        if (arg1 < arg0.void_at_ms) {
            return false
        };
        if (arg0.pool_yes == 0 || arg0.pool_no == 0) {
            return false
        };
        arg0.status = 4;
        let v0 = Voided{
            market_id : 0x2::object::id<Market>(arg0),
            invalid   : false,
            ts        : arg1,
        };
        0x2::event::emit<Voided>(v0);
        true
    }

    fun usable_seats(arg0: &Config, arg1: &Market) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Seat>(&arg1.committee)) {
            if (!0x1::vector::contains<0x2::object::ID>(&arg0.revoked_caps, &0x1::vector::borrow<Seat>(&arg1.committee, v1).cap_id)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun void_at_ms(arg0: &Market) : u64 {
        arg0.void_at_ms
    }

    public fun void_grace_ms() : u64 {
        86400000
    }

    public fun void_market(arg0: &Config, arg1: &mut Market, arg2: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(try_void(arg1, 0x2::clock::timestamp_ms(arg2)), 25);
    }

    public fun vote(arg0: &Config, arg1: &mut Market, arg2: &CouncilCap, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.status == 0, 9);
        let v0 = if (arg3 == 1) {
            true
        } else if (arg3 == 2) {
            true
        } else {
            arg3 == 3
        };
        assert!(v0, 19);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= arg1.close_ms, 14);
        assert!(v1 < arg1.void_at_ms, 15);
        assert!(arg1.pool_yes > 0 && arg1.pool_no > 0, 16);
        let v2 = 0x2::tx_context::sender(arg5);
        assert!(v2 == arg2.holder, 43);
        let v3 = 0x2::object::id<CouncilCap>(arg2);
        let (v4, v5) = seat_index(&arg1.committee, v3);
        assert!(v4, 17);
        assert!(*0x1::vector::borrow<u8>(&arg1.votes, v5) == 0, 18);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.revoked_caps, &v3), 45);
        *0x1::vector::borrow_mut<u8>(&mut arg1.votes, v5) = arg3;
        let v6 = 0x2::object::id<Market>(arg1);
        let v7 = VoteCast{
            market_id : v6,
            member    : v2,
            cap_id    : v3,
            outcome   : arg3,
            ts        : v1,
        };
        0x2::event::emit<VoteCast>(v7);
        if (count_votes(arg0, arg1, arg3) >= arg1.threshold) {
            arg1.status = 1;
            arg1.outcome = arg3;
            arg1.resolved_ms = v1;
            let v8 = Resolved{
                market_id       : v6,
                outcome         : arg3,
                by              : v2,
                cap_id          : v3,
                resolved_ms     : v1,
                finalizes_at_ms : v1 + arg1.dispute_window_ms,
            };
            0x2::event::emit<Resolved>(v8);
        };
    }

    public fun votes(arg0: &Market) : vector<u8> {
        arg0.votes
    }

    fun zero_votes(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

