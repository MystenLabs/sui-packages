module 0x7856979065f08f9533805198d3ff8eee7323351913cdc2797eac566f19635542::raffle {
    struct RAFFLE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RaffleManager has key {
        id: 0x2::object::UID,
        active_raffles: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct Raffle has store, key {
        id: 0x2::object::UID,
        creator: address,
        prize_name: 0x1::string::String,
        prize_description: 0x1::string::String,
        prize_image_url: 0x1::string::String,
        ticket_price: u64,
        max_tickets: u64,
        tickets_sold: u64,
        end_time: u64,
        participants: 0x2::vec_map::VecMap<address, u64>,
        is_active: bool,
        winner: 0x1::option::Option<address>,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        owner: address,
        ticket_number: u64,
    }

    struct WinnerCertificate has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        winner: address,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        prize_name: 0x1::string::String,
        ticket_price: u64,
        max_tickets: u64,
        end_time: u64,
    }

    struct TicketPurchased has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        ticket_ids: vector<0x2::object::ID>,
        ticket_numbers: vector<u64>,
    }

    struct WinnerSelected has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
    }

    struct PrizeClaimed has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
    }

    struct PrizeData has store, key {
        id: 0x2::object::UID,
        data: vector<u8>,
    }

    struct PrizeBytes has store, key {
        id: 0x2::object::UID,
        bytes: vector<u8>,
    }

    public entry fun buy_ticket_entry(arg0: &mut Raffle, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time, 2);
        assert!(arg0.tickets_sold + arg2 <= arg0.max_tickets, 5);
        let v0 = arg0.ticket_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg4), arg0.creator);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0;
        if (0x2::vec_map::contains<address, u64>(&arg0.participants, &v1)) {
            v2 = *0x2::vec_map::get<address, u64>(&arg0.participants, &v1);
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.participants, &v1);
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.participants, v1, v2 + arg2);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        while (v7 < arg2) {
            let v8 = arg0.tickets_sold + v7;
            let v9 = Ticket{
                id            : 0x2::object::new(arg4),
                raffle_id     : 0x2::object::id<Raffle>(arg0),
                owner         : v1,
                ticket_number : v8,
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x2::object::id<Ticket>(&v9));
            0x1::vector::push_back<u64>(&mut v6, v8);
            0x2::transfer::transfer<Ticket>(v9, v1);
            v7 = v7 + 1;
        };
        arg0.tickets_sold = arg0.tickets_sold + arg2;
        let v10 = TicketPurchased{
            raffle_id      : 0x2::object::id<Raffle>(arg0),
            buyer          : v1,
            ticket_ids     : v5,
            ticket_numbers : v6,
        };
        0x2::event::emit<TicketPurchased>(v10);
    }

    public entry fun cancel_raffle(arg0: &mut RaffleManager, arg1: &mut Raffle, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 8);
        assert!(arg1.is_active, 1);
        arg1.is_active = false;
        let v0 = 0x2::object::id<Raffle>(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.active_raffles, &v0)) {
            let v1 = 0x2::object::id<Raffle>(arg1);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_raffles, &v1);
        };
        arg1.winner = 0x1::option::none<address>();
    }

    public entry fun claim_prize(arg0: &mut Raffle, arg1: WinnerCertificate, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.raffle_id == 0x2::object::id<Raffle>(arg0), 7);
        assert!(arg1.winner == 0x2::tx_context::sender(arg2), 7);
        assert!(0x1::option::is_some<address>(&arg0.winner), 10);
        let v0 = *0x1::option::borrow<address>(&arg0.winner);
        assert!(v0 == 0x2::tx_context::sender(arg2), 7);
        let PrizeData {
            id   : v1,
            data : v2,
        } = 0x2::dynamic_field::remove<vector<u8>, PrizeData>(&mut arg0.id, b"prize");
        let v3 = PrizeClaimed{
            raffle_id : 0x2::object::id<Raffle>(arg0),
            winner    : v0,
        };
        0x2::event::emit<PrizeClaimed>(v3);
        let WinnerCertificate {
            id        : v4,
            raffle_id : _,
            winner    : _,
        } = arg1;
        0x2::object::delete(v4);
        0x2::object::delete(v1);
        let v7 = PrizeBytes{
            id    : 0x2::object::new(arg2),
            bytes : v2,
        };
        0x2::transfer::transfer<PrizeBytes>(v7, v0);
    }

    public fun create_raffle(arg0: &mut RaffleManager, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Raffle{
            id                : 0x2::object::new(arg9),
            creator           : 0x2::tx_context::sender(arg9),
            prize_name        : 0x1::string::utf8(arg1),
            prize_description : 0x1::string::utf8(arg2),
            prize_image_url   : 0x1::string::utf8(arg3),
            ticket_price      : arg4,
            max_tickets       : arg5,
            tickets_sold      : 0,
            end_time          : 0x2::clock::timestamp_ms(arg8) + arg6,
            participants      : 0x2::vec_map::empty<address, u64>(),
            is_active         : true,
            winner            : 0x1::option::none<address>(),
        };
        let v1 = 0x2::object::id<Raffle>(&v0);
        let v2 = PrizeData{
            id   : 0x2::object::new(arg9),
            data : arg7,
        };
        0x2::dynamic_field::add<vector<u8>, PrizeData>(&mut v0.id, b"prize", v2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_raffles, v1);
        let v3 = RaffleCreated{
            raffle_id    : v1,
            creator      : 0x2::tx_context::sender(arg9),
            prize_name   : 0x1::string::utf8(arg1),
            ticket_price : arg4,
            max_tickets  : arg5,
            end_time     : 0x2::clock::timestamp_ms(arg8) + arg6,
        };
        0x2::event::emit<RaffleCreated>(v3);
        0x2::transfer::share_object<Raffle>(v0);
        v1
    }

    public entry fun create_raffle_entry(arg0: &mut RaffleManager, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        create_raffle(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun find_ticket_owner(arg0: &Raffle, arg1: u64) : address {
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
        abort 0
    }

    public fun get_active_raffles(arg0: &RaffleManager) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x2::vec_set::into_keys<0x2::object::ID>(arg0.active_raffles);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_raffle_info(arg0: &Raffle) : (0x2::object::ID, address, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, bool, 0x1::option::Option<address>) {
        (0x2::object::id<Raffle>(arg0), arg0.creator, arg0.prize_name, arg0.prize_description, arg0.prize_image_url, arg0.ticket_price, arg0.max_tickets, arg0.tickets_sold, arg0.end_time, arg0.is_active, arg0.winner)
    }

    public fun get_ticket_info(arg0: &Ticket) : (0x2::object::ID, 0x2::object::ID, address, u64) {
        (0x2::object::id<Ticket>(arg0), arg0.raffle_id, arg0.owner, arg0.ticket_number)
    }

    public fun has_tickets(arg0: &Raffle, arg1: address) : (bool, u64) {
        if (0x2::vec_map::contains<address, u64>(&arg0.participants, &arg1)) {
            (true, *0x2::vec_map::get<address, u64>(&arg0.participants, &arg1))
        } else {
            (false, 0)
        }
    }

    fun init(arg0: RAFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RAFFLE>(arg0, arg1);
        let v1 = 0x2::display::new<Ticket>(&v0, arg1);
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Raffle Ticket #{ticket_number}"));
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Ticket for raffle {raffle_id}"));
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://sui-raffles.io/ticket.png"));
        0x2::display::update_version<Ticket>(&mut v1);
        let v2 = 0x2::display::new<WinnerCertificate>(&v0, arg1);
        0x2::display::add<WinnerCertificate>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Raffle Winner Certificate"));
        0x2::display::add<WinnerCertificate>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Certificate for winning raffle {raffle_id}"));
        0x2::display::add<WinnerCertificate>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://sui-raffles.io/winner.png"));
        0x2::display::update_version<WinnerCertificate>(&mut v2);
        let v3 = RaffleManager{
            id             : 0x2::object::new(arg1),
            active_raffles : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WinnerCertificate>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<RaffleManager>(v3);
    }

    public entry fun select_winner(arg0: &mut Raffle, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 3);
        assert!(0x1::option::is_none<address>(&arg0.winner), 6);
        assert!(arg0.tickets_sold > 0, 9);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let v1 = 0;
        if (arg0.tickets_sold > 1) {
            v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, arg0.tickets_sold);
        };
        let v2 = find_ticket_owner(arg0, v1);
        arg0.winner = 0x1::option::some<address>(v2);
        arg0.is_active = false;
        let v3 = WinnerCertificate{
            id        : 0x2::object::new(arg3),
            raffle_id : 0x2::object::id<Raffle>(arg0),
            winner    : v2,
        };
        let v4 = WinnerSelected{
            raffle_id : 0x2::object::id<Raffle>(arg0),
            winner    : v2,
        };
        0x2::event::emit<WinnerSelected>(v4);
        0x2::transfer::transfer<WinnerCertificate>(v3, v2);
    }

    // decompiled from Move bytecode v6
}

