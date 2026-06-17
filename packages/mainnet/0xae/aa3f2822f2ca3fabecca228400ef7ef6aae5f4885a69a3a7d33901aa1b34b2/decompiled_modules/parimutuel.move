module 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel {
    struct PARIMUTUEL has drop {
        dummy_field: bool,
    }

    struct ResolverCap has store, key {
        id: 0x2::object::UID,
    }

    struct ParimutuelMarket<phantom T0> has key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        category: 0x1::string::String,
        num_outcomes: u8,
        close_ts_ms: u64,
        state: u8,
        winning_outcome: u8,
        pools: vector<u64>,
        total_pool: u64,
        bank: 0x2::balance::Balance<T0>,
        rake_bps: u64,
        rake_collected: bool,
        creator: address,
        house: address,
        version: u64,
        frozen: bool,
    }

    struct BetReceipt has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        outcome: u8,
        amount: u64,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        num_outcomes: u8,
        close_ts_ms: u64,
        rake_bps: u64,
        creator: address,
    }

    struct BetPlaced has copy, drop {
        market_id: 0x2::object::ID,
        bettor: address,
        outcome: u8,
        amount: u64,
        outcome_pool: u64,
        total_pool: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        winning_outcome: u8,
        total_pool: u64,
    }

    struct MarketVoided has copy, drop {
        market_id: 0x2::object::ID,
        total_pool: u64,
    }

    struct Claimed has copy, drop {
        market_id: 0x2::object::ID,
        bettor: address,
        outcome: u8,
        stake: u64,
        payout: u64,
        refund: bool,
    }

    struct RakePaid has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
        house: address,
    }

    public fun bank_value<T0>(arg0: &ParimutuelMarket<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.bank)
    }

    public fun bet<T0>(arg0: &mut ParimutuelMarket<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::FeeConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : BetReceipt {
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::assert_not_paused(arg3);
        assert!(arg0.version == 1, 10);
        assert!(arg0.state == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.close_ts_ms, 2);
        assert!((arg1 as u64) < (arg0.num_outcomes as u64), 3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 4);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::assert_min_trade(arg3, v0);
        0x2::balance::join<T0>(&mut arg0.bank, 0x2::coin::into_balance<T0>(arg2));
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.pools, (arg1 as u64));
        *v1 = *v1 + v0;
        arg0.total_pool = arg0.total_pool + v0;
        let v2 = BetPlaced{
            market_id    : 0x2::object::id<ParimutuelMarket<T0>>(arg0),
            bettor       : 0x2::tx_context::sender(arg5),
            outcome      : arg1,
            amount       : v0,
            outcome_pool : *v1,
            total_pool   : arg0.total_pool,
        };
        0x2::event::emit<BetPlaced>(v2);
        BetReceipt{
            id        : 0x2::object::new(arg5),
            market_id : 0x2::object::id<ParimutuelMarket<T0>>(arg0),
            outcome   : arg1,
            amount    : v0,
        }
    }

    public fun claim<T0>(arg0: &mut ParimutuelMarket<T0>, arg1: BetReceipt, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 10);
        assert!(!arg0.frozen, 12);
        let v0 = arg0.state;
        assert!(v0 == 2 || v0 == 3, 6);
        let BetReceipt {
            id        : v1,
            market_id : v2,
            outcome   : v3,
            amount    : v4,
        } = arg1;
        assert!(v2 == 0x2::object::id<ParimutuelMarket<T0>>(arg0), 7);
        0x2::object::delete(v1);
        let v5 = 0x2::object::id<ParimutuelMarket<T0>>(arg0);
        let (v6, v7) = if (v0 == 3) {
            (v4, true)
        } else {
            assert!(v3 == arg0.winning_outcome, 8);
            let v8 = mul_div(arg0.total_pool, arg0.rake_bps, 10000);
            if (!arg0.rake_collected) {
                arg0.rake_collected = true;
                if (v8 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bank, v8), arg2), arg0.house);
                    let v9 = RakePaid{
                        market_id : v5,
                        amount    : v8,
                        house     : arg0.house,
                    };
                    0x2::event::emit<RakePaid>(v9);
                };
            };
            (mul_div(v4, arg0.total_pool - v8, *0x1::vector::borrow<u64>(&arg0.pools, (v3 as u64))), false)
        };
        let v10 = Claimed{
            market_id : v5,
            bettor    : 0x2::tx_context::sender(arg2),
            outcome   : v3,
            stake     : v4,
            payout    : v6,
            refund    : v7,
        };
        0x2::event::emit<Claimed>(v10);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bank, v6), arg2)
    }

    public fun claim_to_sender<T0>(arg0: &mut ParimutuelMarket<T0>, arg1: BetReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun close<T0>(arg0: &mut ParimutuelMarket<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.state == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.close_ts_ms, 5);
        arg0.state = 1;
    }

    public fun close_ts_ms<T0>(arg0: &ParimutuelMarket<T0>) : u64 {
        arg0.close_ts_ms
    }

    public fun create<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::FeeConfig, arg5: &mut 0x2::tx_context::TxContext) : ParimutuelMarket<T0> {
        assert!(arg2 >= 2, 0);
        assert!(arg2 <= 64, 11);
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::trading_fee_bps(arg4);
        let v3 = vector[];
        let v4 = 0;
        while (v4 < arg2) {
            0x1::vector::push_back<u64>(&mut v3, 0);
            v4 = v4 + 1;
        };
        let v5 = MarketCreated{
            market_id    : 0x2::object::uid_to_inner(&v0),
            num_outcomes : arg2,
            close_ts_ms  : arg3,
            rake_bps     : v2,
            creator      : v1,
        };
        0x2::event::emit<MarketCreated>(v5);
        ParimutuelMarket<T0>{
            id              : v0,
            question        : arg0,
            category        : arg1,
            num_outcomes    : arg2,
            close_ts_ms     : arg3,
            state           : 0,
            winning_outcome : 255,
            pools           : v3,
            total_pool      : 0,
            bank            : 0x2::balance::zero<T0>(),
            rake_bps        : v2,
            rake_collected  : false,
            creator         : v1,
            house           : 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::fee_recipient(arg4),
            version         : 1,
            frozen          : false,
        }
    }

    public fun create_and_share<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::FeeConfig, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<ParimutuelMarket<T0>>(create<T0>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public fun creator<T0>(arg0: &ParimutuelMarket<T0>) : address {
        arg0.creator
    }

    fun init(arg0: PARIMUTUEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ResolverCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<ResolverCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_frozen<T0>(arg0: &ParimutuelMarket<T0>) : bool {
        arg0.frozen
    }

    public fun migrate<T0>(arg0: &mut ParimutuelMarket<T0>, arg1: &ResolverCap) {
        assert!(arg0.version < 1, 10);
        arg0.version = 1;
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun num_outcomes<T0>(arg0: &ParimutuelMarket<T0>) : u8 {
        arg0.num_outcomes
    }

    public fun place_bet<T0>(arg0: &mut ParimutuelMarket<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::FeeConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = bet<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<BetReceipt>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun pool_of<T0>(arg0: &ParimutuelMarket<T0>, arg1: u8) : u64 {
        *0x1::vector::borrow<u64>(&arg0.pools, (arg1 as u64))
    }

    public fun quote_multiplier_bps<T0>(arg0: &ParimutuelMarket<T0>, arg1: u8) : u64 {
        let v0 = *0x1::vector::borrow<u64>(&arg0.pools, (arg1 as u64));
        if (v0 == 0) {
            return 0
        };
        mul_div(arg0.total_pool - mul_div(arg0.total_pool, arg0.rake_bps, 10000), 10000, v0)
    }

    public fun rake_bps<T0>(arg0: &ParimutuelMarket<T0>) : u64 {
        arg0.rake_bps
    }

    public fun receipt_amount(arg0: &BetReceipt) : u64 {
        arg0.amount
    }

    public fun receipt_market_id(arg0: &BetReceipt) : 0x2::object::ID {
        arg0.market_id
    }

    public fun receipt_outcome(arg0: &BetReceipt) : u8 {
        arg0.outcome
    }

    public fun resolve<T0>(arg0: &mut ParimutuelMarket<T0>, arg1: &ResolverCap, arg2: &0x2::clock::Clock, arg3: u8) {
        assert!(arg0.version == 1, 10);
        assert!(arg0.state == 0 || arg0.state == 1, 9);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.close_ts_ms, 5);
        assert!((arg3 as u64) < (arg0.num_outcomes as u64), 3);
        if (*0x1::vector::borrow<u64>(&arg0.pools, (arg3 as u64)) == 0) {
            set_invalid_internal<T0>(arg0);
            return
        };
        arg0.state = 2;
        arg0.winning_outcome = arg3;
        let v0 = MarketResolved{
            market_id       : 0x2::object::id<ParimutuelMarket<T0>>(arg0),
            winning_outcome : arg3,
            total_pool      : arg0.total_pool,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    public fun set_frozen<T0>(arg0: &mut ParimutuelMarket<T0>, arg1: &ResolverCap, arg2: bool) {
        arg0.frozen = arg2;
    }

    public(friend) fun set_invalid_internal<T0>(arg0: &mut ParimutuelMarket<T0>) {
        assert!(arg0.state == 0 || arg0.state == 1, 9);
        arg0.state = 3;
        arg0.winning_outcome = 255;
        let v0 = MarketVoided{
            market_id  : 0x2::object::id<ParimutuelMarket<T0>>(arg0),
            total_pool : arg0.total_pool,
        };
        0x2::event::emit<MarketVoided>(v0);
    }

    public(friend) fun set_resolved_internal<T0>(arg0: &mut ParimutuelMarket<T0>, arg1: u8) {
        assert!(arg0.version == 1, 10);
        assert!(arg0.state == 0 || arg0.state == 1, 9);
        assert!((arg1 as u64) < (arg0.num_outcomes as u64), 3);
        if (*0x1::vector::borrow<u64>(&arg0.pools, (arg1 as u64)) == 0) {
            set_invalid_internal<T0>(arg0);
            return
        };
        arg0.state = 2;
        arg0.winning_outcome = arg1;
        let v0 = MarketResolved{
            market_id       : 0x2::object::id<ParimutuelMarket<T0>>(arg0),
            winning_outcome : arg1,
            total_pool      : arg0.total_pool,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    public fun share<T0>(arg0: ParimutuelMarket<T0>) {
        0x2::transfer::share_object<ParimutuelMarket<T0>>(arg0);
    }

    public fun state<T0>(arg0: &ParimutuelMarket<T0>) : u8 {
        arg0.state
    }

    public fun state_closed() : u8 {
        1
    }

    public fun state_invalid() : u8 {
        3
    }

    public fun state_open() : u8 {
        0
    }

    public fun state_resolved() : u8 {
        2
    }

    public fun total_pool<T0>(arg0: &ParimutuelMarket<T0>) : u64 {
        arg0.total_pool
    }

    public fun version<T0>(arg0: &ParimutuelMarket<T0>) : u64 {
        arg0.version
    }

    public fun void<T0>(arg0: &mut ParimutuelMarket<T0>, arg1: &ResolverCap) {
        assert!(arg0.version == 1, 10);
        set_invalid_internal<T0>(arg0);
    }

    public fun winning_outcome<T0>(arg0: &ParimutuelMarket<T0>) : u8 {
        arg0.winning_outcome
    }

    // decompiled from Move bytecode v7
}

