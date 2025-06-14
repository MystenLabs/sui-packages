module 0x83ae8b709fb253a44d000f20316dc2f855b33eb0d6545238e9091807738eaadb::flow_raffle {
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
        assert!(arg1 > 0, 10);
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
            start_ticket_number : arg0.tickets_sold - arg1 + 1,
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

    public entry fun cancel_kiosk_borrow_raffle<T0: store + key>(arg0: &mut HybridRaffle, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.nft_source_type == 14, 4);
        assert!(arg0.creator == 0x2::tx_context::sender(arg4), 4);
        assert!(arg0.active, 2);
        assert!(!arg0.prize_claimed, 17);
        assert!(arg0.tickets_sold == 0, 21);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        0x2::kiosk::place<T0>(arg1, arg2, 0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, b"nft"));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, 0x2::transfer_policy::new_request<T0>(arg0.nft_id, 0, *0x1::option::borrow<0x2::object::ID>(&arg0.kiosk_id)));
        arg0.active = false;
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

    public entry fun claim_prize_kiosk_borrow<T0: store + key>(arg0: &mut HybridRaffle, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.active, 2);
        assert!(arg0.nft_source_type == 14, 4);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.end_time, 15);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::option::contains<address>(&arg0.winner_address, &v0), 4);
        assert!(!arg0.prize_claimed, 17);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        0x2::kiosk::place<T0>(arg1, arg2, 0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, b"nft"));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, 0x2::transfer_policy::new_request<T0>(arg0.nft_id, 0, *0x1::option::borrow<0x2::object::ID>(&arg0.kiosk_id)));
        arg0.prize_claimed = true;
        let v4 = PrizeClaimed{
            raffle_id : 0x2::object::id<HybridRaffle>(arg0),
            winner    : v0,
            nft_id    : arg0.nft_id,
        };
        0x2::event::emit<PrizeClaimed>(v4);
    }

    public entry fun claim_prize_marketplace<T0: store + key>(arg0: &mut HybridRaffle, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.active, 2);
        assert!(arg0.nft_source_type == 10, 4);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.end_time, 15);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::option::contains<address>(&arg0.winner_address, &v0), 4);
        assert!(!arg0.prize_claimed, 17);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == *0x1::option::borrow<0x2::object::ID>(&arg0.kiosk_id), 13);
        assert!(0x2::kiosk::has_item(arg1, arg0.nft_id), 12);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg0.nft_id), 12);
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

    public entry fun create_kiosk_borrow_raffle<T0: store + key>(arg0: &GlobalConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::kiosk::PurchaseCap<T0>, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 5);
        assert!(arg6 > 0, 10);
        assert!(arg7 > 0, 11);
        assert!(arg8 > 0, 7);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9) + arg8;
        let v2 = 0x2::kiosk::purchase_cap_item<T0>(&arg2);
        let v3 = 0x2::kiosk::purchase_cap_kiosk<T0>(&arg2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v3, 13);
        assert!(0x2::kiosk::has_item(arg1, v2), 12);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, v2), 12);
        assert!(0x2::kiosk::is_listed_exclusively(arg1, v2), 20);
        assert!(0x2::kiosk::purchase_cap_min_price<T0>(&arg2) == 0, 22);
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<T0>(arg1, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg10));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v5);
        let v9 = 0x1::string::utf8(b"");
        let v10 = HybridRaffle{
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
            kiosk_id        : 0x1::option::some<0x2::object::ID>(v3),
            nft_source_id   : v3,
            nft_id          : v2,
            nft_metadata    : 0x1::option::some<0x1::string::String>(v9),
            winner_address  : 0x1::option::none<address>(),
            prize_claimed   : false,
            ticket_holders  : 0x1::vector::empty<address>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v10.id, b"nft", v4);
        let v11 = HybridRaffleCreated{
            raffle_id    : 0x2::object::id<HybridRaffle>(&v10),
            creator      : v0,
            kiosk_id     : 0x1::option::some<0x2::object::ID>(v3),
            nft_id       : v2,
            source_type  : 14,
            ticket_price : arg6,
            max_tickets  : arg7,
            end_time     : v1,
            nft_metadata : 0x1::option::some<0x1::string::String>(v9),
        };
        0x2::event::emit<HybridRaffleCreated>(v11);
        0x2::transfer::share_object<HybridRaffle>(v10);
    }

    public entry fun create_marketplace_style_raffle<T0: store + key>(arg0: &GlobalConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 5);
        assert!(arg7 > 0, 11);
        assert!(arg8 > 0, 7);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9) + arg8;
        assert!(0x2::kiosk::has_item(arg1, arg3), 12);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg3), 12);
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
        assert!(arg0.is_initialized, 5);
        assert!(arg4 > 0, 10);
        assert!(arg5 > 0, 11);
        assert!(arg6 > 0, 7);
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
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::tx_context::epoch(arg2);
        let v3 = 0x2::object::id<HybridRaffle>(arg0);
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v4, 0x2::object::id_to_bytes(&v3));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg0.tickets_sold));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg0.end_time));
        let v5 = 0x2::hash::keccak256(&v4);
        let v6 = ((*0x1::vector::borrow<u8>(&v5, 0) as u64) << 56 | (*0x1::vector::borrow<u8>(&v5, 1) as u64) << 48 | (*0x1::vector::borrow<u8>(&v5, 2) as u64) << 40 | (*0x1::vector::borrow<u8>(&v5, 3) as u64) << 32 | (*0x1::vector::borrow<u8>(&v5, 4) as u64) << 24 | (*0x1::vector::borrow<u8>(&v5, 5) as u64) << 16 | (*0x1::vector::borrow<u8>(&v5, 6) as u64) << 8 | (*0x1::vector::borrow<u8>(&v5, 7) as u64)) % arg0.tickets_sold;
        let v7 = *0x1::vector::borrow<address>(&arg0.ticket_holders, v6);
        arg0.winner_address = 0x1::option::some<address>(v7);
        let v8 = RaffleEnded{
            raffle_id    : 0x2::object::id<HybridRaffle>(arg0),
            winner       : v7,
            nft_id       : arg0.nft_id,
            random_seed  : v5,
            winner_index : v6,
        };
        0x2::event::emit<RaffleEnded>(v8);
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

