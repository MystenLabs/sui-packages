module 0x4d34554f47a02ac7966036cb26e7f0f4914538585e29fa9cfb41258ef597281a::flow_raffle {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_percentage: u64,
        fee_address: address,
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
        nft_type: 0x1::string::String,
        nft_id: 0x1::string::String,
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
        nft_held_id: 0x1::string::String,
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
        nft_id: 0x1::string::String,
    }

    public entry fun buy_ticket(arg0: &mut Raffle, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time, 6);
        assert!(arg0.tickets_sold < arg0.max_tickets, 5);
        let v0 = arg0.ticket_price;
        let v1 = 0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg4);
        let v2 = v0 * arg2.fee_percentage / 10000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v2, arg4), arg2.fee_address);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg0.creator);
        let v3 = arg0.tickets_sold + 1;
        let v4 = Ticket{
            id            : 0x2::object::new(arg4),
            raffle_id     : 0x2::object::id<Raffle>(arg0),
            owner         : 0x2::tx_context::sender(arg4),
            ticket_number : v3,
        };
        arg0.tickets_sold = v3;
        let v5 = TicketPurchased{
            raffle_id     : 0x2::object::id<Raffle>(arg0),
            ticket_id     : 0x2::object::id<Ticket>(&v4),
            buyer         : 0x2::tx_context::sender(arg4),
            ticket_number : v3,
        };
        0x2::event::emit<TicketPurchased>(v5);
        0x2::transfer::transfer<Ticket>(v4, 0x2::tx_context::sender(arg4));
    }

    public entry fun create_raffle<T0: copy + drop + store + key>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 10000000, 9);
        assert!(arg4 > 0, 10);
        assert!(arg5 > 0, 11);
        let v0 = 0x2::clock::timestamp_ms(arg6) + arg5 * 3600 * 1000;
        let v1 = 0x2::object::id<T0>(&arg0);
        0x2::object::id_to_bytes(&v1);
        let v2 = 0x1::string::utf8(b"0x");
        let v3 = Raffle{
            id           : 0x2::object::new(arg8),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            creator      : 0x2::tx_context::sender(arg8),
            ticket_price : arg3,
            max_tickets  : arg4,
            tickets_sold : 0,
            end_time     : v0,
            active       : true,
            nft_type     : 0x1::string::utf8(b"Generic NFT"),
            nft_id       : v2,
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v3.id, b"nft", arg0);
        let v4 = RaffleCreated{
            raffle_id    : 0x2::object::id<Raffle>(&v3),
            creator      : 0x2::tx_context::sender(arg8),
            nft_held_id  : v2,
            ticket_price : arg3,
            max_tickets  : arg4,
            end_time     : v0,
        };
        0x2::event::emit<RaffleCreated>(v4);
        0x2::transfer::share_object<Raffle>(v3);
    }

    public entry fun draw_winner<T0: copy + drop + store + key>(arg0: &mut Raffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
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
            nft_id         : arg0.nft_id,
        };
        0x2::event::emit<RaffleEnded>(v2);
    }

    public entry fun end_raffle<T0: copy + drop + store + key>(arg0: &mut Raffle, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 4);
        assert!(arg0.active, 2);
        assert!(arg0.tickets_sold > 0, 3);
        arg0.active = false;
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"nft")) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, b"nft"), arg1);
        };
        let v0 = RaffleEnded{
            raffle_id      : 0x2::object::id<Raffle>(arg0),
            winner         : arg1,
            winning_ticket : 0x2::object::uid_to_inner(&arg0.id),
            nft_id         : arg0.nft_id,
        };
        0x2::event::emit<RaffleEnded>(v0);
    }

    fun generate_random_number(arg0: vector<u8>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = if (0x1::vector::length<u8>(&arg0) > 0) {
            *0x1::vector::borrow<u8>(&arg0, 0)
        } else {
            123
        };
        (v0 as u64) % arg1
    }

    public fun get_raffle_info(arg0: &Raffle) : (0x1::string::String, 0x1::string::String, address, u64, u64, u64, u64, bool, 0x1::string::String) {
        (arg0.name, arg0.description, arg0.creator, arg0.ticket_price, arg0.max_tickets, arg0.tickets_sold, arg0.end_time, arg0.active, arg0.nft_id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Config{
            id             : 0x2::object::new(arg0),
            fee_percentage : 500,
            fee_address    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public entry fun update_fee_address(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee_address = arg2;
    }

    public entry fun update_fee_percentage(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 3000, 1);
        arg1.fee_percentage = arg2;
    }

    // decompiled from Move bytecode v6
}

