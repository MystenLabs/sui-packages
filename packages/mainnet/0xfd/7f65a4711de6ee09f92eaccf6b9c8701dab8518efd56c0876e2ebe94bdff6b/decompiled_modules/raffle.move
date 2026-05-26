module 0xb3c8e5449b57f094aed49ef1faba7dd6f31ac76bff652957940122ec0cb666b6::raffle {
    struct Raffle<T0: store + key> has key {
        id: 0x2::object::UID,
        creator: address,
        prize: 0x1::option::Option<T0>,
        title: 0x1::string::String,
        ticket_price: u64,
        end_time_ms: u64,
        tickets: vector<address>,
        seller_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        settled: bool,
        winner: 0x1::option::Option<address>,
        winning_ticket: 0x1::option::Option<u64>,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        ticket_price: u64,
        end_time_ms: u64,
        prize_type: vector<u8>,
        title: vector<u8>,
    }

    struct TicketsBought has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        quantity: u64,
        gross_paid: u64,
        fee_paid: u64,
        total_tickets_after: u64,
    }

    struct RaffleSettled has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        winning_ticket: u64,
        prize_payout_to_creator: u64,
    }

    struct RaffleCancelled has copy, drop {
        raffle_id: 0x2::object::ID,
    }

    public entry fun buy_tickets<T0: store + key>(arg0: &mut Raffle<T0>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 7);
        assert!(!arg0.settled, 5);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time_ms, 1);
        let v0 = arg0.ticket_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 6);
        let v1 = v0 * 500 / 10000;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0;
        while (v3 < arg2) {
            0x1::vector::push_back<address>(&mut arg0.tickets, v2);
            v3 = v3 + 1;
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v1, arg4), @0x1a4c3e81ef4055af3ecf16d2f7c2ee34dd7406555716c9f32f4b75954f581490);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.seller_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v0 - v1, arg4)));
        let v4 = TicketsBought{
            raffle_id           : 0x2::object::id<Raffle<T0>>(arg0),
            buyer               : v2,
            quantity            : arg2,
            gross_paid          : v0,
            fee_paid            : v1,
            total_tickets_after : 0x1::vector::length<address>(&arg0.tickets),
        };
        0x2::event::emit<TicketsBought>(v4);
    }

    public entry fun cancel<T0: store + key>(arg0: &mut Raffle<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.settled, 5);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 3);
        assert!(0x1::vector::is_empty<address>(&arg0.tickets), 4);
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.prize), arg0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.seller_balance), arg1), arg0.creator);
        arg0.settled = true;
        let v0 = RaffleCancelled{raffle_id: 0x2::object::id<Raffle<T0>>(arg0)};
        0x2::event::emit<RaffleCancelled>(v0);
    }

    public entry fun create_raffle<T0: store + key>(arg0: T0, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 8);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 9);
        let v0 = Raffle<T0>{
            id             : 0x2::object::new(arg5),
            creator        : 0x2::tx_context::sender(arg5),
            prize          : 0x1::option::some<T0>(arg0),
            title          : 0x1::string::utf8(arg1),
            ticket_price   : arg2,
            end_time_ms    : arg3,
            tickets        : 0x1::vector::empty<address>(),
            seller_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            settled        : false,
            winner         : 0x1::option::none<address>(),
            winning_ticket : 0x1::option::none<u64>(),
        };
        let v1 = RaffleCreated{
            raffle_id    : 0x2::object::id<Raffle<T0>>(&v0),
            creator      : v0.creator,
            ticket_price : arg2,
            end_time_ms  : arg3,
            prize_type   : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            title        : *0x1::string::as_bytes(&v0.title),
        };
        0x2::event::emit<RaffleCreated>(v1);
        0x2::transfer::share_object<Raffle<T0>>(v0);
    }

    public fun creator<T0: store + key>(arg0: &Raffle<T0>) : address {
        arg0.creator
    }

    public fun end_time_ms<T0: store + key>(arg0: &Raffle<T0>) : u64 {
        arg0.end_time_ms
    }

    public fun is_settled<T0: store + key>(arg0: &Raffle<T0>) : bool {
        arg0.settled
    }

    entry fun settle<T0: store + key>(arg0: &mut Raffle<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.settled, 5);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time_ms, 2);
        let v0 = 0x1::vector::length<address>(&arg0.tickets);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.seller_balance), arg3), arg0.creator);
        if (v0 == 0) {
            0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.prize), arg0.creator);
            arg0.settled = true;
            let v1 = RaffleSettled{
                raffle_id               : 0x2::object::id<Raffle<T0>>(arg0),
                winner                  : arg0.creator,
                winning_ticket          : 0,
                prize_payout_to_creator : 0x2::balance::value<0x2::sui::SUI>(&arg0.seller_balance),
            };
            0x2::event::emit<RaffleSettled>(v1);
            return
        };
        let v2 = 0x2::random::new_generator(arg1, arg3);
        let v3 = 0x2::random::generate_u64_in_range(&mut v2, 0, v0 - 1);
        let v4 = *0x1::vector::borrow<address>(&arg0.tickets, v3);
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.prize), v4);
        arg0.settled = true;
        arg0.winner = 0x1::option::some<address>(v4);
        arg0.winning_ticket = 0x1::option::some<u64>(v3);
        let v5 = RaffleSettled{
            raffle_id               : 0x2::object::id<Raffle<T0>>(arg0),
            winner                  : v4,
            winning_ticket          : v3,
            prize_payout_to_creator : 0x2::balance::value<0x2::sui::SUI>(&arg0.seller_balance),
        };
        0x2::event::emit<RaffleSettled>(v5);
    }

    public fun ticket_price<T0: store + key>(arg0: &Raffle<T0>) : u64 {
        arg0.ticket_price
    }

    public fun total_tickets<T0: store + key>(arg0: &Raffle<T0>) : u64 {
        0x1::vector::length<address>(&arg0.tickets)
    }

    // decompiled from Move bytecode v7
}

