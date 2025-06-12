module 0xda69d4edfe724f6b2562467b230779a60e3762a99fd141c891832d7986d3058d::flow_raffle {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        primary_fee_percentage: u64,
        secondary_fee_percentage: u64,
        primary_fee_address: address,
        secondary_fee_address: address,
        admin_addresses: vector<address>,
        whitelisted_nft_types: vector<0x1::string::String>,
        is_initialized: bool,
    }

    struct HybridRaffle has store, key {
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
        kiosk_id: 0x1::option::Option<0x2::object::ID>,
        nft_id: 0x2::object::ID,
        nft_metadata: 0x1::option::Option<0x1::string::String>,
        winner_address: 0x1::option::Option<address>,
        prize_claimed: bool,
        ticket_holders: vector<address>,
    }

    struct HybridRaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        kiosk_id: 0x1::option::Option<0x2::object::ID>,
        nft_id: 0x2::object::ID,
        source_type: u8,
        ticket_price: u64,
        max_tickets: u64,
        end_time: u64,
        nft_metadata: 0x1::option::Option<0x1::string::String>,
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

    struct RaffleEnded has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        nft_id: 0x2::object::ID,
        random_seed: vector<u8>,
        winner_index: u64,
    }

    struct PrizeClaimed has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        nft_id: 0x2::object::ID,
    }

    struct AdminAdded has copy, drop {
        admin_address: address,
        added_by: address,
    }

    struct AdminRemoved has copy, drop {
        admin_address: address,
        removed_by: address,
    }

    struct FeesUpdated has copy, drop {
        primary_fee_percentage: u64,
        secondary_fee_percentage: u64,
        updated_by: address,
    }

    struct FeeAddressesUpdated has copy, drop {
        primary_fee_address: address,
        secondary_fee_address: address,
        updated_by: address,
    }

    public entry fun add_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
        if (!0x1::vector::contains<address>(&arg0.admin_addresses, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admin_addresses, arg1);
            let v1 = AdminAdded{
                admin_address : arg1,
                added_by      : v0,
            };
            0x2::event::emit<AdminAdded>(v1);
        };
    }

    public entry fun add_nft_type(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
        if (!0x1::vector::contains<0x1::string::String>(&arg0.whitelisted_nft_types, &arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut arg0.whitelisted_nft_types, arg1);
        };
    }

    fun add_tickets_to_raffle(arg0: &mut HybridRaffle, arg1: address, arg2: u64) {
        if (arg2 > 0) {
            0x1::vector::push_back<address>(&mut arg0.ticket_holders, arg1);
            arg0.tickets_sold = arg0.tickets_sold + 1;
            add_tickets_to_raffle(arg0, arg1, arg2 - 1);
        };
    }

    public entry fun buy_multiple_tickets(arg0: &GlobalConfig, arg1: &mut HybridRaffle, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(arg1.active, 2);
        assert!(arg3 > 0, 24);
        assert!(arg3 <= 20, 24);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.end_time, 6);
        assert!(arg1.tickets_sold + arg3 <= arg1.max_tickets, 19);
        let v0 = arg1.ticket_price * arg3;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 16);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg5);
        let v2 = v0 * arg0.primary_fee_percentage / 100;
        let v3 = v0 * arg0.secondary_fee_percentage / 100;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v2, arg5), arg0.primary_fee_address);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg5), arg0.secondary_fee_address);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg1.creator);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = arg1.tickets_sold + 1;
        add_tickets_to_raffle(arg1, v4, arg3);
        let v6 = MultipleTicketsPurchased{
            raffle_id           : 0x2::object::id<HybridRaffle>(arg1),
            buyer               : v4,
            quantity            : arg3,
            start_ticket_number : v5,
        };
        0x2::event::emit<MultipleTicketsPurchased>(v6);
    }

    public entry fun buy_ticket(arg0: &GlobalConfig, arg1: &mut HybridRaffle, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(arg1.active, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.end_time, 6);
        assert!(arg1.tickets_sold < arg1.max_tickets, 19);
        let v0 = arg1.ticket_price;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 16);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg4);
        let v2 = v0 * arg0.primary_fee_percentage / 100;
        let v3 = v0 * arg0.secondary_fee_percentage / 100;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v2, arg4), arg0.primary_fee_address);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg4), arg0.secondary_fee_address);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg1.creator);
        let v4 = 0x2::tx_context::sender(arg4);
        0x1::vector::push_back<address>(&mut arg1.ticket_holders, v4);
        arg1.tickets_sold = arg1.tickets_sold + 1;
        let v5 = TicketPurchased{
            raffle_id     : 0x2::object::id<HybridRaffle>(arg1),
            buyer         : v4,
            ticket_number : arg1.tickets_sold,
        };
        0x2::event::emit<TicketPurchased>(v5);
    }

    fun calculate_hash_value(arg0: &vector<u8>, arg1: u64, arg2: u64) : u64 {
        if (arg1 >= 0x1::vector::length<u8>(arg0) || arg1 >= 8) {
            return arg2
        };
        let v0 = arg1 * 8;
        if (v0 >= 64) {
            return arg2
        };
        calculate_hash_value(arg0, arg1 + 1, arg2 + ((*0x1::vector::borrow<u8>(arg0, arg1) as u64) << (v0 as u8)))
    }

    public entry fun claim_prize<T0: store + key>(arg0: &mut HybridRaffle, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.active, 15);
        assert!(!arg0.prize_claimed, 17);
        assert!(0x1::option::is_some<address>(&arg0.winner_address), 20);
        let v0 = *0x1::option::borrow<address>(&arg0.winner_address);
        assert!(0x2::tx_context::sender(arg1) == v0, 4);
        arg0.prize_claimed = true;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, b"nft"), v0);
        let v1 = PrizeClaimed{
            raffle_id : 0x2::object::id<HybridRaffle>(arg0),
            winner    : v0,
            nft_id    : arg0.nft_id,
        };
        0x2::event::emit<PrizeClaimed>(v1);
    }

    public entry fun create_raffle<T0: store + key>(arg0: &GlobalConfig, arg1: T0, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_raffle_direct<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun create_raffle_direct<T0: store + key>(arg0: &GlobalConfig, arg1: T0, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(arg4 > 0, 9);
        assert!(arg5 > 0, 10);
        assert!(arg6 > 0, 11);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg7) + arg6;
        let v3 = HybridRaffle{
            id              : 0x2::object::new(arg8),
            name            : arg2,
            description     : arg3,
            creator         : v0,
            ticket_price    : arg4,
            max_tickets     : arg5,
            tickets_sold    : 0,
            end_time        : v2,
            active          : true,
            nft_source_type : 1,
            kiosk_id        : 0x1::option::none<0x2::object::ID>(),
            nft_id          : v1,
            nft_metadata    : 0x1::option::none<0x1::string::String>(),
            winner_address  : 0x1::option::none<address>(),
            prize_claimed   : false,
            ticket_holders  : 0x1::vector::empty<address>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v3.id, b"nft", arg1);
        let v4 = HybridRaffleCreated{
            raffle_id    : 0x2::object::id<HybridRaffle>(&v3),
            creator      : v0,
            kiosk_id     : 0x1::option::none<0x2::object::ID>(),
            nft_id       : v1,
            source_type  : 1,
            ticket_price : arg4,
            max_tickets  : arg5,
            end_time     : v2,
            nft_metadata : 0x1::option::none<0x1::string::String>(),
        };
        0x2::event::emit<HybridRaffleCreated>(v4);
        0x2::transfer::share_object<HybridRaffle>(v3);
    }

    public entry fun create_raffle_kiosk<T0: store + key>(arg0: &GlobalConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(arg7 > 0, 9);
        assert!(arg8 > 0, 10);
        assert!(arg9 > 0, 11);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::clock::timestamp_ms(arg10) + arg9;
        let (v2, v3) = 0x2::kiosk::purchase<T0>(arg1, arg4, 0x2::coin::zero<0x2::sui::SUI>(arg11));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v3);
        let v7 = HybridRaffle{
            id              : 0x2::object::new(arg11),
            name            : arg5,
            description     : arg6,
            creator         : v0,
            ticket_price    : arg7,
            max_tickets     : arg8,
            tickets_sold    : 0,
            end_time        : v1,
            active          : true,
            nft_source_type : 0,
            kiosk_id        : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg1)),
            nft_id          : arg4,
            nft_metadata    : 0x1::option::none<0x1::string::String>(),
            winner_address  : 0x1::option::none<address>(),
            prize_claimed   : false,
            ticket_holders  : 0x1::vector::empty<address>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v7.id, b"nft", v2);
        let v8 = HybridRaffleCreated{
            raffle_id    : 0x2::object::id<HybridRaffle>(&v7),
            creator      : v0,
            kiosk_id     : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg1)),
            nft_id       : arg4,
            source_type  : 0,
            ticket_price : arg7,
            max_tickets  : arg8,
            end_time     : v1,
            nft_metadata : 0x1::option::none<0x1::string::String>(),
        };
        0x2::event::emit<HybridRaffleCreated>(v8);
        0x2::transfer::share_object<HybridRaffle>(v7);
    }

    public entry fun end_raffle(arg0: &mut HybridRaffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(arg0.tickets_sold > 0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.end_time || arg0.tickets_sold >= arg0.max_tickets, 15);
        let v1 = generate_randomness(arg0, v0, arg2);
        let v2 = generate_winner_index(&v1, arg0.tickets_sold);
        let v3 = *0x1::vector::borrow<address>(&arg0.ticket_holders, v2);
        arg0.active = false;
        arg0.winner_address = 0x1::option::some<address>(v3);
        let v4 = RaffleEnded{
            raffle_id    : 0x2::object::id<HybridRaffle>(arg0),
            winner       : v3,
            nft_id       : arg0.nft_id,
            random_seed  : v1,
            winner_index : v2,
        };
        0x2::event::emit<RaffleEnded>(v4);
    }

    fun generate_randomness(arg0: &HybridRaffle, arg1: u64, arg2: &0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::object::id<HybridRaffle>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, *0x2::tx_context::digest(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.tickets_sold));
        v0
    }

    fun generate_winner_index(arg0: &vector<u8>, arg1: u64) : u64 {
        if (0x1::vector::length<u8>(arg0) == 0 || arg1 == 0) {
            return 0
        };
        calculate_hash_value(arg0, 0, 0) % arg1
    }

    public fun get_config_info(arg0: &GlobalConfig) : (u64, u64, address, address, vector<address>, vector<0x1::string::String>, bool) {
        (arg0.primary_fee_percentage, arg0.secondary_fee_percentage, arg0.primary_fee_address, arg0.secondary_fee_address, arg0.admin_addresses, arg0.whitelisted_nft_types, arg0.is_initialized)
    }

    public fun get_raffle_info(arg0: &HybridRaffle) : (0x1::string::String, 0x1::string::String, address, u64, u64, u64, u64, bool, u8, 0x1::option::Option<0x2::object::ID>, 0x2::object::ID, 0x1::option::Option<address>, bool) {
        (arg0.name, arg0.description, arg0.creator, arg0.ticket_price, arg0.max_tickets, arg0.tickets_sold, arg0.end_time, arg0.active, arg0.nft_source_type, arg0.kiosk_id, arg0.nft_id, arg0.winner_address, arg0.prize_claimed)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                       : 0x2::object::new(arg0),
            primary_fee_percentage   : 10,
            secondary_fee_percentage : 5,
            primary_fee_address      : 0x2::tx_context::sender(arg0),
            secondary_fee_address    : 0x2::tx_context::sender(arg0),
            admin_addresses          : v0,
            whitelisted_nft_types    : 0x1::vector::empty<0x1::string::String>(),
            is_initialized           : true,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public entry fun remove_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
        assert!(0x1::vector::length<address>(&arg0.admin_addresses) > 1, 4);
        assert!(v0 != arg1, 4);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.admin_addresses, &arg1);
        if (v1) {
            0x1::vector::remove<address>(&mut arg0.admin_addresses, v2);
            let v3 = AdminRemoved{
                admin_address : arg1,
                removed_by    : v0,
            };
            0x2::event::emit<AdminRemoved>(v3);
        };
    }

    public entry fun remove_nft_type(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
        let (v1, v2) = 0x1::vector::index_of<0x1::string::String>(&arg0.whitelisted_nft_types, &arg1);
        if (v1) {
            0x1::vector::remove<0x1::string::String>(&mut arg0.whitelisted_nft_types, v2);
        };
    }

    public entry fun toggle_raffle_status(arg0: &GlobalConfig, arg1: &mut HybridRaffle, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
        arg1.active = !arg1.active;
    }

    public entry fun update_fee_addresses(arg0: &mut GlobalConfig, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
        arg0.primary_fee_address = arg1;
        arg0.secondary_fee_address = arg2;
        let v1 = FeeAddressesUpdated{
            primary_fee_address   : arg1,
            secondary_fee_address : arg2,
            updated_by            : v0,
        };
        0x2::event::emit<FeeAddressesUpdated>(v1);
    }

    public entry fun update_fees(arg0: &mut GlobalConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
        assert!(arg1 + arg2 <= 30, 9);
        arg0.primary_fee_percentage = arg1;
        arg0.secondary_fee_percentage = arg2;
        let v1 = FeesUpdated{
            primary_fee_percentage   : arg1,
            secondary_fee_percentage : arg2,
            updated_by               : v0,
        };
        0x2::event::emit<FeesUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

