module 0x3bb02ae1a046336fb0fe5d285969dfe6a50b68b45398c29a96e95e2688d4e0ad::flow_raffle {
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
        nft_source_id: 0x2::object::ID,
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

    struct EscrowWithPurchaseCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        buyer: address,
        purchase_cap: 0x2::object::ID,
    }

    struct ClaimWithPurchaseCapEvent has copy, drop {
        nft_id: 0x2::object::ID,
        buyer: address,
        buyer_kiosk_id: 0x2::object::ID,
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

    public entry fun buy_multiple_tickets(arg0: &mut HybridRaffle, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(arg1 > 0, 24);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time, 6);
        assert!(arg0.tickets_sold + arg1 <= arg0.max_tickets, 19);
        let v0 = arg0.ticket_price * arg1;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 16);
        let v1 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg4), arg0.creator);
        let v2 = 0;
        while (v2 < arg1) {
            0x1::vector::push_back<address>(&mut arg0.ticket_holders, v1);
            v2 = v2 + 1;
        };
        arg0.tickets_sold = arg0.tickets_sold + arg1;
        let v3 = MultipleTicketsPurchased{
            raffle_id           : 0x2::object::id<HybridRaffle>(arg0),
            buyer               : v1,
            quantity            : arg1,
            start_ticket_number : arg0.tickets_sold + 1,
        };
        0x2::event::emit<MultipleTicketsPurchased>(v3);
        if (arg0.tickets_sold == arg0.max_tickets) {
            arg0.active = false;
        };
    }

    public entry fun buy_ticket(arg0: &mut HybridRaffle, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time, 6);
        assert!(arg0.tickets_sold < arg0.max_tickets, 19);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.ticket_price, 16);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.ticket_price, arg3), arg0.creator);
        0x1::vector::push_back<address>(&mut arg0.ticket_holders, v0);
        arg0.tickets_sold = arg0.tickets_sold + 1;
        let v1 = TicketPurchased{
            raffle_id     : 0x2::object::id<HybridRaffle>(arg0),
            buyer         : v0,
            ticket_number : arg0.tickets_sold,
        };
        0x2::event::emit<TicketPurchased>(v1);
        if (arg0.tickets_sold == arg0.max_tickets) {
            arg0.active = false;
        };
    }

    public entry fun claim_prize_direct<T0: store + key>(arg0: &mut HybridRaffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.active, 2);
        assert!(arg0.nft_source_type == 1, 4);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 15);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::option::contains<address>(&arg0.winner_address, &v0), 4);
        assert!(!arg0.prize_claimed, 17);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, b"nft"), v0);
        arg0.prize_claimed = true;
        let v1 = PrizeClaimed{
            raffle_id : 0x2::object::id<HybridRaffle>(arg0),
            winner    : v0,
            nft_id    : arg0.nft_id,
        };
        0x2::event::emit<PrizeClaimed>(v1);
    }

    public entry fun claim_prize_kiosk_borrow<T0: store + key>(arg0: &mut HybridRaffle, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.active, 2);
        assert!(arg0.nft_source_type == 14, 4);
        assert!(0x2::clock::timestamp_ms(arg6) >= arg0.end_time, 15);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x1::option::contains<address>(&arg0.winner_address, &v0), 4);
        assert!(!arg0.prize_claimed, 17);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        assert!(0x2::kiosk::has_access(arg3, arg4), 4);
        assert!(0x2::kiosk::has_item(arg1, arg0.nft_id), 4);
        let (v1, v2) = 0x2::kiosk::purchase<T0>(arg1, arg0.nft_id, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        0x2::kiosk::place<T0>(arg3, arg4, v1);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v2);
        arg0.prize_claimed = true;
        let v6 = PrizeClaimed{
            raffle_id : 0x2::object::id<HybridRaffle>(arg0),
            winner    : v0,
            nft_id    : arg0.nft_id,
        };
        0x2::event::emit<PrizeClaimed>(v6);
    }

    public entry fun claim_prize_marketplace<T0: store + key>(arg0: &mut HybridRaffle, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.active, 2);
        assert!(arg0.nft_source_type == 10, 4);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.end_time, 15);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::option::contains<address>(&arg0.winner_address, &v0), 4);
        assert!(!arg0.prize_claimed, 17);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == *0x1::option::borrow<0x2::object::ID>(&arg0.kiosk_id), 4);
        assert!(0x2::kiosk::has_item(arg1, arg0.nft_id), 4);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg0.nft_id), 4);
        let (v1, v2) = 0x2::kiosk::purchase<T0>(arg1, arg0.nft_id, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        0x2::transfer::public_transfer<T0>(v1, v0);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v2);
        arg0.prize_claimed = true;
        let v6 = PrizeClaimed{
            raffle_id : 0x2::object::id<HybridRaffle>(arg0),
            winner    : v0,
            nft_id    : arg0.nft_id,
        };
        0x2::event::emit<PrizeClaimed>(v6);
    }

    public entry fun claim_prize_marketplace_style<T0: store + key>(arg0: &mut HybridRaffle, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.active, 2);
        assert!(arg0.nft_source_type == 6, 4);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.end_time, 15);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::option::contains<address>(&arg0.winner_address, &v0), 4);
        assert!(!arg0.prize_claimed, 17);
        0x2::kiosk::place<T0>(arg1, arg2, 0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, b"nft"));
        arg0.prize_claimed = true;
        let v1 = PrizeClaimed{
            raffle_id : 0x2::object::id<HybridRaffle>(arg0),
            winner    : v0,
            nft_id    : arg0.nft_id,
        };
        0x2::event::emit<PrizeClaimed>(v1);
    }

    public entry fun create_kiosk_borrow_raffle<T0: store + key>(arg0: &GlobalConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 4);
        assert!(arg6 > 0, 9);
        assert!(arg7 > 0, 10);
        assert!(arg8 > 0, 11);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9) + arg8;
        assert!(0x2::kiosk::has_item(arg1, arg3), 4);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg3), 4);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        0x2::kiosk::borrow<T0>(arg1, arg2, arg3);
        let v2 = 0x1::string::utf8(b"");
        let v3 = HybridRaffle{
            id              : 0x2::object::new(arg10),
            name            : arg4,
            description     : arg5,
            creator         : v0,
            ticket_price    : arg6,
            max_tickets     : arg7,
            tickets_sold    : 0,
            end_time        : v1,
            active          : true,
            nft_source_type : 14,
            kiosk_id        : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg1)),
            nft_source_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id          : arg3,
            nft_metadata    : 0x1::option::some<0x1::string::String>(v2),
            winner_address  : 0x1::option::none<address>(),
            prize_claimed   : false,
            ticket_holders  : 0x1::vector::empty<address>(),
        };
        let v4 = HybridRaffleCreated{
            raffle_id    : 0x2::object::id<HybridRaffle>(&v3),
            creator      : v0,
            kiosk_id     : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg1)),
            nft_id       : arg3,
            source_type  : 14,
            ticket_price : arg6,
            max_tickets  : arg7,
            end_time     : v1,
            nft_metadata : 0x1::option::some<0x1::string::String>(v2),
        };
        0x2::event::emit<HybridRaffleCreated>(v4);
        0x2::transfer::share_object<HybridRaffle>(v3);
    }

    public entry fun create_marketplace_style_raffle<T0: store + key>(arg0: &GlobalConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 25);
        assert!(arg7 > 0, 24);
        assert!(arg8 > 0, 11);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9) + arg8;
        assert!(0x2::kiosk::has_item(arg1, arg3), 4);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg3), 4);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        let v2 = HybridRaffle{
            id              : 0x2::object::new(arg10),
            name            : arg4,
            description     : arg5,
            creator         : v0,
            ticket_price    : arg6,
            max_tickets     : arg7,
            tickets_sold    : 0,
            end_time        : v1,
            active          : true,
            nft_source_type : 6,
            kiosk_id        : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg1)),
            nft_source_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id          : arg3,
            nft_metadata    : 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"")),
            winner_address  : 0x1::option::none<address>(),
            prize_claimed   : false,
            ticket_holders  : 0x1::vector::empty<address>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v2.id, b"nft", 0x2::kiosk::take<T0>(arg1, arg2, arg3));
        let v3 = HybridRaffleCreated{
            raffle_id    : 0x2::object::id<HybridRaffle>(&v2),
            creator      : v0,
            kiosk_id     : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg1)),
            nft_id       : arg3,
            source_type  : 6,
            ticket_price : arg6,
            max_tickets  : arg7,
            end_time     : v1,
            nft_metadata : 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"")),
        };
        0x2::event::emit<HybridRaffleCreated>(v3);
        0x2::transfer::share_object<HybridRaffle>(v2);
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
            nft_source_id   : v1,
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

    public entry fun end_raffle(arg0: &mut HybridRaffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.end_time || arg0.tickets_sold == arg0.max_tickets, 15);
        assert!(arg0.tickets_sold > 0, 3);
        arg0.active = false;
        0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<HybridRaffle>(arg0);
        let v2 = 0x2::object::id_to_bytes(&v1);
        let v3 = 0x2::tx_context::sender(arg2);
        let v4 = 0x1::bcs::to_bytes<address>(&v3);
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u8>(&v2)) {
            v5 = v5 + (*0x1::vector::borrow<u8>(&v2, v6) as u64);
            v6 = v6 + 1;
        };
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<u8>(&v4)) {
            v7 = v7 + (*0x1::vector::borrow<u8>(&v4, v8) as u64);
            v8 = v8 + 1;
        };
        let v9 = ((v0 % 982451653 + v5 % 982451653 + v7 % 982451653 + arg0.tickets_sold % 982451653) % 982451653 * 1664525 + 1013904223) % 4294967296 % arg0.tickets_sold;
        let v10 = *0x1::vector::borrow<address>(&arg0.ticket_holders, v9);
        arg0.winner_address = 0x1::option::some<address>(v10);
        let v11 = RaffleEnded{
            raffle_id    : 0x2::object::id<HybridRaffle>(arg0),
            winner       : v10,
            nft_id       : arg0.nft_id,
            random_seed  : 0x1::vector::empty<u8>(),
            winner_index : v9,
        };
        0x2::event::emit<RaffleEnded>(v11);
    }

    public fun get_raffle_info(arg0: &HybridRaffle) : (0x1::string::String, 0x1::string::String, address, u64, u64, u64, u64, bool, u8, 0x1::option::Option<0x2::object::ID>) {
        (arg0.name, arg0.description, arg0.creator, arg0.ticket_price, arg0.max_tickets, arg0.tickets_sold, arg0.end_time, arg0.active, arg0.nft_source_type, arg0.kiosk_id)
    }

    public fun get_winner_info(arg0: &HybridRaffle) : (0x1::option::Option<address>, bool) {
        (arg0.winner_address, arg0.prize_claimed)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                       : 0x2::object::new(arg0),
            primary_fee_percentage   : 1500,
            secondary_fee_percentage : 500,
            primary_fee_address      : 0x2::tx_context::sender(arg0),
            secondary_fee_address    : 0x2::tx_context::sender(arg0),
            admin_addresses          : v0,
            whitelisted_nft_types    : 0x1::vector::empty<0x1::string::String>(),
            is_initialized           : true,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public entry fun initialize_global_config(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg0);
        let v1 = GlobalConfig{
            id                       : 0x2::object::new(arg2),
            primary_fee_percentage   : arg1,
            secondary_fee_percentage : 500,
            primary_fee_address      : arg0,
            secondary_fee_address    : arg0,
            admin_addresses          : v0,
            whitelisted_nft_types    : 0x1::vector::empty<0x1::string::String>(),
            is_initialized           : true,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public entry fun remove_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
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

