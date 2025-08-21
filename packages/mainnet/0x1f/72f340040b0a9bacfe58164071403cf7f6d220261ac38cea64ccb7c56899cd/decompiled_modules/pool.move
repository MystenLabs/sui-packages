module 0x1f72f340040b0a9bacfe58164071403cf7f6d220261ac38cea64ccb7c56899cd::pool {
    struct Betting has copy, drop, store {
        predicted_price: u64,
        betting_time: u64,
    }

    struct ListBettingItem has copy, drop, store {
        bettor: address,
        predicted_price: u64,
        betting_time: u64,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        market: 0x1::type_name::TypeName,
        betting_currency: 0x1::type_name::TypeName,
        round: u64,
        size: u64,
        closing_price: u64,
        closing_round_time: u64,
        betting_start_time: u64,
        betting_end_time: u64,
        is_round_closed: bool,
        is_settle_round: bool,
        prize_balance: 0x2::balance::Balance<T1>,
        betting_addresses: vector<address>,
        bets: 0x2::table::Table<address, Betting>,
        claimed: 0x2::table::Table<address, bool>,
        prize_amount_per_winner: u64,
        total_winners: u64,
        revenue_amount: u64,
        bettors_per_winner: u64,
        winners: vector<address>,
        price_feed_id: vector<u8>,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        market: 0x1::type_name::TypeName,
        betting_currency: 0x1::type_name::TypeName,
        round: u64,
        size: u64,
        closing_round_time: u64,
        betting_start_time: u64,
        betting_end_time: u64,
        bettors_per_winner: u64,
        price_feed_id: vector<u8>,
    }

    struct BetEvent has copy, drop {
        bettor: address,
        pool_id: 0x2::object::ID,
        betting_time: u64,
    }

    fun add_claimed(arg0: &mut 0x2::table::Table<address, bool>, arg1: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            0x2::table::add<address, bool>(arg0, *0x1::vector::borrow<address>(arg1, v0), false);
            v0 = v0 + 1;
        };
    }

    public entry fun bet<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.betting_start_time) {
            abort 0
        };
        if (v0 >= arg0.betting_end_time) {
            abort 10
        };
        let v1 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, Betting>(&arg0.bets, v1)) {
            abort 2
        };
        let v2 = 0x2::coin::into_balance<T1>(arg3);
        if (0x2::balance::value<T1>(&v2) != arg0.size) {
            abort 3
        };
        0x2::balance::join<T1>(&mut arg0.prize_balance, v2);
        0x1::vector::push_back<address>(&mut arg0.betting_addresses, v1);
        let v3 = Betting{
            predicted_price : arg2,
            betting_time    : v0,
        };
        0x2::table::add<address, Betting>(&mut arg0.bets, v1, v3);
        let v4 = BetEvent{
            bettor       : v1,
            pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
            betting_time : v0,
        };
        0x2::event::emit<BetEvent>(v4);
    }

    public(friend) fun claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (!arg0.is_settle_round) {
            abort 9
        };
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, bool>(&arg0.claimed, v0)) {
            abort 6
        };
        let v1 = 0x2::table::borrow_mut<address, bool>(&mut arg0.claimed, v0);
        if (*v1) {
            abort 4
        };
        *v1 = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.prize_balance, arg1), arg2), v0);
    }

    public entry fun close_round<T0, T1>(arg0: &0x1f72f340040b0a9bacfe58164071403cf7f6d220261ac38cea64ccb7c56899cd::admin_cap::AdminCap, arg1: &mut Pool<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        if (arg1.is_round_closed) {
            abort 5
        };
        if (0x2::clock::timestamp_ms(arg3) < arg1.closing_round_time) {
            abort 1
        };
        handle_close_round<T0, T1>(arg1, get_market_price(arg2), arg3);
    }

    fun create<T0, T1>(arg0: &mut 0x1f72f340040b0a9bacfe58164071403cf7f6d220261ac38cea64ccb7c56899cd::round_seq::RoundSeq, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        if (arg2 <= 0) {
            abort 14
        };
        if (arg3 <= 0) {
            abort 11
        };
        if (arg4 <= arg3) {
            abort 12
        };
        if (arg5 <= arg4) {
            abort 13
        };
        let v0 = 0x1::type_name::get<T0>();
        Pool<T0, T1>{
            id                      : 0x2::object::new(arg7),
            market                  : v0,
            betting_currency        : 0x1::type_name::get<T1>(),
            round                   : 0x1f72f340040b0a9bacfe58164071403cf7f6d220261ac38cea64ccb7c56899cd::round_seq::get_next_round(arg0, v0),
            size                    : arg1,
            closing_price           : 0,
            closing_round_time      : arg5,
            betting_start_time      : arg3,
            betting_end_time        : arg4,
            is_round_closed         : false,
            is_settle_round         : false,
            prize_balance           : 0x2::coin::into_balance<T1>(0x2::coin::zero<T1>(arg7)),
            betting_addresses       : 0x1::vector::empty<address>(),
            bets                    : 0x2::table::new<address, Betting>(arg7),
            claimed                 : 0x2::table::new<address, bool>(arg7),
            prize_amount_per_winner : 0,
            total_winners           : 0,
            revenue_amount          : 0,
            bettors_per_winner      : arg2,
            winners                 : 0x1::vector::empty<address>(),
            price_feed_id           : arg6,
        }
    }

    public entry fun create_pool<T0, T1>(arg0: &0x1f72f340040b0a9bacfe58164071403cf7f6d220261ac38cea64ccb7c56899cd::admin_cap::AdminCap, arg1: &mut 0x1f72f340040b0a9bacfe58164071403cf7f6d220261ac38cea64ccb7c56899cd::round_seq::RoundSeq, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = create<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = CreatePoolEvent{
            pool_id            : 0x2::object::id<Pool<T0, T1>>(&v0),
            market             : v0.market,
            betting_currency   : v0.betting_currency,
            round              : v0.round,
            size               : v0.size,
            closing_round_time : v0.closing_round_time,
            betting_start_time : v0.betting_start_time,
            betting_end_time   : v0.betting_end_time,
            bettors_per_winner : v0.bettors_per_winner,
            price_feed_id      : v0.price_feed_id,
        };
        0x2::event::emit<CreatePoolEvent>(v1);
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    fun get_market_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)
    }

    public(friend) fun handle_close_round<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        if (arg0.is_round_closed) {
            abort 5
        };
        if (0x2::clock::timestamp_ms(arg2) < arg0.closing_round_time) {
            abort 1
        };
        arg0.closing_price = arg1;
        arg0.is_round_closed = true;
        let v0 = 0x1::vector::length<address>(&arg0.betting_addresses);
        if (v0 < arg0.bettors_per_winner) {
            return
        };
        let v1 = v0 % arg0.bettors_per_winner;
        let v2 = v0 - v1;
        let v3 = v2 / arg0.bettors_per_winner;
        let v4 = v2 * arg0.size;
        let v5 = v4 % v3;
        arg0.total_winners = v3;
        arg0.revenue_amount = v1 * arg0.size + v5;
        arg0.prize_amount_per_winner = (v4 - v5) / v3;
    }

    public entry fun is_claimed<T0, T1>(arg0: &Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, bool>(&arg0.claimed, v0)) {
            abort 6
        };
        *0x2::table::borrow<address, bool>(&arg0.claimed, v0)
    }

    public entry fun list_betting<T0, T1>(arg0: &Pool<T0, T1>) : vector<ListBettingItem> {
        let v0 = 0x1::vector::empty<ListBettingItem>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.betting_addresses)) {
            let v2 = 0x1::vector::borrow<address>(&arg0.betting_addresses, v1);
            let v3 = 0x2::table::borrow<address, Betting>(&arg0.bets, *v2);
            let v4 = ListBettingItem{
                bettor          : *v2,
                predicted_price : v3.predicted_price,
                betting_time    : v3.betting_time,
            };
            0x1::vector::push_back<ListBettingItem>(&mut v0, v4);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun refund<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        if (arg0.total_winners > 0) {
            abort 16
        };
        let v0 = arg0.size;
        claim<T0, T1>(arg0, v0, arg1);
    }

    public entry fun settle_round<T0, T1>(arg0: &0x1f72f340040b0a9bacfe58164071403cf7f6d220261ac38cea64ccb7c56899cd::admin_cap::AdminCap, arg1: &mut Pool<T0, T1>, arg2: &mut 0x1f72f340040b0a9bacfe58164071403cf7f6d220261ac38cea64ccb7c56899cd::treasury::Treasury, arg3: vector<address>) {
        if (!arg1.is_round_closed) {
            abort 8
        };
        if (arg1.is_settle_round) {
            abort 7
        };
        if (arg1.total_winners == 0) {
            let v0 = &mut arg1.claimed;
            add_claimed(v0, &arg1.betting_addresses);
        } else {
            arg1.winners = arg3;
            let v1 = &mut arg1.claimed;
            add_claimed(v1, &arg3);
            0x1f72f340040b0a9bacfe58164071403cf7f6d220261ac38cea64ccb7c56899cd::treasury::deposit<T1>(arg0, arg2, 0x2::balance::split<T1>(&mut arg1.prize_balance, arg1.revenue_amount));
        };
        arg1.is_settle_round = true;
    }

    public entry fun winner_claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        if (arg0.total_winners == 0) {
            abort 15
        };
        let v0 = arg0.prize_amount_per_winner;
        claim<T0, T1>(arg0, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

