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

    struct KioskRaffle has key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        ticket_price: u64,
        end_time_ms: u64,
        tickets: vector<address>,
        seller_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        settled: bool,
        winner: 0x1::option::Option<address>,
        winning_ticket: 0x1::option::Option<u64>,
        creator_kiosk_id: 0x2::object::ID,
        prize_item_id: 0x2::object::ID,
        cap_taken: bool,
    }

    struct CapKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct KioskRaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        creator_kiosk_id: 0x2::object::ID,
        prize_item_id: 0x2::object::ID,
        ticket_price: u64,
        end_time_ms: u64,
        prize_type: vector<u8>,
        title: vector<u8>,
    }

    struct KioskTicketsBought has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        quantity: u64,
        gross_paid: u64,
        fee_paid: u64,
        total_tickets_after: u64,
    }

    struct KioskWinnerPicked has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        winning_ticket: u64,
    }

    struct KioskRaffleSettled has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        kiosk_payment: u64,
        creator_payout: u64,
    }

    struct KioskRaffleCancelled has copy, drop {
        raffle_id: 0x2::object::ID,
    }

    public entry fun buy_kiosk_tickets(arg0: &mut KioskRaffle, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
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
        let v4 = KioskTicketsBought{
            raffle_id           : 0x2::object::id<KioskRaffle>(arg0),
            buyer               : v2,
            quantity            : arg2,
            gross_paid          : v0,
            fee_paid            : v1,
            total_tickets_after : 0x1::vector::length<address>(&arg0.tickets),
        };
        0x2::event::emit<KioskTicketsBought>(v4);
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

    public entry fun cancel_kiosk_raffle<T0: store + key>(arg0: &mut KioskRaffle, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.settled, 5);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 3);
        assert!(0x1::vector::is_empty<address>(&arg0.tickets), 4);
        arg0.settled = true;
        let v0 = CapKey<T0>{dummy_field: false};
        0x2::transfer::public_transfer<0x2::kiosk::PurchaseCap<T0>>(0x2::dynamic_field::remove<CapKey<T0>, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, v0), arg0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.seller_balance), arg1), arg0.creator);
        let v1 = KioskRaffleCancelled{raffle_id: 0x2::object::id<KioskRaffle>(arg0)};
        0x2::event::emit<KioskRaffleCancelled>(v1);
    }

    public entry fun create_kiosk_raffle<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 8);
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6), 9);
        let v0 = KioskRaffle{
            id               : 0x2::object::new(arg7),
            creator          : 0x2::tx_context::sender(arg7),
            title            : 0x1::string::utf8(arg3),
            ticket_price     : arg4,
            end_time_ms      : arg5,
            tickets          : 0x1::vector::empty<address>(),
            seller_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            settled          : false,
            winner           : 0x1::option::none<address>(),
            winning_ticket   : 0x1::option::none<u64>(),
            creator_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            prize_item_id    : arg2,
            cap_taken        : false,
        };
        let v1 = KioskRaffleCreated{
            raffle_id        : 0x2::object::id<KioskRaffle>(&v0),
            creator          : v0.creator,
            creator_kiosk_id : v0.creator_kiosk_id,
            prize_item_id    : arg2,
            ticket_price     : arg4,
            end_time_ms      : arg5,
            prize_type       : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            title            : *0x1::string::as_bytes(&v0.title),
        };
        0x2::event::emit<KioskRaffleCreated>(v1);
        let v2 = CapKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<CapKey<T0>, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, v2, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg7));
        0x2::transfer::share_object<KioskRaffle>(v0);
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

    public entry fun finalize_kiosk_settle(arg0: &mut KioskRaffle, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.settled, 5);
        assert!(arg0.cap_taken, 14);
        arg0.settled = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.seller_balance), arg1), arg0.creator);
        let v0 = if (0x1::option::is_some<address>(&arg0.winner)) {
            *0x1::option::borrow<address>(&arg0.winner)
        } else {
            arg0.creator
        };
        let v1 = KioskRaffleSettled{
            raffle_id      : 0x2::object::id<KioskRaffle>(arg0),
            winner         : v0,
            kiosk_payment  : 0,
            creator_payout : 0x2::balance::value<0x2::sui::SUI>(&arg0.seller_balance),
        };
        0x2::event::emit<KioskRaffleSettled>(v1);
    }

    public fun is_settled<T0: store + key>(arg0: &Raffle<T0>) : bool {
        arg0.settled
    }

    public fun kiosk_creator(arg0: &KioskRaffle) : address {
        arg0.creator
    }

    public fun kiosk_creator_kiosk_id(arg0: &KioskRaffle) : 0x2::object::ID {
        arg0.creator_kiosk_id
    }

    public fun kiosk_end_time_ms(arg0: &KioskRaffle) : u64 {
        arg0.end_time_ms
    }

    public fun kiosk_is_settled(arg0: &KioskRaffle) : bool {
        arg0.settled
    }

    public fun kiosk_pool_value(arg0: &KioskRaffle) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.seller_balance)
    }

    public fun kiosk_prize_item_id(arg0: &KioskRaffle) : 0x2::object::ID {
        arg0.prize_item_id
    }

    public fun kiosk_ticket_price(arg0: &KioskRaffle) : u64 {
        arg0.ticket_price
    }

    public fun kiosk_total_tickets(arg0: &KioskRaffle) : u64 {
        0x1::vector::length<address>(&arg0.tickets)
    }

    entry fun pick_winner_kiosk(arg0: &mut KioskRaffle, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.settled, 5);
        assert!(0x1::option::is_none<address>(&arg0.winner), 11);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time_ms, 2);
        let v0 = 0x1::vector::length<address>(&arg0.tickets);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::random::new_generator(arg1, arg3);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 0, v0 - 1);
        let v3 = *0x1::vector::borrow<address>(&arg0.tickets, v2);
        arg0.winner = 0x1::option::some<address>(v3);
        arg0.winning_ticket = 0x1::option::some<u64>(v2);
        let v4 = KioskWinnerPicked{
            raffle_id      : 0x2::object::id<KioskRaffle>(arg0),
            winner         : v3,
            winning_ticket : v2,
        };
        0x2::event::emit<KioskWinnerPicked>(v4);
    }

    public entry fun refund_no_tickets_kiosk<T0: store + key>(arg0: &mut KioskRaffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.settled, 5);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time_ms, 2);
        assert!(0x1::vector::is_empty<address>(&arg0.tickets), 4);
        arg0.settled = true;
        let v0 = CapKey<T0>{dummy_field: false};
        0x2::transfer::public_transfer<0x2::kiosk::PurchaseCap<T0>>(0x2::dynamic_field::remove<CapKey<T0>, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, v0), arg0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.seller_balance), arg2), arg0.creator);
        let v1 = KioskRaffleCancelled{raffle_id: 0x2::object::id<KioskRaffle>(arg0)};
        0x2::event::emit<KioskRaffleCancelled>(v1);
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

    public fun take_for_kiosk_settle<T0: store + key>(arg0: &mut KioskRaffle, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::PurchaseCap<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.settled, 5);
        assert!(0x1::option::is_some<address>(&arg0.winner), 10);
        assert!(!arg0.cap_taken, 13);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.seller_balance) >= arg1, 15);
        arg0.cap_taken = true;
        let v0 = CapKey<T0>{dummy_field: false};
        (0x2::dynamic_field::remove<CapKey<T0>, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, v0), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.seller_balance, arg1), arg2))
    }

    public fun ticket_price<T0: store + key>(arg0: &Raffle<T0>) : u64 {
        arg0.ticket_price
    }

    public fun total_tickets<T0: store + key>(arg0: &Raffle<T0>) : u64 {
        0x1::vector::length<address>(&arg0.tickets)
    }

    // decompiled from Move bytecode v7
}

