module 0x743d7bea632b31130be7795485abeff185249a40a63bbb4b138a57d2c6919ad0::flow_raffle {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        primary_fee_percentage: u64,
        secondary_fee_percentage: u64,
        primary_fee_address: address,
        secondary_fee_address: address,
        admin_addresses: vector<address>,
        is_initialized: bool,
    }

    struct ObjectNFTRef has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        owner_object_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        verified_owner: address,
    }

    struct FlexibleRaffle has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        ticket_price: u64,
        max_tickets: u64,
        tickets_sold: u64,
        end_time: u64,
        active: bool,
        nft_source_type: u8,
        winner_address: 0x1::option::Option<address>,
        prize_claimed: bool,
        ticket_holders: vector<address>,
    }

    struct FlexibleRaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        nft_id: 0x2::object::ID,
        source_type: u8,
        ticket_price: u64,
        max_tickets: u64,
        end_time: u64,
    }

    struct TicketPurchased has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        ticket_number: u64,
    }

    struct MultipleTicketsPurchased has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        quantity: u64,
        start_ticket_number: u64,
    }

    struct AdminAdded has copy, drop {
        new_admin: address,
        added_by: address,
    }

    struct AdminRemoved has copy, drop {
        removed_admin: address,
        removed_by: address,
    }

    struct RaffleEnded has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        nft_id: 0x2::object::ID,
    }

    public entry fun add_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_admin(arg0, v0), 4);
        assert!(!0x1::vector::contains<address>(&arg0.admin_addresses, &arg1), 26);
        0x1::vector::push_back<address>(&mut arg0.admin_addresses, arg1);
        let v1 = AdminAdded{
            new_admin : arg1,
            added_by  : v0,
        };
        0x2::event::emit<AdminAdded>(v1);
    }

    public entry fun buy_multiple_tickets(arg0: &GlobalConfig, arg1: &mut FlexibleRaffle, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(arg3 > 0 && arg3 <= 10, 24);
        validate_ticket_purchase_status(arg1, 0x2::clock::timestamp_ms(arg4));
        assert!(arg1.tickets_sold + arg3 <= arg1.max_tickets, 19);
        let v0 = arg1.ticket_price * arg3;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 16);
        let v1 = v0 * arg0.primary_fee_percentage / 10000;
        let v2 = v0 * arg0.secondary_fee_percentage / 10000;
        let v3 = v1 + v2;
        if (v3 > 0 && v3 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg5), arg0.primary_fee_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v2, arg5), arg0.secondary_fee_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v0 - v3, arg5), arg1.creator);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg5), arg1.creator);
        };
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = 0;
        while (v5 < arg3) {
            0x1::vector::push_back<address>(&mut arg1.ticket_holders, v4);
            arg1.tickets_sold = arg1.tickets_sold + 1;
            let v6 = TicketPurchased{
                raffle_id     : 0x2::object::id<FlexibleRaffle>(arg1),
                buyer         : v4,
                ticket_number : arg1.tickets_sold,
            };
            0x2::event::emit<TicketPurchased>(v6);
            v5 = v5 + 1;
        };
        let v7 = MultipleTicketsPurchased{
            raffle_id           : 0x2::object::id<FlexibleRaffle>(arg1),
            buyer               : v4,
            quantity            : arg3,
            start_ticket_number : arg1.tickets_sold + 1,
        };
        0x2::event::emit<MultipleTicketsPurchased>(v7);
    }

    public entry fun buy_ticket(arg0: &GlobalConfig, arg1: &mut FlexibleRaffle, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        validate_ticket_purchase_status(arg1, 0x2::clock::timestamp_ms(arg3));
        let v0 = arg1.ticket_price;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 16);
        let v1 = v0 * arg0.primary_fee_percentage / 10000;
        let v2 = v0 * arg0.secondary_fee_percentage / 10000;
        let v3 = v1 + v2;
        if (v3 > 0 && v3 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg4), arg0.primary_fee_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v2, arg4), arg0.secondary_fee_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v0 - v3, arg4), arg1.creator);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg4), arg1.creator);
        };
        let v4 = 0x2::tx_context::sender(arg4);
        0x1::vector::push_back<address>(&mut arg1.ticket_holders, v4);
        arg1.tickets_sold = arg1.tickets_sold + 1;
        let v5 = TicketPurchased{
            raffle_id     : 0x2::object::id<FlexibleRaffle>(arg1),
            buyer         : v4,
            ticket_number : arg1.tickets_sold,
        };
        0x2::event::emit<TicketPurchased>(v5);
    }

    public fun check_admin_status(arg0: &GlobalConfig, arg1: address) : bool {
        is_admin(arg0, arg1)
    }

    public entry fun claim_prize_direct<T0: store + key>(arg0: &mut FlexibleRaffle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!arg0.active, 15);
        assert!(0x1::option::is_some<address>(&arg0.winner_address), 20);
        assert!(*0x1::option::borrow<address>(&arg0.winner_address) == v0, 4);
        assert!(!arg0.prize_claimed, 17);
        assert!(arg0.nft_source_type == 0, 23);
        arg0.prize_claimed = true;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, b"nft"), v0);
    }

    public entry fun claim_prize_kiosk<T0: store + key>(arg0: &mut FlexibleRaffle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!arg0.active, 15);
        assert!(0x1::option::is_some<address>(&arg0.winner_address), 20);
        assert!(*0x1::option::borrow<address>(&arg0.winner_address) == v0, 4);
        assert!(!arg0.prize_claimed, 17);
        assert!(arg0.nft_source_type == 1, 23);
        arg0.prize_claimed = true;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, b"nft"), v0);
    }

    public entry fun create_raffle_direct<T0: store + key>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        validate_raffle_inputs(arg3, arg4, arg5);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6) + arg5 * 3600000;
        let v2 = FlexibleRaffle{
            id              : 0x2::object::new(arg7),
            name            : 0x1::string::utf8(arg1),
            description     : 0x1::string::utf8(arg2),
            creator         : v0,
            ticket_price    : arg3,
            max_tickets     : arg4,
            tickets_sold    : 0,
            end_time        : v1,
            active          : true,
            nft_source_type : 0,
            winner_address  : 0x1::option::none<address>(),
            prize_claimed   : false,
            ticket_holders  : 0x1::vector::empty<address>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v2.id, b"nft", arg0);
        let v3 = FlexibleRaffleCreated{
            raffle_id    : 0x2::object::id<FlexibleRaffle>(&v2),
            creator      : v0,
            nft_id       : 0x2::object::id<T0>(&arg0),
            source_type  : 0,
            ticket_price : arg3,
            max_tickets  : arg4,
            end_time     : v1,
        };
        0x2::event::emit<FlexibleRaffleCreated>(v3);
        0x2::transfer::share_object<FlexibleRaffle>(v2);
    }

    public entry fun create_raffle_with_object_nft<T0: store + key>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        validate_raffle_inputs(arg3, arg4, arg5);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6) + arg5 * 3600000;
        let v2 = FlexibleRaffle{
            id              : 0x2::object::new(arg7),
            name            : 0x1::string::utf8(arg1),
            description     : 0x1::string::utf8(arg2),
            creator         : v0,
            ticket_price    : arg3,
            max_tickets     : arg4,
            tickets_sold    : 0,
            end_time        : v1,
            active          : true,
            nft_source_type : 1,
            winner_address  : 0x1::option::none<address>(),
            prize_claimed   : false,
            ticket_holders  : 0x1::vector::empty<address>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v2.id, b"nft", arg0);
        let v3 = FlexibleRaffleCreated{
            raffle_id    : 0x2::object::id<FlexibleRaffle>(&v2),
            creator      : v0,
            nft_id       : 0x2::object::id<T0>(&arg0),
            source_type  : 1,
            ticket_price : arg3,
            max_tickets  : arg4,
            end_time     : v1,
        };
        0x2::event::emit<FlexibleRaffleCreated>(v3);
        0x2::transfer::share_object<FlexibleRaffle>(v2);
    }

    public entry fun draw_winner(arg0: &GlobalConfig, arg1: &mut FlexibleRaffle, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg4)), 4);
        assert!(arg1.active, 2);
        assert!(arg1.tickets_sold > 0, 3);
        assert!(0x1::option::is_none<address>(&arg1.winner_address), 20);
        let v0 = *0x1::vector::borrow<address>(&arg1.ticket_holders, generate_random_winner(arg2, arg1.tickets_sold, 0x2::clock::timestamp_ms(arg3)));
        arg1.winner_address = 0x1::option::some<address>(v0);
        arg1.active = false;
        let v1 = if (arg1.nft_source_type == 0) {
            0x2::object::id_from_address(@0x0)
        } else if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg1.id, b"object_ref")) {
            0x2::dynamic_object_field::borrow<vector<u8>, ObjectNFTRef>(&arg1.id, b"object_ref").nft_id
        } else {
            0x2::object::id_from_address(@0x0)
        };
        let v2 = RaffleEnded{
            raffle_id : 0x2::object::id<FlexibleRaffle>(arg1),
            winner    : v0,
            nft_id    : v1,
        };
        0x2::event::emit<RaffleEnded>(v2);
    }

    fun generate_random_winner(arg0: vector<u8>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 == 0) {
            return arg2 % arg1
        };
        let v1 = arg2;
        let v2 = 0;
        while (v2 < v0 && v2 < 8) {
            v1 = v1 + (*0x1::vector::borrow<u8>(&arg0, v2) as u64) * (v2 + 1);
            v2 = v2 + 1;
        };
        v1 % arg1
    }

    public fun get_admin_addresses(arg0: &GlobalConfig) : vector<address> {
        arg0.admin_addresses
    }

    public fun get_raffle_info(arg0: &FlexibleRaffle) : (0x1::string::String, 0x1::string::String, address, u64, u64, u64, u64, bool, u8) {
        (arg0.name, arg0.description, arg0.creator, arg0.ticket_price, arg0.max_tickets, arg0.tickets_sold, arg0.end_time, arg0.active, arg0.nft_source_type)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                       : 0x2::object::new(arg0),
            primary_fee_percentage   : 1000,
            secondary_fee_percentage : 500,
            primary_fee_address      : @0xfff953ec5eac874d97ef8b771f9b2bda6eeaf633197784838b45c66ad8cbabe,
            secondary_fee_address    : @0xdca02992b463ad2489375efcb376fbdbe4e555efa9d96f1995eff0d41928c275,
            admin_addresses          : v0,
            is_initialized           : true,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    fun is_admin(arg0: &GlobalConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admin_addresses, &arg1)
    }

    public entry fun remove_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_admin(arg0, v0), 4);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &arg1), 4);
        assert!(0x1::vector::length<address>(&arg0.admin_addresses) > 1, 25);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.admin_addresses, &arg1);
        assert!(v1, 4);
        0x1::vector::remove<address>(&mut arg0.admin_addresses, v2);
        let v3 = AdminRemoved{
            removed_admin : arg1,
            removed_by    : v0,
        };
        0x2::event::emit<AdminRemoved>(v3);
    }

    fun validate_raffle_inputs(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0, 9);
        assert!(arg0 <= 1000000000000, 9);
        assert!(arg1 > 0, 10);
        assert!(arg2 > 0 && arg2 <= 720, 11);
    }

    fun validate_ticket_purchase_status(arg0: &FlexibleRaffle, arg1: u64) {
        assert!(arg0.active, 2);
        assert!(arg1 < arg0.end_time, 6);
        assert!(arg0.tickets_sold < arg0.max_tickets, 19);
        assert!(0x1::option::is_none<address>(&arg0.winner_address), 20);
    }

    // decompiled from Move bytecode v6
}

