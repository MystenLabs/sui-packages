module 0xa8b8a939eb28902671cdcfc556c3e1c9e19be04ecdc0ee28a73e6335b41ffb54::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeTierCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        default_rake_bps: u64,
        split_dev_bps: u64,
        split_xvic_bps: u64,
        split_buyback_bps: u64,
        dev_wallet_a: address,
        dev_wallet_b: address,
        xvic_wallet: address,
        buyback_wallet: address,
        dispute_window_ms: u64,
        min_pool: u64,
        min_stake: u64,
        rake: 0x2::bag::Bag,
        tiers: 0x2::table::Table<address, u64>,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        event_id: vector<u8>,
        num_outcomes: u8,
        close_time_ms: u64,
        status: u8,
        pending_outcome: 0x1::option::Option<u8>,
        winning_outcome: 0x1::option::Option<u8>,
        settle_due_ms: u64,
        prize_pot: 0x2::balance::Balance<T0>,
        outcome_totals: vector<u64>,
        total_prize: u64,
        winner_remaining: u64,
        instant_allowed: bool,
    }

    struct Entry has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        outcome: u8,
        stake_gross: u64,
        stake_net: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        event_id: vector<u8>,
        num_outcomes: u8,
        close_time_ms: u64,
        instant_allowed: bool,
    }

    struct Entered has copy, drop {
        pool_id: 0x2::object::ID,
        entry_id: 0x2::object::ID,
        backer: address,
        outcome: u8,
        stake: u64,
        rake: u64,
        prize_contribution: u64,
    }

    struct ResultSubmitted has copy, drop {
        pool_id: 0x2::object::ID,
        pending_outcome: u8,
        settle_due_ms: u64,
    }

    struct Settled has copy, drop {
        pool_id: 0x2::object::ID,
        winning_outcome: u8,
        total_prize: u64,
        instant: bool,
    }

    struct Disputed has copy, drop {
        pool_id: 0x2::object::ID,
        disputer: address,
    }

    struct Voided has copy, drop {
        pool_id: 0x2::object::ID,
        winning_outcome: u8,
    }

    struct Claimed has copy, drop {
        pool_id: 0x2::object::ID,
        entry_id: 0x2::object::ID,
        claimant: address,
        payout: u64,
    }

    struct Refunded has copy, drop {
        pool_id: 0x2::object::ID,
        entry_id: 0x2::object::ID,
        claimant: address,
        refund: u64,
    }

    struct RakeRouted has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        dev_a: u64,
        dev_b: u64,
        xvic: u64,
        buyback: u64,
    }

    public fun admin_void<T0>(arg0: &mut Pool<T0>, arg1: &AdminCap) {
        assert!(arg0.status != 4 && arg0.status != 5, 20);
        arg0.status = 5;
        let v0 = Voided{
            pool_id         : 0x2::object::id<Pool<T0>>(arg0),
            winning_outcome : 255,
        };
        0x2::event::emit<Voided>(v0);
    }

    public fun claim<T0>(arg0: &mut Pool<T0>, arg1: Entry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 4, 11);
        assert!(arg1.pool_id == 0x2::object::id<Pool<T0>>(arg0), 13);
        assert!(arg1.outcome == *0x1::option::borrow<u8>(&arg0.winning_outcome), 14);
        let v0 = mul_div(arg1.stake_net, 0x2::balance::value<T0>(&arg0.prize_pot), arg0.winner_remaining);
        arg0.winner_remaining = arg0.winner_remaining - arg1.stake_net;
        let Entry {
            id          : v1,
            pool_id     : _,
            outcome     : _,
            stake_gross : _,
            stake_net   : _,
        } = arg1;
        let v6 = v1;
        let v7 = Claimed{
            pool_id  : 0x2::object::id<Pool<T0>>(arg0),
            entry_id : 0x2::object::uid_to_inner(&v6),
            claimant : 0x2::tx_context::sender(arg2),
            payout   : v0,
        };
        0x2::event::emit<Claimed>(v7);
        0x2::object::delete(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pot, v0), arg2)
    }

    public fun clear_tier(arg0: &mut Config, arg1: &FeeTierCap, arg2: address) {
        if (0x2::table::contains<address, u64>(&arg0.tiers, arg2)) {
            0x2::table::remove<address, u64>(&mut arg0.tiers, arg2);
        };
    }

    public fun close_pool<T0>(arg0: &mut Pool<T0>, arg1: &AdminCap) {
        assert!(arg0.status == 0, 1);
        arg0.status = 1;
    }

    public fun close_time_ms<T0>(arg0: &Pool<T0>) : u64 {
        arg0.close_time_ms
    }

    public fun create_pool<T0>(arg0: &Config, arg1: &AdminCap, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 2, 5);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg6), 2);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg3) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = Pool<T0>{
            id               : 0x2::object::new(arg7),
            event_id         : arg2,
            num_outcomes     : arg3,
            close_time_ms    : arg4,
            status           : 0,
            pending_outcome  : 0x1::option::none<u8>(),
            winning_outcome  : 0x1::option::none<u8>(),
            settle_due_ms    : 0,
            prize_pot        : 0x2::balance::zero<T0>(),
            outcome_totals   : v0,
            total_prize      : 0,
            winner_remaining : 0,
            instant_allowed  : arg5,
        };
        let v3 = PoolCreated{
            pool_id         : 0x2::object::id<Pool<T0>>(&v2),
            event_id        : v2.event_id,
            num_outcomes    : arg3,
            close_time_ms   : arg4,
            instant_allowed : arg5,
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::transfer::share_object<Pool<T0>>(v2);
    }

    public fun default_rake_bps(arg0: &Config) : u64 {
        arg0.default_rake_bps
    }

    fun deposit_rake<T0>(arg0: &mut Config, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rake, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rake, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rake, v0, arg1);
        };
    }

    public fun dispute<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 7);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.settle_due_ms, 9);
        arg0.status = 3;
        let v0 = Disputed{
            pool_id  : 0x2::object::id<Pool<T0>>(arg0),
            disputer : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Disputed>(v0);
    }

    public fun enter<T0>(arg0: &mut Config, arg1: &mut Pool<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(arg1.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.close_time_ms, 2);
        assert!((arg2 as u64) < (arg1.num_outcomes as u64), 3);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 4);
        assert!(v0 >= arg0.min_stake, 22);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.tiers, v1)) {
            *0x2::table::borrow<address, u64>(&arg0.tiers, v1)
        } else {
            arg0.default_rake_bps
        };
        let v3 = mul_div(v0, v2, 10000);
        let v4 = v0 - v3;
        0x2::balance::join<T0>(&mut arg1.prize_pot, 0x2::coin::into_balance<T0>(arg3));
        *0x1::vector::borrow_mut<u64>(&mut arg1.outcome_totals, (arg2 as u64)) = *0x1::vector::borrow<u64>(&arg1.outcome_totals, (arg2 as u64)) + v4;
        arg1.total_prize = arg1.total_prize + v4;
        let v5 = Entry{
            id          : 0x2::object::new(arg5),
            pool_id     : 0x2::object::id<Pool<T0>>(arg1),
            outcome     : arg2,
            stake_gross : v0,
            stake_net   : v4,
        };
        let v6 = Entered{
            pool_id            : 0x2::object::id<Pool<T0>>(arg1),
            entry_id           : 0x2::object::id<Entry>(&v5),
            backer             : 0x2::tx_context::sender(arg5),
            outcome            : arg2,
            stake              : v0,
            rake               : v3,
            prize_contribution : v4,
        };
        0x2::event::emit<Entered>(v6);
        0x2::transfer::public_transfer<Entry>(v5, 0x2::tx_context::sender(arg5));
    }

    public fun entry_outcome(arg0: &Entry) : u8 {
        arg0.outcome
    }

    public fun entry_pool_id(arg0: &Entry) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun entry_prize_contribution(arg0: &Entry) : u64 {
        arg0.stake_net
    }

    public fun entry_stake_gross(arg0: &Entry) : u64 {
        arg0.stake_gross
    }

    public fun event_id<T0>(arg0: &Pool<T0>) : vector<u8> {
        arg0.event_id
    }

    public fun finalize<T0>(arg0: &mut Config, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.status == 2, 7);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.settle_due_ms, 10);
        let v0 = *0x1::option::borrow<u8>(&arg1.pending_outcome);
        settle_internal<T0>(arg0, arg1, v0, false);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id                : 0x2::object::new(arg0),
            admin             : v0,
            paused            : false,
            default_rake_bps  : 1000,
            split_dev_bps     : 2500,
            split_xvic_bps    : 4000,
            split_buyback_bps : 3500,
            dev_wallet_a      : v0,
            dev_wallet_b      : v0,
            xvic_wallet       : v0,
            buyback_wallet    : v0,
            dispute_window_ms : 86400000,
            min_pool          : 0,
            min_stake         : 0,
            rake              : 0x2::bag::new(arg0),
            tiers             : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
        let v3 = OracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OracleCap>(v3, v0);
        let v4 = FeeTierCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FeeTierCap>(v4, v0);
    }

    public fun instant_allowed<T0>(arg0: &Pool<T0>) : bool {
        arg0.instant_allowed
    }

    public fun instant_settle<T0>(arg0: &mut Config, arg1: &mut Pool<T0>, arg2: &OracleCap, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(arg1.instant_allowed, 8);
        let v0 = if (arg1.status == 0) {
            true
        } else if (arg1.status == 1) {
            true
        } else {
            arg1.status == 2
        };
        assert!(v0, 7);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.close_time_ms, 6);
        assert!((arg3 as u64) < (arg1.num_outcomes as u64), 3);
        settle_internal<T0>(arg0, arg1, arg3, true);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun min_pool(arg0: &Config) : u64 {
        arg0.min_pool
    }

    public fun min_stake(arg0: &Config) : u64 {
        arg0.min_stake
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            0
        } else {
            (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
        }
    }

    public fun num_outcomes<T0>(arg0: &Pool<T0>) : u8 {
        arg0.num_outcomes
    }

    public fun outcome_total<T0>(arg0: &Pool<T0>, arg1: u8) : u64 {
        *0x1::vector::borrow<u64>(&arg0.outcome_totals, (arg1 as u64))
    }

    public fun pending_outcome<T0>(arg0: &Pool<T0>) : 0x1::option::Option<u8> {
        arg0.pending_outcome
    }

    public fun pot_value<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.prize_pot)
    }

    public fun rake_balance<T0>(arg0: &Config) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rake, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.rake, v0))
        } else {
            0
        }
    }

    public fun refund<T0>(arg0: &mut Pool<T0>, arg1: Entry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 5, 12);
        assert!(arg1.pool_id == 0x2::object::id<Pool<T0>>(arg0), 13);
        let v0 = arg1.stake_gross;
        let Entry {
            id          : v1,
            pool_id     : _,
            outcome     : _,
            stake_gross : _,
            stake_net   : _,
        } = arg1;
        let v6 = v1;
        let v7 = Refunded{
            pool_id  : 0x2::object::id<Pool<T0>>(arg0),
            entry_id : 0x2::object::uid_to_inner(&v6),
            claimant : 0x2::tx_context::sender(arg2),
            refund   : v0,
        };
        0x2::event::emit<Refunded>(v7);
        0x2::object::delete(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pot, v0), arg2)
    }

    public fun resolve_dispute<T0>(arg0: &mut Config, arg1: &mut Pool<T0>, arg2: &AdminCap, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(arg1.status == 3, 7);
        assert!((arg3 as u64) < (arg1.num_outcomes as u64), 3);
        settle_internal<T0>(arg0, arg1, arg3, false);
    }

    public fun route_rake<T0>(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rake, v0), 18);
        let v1 = mul_div(arg2, arg0.split_dev_bps, 10000);
        let v2 = v1 / 2;
        let v3 = v1 - v2;
        let v4 = mul_div(arg2, arg0.split_xvic_bps, 10000);
        let v5 = arg2 - v2 - v3 - v4;
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rake, v0);
        assert!(0x2::balance::value<T0>(v6) >= arg2, 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v2), arg3), arg0.dev_wallet_a);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v3), arg3), arg0.dev_wallet_b);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v4), arg3), arg0.xvic_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v5), arg3), arg0.buyback_wallet);
        let v7 = RakeRouted{
            coin_type : v0,
            amount    : arg2,
            dev_a     : v2,
            dev_b     : v3,
            xvic      : v4,
            buyback   : v5,
        };
        0x2::event::emit<RakeRouted>(v7);
    }

    public fun set_dispute_window(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.dispute_window_ms = arg2;
    }

    public fun set_min_pool(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.min_pool = arg2;
    }

    public fun set_min_stake(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.min_stake = arg2;
    }

    public fun set_paused(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun set_rake_bps(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 5000, 19);
        arg0.default_rake_bps = arg2;
    }

    public fun set_splits(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 + arg3 + arg4 == 10000, 16);
        arg0.split_dev_bps = arg2;
        arg0.split_xvic_bps = arg3;
        arg0.split_buyback_bps = arg4;
    }

    public fun set_tier(arg0: &mut Config, arg1: &FeeTierCap, arg2: address, arg3: u64) {
        assert!(arg3 <= arg0.default_rake_bps, 21);
        assert!(arg3 >= 0, 21);
        if (0x2::table::contains<address, u64>(&arg0.tiers, arg2)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.tiers, arg2) = arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.tiers, arg2, arg3);
        };
    }

    public fun set_wallets(arg0: &mut Config, arg1: &AdminCap, arg2: address, arg3: address, arg4: address, arg5: address) {
        arg0.dev_wallet_a = arg2;
        arg0.dev_wallet_b = arg3;
        arg0.xvic_wallet = arg4;
        arg0.buyback_wallet = arg5;
    }

    public fun settle_due_ms<T0>(arg0: &Pool<T0>) : u64 {
        arg0.settle_due_ms
    }

    fun settle_internal<T0>(arg0: &mut Config, arg1: &mut Pool<T0>, arg2: u8, arg3: bool) {
        arg1.winning_outcome = 0x1::option::some<u8>(arg2);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1.outcome_totals)) {
            if (*0x1::vector::borrow<u64>(&arg1.outcome_totals, v1) > 0) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        let v2 = *0x1::vector::borrow<u64>(&arg1.outcome_totals, (arg2 as u64));
        let v3 = if (v0 < 2) {
            true
        } else if (v2 == 0) {
            true
        } else {
            arg1.total_prize < arg0.min_pool
        };
        if (v3) {
            arg1.status = 5;
            let v4 = Voided{
                pool_id         : 0x2::object::id<Pool<T0>>(arg1),
                winning_outcome : arg2,
            };
            0x2::event::emit<Voided>(v4);
        } else {
            let v5 = 0x2::balance::value<T0>(&arg1.prize_pot) - arg1.total_prize;
            if (v5 > 0) {
                deposit_rake<T0>(arg0, 0x2::balance::split<T0>(&mut arg1.prize_pot, v5));
            };
            arg1.status = 4;
            arg1.winner_remaining = v2;
            let v6 = Settled{
                pool_id         : 0x2::object::id<Pool<T0>>(arg1),
                winning_outcome : arg2,
                total_prize     : arg1.total_prize,
                instant         : arg3,
            };
            0x2::event::emit<Settled>(v6);
        };
    }

    public fun status<T0>(arg0: &Pool<T0>) : u8 {
        arg0.status
    }

    public fun submit_result<T0>(arg0: &Config, arg1: &mut Pool<T0>, arg2: &OracleCap, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(arg1.status == 0 || arg1.status == 1, 7);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg1.close_time_ms, 6);
        assert!((arg3 as u64) < (arg1.num_outcomes as u64), 3);
        arg1.pending_outcome = 0x1::option::some<u8>(arg3);
        arg1.status = 2;
        arg1.settle_due_ms = v0 + arg0.dispute_window_ms;
        let v1 = ResultSubmitted{
            pool_id         : 0x2::object::id<Pool<T0>>(arg1),
            pending_outcome : arg3,
            settle_due_ms   : arg1.settle_due_ms,
        };
        0x2::event::emit<ResultSubmitted>(v1);
    }

    public fun tier_of(arg0: &Config, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.tiers, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.tiers, arg1)
        } else {
            arg0.default_rake_bps
        }
    }

    public fun total_prize<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_prize
    }

    public fun winner_remaining<T0>(arg0: &Pool<T0>) : u64 {
        arg0.winner_remaining
    }

    public fun winning_outcome<T0>(arg0: &Pool<T0>) : 0x1::option::Option<u8> {
        arg0.winning_outcome
    }

    // decompiled from Move bytecode v6
}

