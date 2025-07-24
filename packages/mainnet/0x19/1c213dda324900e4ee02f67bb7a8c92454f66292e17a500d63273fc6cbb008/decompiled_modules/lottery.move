module 0x191c213dda324900e4ee02f67bb7a8c92454f66292e17a500d63273fc6cbb008::lottery {
    struct Lottery has store, key {
        id: 0x2::object::UID,
        ticket_price: u64,
        max_tickets: u64,
        current_tickets: u64,
        participants: 0x2::vec_map::VecMap<address, u64>,
        total_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        is_active: bool,
        round_number: u64,
        admin: address,
    }

    struct LotteryCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        owner: address,
        lottery_id: address,
        round_number: u64,
        purchase_count: u64,
        total_purchases: u64,
        lottery_version: u64,
        image_url: 0x1::string::String,
    }

    struct LotteryCreated has copy, drop {
        lottery_id: address,
        ticket_price: u64,
        max_tickets: u64,
        admin: address,
    }

    struct TicketPurchased has copy, drop {
        lottery_id: address,
        buyer: address,
        ticket_count: u64,
        total_cost: u64,
        round_number: u64,
    }

    struct LotteryDrawn has copy, drop {
        lottery_id: address,
        winner: address,
        prize_amount: u64,
        round_number: u64,
        total_participants: u64,
    }

    public fun create_lottery(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 5);
        let v0 = Lottery{
            id              : 0x2::object::new(arg1),
            ticket_price    : 100000000,
            max_tickets     : arg0,
            current_tickets : 0,
            participants    : 0x2::vec_map::empty<address, u64>(),
            total_pool      : 0x2::balance::zero<0x2::sui::SUI>(),
            is_active       : true,
            round_number    : 1,
            admin           : @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a,
        };
        let v1 = LotteryCap{
            id    : 0x2::object::new(arg1),
            admin : @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a,
        };
        let v2 = LotteryCreated{
            lottery_id   : 0x2::object::uid_to_address(&v0.id),
            ticket_price : 100000000,
            max_tickets  : arg0,
            admin        : @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a,
        };
        0x2::event::emit<LotteryCreated>(v2);
        0x2::transfer::public_transfer<Lottery>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<LotteryCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun destroy_lottery(arg0: Lottery, arg1: LotteryCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == arg0.admin, 7);
        assert!(!arg0.is_active, 2);
        let Lottery {
            id              : v0,
            ticket_price    : _,
            max_tickets     : _,
            current_tickets : _,
            participants    : _,
            total_pool      : v5,
            is_active       : _,
            round_number    : _,
            admin           : _,
        } = arg0;
        let v9 = v5;
        let LotteryCap {
            id    : v10,
            admin : _,
        } = arg1;
        if (0x2::balance::value<0x2::sui::SUI>(&v9) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v9, arg2), @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a);
        };
        0x2::object::delete(v0);
        0x2::object::delete(v10);
    }

    public fun draw_lottery(arg0: &mut Lottery, arg1: &LotteryCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == arg0.admin, 7);
        assert!(arg0.is_active, 1);
        assert!(arg0.current_tickets > 0, 3);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool);
        let v1 = v0 / 10;
        let v2 = v0 - v1;
        let v3 = 0x2::vec_map::keys<address, u64>(&arg0.participants);
        let v4 = if (0x1::vector::length<address>(&v3) > 0) {
            *0x1::vector::borrow<address>(&v3, 0)
        } else {
            arg0.admin
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v2), arg2), v4);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v1), arg2), arg0.admin);
        };
        arg0.is_active = false;
        let v5 = LotteryDrawn{
            lottery_id         : 0x2::object::uid_to_address(&arg0.id),
            winner             : v4,
            prize_amount       : v2,
            round_number       : arg0.round_number,
            total_participants : arg0.current_tickets,
        };
        0x2::event::emit<LotteryDrawn>(v5);
    }

    public fun purchase_tickets(arg0: &mut Lottery, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.is_active, 1);
        assert!(arg0.current_tickets + arg2 <= arg0.max_tickets, 6);
        let v0 = arg0.ticket_price * arg2;
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= v0, 0);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x2::object::uid_to_address(&arg0.id);
        let v4 = if (0x2::vec_map::contains<address, u64>(&arg0.participants, &v2)) {
            *0x2::vec_map::get<address, u64>(&arg0.participants, &v2)
        } else {
            0
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.participants, v2, v4 + arg2);
        arg0.current_tickets = arg0.current_tickets + arg2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v5 = 0;
        while (v5 < arg2) {
            let v6 = Ticket{
                id              : 0x2::object::new(arg3),
                owner           : v2,
                lottery_id      : v3,
                round_number    : arg0.round_number,
                purchase_count  : v4 + v5 + 1,
                total_purchases : v4 + arg2,
                lottery_version : 3,
                image_url       : 0x1::string::utf8(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSE-IusERCmtNsDEh925OMzGu2iNajMCIeEXQ&s"),
            };
            0x2::transfer::public_transfer<Ticket>(v6, v2);
            v5 = v5 + 1;
        };
        let v7 = TicketPurchased{
            lottery_id   : v3,
            buyer        : v2,
            ticket_count : arg2,
            total_cost   : v0,
            round_number : arg0.round_number,
        };
        0x2::event::emit<TicketPurchased>(v7);
        if (v1 > v0) {
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v1 - v0), arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        }
    }

    public fun start_new_round(arg0: &mut Lottery, arg1: &LotteryCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == arg0.admin, 7);
        assert!(!arg0.is_active, 2);
        arg0.is_active = true;
        arg0.current_tickets = 0;
        arg0.round_number = arg0.round_number + 1;
        arg0.participants = 0x2::vec_map::empty<address, u64>();
    }

    // decompiled from Move bytecode v6
}

