module 0x6e35dab0538ce809951738432c1b3d5817f19e46ba29c8210fb135b169232018::pool {
    struct Betting has drop, store {
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
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct BetEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        timestamp: u64,
    }

    fun add_claimed(arg0: &mut 0x2::table::Table<address, bool>, arg1: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            0x2::table::add<address, bool>(arg0, *0x1::vector::borrow<address>(arg1, v0), false);
            v0 = v0 + 1;
        };
    }

    public fun bet<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.betting_start_time) {
            abort 0
        };
        if (v0 >= arg0.betting_end_time) {
            abort 0
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
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
            sender    : v1,
            timestamp : v0,
        };
        0x2::event::emit<BetEvent>(v4);
    }

    public fun bets<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::table::Table<address, Betting> {
        &arg0.bets
    }

    public fun betting_addresses<T0, T1>(arg0: &Pool<T0, T1>) : &vector<address> {
        &arg0.betting_addresses
    }

    public fun betting_currency<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::type_name::TypeName {
        &arg0.betting_currency
    }

    public fun betting_end_time<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.betting_end_time
    }

    public fun betting_start_time<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.betting_start_time
    }

    public fun bettors_per_winner<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.bettors_per_winner
    }

    public fun claimed<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::table::Table<address, bool> {
        &arg0.claimed
    }

    public fun close_round<T0, T1>(arg0: &0x6e35dab0538ce809951738432c1b3d5817f19e46ba29c8210fb135b169232018::admin_cap::AdminCap, arg1: &mut Pool<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        if (arg1.is_round_closed) {
            abort 5
        };
        if (0x2::clock::timestamp_ms(arg3) < arg1.closing_round_time) {
            abort 1
        };
        handle_close_round<T0, T1>(arg1, get_market_price(arg2), arg3);
    }

    public fun closing_price<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.closing_price
    }

    public fun closing_round_time<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.closing_round_time
    }

    fun create<T0, T1>(arg0: &mut 0x6e35dab0538ce809951738432c1b3d5817f19e46ba29c8210fb135b169232018::round_seq::RoundSeq, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = 0x1::type_name::get<T0>();
        Pool<T0, T1>{
            id                      : 0x2::object::new(arg6),
            market                  : v0,
            betting_currency        : 0x1::type_name::get<T1>(),
            round                   : 0x6e35dab0538ce809951738432c1b3d5817f19e46ba29c8210fb135b169232018::round_seq::get_next_round(arg0, v0),
            size                    : arg1,
            closing_price           : 0,
            closing_round_time      : arg5,
            betting_start_time      : arg3,
            betting_end_time        : arg4,
            is_round_closed         : false,
            is_settle_round         : false,
            prize_balance           : 0x2::coin::into_balance<T1>(0x2::coin::zero<T1>(arg6)),
            betting_addresses       : 0x1::vector::empty<address>(),
            bets                    : 0x2::table::new<address, Betting>(arg6),
            claimed                 : 0x2::table::new<address, bool>(arg6),
            prize_amount_per_winner : 0,
            total_winners           : 0,
            revenue_amount          : 0,
            bettors_per_winner      : arg2,
        }
    }

    public fun create_pool<T0, T1>(arg0: &0x6e35dab0538ce809951738432c1b3d5817f19e46ba29c8210fb135b169232018::admin_cap::AdminCap, arg1: &mut 0x6e35dab0538ce809951738432c1b3d5817f19e46ba29c8210fb135b169232018::round_seq::RoundSeq, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = create<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = CreatePoolEvent{pool_id: 0x2::object::id<Pool<T0, T1>>(&v0)};
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
        arg0.total_winners = v3;
        arg0.revenue_amount = v1 * arg0.size + v2 * arg0.size % v3;
    }

    public fun is_round_closed<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.is_round_closed
    }

    public fun is_settle_round<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.is_settle_round
    }

    public fun market<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::type_name::TypeName {
        &arg0.market
    }

    public fun prize_amount_per_winner<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.prize_amount_per_winner
    }

    public fun prize_balance<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.prize_balance
    }

    public fun refund<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg1) < arg0.closing_round_time) {
            abort 10
        };
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, bool>(&arg0.claimed, v0)) {
            abort 9
        };
        let v1 = 0x2::table::borrow_mut<address, bool>(&mut arg0.claimed, v0);
        if (*v1) {
            abort 4
        };
        *v1 = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.prize_balance, arg0.size), arg2), v0);
    }

    public fun revenue_amount<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.revenue_amount
    }

    public fun round<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.round
    }

    public fun settle_round<T0, T1>(arg0: &0x6e35dab0538ce809951738432c1b3d5817f19e46ba29c8210fb135b169232018::admin_cap::AdminCap, arg1: &mut Pool<T0, T1>, arg2: &mut 0x6e35dab0538ce809951738432c1b3d5817f19e46ba29c8210fb135b169232018::treasury::Treasury, arg3: vector<address>) {
        if (!arg1.is_round_closed) {
            abort 8
        };
        if (arg1.is_settle_round) {
            abort 7
        };
        if (arg1.total_winners == 0) {
            return
        };
        if (arg1.total_winners == 0) {
            let v0 = &mut arg1.claimed;
            add_claimed(v0, &arg1.betting_addresses);
        } else {
            let v1 = &mut arg1.claimed;
            add_claimed(v1, &arg3);
            0x6e35dab0538ce809951738432c1b3d5817f19e46ba29c8210fb135b169232018::treasury::deposit<T1>(arg0, arg2, 0x2::balance::split<T1>(&mut arg1.prize_balance, arg1.revenue_amount));
        };
    }

    public fun size<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.size
    }

    public fun total_winners<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.total_winners
    }

    public fun winner_claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg1) < arg0.closing_round_time) {
            abort 10
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.prize_balance, arg0.prize_amount_per_winner), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

