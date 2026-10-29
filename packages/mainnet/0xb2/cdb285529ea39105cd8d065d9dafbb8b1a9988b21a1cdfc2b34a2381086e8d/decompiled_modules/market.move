module 0xb2cdb285529ea39105cd8d065d9dafbb8b1a9988b21a1cdfc2b34a2381086e8d::market {
    struct ResolverCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        treasury: address,
        min_stake: u64,
        max_stake: u64,
    }

    struct Market has key {
        id: 0x2::object::UID,
        key: 0x1::string::String,
        question: 0x1::string::String,
        category: 0x1::string::String,
        source: 0x1::string::String,
        outcomes: vector<0x1::string::String>,
        closes_at_ms: u64,
        pools: vector<u64>,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
        winner: u64,
        payout_pot: u64,
        tickets: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        outcome: u64,
        stake: u64,
        placed_at_ms: u64,
        note_hash: vector<u8>,
        claimed: bool,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        key: 0x1::string::String,
        question: 0x1::string::String,
        category: 0x1::string::String,
        source: 0x1::string::String,
        outcomes: vector<0x1::string::String>,
        closes_at_ms: u64,
    }

    struct Placed has copy, drop {
        market_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        picker: address,
        outcome: u64,
        stake: u64,
        placed_at_ms: u64,
        note_hash: vector<u8>,
    }

    struct Resolved has copy, drop {
        market_id: 0x2::object::ID,
        winner: u64,
        total: u64,
        fee: u64,
    }

    struct Voided has copy, drop {
        market_id: 0x2::object::ID,
        total: u64,
    }

    struct Claimed has copy, drop {
        market_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        picker: address,
        amount: u64,
    }

    public fun claim(arg0: &mut Market, arg1: &mut Ticket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.market_id == 0x2::object::id<Market>(arg0), 3);
        assert!(!arg1.claimed, 9);
        let v0 = payout_of(arg0, arg1);
        assert!(v0 > 0, 4);
        arg1.claimed = true;
        let v1 = Claimed{
            market_id : arg1.market_id,
            ticket_id : 0x2::object::id<Ticket>(arg1),
            picker    : 0x2::tx_context::sender(arg2),
            amount    : v0,
        };
        0x2::event::emit<Claimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v0), arg2)
    }

    public fun closes_at_ms(arg0: &Market) : u64 {
        arg0.closes_at_ms
    }

    public fun create_market(arg0: &ResolverCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg5);
        assert!(v0 >= 2, 10);
        assert!(arg6 > 0x2::clock::timestamp_ms(arg7), 0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = Market{
            id           : 0x2::object::new(arg8),
            key          : arg1,
            question     : arg2,
            category     : arg3,
            source       : arg4,
            outcomes     : arg5,
            closes_at_ms : arg6,
            pools        : v1,
            vault        : 0x2::balance::zero<0x2::sui::SUI>(),
            status       : 0,
            winner       : 0,
            payout_pot   : 0,
            tickets      : 0,
        };
        let v4 = MarketCreated{
            market_id    : 0x2::object::id<Market>(&v3),
            key          : v3.key,
            question     : v3.question,
            category     : v3.category,
            source       : v3.source,
            outcomes     : v3.outcomes,
            closes_at_ms : arg6,
        };
        0x2::event::emit<MarketCreated>(v4);
        0x2::transfer::share_object<Market>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ResolverCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ResolverCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id        : 0x2::object::new(arg0),
            fee_bps   : 200,
            treasury  : 0x2::tx_context::sender(arg0),
            min_stake : 10000000,
            max_stake : 5000000000,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun payout_of(arg0: &Market, arg1: &Ticket) : u64 {
        if (arg1.claimed) {
            return 0
        };
        if (arg0.status == 2) {
            return arg1.stake
        };
        assert!(arg0.status == 1, 2);
        if (arg1.outcome != arg0.winner) {
            return 0
        };
        (((arg1.stake as u128) * (arg0.payout_pot as u128) / (*0x1::vector::borrow<u64>(&arg0.pools, arg0.winner) as u128)) as u64)
    }

    public fun place(arg0: &mut Market, arg1: &Config, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Ticket {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.status == 0, 5);
        assert!(v0 < arg0.closes_at_ms, 0);
        assert!(arg2 < 0x1::vector::length<0x1::string::String>(&arg0.outcomes), 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= arg1.min_stake, 6);
        assert!(v1 <= arg1.max_stake, 11);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        *0x1::vector::borrow_mut<u64>(&mut arg0.pools, arg2) = *0x1::vector::borrow<u64>(&arg0.pools, arg2) + v1;
        arg0.tickets = arg0.tickets + 1;
        let v2 = Ticket{
            id           : 0x2::object::new(arg6),
            market_id    : 0x2::object::id<Market>(arg0),
            outcome      : arg2,
            stake        : v1,
            placed_at_ms : v0,
            note_hash    : arg4,
            claimed      : false,
        };
        let v3 = Placed{
            market_id    : v2.market_id,
            ticket_id    : 0x2::object::id<Ticket>(&v2),
            picker       : 0x2::tx_context::sender(arg6),
            outcome      : arg2,
            stake        : v1,
            placed_at_ms : v0,
            note_hash    : v2.note_hash,
        };
        0x2::event::emit<Placed>(v3);
        v2
    }

    public fun pools(arg0: &Market) : vector<u64> {
        arg0.pools
    }

    public fun resolve(arg0: &ResolverCap, arg1: &mut Market, arg2: &Config, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 5);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.closes_at_ms, 7);
        assert!(arg3 < 0x1::vector::length<0x1::string::String>(&arg1.outcomes), 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.vault);
        if (*0x1::vector::borrow<u64>(&arg1.pools, arg3) == 0) {
            arg1.status = 2;
            let v1 = Voided{
                market_id : 0x2::object::id<Market>(arg1),
                total     : v0,
            };
            0x2::event::emit<Voided>(v1);
            return
        };
        let v2 = (((v0 as u128) * (arg2.fee_bps as u128) / (10000 as u128)) as u64);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v2), arg5), arg2.treasury);
        };
        arg1.status = 1;
        arg1.winner = arg3;
        arg1.payout_pot = v0 - v2;
        let v3 = Resolved{
            market_id : 0x2::object::id<Market>(arg1),
            winner    : arg3,
            total     : v0,
            fee       : v2,
        };
        0x2::event::emit<Resolved>(v3);
    }

    public fun set_config(arg0: &ResolverCap, arg1: &mut Config, arg2: u64, arg3: address, arg4: u64, arg5: u64) {
        assert!(arg2 <= 500, 8);
        arg1.fee_bps = arg2;
        arg1.treasury = arg3;
        arg1.min_stake = arg4;
        arg1.max_stake = arg5;
    }

    public fun status(arg0: &Market) : u8 {
        arg0.status
    }

    public fun ticket_claimed(arg0: &Ticket) : bool {
        arg0.claimed
    }

    public fun ticket_outcome(arg0: &Ticket) : u64 {
        arg0.outcome
    }

    public fun ticket_stake(arg0: &Ticket) : u64 {
        arg0.stake
    }

    public fun void(arg0: &ResolverCap, arg1: &mut Market) {
        assert!(arg1.status == 0, 5);
        arg1.status = 2;
        let v0 = Voided{
            market_id : 0x2::object::id<Market>(arg1),
            total     : 0x2::balance::value<0x2::sui::SUI>(&arg1.vault),
        };
        0x2::event::emit<Voided>(v0);
    }

    public fun winner(arg0: &Market) : u64 {
        arg0.winner
    }

    // decompiled from Move bytecode v7
}

