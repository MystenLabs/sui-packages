module 0xd96ce312f857e4dd5e49d2ab5ca1a6f203385e68ef8e4bbad1c197bcdcb93c2a::raffle {
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

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        ticket_supply: u64,
        start_time: u64,
        end_time: u64,
    }

    struct TicketPurchased has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        quantity: u64,
        ticket_numbers: vector<u64>,
    }

    struct RaffleCompleted has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        winner_prize: u64,
        creator_prize: u64,
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
        let v2 = 0x1::vector::empty<u64>();
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

    fun bytes_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8 && v1 < 0x1::vector::length<u8>(&arg0)) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << (((7 - v1) * 8) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun complete_raffle(arg0: &mut Raffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 8);
        assert!(arg0.tickets_sold > 0, 12);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time || arg0.tickets_sold == arg0.ticket_supply, 11);
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, 0x2::object::uid_to_bytes(&arg0.id));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg0.tickets_sold));
        let v3 = *0x1::vector::borrow<address>(&arg0.tickets, bytes_to_u64(0x2::hash::keccak256(&v2)) % arg0.tickets_sold);
        arg0.winner = 0x1::option::some<address>(v3);
        arg0.completed = true;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        let v5 = v4 / 2;
        let v6 = v4 - v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v5, arg2), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v6, arg2), arg0.creator);
        let v7 = RaffleCompleted{
            raffle_id     : 0x2::object::uid_to_inner(&arg0.id),
            winner        : v3,
            winner_prize  : v5,
            creator_prize : v6,
        };
        0x2::event::emit<RaffleCompleted>(v7);
    }

    public entry fun create_raffle(arg0: &mut RaffleRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 10000000000, 1);
        assert!(arg5 > 0, 2);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 5);
        assert!(arg6 >= 0x2::clock::timestamp_ms(arg8) + 120000, 3);
        assert!(arg7 > arg6, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xdd6534e8b1807d7d16e2f168074612332cf443c627abc1da954ec5f315290974);
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Raffle{
            id            : v0,
            creator       : 0x2::tx_context::sender(arg9),
            title         : 0x1::string::utf8(arg2),
            description   : 0x1::string::utf8(arg3),
            image         : 0x1::string::utf8(arg4),
            ticket_supply : arg5,
            tickets_sold  : 0,
            start_time    : arg6,
            end_time      : arg7,
            winner        : 0x1::option::none<address>(),
            completed     : false,
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            tickets       : 0x1::vector::empty<address>(),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.raffle_ids, v1);
        let v3 = RaffleCreated{
            raffle_id     : v1,
            creator       : 0x2::tx_context::sender(arg9),
            title         : 0x1::string::utf8(arg2),
            ticket_supply : arg5,
            start_time    : arg6,
            end_time      : arg7,
        };
        0x2::event::emit<RaffleCreated>(v3);
        0x2::transfer::share_object<Raffle>(v2);
    }

    public fun get_creation_fee() : u64 {
        10000000000
    }

    public fun get_platform_wallet() : address {
        @0xdd6534e8b1807d7d16e2f168074612332cf443c627abc1da954ec5f315290974
    }

    public fun get_raffle_info(arg0: &Raffle) : (address, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, 0x1::option::Option<address>, bool, u64) {
        (arg0.creator, arg0.title, arg0.description, arg0.image, arg0.ticket_supply, arg0.tickets_sold, arg0.start_time, arg0.end_time, arg0.winner, arg0.completed, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance))
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
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
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
                0x2::clock::timestamp_ms(arg1) >= arg0.end_time || arg0.tickets_sold == arg0.ticket_supply
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

