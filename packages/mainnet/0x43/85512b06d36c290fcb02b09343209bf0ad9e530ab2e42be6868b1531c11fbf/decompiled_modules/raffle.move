module 0x4385512b06d36c290fcb02b09343209bf0ad9e530ab2e42be6868b1531c11fbf::raffle {
    struct Ticket has store, key {
        id: 0x2::object::UID,
        raffle_id: address,
        ticket_number: u64,
        owner: address,
    }

    struct Raffle has key {
        id: 0x2::object::UID,
        admin: address,
        ticket_price: u64,
        end_time: u64,
        fee_percentage: u64,
        num_winners: u64,
        prize_pool: 0x2::coin::Coin<0x2::sui::SUI>,
        admin_fee: 0x2::coin::Coin<0x2::sui::SUI>,
        tickets: vector<Ticket>,
        winners: vector<address>,
        active: bool,
        next_ticket_number: u64,
    }

    struct RaffleRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        raffles: vector<address>,
    }

    struct TicketPurchased has copy, drop {
        raffle_id: address,
        buyer: address,
        ticket_numbers: vector<u64>,
        amount_paid: u64,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: address,
        admin: address,
        ticket_price: u64,
        end_time: u64,
        fee_percentage: u64,
        num_winners: u64,
    }

    struct RaffleEnded has copy, drop {
        raffle_id: address,
        winners: vector<address>,
        prize_per_winner: u64,
        admin_fee: u64,
        total_tickets: u64,
    }

    struct AdminFeeWithdrawn has copy, drop {
        raffle_id: address,
        admin: address,
        amount: u64,
    }

    public entry fun buy_ticket(arg0: &mut Raffle, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.ticket_price, 1);
        let v1 = v0 / arg0.ticket_price;
        let v2 = v1 * arg0.ticket_price;
        if (v0 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 - v2, arg2), 0x2::tx_context::sender(arg2));
        };
        let v3 = 0x2::tx_context::sender(arg2);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x2::object::uid_to_address(&arg0.id);
        let v6 = 0;
        while (v6 < v1) {
            let v7 = Ticket{
                id            : 0x2::object::new(arg2),
                raffle_id     : v5,
                ticket_number : arg0.next_ticket_number,
                owner         : v3,
            };
            0x1::vector::push_back<u64>(&mut v4, arg0.next_ticket_number);
            arg0.next_ticket_number = arg0.next_ticket_number + 1;
            0x1::vector::push_back<Ticket>(&mut arg0.tickets, v7);
            v6 = v6 + 1;
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.prize_pool, arg1);
        let v8 = TicketPurchased{
            raffle_id      : v5,
            buyer          : v3,
            ticket_numbers : v4,
            amount_paid    : v2,
        };
        0x2::event::emit<TicketPurchased>(v8);
    }

    public entry fun create_raffle(arg0: &mut RaffleRegistry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 4);
        assert!(arg1 >= 100000000, 1);
        assert!(arg3 <= 50, 7);
        assert!(arg4 > 0, 7);
        let v0 = 0x2::clock::timestamp_ms(arg5) + arg2;
        let v1 = Raffle{
            id                 : 0x2::object::new(arg6),
            admin              : arg0.admin,
            ticket_price       : arg1,
            end_time           : v0,
            fee_percentage     : arg3,
            num_winners        : arg4,
            prize_pool         : 0x2::coin::zero<0x2::sui::SUI>(arg6),
            admin_fee          : 0x2::coin::zero<0x2::sui::SUI>(arg6),
            tickets            : 0x1::vector::empty<Ticket>(),
            winners            : 0x1::vector::empty<address>(),
            active             : true,
            next_ticket_number : 1,
        };
        let v2 = 0x2::object::uid_to_address(&v1.id);
        0x1::vector::push_back<address>(&mut arg0.raffles, v2);
        let v3 = RaffleCreated{
            raffle_id      : v2,
            admin          : arg0.admin,
            ticket_price   : arg1,
            end_time       : v0,
            fee_percentage : arg3,
            num_winners    : arg4,
        };
        0x2::event::emit<RaffleCreated>(v3);
        0x2::transfer::share_object<Raffle>(v1);
    }

    public entry fun end_raffle(arg0: &mut Raffle, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        assert!(arg0.active, 5);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 3);
        let v0 = 0x1::vector::length<Ticket>(&arg0.tickets);
        assert!(v0 > 0, 6);
        let v1 = if (arg0.num_winners > v0) {
            v0
        } else {
            arg0.num_winners
        };
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v3 = v2 * arg0.fee_percentage / 100;
        let v4 = (v2 - v3) / v1;
        if (v3 > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg0.admin_fee, 0x2::coin::split<0x2::sui::SUI>(&mut arg0.prize_pool, v3, arg3));
        };
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x2::random::new_generator(arg2, arg3);
        while (0x1::vector::length<u64>(&v5) < v1) {
            let v7 = 0x2::random::generate_u64_in_range(&mut v6, 0, v0 - 1);
            let v8 = false;
            let v9 = 0;
            while (v9 < 0x1::vector::length<u64>(&v5)) {
                if (*0x1::vector::borrow<u64>(&v5, v9) == v7) {
                    v8 = true;
                    break
                };
                v9 = v9 + 1;
            };
            if (!v8) {
                0x1::vector::push_back<u64>(&mut v5, v7);
            };
        };
        let v10 = 0;
        while (v10 < 0x1::vector::length<u64>(&v5)) {
            let v11 = 0x1::vector::borrow<Ticket>(&arg0.tickets, *0x1::vector::borrow<u64>(&v5, v10)).owner;
            0x1::vector::push_back<address>(&mut arg0.winners, v11);
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.prize_pool, v4, arg3), v11);
            };
            v10 = v10 + 1;
        };
        arg0.active = false;
        let v12 = RaffleEnded{
            raffle_id        : 0x2::object::uid_to_address(&arg0.id),
            winners          : arg0.winners,
            prize_per_winner : v4,
            admin_fee        : v3,
            total_tickets    : v0,
        };
        0x2::event::emit<RaffleEnded>(v12);
    }

    public fun get_raffle_info(arg0: &Raffle) : (u64, u64, u64, u64, u64, u64, u64, vector<address>, bool) {
        (arg0.ticket_price, arg0.end_time, arg0.fee_percentage, arg0.num_winners, 0x2::coin::value<0x2::sui::SUI>(&arg0.prize_pool), 0x2::coin::value<0x2::sui::SUI>(&arg0.admin_fee), 0x1::vector::length<Ticket>(&arg0.tickets), arg0.winners, arg0.active)
    }

    public fun get_ticket_info(arg0: &Ticket) : (address, u64, address) {
        (arg0.raffle_id, arg0.ticket_number, arg0.owner)
    }

    public fun get_user_tickets(arg0: &Raffle, arg1: address) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Ticket>(&arg0.tickets)) {
            let v2 = 0x1::vector::borrow<Ticket>(&arg0.tickets, v1);
            if (v2.owner == arg1) {
                0x1::vector::push_back<u64>(&mut v0, v2.ticket_number);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RaffleRegistry{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            raffles : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<RaffleRegistry>(v0);
    }

    public fun is_raffle_ended(arg0: &Raffle, arg1: &0x2::clock::Clock) : bool {
        !arg0.active || 0x2::clock::timestamp_ms(arg1) >= arg0.end_time
    }

    public entry fun withdraw_admin_fee(arg0: &mut Raffle, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 4);
        assert!(!arg0.active, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0.admin_fee);
        assert!(v0 > 0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.admin_fee, v0, arg1), arg0.admin);
        let v1 = AdminFeeWithdrawn{
            raffle_id : 0x2::object::uid_to_address(&arg0.id),
            admin     : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<AdminFeeWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

