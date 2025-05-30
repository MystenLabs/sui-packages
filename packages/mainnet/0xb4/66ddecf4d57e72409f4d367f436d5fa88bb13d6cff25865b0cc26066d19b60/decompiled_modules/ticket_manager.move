module 0xb466ddecf4d57e72409f4d367f436d5fa88bb13d6cff25865b0cc26066d19b60::ticket_manager {
    struct TICKET_MANAGER has drop {
        dummy_field: bool,
    }

    struct TicketBatch has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        owner: address,
        start_number: u64,
        quantity: u64,
        purchase_time: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        owner: address,
        ticket_number: u64,
        purchase_time: u64,
    }

    struct TicketManager has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        creator: address,
        ticket_price: u64,
        max_tickets: u64,
        tickets_sold: u64,
        total_value: u64,
        is_active: bool,
        participants: 0x2::vec_map::VecMap<address, u64>,
        proceeds: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
    }

    struct TicketsPurchased has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        quantity: u64,
        start_number: u64,
        amount_paid: u64,
        purchase_time: u64,
    }

    struct TicketBatchCreated has copy, drop {
        batch_id: 0x2::object::ID,
        raffle_id: 0x2::object::ID,
        owner: address,
        start_number: u64,
        quantity: u64,
    }

    struct IndividualTicketCreated has copy, drop {
        ticket_id: 0x2::object::ID,
        raffle_id: 0x2::object::ID,
        owner: address,
        ticket_number: u64,
    }

    public fun buy_individual_tickets(arg0: &mut TicketManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_tickets(arg0, arg1, arg2, arg3, arg4);
        let v1 = v0.owner;
        let v2 = v0.raffle_id;
        let v3 = 0;
        while (v3 < v0.quantity) {
            let v4 = v0.start_number + v3;
            let v5 = Ticket{
                id            : 0x2::object::new(arg4),
                raffle_id     : v2,
                owner         : v1,
                ticket_number : v4,
                purchase_time : arg3,
            };
            let v6 = IndividualTicketCreated{
                ticket_id     : 0x2::object::id<Ticket>(&v5),
                raffle_id     : v2,
                owner         : v1,
                ticket_number : v4,
            };
            0x2::event::emit<IndividualTicketCreated>(v6);
            0x2::transfer::public_transfer<Ticket>(v5, v1);
            v3 = v3 + 1;
        };
        let TicketBatch {
            id            : v7,
            raffle_id     : _,
            owner         : _,
            start_number  : _,
            quantity      : _,
            purchase_time : _,
        } = v0;
        0x2::object::delete(v7);
    }

    public fun buy_tickets(arg0: &mut TicketManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : TicketBatch {
        assert!(arg0.is_active, 4);
        assert!(arg0.tickets_sold + arg2 <= arg0.max_tickets, 2);
        assert!(arg2 > 0, 8);
        let v0 = arg0.ticket_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 1);
        if (0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.proceeds)) {
            0x1::option::fill<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.proceeds, 0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg4));
        } else {
            0x2::coin::join<0x2::sui::SUI>(0x1::option::borrow_mut<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.proceeds), 0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg4));
        };
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = arg0.tickets_sold;
        let v3 = 0;
        if (0x2::vec_map::contains<address, u64>(&arg0.participants, &v1)) {
            v3 = *0x2::vec_map::get<address, u64>(&arg0.participants, &v1);
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.participants, &v1);
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.participants, v1, v3 + arg2);
        arg0.tickets_sold = arg0.tickets_sold + arg2;
        arg0.total_value = arg0.total_value + v0;
        let v6 = TicketBatch{
            id            : 0x2::object::new(arg4),
            raffle_id     : arg0.raffle_id,
            owner         : v1,
            start_number  : v2,
            quantity      : arg2,
            purchase_time : arg3,
        };
        let v7 = TicketsPurchased{
            raffle_id     : arg0.raffle_id,
            buyer         : v1,
            quantity      : arg2,
            start_number  : v2,
            amount_paid   : v0,
            purchase_time : arg3,
        };
        0x2::event::emit<TicketsPurchased>(v7);
        let v8 = TicketBatchCreated{
            batch_id     : 0x2::object::id<TicketBatch>(&v6),
            raffle_id    : arg0.raffle_id,
            owner        : v1,
            start_number : v2,
            quantity     : arg2,
        };
        0x2::event::emit<TicketBatchCreated>(v8);
        v6
    }

    public fun create_ticket_manager(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : TicketManager {
        assert!(arg1 > 0, 3);
        TicketManager{
            id           : 0x2::object::new(arg3),
            raffle_id    : arg0,
            creator      : 0x2::tx_context::sender(arg3),
            ticket_price : arg1,
            max_tickets  : arg2,
            tickets_sold : 0,
            total_value  : 0,
            is_active    : true,
            participants : 0x2::vec_map::empty<address, u64>(),
            proceeds     : 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>(),
        }
    }

    public fun deactivate(arg0: &mut TicketManager, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 6);
        arg0.is_active = false;
    }

    public fun extract_proceeds(arg0: &mut TicketManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 6);
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.proceeds), 0);
        0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.proceeds)
    }

    public fun find_ticket_owner(arg0: &TicketManager, arg1: u64) : address {
        assert!(arg1 < arg0.tickets_sold, 7);
        let v0 = &arg0.participants;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::vec_map::size<address, u64>(v0)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<address, u64>(v0, v2);
            if (arg1 < v1 + *v4) {
                return *v3
            };
            v1 = v1 + *v4;
            v2 = v2 + 1;
        };
        abort 7
    }

    public fun get_all_participants(arg0: &TicketManager) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<address, u64>(&arg0.participants)) {
            let (v2, _) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.participants, v1);
            0x1::vector::push_back<address>(&mut v0, *v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_batch_info(arg0: &TicketBatch) : (0x2::object::ID, 0x2::object::ID, address, u64, u64, u64) {
        (0x2::object::id<TicketBatch>(arg0), arg0.raffle_id, arg0.owner, arg0.start_number, arg0.quantity, arg0.purchase_time)
    }

    public fun get_manager_info(arg0: &TicketManager) : (0x2::object::ID, 0x2::object::ID, address, u64, u64, u64, u64, bool) {
        (0x2::object::id<TicketManager>(arg0), arg0.raffle_id, arg0.creator, arg0.ticket_price, arg0.max_tickets, arg0.tickets_sold, arg0.total_value, arg0.is_active)
    }

    public fun get_ticket_info(arg0: &Ticket) : (0x2::object::ID, 0x2::object::ID, address, u64, u64) {
        (0x2::object::id<Ticket>(arg0), arg0.raffle_id, arg0.owner, arg0.ticket_number, arg0.purchase_time)
    }

    public fun has_tickets(arg0: &TicketManager, arg1: address) : (bool, u64) {
        if (0x2::vec_map::contains<address, u64>(&arg0.participants, &arg1)) {
            (true, *0x2::vec_map::get<address, u64>(&arg0.participants, &arg1))
        } else {
            (false, 0)
        }
    }

    fun init(arg0: TICKET_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TICKET_MANAGER>(arg0, arg1);
        let v1 = 0x2::display::new<TicketBatch>(&v0, arg1);
        0x2::display::add<TicketBatch>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Raffle Ticket Batch"));
        0x2::display::add<TicketBatch>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Batch of {quantity} tickets for raffle {raffle_id}"));
        0x2::display::add<TicketBatch>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://sui-raffles.io/ticket-batch-image/{raffle_id}"));
        0x2::display::update_version<TicketBatch>(&mut v1);
        let v2 = 0x2::display::new<Ticket>(&v0, arg1);
        0x2::display::add<Ticket>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Raffle Ticket #{ticket_number}"));
        0x2::display::add<Ticket>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Ticket for raffle {raffle_id}"));
        0x2::display::add<Ticket>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://sui-raffles.io/ticket-image/{raffle_id}/{ticket_number}"));
        0x2::display::update_version<Ticket>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TicketBatch>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun process_refunds(arg0: &mut TicketManager, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 6);
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.proceeds), 0);
        let v0 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.proceeds);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = arg0.participants;
        let v3 = 0;
        while (v3 < 0x2::vec_map::size<address, u64>(&v2) && v1 > 0) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<address, u64>(&v2, v3);
            let v6 = *v5 * arg0.ticket_price;
            if (0x2::vec_map::contains<address, u64>(&arg0.participants, v4) && v6 <= v1) {
                let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.participants, v4);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v6, arg1), *v4);
                v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
            };
            v3 = v3 + 1;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.creator);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        arg0.is_active = false;
    }

    public fun split_proceeds(arg0: &mut TicketManager, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 6);
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.proceeds), 0);
        let v0 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.proceeds);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0) * arg1 / 10000;
        let v2 = if (v1 > 0) {
            0x2::coin::split<0x2::sui::SUI>(&mut v0, v1, arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        (v2, v0)
    }

    // decompiled from Move bytecode v6
}

