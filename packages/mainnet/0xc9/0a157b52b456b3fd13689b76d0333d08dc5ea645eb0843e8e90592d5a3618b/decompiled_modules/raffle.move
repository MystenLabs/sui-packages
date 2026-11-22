module 0xc90a157b52b456b3fd13689b76d0333d08dc5ea645eb0843e8e90592d5a3618b::raffle {
    struct Raffle has store, key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        image: 0x1::string::String,
        ticket_supply: u64,
        tickets_sold: u64,
        start_time: u64,
        end_time: u64,
        winner: 0x1::option::Option<address>,
        completed: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        draw_requested: bool,
        draw_ts: u64,
        pofr_event_id: 0x1::option::Option<0x2::object::ID>,
        automation_client_id: 0x2::object::ID,
        settle_client_id: 0x2::object::ID,
        tickets: vector<address>,
    }

    struct TicketRecord has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        owner: address,
        ticket_numbers: vector<u64>,
    }

    struct RaffleRegistry has key {
        id: 0x2::object::UID,
        raffle_ids: vector<0x2::object::ID>,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        ticket_supply: u64,
        start_time: u64,
        end_time: u64,
        automation_client_id: 0x2::object::ID,
    }

    struct TicketPurchased has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        quantity: u64,
        ticket_numbers: vector<u64>,
    }

    struct DrawRequested has copy, drop {
        raffle_id: 0x2::object::ID,
        draw_ts: u64,
    }

    struct RaffleCompleted has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        winner_prize: u64,
        creator_prize: u64,
        pofr_event_id: 0x2::object::ID,
    }

    public entry fun buy_tickets(arg0: &mut Raffle, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 13);
        assert!(!arg0.completed, 8);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.start_time, 6);
        assert!(v0 < arg0.end_time, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 2000000000 * arg2, 9);
        assert!(arg0.tickets_sold + arg2 <= arg0.ticket_supply, 10);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < arg2) {
            0x1::vector::push_back<address>(&mut arg0.tickets, v1);
            0x1::vector::push_back<u64>(&mut v2, arg0.tickets_sold + v3);
            v3 = v3 + 1;
        };
        arg0.tickets_sold = arg0.tickets_sold + arg2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v4 = TicketRecord{
            id             : 0x2::object::new(arg4),
            raffle_id      : 0x2::object::uid_to_inner(&arg0.id),
            owner          : v1,
            ticket_numbers : v2,
        };
        0x2::transfer::transfer<TicketRecord>(v4, v1);
        let v5 = TicketPurchased{
            raffle_id      : 0x2::object::uid_to_inner(&arg0.id),
            buyer          : v1,
            quantity       : arg2,
            ticket_numbers : v2,
        };
        0x2::event::emit<TicketPurchased>(v5);
    }

    public entry fun create_raffle(arg0: &mut RaffleRegistry, arg1: &mut 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::AutomationRegistry, arg2: &0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::CoordinatorConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 10000000000, 1);
        assert!(arg7 > 0, 2);
        assert!(arg7 <= 100000, 18);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 5);
        assert!(arg8 >= 0x2::clock::timestamp_ms(arg10) + 60000, 3);
        assert!(arg9 > arg8, 4);
        let v0 = 0x2::object::new(arg11);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x1::type_name::with_defining_ids<Raffle>();
        let v3 = 0x1::type_name::address_string(&v2);
        let v4 = b"0x";
        0x1::vector::append<u8>(&mut v4, *0x1::ascii::as_bytes(&v3));
        0x1::vector::append<u8>(&mut v4, b"::raffle::execute_settlement");
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v5, v1);
        0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::register_client(arg1, 2, v4, v5, 0x1::bcs::to_bytes<0x2::object::ID>(&v1), arg11);
        let v6 = b"0x";
        0x1::vector::append<u8>(&mut v6, *0x1::ascii::as_bytes(&v3));
        0x1::vector::append<u8>(&mut v6, b"::raffle::execute_draw");
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x2::object::ID>(v8, v1);
        0x1::vector::push_back<0x2::object::ID>(v8, 0x2::object::id<0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::AutomationRegistry>(arg1));
        0x1::vector::push_back<0x2::object::ID>(v8, 0x2::object::id<0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::CoordinatorConfig>(arg2));
        0x1::vector::push_back<0x2::object::ID>(v8, 0x2::object::id_from_address(@0x6));
        0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::register_client(arg1, 2, v6, v7, 0x1::bcs::to_bytes<0x2::object::ID>(&v1), arg11);
        let v9 = 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::client_of(arg1, 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::client_count(arg1) - 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, @0x68009a0fca7402615efa3b8ed33531cecb072b4fe3165d0007342b400cea7530);
        let v10 = Raffle{
            id                   : v0,
            creator              : 0x2::tx_context::sender(arg11),
            title                : 0x1::string::utf8(arg4),
            description          : 0x1::string::utf8(arg5),
            image                : 0x1::string::utf8(arg6),
            ticket_supply        : arg7,
            tickets_sold         : 0,
            start_time           : arg8,
            end_time             : arg9,
            winner               : 0x1::option::none<address>(),
            completed            : false,
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_reserve          : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 150000000, arg11)),
            draw_requested       : false,
            draw_ts              : 0,
            pofr_event_id        : 0x1::option::none<0x2::object::ID>(),
            automation_client_id : v9,
            settle_client_id     : 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::client_of(arg1, 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::client_count(arg1) - 1),
            tickets              : vector[],
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.raffle_ids, v1);
        let v11 = RaffleCreated{
            raffle_id            : v1,
            creator              : 0x2::tx_context::sender(arg11),
            title                : 0x1::string::utf8(arg4),
            ticket_supply        : arg7,
            start_time           : arg8,
            end_time             : arg9,
            automation_client_id : v9,
        };
        0x2::event::emit<RaffleCreated>(v11);
        0x2::transfer::share_object<Raffle>(v10);
    }

    fun draw_core(arg0: &mut Raffle, arg1: &mut 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client, arg2: &0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::AutomationRegistry, arg3: &mut 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::CoordinatorConfig, arg4: &0x2::clock::Clock, arg5: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::min_fee(arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_reserve);
        let v2 = if (v1 >= v0) {
            v0
        } else {
            v1
        };
        let v3 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_reserve, v2, arg6);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg5)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v3, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg5));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v3) >= v0, 17);
        let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut v3, v0, arg6);
        refund_coin(v3, 0x2::tx_context::sender(arg6));
        top_escrow_from_reserve(arg0, arg1, 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::automation_fee(arg2), arg6);
        let v5 = 0x2::object::uid_to_inner(&arg0.id);
        arg0.draw_requested = true;
        arg0.draw_ts = 0x2::clock::timestamp_ms(arg4);
        0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::request_randomness_with_key(arg3, 0x1::bcs::to_bytes<0x2::object::ID>(&v5), v4, arg4, arg6);
        let v6 = DrawRequested{
            raffle_id : 0x2::object::uid_to_inner(&arg0.id),
            draw_ts   : arg0.draw_ts,
        };
        0x2::event::emit<DrawRequested>(v6);
    }

    public fun draw_key(arg0: &Raffle) : vector<u8> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x1::bcs::to_bytes<0x2::object::ID>(&v0)
    }

    public entry fun execute_draw(arg0: &mut 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client, arg1: 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::PerformTicket, arg2: &mut Raffle, arg3: &0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::AutomationRegistry, arg4: &mut 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::CoordinatorConfig, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client>(arg0) == arg2.automation_client_id, 14);
        assert!(!arg2.draw_requested, 11);
        draw_core(arg2, arg0, arg3, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>(), arg7);
        0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::roll_deadline(arg0, &arg1, 18446744073709551615);
        0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::consume_ticket(arg0, arg1);
    }

    public entry fun execute_settlement(arg0: &mut 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client, arg1: 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::PerformTicket, arg2: &mut Raffle, arg3: &0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::PoFREvent, arg4: &0x2::clock::Clock, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client>(arg0) == arg2.settle_client_id, 14);
        settle(arg2, arg3, arg4, arg6);
        0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::roll_deadline(arg0, &arg1, 18446744073709551615);
        0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::consume_ticket(arg0, arg1);
    }

    public fun fee_reserve_of(arg0: &Raffle) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_reserve)
    }

    public entry fun fund_escrow(arg0: &mut Raffle, arg1: &mut 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client, arg2: &0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::AutomationRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client>(arg1);
        assert!(v0 == arg0.automation_client_id || v0 == arg0.settle_client_id, 14);
        top_escrow_from_reserve(arg0, arg1, 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::automation_fee(arg2), arg3);
    }

    public fun get_creation_fee() : u64 {
        10000000000
    }

    public fun get_platform_wallet() : address {
        @0x68009a0fca7402615efa3b8ed33531cecb072b4fe3165d0007342b400cea7530
    }

    public fun get_raffle_info(arg0: &Raffle) : (address, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, 0x1::option::Option<address>, bool, u64, bool, u64, 0x1::option::Option<0x2::object::ID>, 0x2::object::ID) {
        (arg0.creator, arg0.title, arg0.description, arg0.image, arg0.ticket_supply, arg0.tickets_sold, arg0.start_time, arg0.end_time, arg0.winner, arg0.completed, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.draw_requested, arg0.draw_ts, arg0.pofr_event_id, arg0.automation_client_id)
    }

    public fun get_randproof_fee_reserve() : u64 {
        150000000
    }

    public fun get_ticket_price() : u64 {
        2000000000
    }

    public fun get_time_remaining(arg0: &Raffle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.end_time) {
            0
        } else {
            arg0.end_time - v0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RaffleRegistry{
            id         : 0x2::object::new(arg0),
            raffle_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<RaffleRegistry>(v0);
    }

    fun is_due(arg0: &Raffle, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.end_time || arg0.tickets_sold == arg0.ticket_supply
    }

    public fun is_raffle_active(arg0: &Raffle, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (!arg0.completed) {
            if (v0 >= arg0.start_time) {
                v0 < arg0.end_time
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_raffle_ready_to_complete(arg0: &Raffle, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.completed) {
            if (arg0.tickets_sold > 0) {
                is_due(arg0, arg1)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun refund_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        };
    }

    fun refund_coins(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: address) {
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0), arg1);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
    }

    public entry fun request_draw(arg0: &mut Raffle, arg1: &mut 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client, arg2: &0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::AutomationRegistry, arg3: &mut 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::CoordinatorConfig, arg4: &0x2::clock::Clock, arg5: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 8);
        assert!(0x2::object::id<0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client>(arg1) == arg0.automation_client_id, 14);
        assert!(arg0.tickets_sold > 0, 12);
        assert!(is_due(arg0, arg4), 11);
        if (arg0.draw_requested) {
            refund_coins(arg5, 0x2::tx_context::sender(arg6));
            return
        };
        draw_core(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun seed_to_u64(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 8) {
            let v2 = v1 << 8;
            v1 = v2 | (*0x1::vector::borrow<u8>(arg0, v0) as u64);
            v0 = v0 + 1;
        };
        v1
    }

    fun settle(arg0: &mut Raffle, arg1: &0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::PoFREvent, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 8);
        assert!(arg0.tickets_sold > 0, 12);
        assert!(is_due(arg0, arg2), 11);
        assert!(arg0.draw_requested, 11);
        assert!(0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::is_fulfilled(arg1), 15);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::draw_key_of(arg1) == 0x1::bcs::to_bytes<0x2::object::ID>(&v0), 16);
        assert!(0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::request_ts_of(arg1) == arg0.draw_ts, 16);
        let v1 = 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::seed_of(arg1);
        let v2 = *0x1::vector::borrow<address>(&arg0.tickets, seed_to_u64(&v1) % arg0.tickets_sold);
        arg0.winner = 0x1::option::some<address>(v2);
        arg0.completed = true;
        let v3 = 0x2::object::id<0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::PoFREvent>(arg1);
        arg0.pofr_event_id = 0x1::option::some<0x2::object::ID>(v3);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        let v5 = v4 / 2;
        let v6 = v4 - v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v5, arg3), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v6, arg3), arg0.creator);
        let v7 = RaffleCompleted{
            raffle_id     : 0x2::object::uid_to_inner(&arg0.id),
            winner        : v2,
            winner_prize  : v5,
            creator_prize : v6,
            pofr_event_id : v3,
        };
        0x2::event::emit<RaffleCompleted>(v7);
    }

    public fun settle_client_id(arg0: &Raffle) : 0x2::object::ID {
        arg0.settle_client_id
    }

    public entry fun settle_raffle(arg0: &mut Raffle, arg1: &0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event::PoFREvent, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        settle(arg0, arg1, arg2, arg3);
    }

    fun top_escrow_from_reserve(arg0: &mut Raffle, arg1: &mut 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::Client, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::client_balance(arg1);
        if (v0 >= arg2) {
            return
        };
        let v1 = arg2 - v0;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_reserve);
        if (v2 == 0) {
            return
        };
        let v3 = if (v2 >= v1) {
            v1
        } else {
            v2
        };
        0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation::add_funds(arg1, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_reserve, v3, arg3));
    }

    // decompiled from Move bytecode v7
}

