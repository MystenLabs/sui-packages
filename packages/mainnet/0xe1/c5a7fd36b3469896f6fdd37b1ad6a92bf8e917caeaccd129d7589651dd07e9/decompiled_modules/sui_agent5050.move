module 0xe1c5a7fd36b3469896f6fdd37b1ad6a92bf8e917caeaccd129d7589651dd07e9::sui_agent5050 {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Raffle<phantom T0> has store {
        raffle_id: u64,
        creator: address,
        name: 0x1::string::String,
        ticket_price: u64,
        total_prize_pool: u64,
        tickets_sold: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        state: u8,
        winner: 0x1::option::Option<address>,
        creator_fee: u64,
        winner_prize: u64,
        finalized: bool,
        balance: 0x2::balance::Balance<T0>,
        ticket_owners: vector<address>,
    }

    struct RafflePool<phantom T0> has key {
        id: 0x2::object::UID,
        next_raffle_id: u64,
        raffles: 0x2::table::Table<u64, Raffle<T0>>,
        platform_wallet: address,
    }

    struct TicketNFT has store, key {
        id: 0x2::object::UID,
        raffle_id: u64,
        ticket_number: u64,
        purchase_time_ms: u64,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: u64,
        creator: address,
        name: 0x1::string::String,
        end_time_ms: u64,
    }

    struct TicketPurchased has copy, drop {
        raffle_id: u64,
        buyer: address,
        ticket_number: u64,
        amount: u64,
    }

    struct RaffleEnded has copy, drop {
        raffle_id: u64,
        tickets_sold: u64,
        prize_pool: u64,
    }

    struct RandomSeedGenerated has copy, drop {
        raffle_id: u64,
        winning_ticket: u64,
    }

    struct WinnerSelected has copy, drop {
        raffle_id: u64,
        winner: address,
        prize_amount: u64,
        winning_ticket: u64,
    }

    struct PrizeClaimed has copy, drop {
        raffle_id: u64,
        winner: address,
        amount: u64,
    }

    struct CreatorFeeClaimed has copy, drop {
        raffle_id: u64,
        creator: address,
        amount: u64,
    }

    public entry fun buy_tickets<T0>(arg0: &mut RafflePool<T0>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 7);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::table::borrow_mut<u64, Raffle<T0>>(&mut arg0.raffles, arg1);
        assert!(v2.state == 1 || v2.state == 0, 3);
        assert!(v1 < v2.end_time_ms, 4);
        assert!(!v2.finalized, 6);
        let v3 = 2500000 * arg2;
        assert!(0x2::coin::value<T0>(&arg3) >= v3, 2);
        0x2::balance::join<T0>(&mut v2.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v3, arg5)));
        v2.total_prize_pool = v2.total_prize_pool + v3;
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        if (v2.state == 0) {
            v2.state = 1;
        };
        let v4 = 0;
        while (v4 < arg2) {
            let v5 = v2.tickets_sold + 1 + v4;
            0x1::vector::push_back<address>(&mut v2.ticket_owners, v0);
            let v6 = TicketNFT{
                id               : 0x2::object::new(arg5),
                raffle_id        : arg1,
                ticket_number    : v5,
                purchase_time_ms : v1,
            };
            0x2::transfer::transfer<TicketNFT>(v6, v0);
            let v7 = TicketPurchased{
                raffle_id     : arg1,
                buyer         : v0,
                ticket_number : v5,
                amount        : 2500000,
            };
            0x2::event::emit<TicketPurchased>(v7);
            v4 = v4 + 1;
        };
        v2.tickets_sold = v2.tickets_sold + arg2;
    }

    public entry fun create_raffle<T0>(arg0: &mut RafflePool<T0>, arg1: vector<u8>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 300000, 1);
        assert!(0x2::coin::value<T0>(&arg3) >= 10000000, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, 10000000, arg5), arg0.platform_wallet);
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        let v2 = arg0.next_raffle_id;
        arg0.next_raffle_id = arg0.next_raffle_id + 1;
        let v3 = 0x1::string::utf8(arg1);
        let v4 = v1 + arg2;
        let v5 = Raffle<T0>{
            raffle_id        : v2,
            creator          : v0,
            name             : v3,
            ticket_price     : 2500000,
            total_prize_pool : 0,
            tickets_sold     : 0,
            start_time_ms    : v1,
            end_time_ms      : v4,
            state            : 0,
            winner           : 0x1::option::none<address>(),
            creator_fee      : 0,
            winner_prize     : 0,
            finalized        : false,
            balance          : 0x2::balance::zero<T0>(),
            ticket_owners    : 0x1::vector::empty<address>(),
        };
        0x2::table::add<u64, Raffle<T0>>(&mut arg0.raffles, v2, v5);
        let v6 = RaffleCreated{
            raffle_id   : v2,
            creator     : v0,
            name        : v3,
            end_time_ms : v4,
        };
        0x2::event::emit<RaffleCreated>(v6);
    }

    public entry fun create_raffle_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RafflePool<T0>{
            id              : 0x2::object::new(arg1),
            next_raffle_id  : 1,
            raffles         : 0x2::table::new<u64, Raffle<T0>>(arg1),
            platform_wallet : @0x80351f29842017678271bd183d19a35774f1484c87b505f8243ff5e556c19c55,
        };
        0x2::transfer::share_object<RafflePool<T0>>(v0);
    }

    public entry fun end_raffle<T0>(arg0: &mut RafflePool<T0>, arg1: u64, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Raffle<T0>>(&mut arg0.raffles, arg1);
        assert!(v0.state == 1, 3);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.end_time_ms, 5);
        assert!(!v0.finalized, 6);
        v0.state = 2;
        v0.finalized = true;
        let v1 = v0.tickets_sold;
        let v2 = v0.total_prize_pool;
        if (v1 > 0) {
            let v3 = 0x2::random::new_generator(arg2, arg4);
            let v4 = 0x2::random::generate_u64_in_range(&mut v3, 0, v1 - 1);
            let v5 = v4 + 1;
            let v6 = *0x1::vector::borrow<address>(&v0.ticket_owners, v4);
            v0.winner = 0x1::option::some<address>(v6);
            let v7 = RandomSeedGenerated{
                raffle_id      : arg1,
                winning_ticket : v5,
            };
            0x2::event::emit<RandomSeedGenerated>(v7);
            v0.creator_fee = v2 * 5000 / 10000;
            v0.winner_prize = v2 - v0.creator_fee;
            let v8 = v0.winner_prize;
            let v9 = v0.creator_fee;
            let v10 = v0.creator;
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, v8), arg4), v6);
                let v11 = PrizeClaimed{
                    raffle_id : arg1,
                    winner    : v6,
                    amount    : v8,
                };
                0x2::event::emit<PrizeClaimed>(v11);
            };
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, v9), arg4), v10);
                let v12 = CreatorFeeClaimed{
                    raffle_id : arg1,
                    creator   : v10,
                    amount    : v9,
                };
                0x2::event::emit<CreatorFeeClaimed>(v12);
            };
            let v13 = WinnerSelected{
                raffle_id      : arg1,
                winner         : v6,
                prize_amount   : v8,
                winning_ticket : v5,
            };
            0x2::event::emit<WinnerSelected>(v13);
        };
        let v14 = RaffleEnded{
            raffle_id    : arg1,
            tickets_sold : v1,
            prize_pool   : v2,
        };
        0x2::event::emit<RaffleEnded>(v14);
    }

    public fun get_creator<T0>(arg0: &RafflePool<T0>, arg1: u64) : address {
        0x2::table::borrow<u64, Raffle<T0>>(&arg0.raffles, arg1).creator
    }

    public fun get_end_time<T0>(arg0: &RafflePool<T0>, arg1: u64) : u64 {
        0x2::table::borrow<u64, Raffle<T0>>(&arg0.raffles, arg1).end_time_ms
    }

    public fun get_pricing() : (u64, u64) {
        (10000000, 2500000)
    }

    public fun get_prize_pool<T0>(arg0: &RafflePool<T0>, arg1: u64) : u64 {
        0x2::table::borrow<u64, Raffle<T0>>(&arg0.raffles, arg1).total_prize_pool
    }

    public fun get_raffle_count<T0>(arg0: &RafflePool<T0>) : u64 {
        arg0.next_raffle_id - 1
    }

    public fun get_raffle_name<T0>(arg0: &RafflePool<T0>, arg1: u64) : 0x1::string::String {
        0x2::table::borrow<u64, Raffle<T0>>(&arg0.raffles, arg1).name
    }

    public fun get_raffle_state<T0>(arg0: &RafflePool<T0>, arg1: u64) : u8 {
        0x2::table::borrow<u64, Raffle<T0>>(&arg0.raffles, arg1).state
    }

    public fun get_tickets_sold<T0>(arg0: &RafflePool<T0>, arg1: u64) : u64 {
        0x2::table::borrow<u64, Raffle<T0>>(&arg0.raffles, arg1).tickets_sold
    }

    public fun get_winner<T0>(arg0: &RafflePool<T0>, arg1: u64) : 0x1::option::Option<address> {
        0x2::table::borrow<u64, Raffle<T0>>(&arg0.raffles, arg1).winner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_finalized<T0>(arg0: &RafflePool<T0>, arg1: u64) : bool {
        0x2::table::borrow<u64, Raffle<T0>>(&arg0.raffles, arg1).finalized
    }

    public entry fun update_raffle_state<T0>(arg0: &mut RafflePool<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::table::borrow_mut<u64, Raffle<T0>>(&mut arg0.raffles, arg1);
        if (v1.finalized) {
            return
        };
        if (v1.state == 0 && v0 >= v1.end_time_ms) {
            v1.state = 2;
            v1.finalized = true;
            let v2 = RaffleEnded{
                raffle_id    : arg1,
                tickets_sold : 0,
                prize_pool   : 0,
            };
            0x2::event::emit<RaffleEnded>(v2);
        } else {
            let v3 = if (v1.state == 0) {
                if (v0 >= v1.start_time_ms) {
                    v0 < v1.end_time_ms
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                v1.state = 1;
            } else if (v1.state == 1 && v0 >= v1.end_time_ms) {
                v1.state = 2;
                let v4 = RaffleEnded{
                    raffle_id    : arg1,
                    tickets_sold : v1.tickets_sold,
                    prize_pool   : v1.total_prize_pool,
                };
                0x2::event::emit<RaffleEnded>(v4);
            };
        };
    }

    // decompiled from Move bytecode v7
}

