module 0xda69d4edfe724f6b2562467b230779a60e3762a99fd141c891832d7986d3058d::nft_raffle {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Raffle has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        ticket_price: u64,
        max_tickets: u64,
        tickets_sold: u64,
        end_time: u64,
        active: bool,
        platform_fee_percent: u64,
        platform_address: address,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        owner: address,
        ticket_number: u64,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        nft_held_id: 0x2::object::ID,
        ticket_price: u64,
        max_tickets: u64,
        end_time: u64,
    }

    struct TicketPurchased has copy, drop {
        raffle_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        buyer: address,
        ticket_number: u64,
    }

    struct RaffleEnded has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        winning_ticket: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    public entry fun buy_ticket(arg0: &mut Raffle, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time, 6);
        assert!(arg0.tickets_sold < arg0.max_tickets, 5);
        let v0 = arg0.ticket_price;
        let v1 = 0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg3);
        let v2 = v0 * arg0.platform_fee_percent / 10000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v2, arg3), arg0.platform_address);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg0.creator);
        let v3 = arg0.tickets_sold + 1;
        let v4 = Ticket{
            id            : 0x2::object::new(arg3),
            raffle_id     : 0x2::object::id<Raffle>(arg0),
            owner         : 0x2::tx_context::sender(arg3),
            ticket_number : v3,
        };
        arg0.tickets_sold = v3;
        let v5 = TicketPurchased{
            raffle_id     : 0x2::object::id<Raffle>(arg0),
            ticket_id     : 0x2::object::id<Ticket>(&v4),
            buyer         : 0x2::tx_context::sender(arg3),
            ticket_number : v3,
        };
        0x2::event::emit<TicketPurchased>(v5);
        0x2::transfer::transfer<Ticket>(v4, 0x2::tx_context::sender(arg3));
    }

    public entry fun create_raffle<T0: copy + drop + store + key>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 10000000, 1);
        assert!(arg4 > 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg6) + arg5 * 3600 * 1000;
        let v1 = 0x2::object::new(arg8);
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v1, b"nft", arg0);
        let v2 = Raffle{
            id                   : v1,
            name                 : 0x1::string::utf8(arg1),
            description          : 0x1::string::utf8(arg2),
            creator              : 0x2::tx_context::sender(arg8),
            ticket_price         : arg3,
            max_tickets          : arg4,
            tickets_sold         : 0,
            end_time             : v0,
            active               : true,
            platform_fee_percent : 500,
            platform_address     : arg7,
        };
        let v3 = RaffleCreated{
            raffle_id    : 0x2::object::id<Raffle>(&v2),
            creator      : 0x2::tx_context::sender(arg8),
            nft_held_id  : 0x2::object::id<T0>(&arg0),
            ticket_price : arg3,
            max_tickets  : arg4,
            end_time     : v0,
        };
        0x2::event::emit<RaffleCreated>(v3);
        0x2::transfer::share_object<Raffle>(v2);
    }

    public entry fun draw_winner<T0: copy + drop + store + key>(arg0: &AdminCap, arg1: &mut Raffle, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.active, 7);
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg1.id, b"nft")) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg1.id, b"nft"), arg2);
        };
        let v0 = RaffleEnded{
            raffle_id      : 0x2::object::id<Raffle>(arg1),
            winner         : arg2,
            winning_ticket : 0x2::object::uid_to_inner(&arg1.id),
            nft_id         : 0x2::object::uid_to_inner(&arg1.id),
        };
        0x2::event::emit<RaffleEnded>(v0);
    }

    public entry fun end_raffle<T0: copy + drop + store + key>(arg0: &mut Raffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 4);
        assert!(arg0.active, 2);
        assert!(arg0.tickets_sold > 0, 3);
        arg0.active = false;
        let _ = 0x2::object::id<Raffle>(arg0);
        let v1 = arg0.creator;
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"nft")) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, b"nft"), v1);
        };
        let v2 = RaffleEnded{
            raffle_id      : 0x2::object::id<Raffle>(arg0),
            winner         : v1,
            winning_ticket : 0x2::object::uid_to_inner(&arg0.id),
            nft_id         : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<RaffleEnded>(v2);
    }

    fun generate_random_number(arg0: vector<u8>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        123 % arg1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

