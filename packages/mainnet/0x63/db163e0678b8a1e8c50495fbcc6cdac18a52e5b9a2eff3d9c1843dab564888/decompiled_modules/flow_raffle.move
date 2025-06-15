module 0x63db163e0678b8a1e8c50495fbcc6cdac18a52e5b9a2eff3d9c1843dab564888::flow_raffle {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        primary_fee_percentage: u64,
        secondary_fee_percentage: u64,
        primary_fee_address: address,
        secondary_fee_address: address,
        admin_addresses: vector<address>,
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
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        winner_address: 0x1::option::Option<address>,
        prize_claimed: bool,
        ticket_holders: vector<address>,
        is_locked: bool,
    }

    struct NFTEscrow<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft: T0,
        raffle_id: 0x2::object::ID,
        original_kiosk_id: 0x2::object::ID,
    }

    struct HybridRaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        ticket_price: u64,
        max_tickets: u64,
        end_time: u64,
    }

    struct TicketPurchased has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        ticket_number: u64,
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
        winner_kiosk_id: 0x2::object::ID,
    }

    public entry fun add_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
        if (!0x1::vector::contains<address>(&arg0.admin_addresses, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admin_addresses, arg1);
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

    public entry fun claim_prize<T0: store + key>(arg0: &mut HybridRaffle, arg1: NFTEscrow<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.active, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 15);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::contains<address>(&arg0.winner_address, &v0), 4);
        assert!(!arg0.prize_claimed, 17);
        assert!(arg1.raffle_id == 0x2::object::id<HybridRaffle>(arg0), 4);
        assert!(arg1.original_kiosk_id == arg0.kiosk_id, 13);
        let NFTEscrow {
            id                : v1,
            nft               : v2,
            raffle_id         : _,
            original_kiosk_id : _,
        } = arg1;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<T0>(v2, v0);
        arg0.prize_claimed = true;
        let v5 = PrizeClaimed{
            raffle_id       : 0x2::object::id<HybridRaffle>(arg0),
            winner          : v0,
            nft_id          : arg0.nft_id,
            winner_kiosk_id : 0x2::object::id_from_address(@0x0),
        };
        0x2::event::emit<PrizeClaimed>(v5);
    }

    public entry fun claim_prize_direct<T0: store + key>(arg0: &mut HybridRaffle, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.active, 2);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.end_time, 15);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::option::contains<address>(&arg0.winner_address, &v0), 4);
        assert!(!arg0.prize_claimed, 17);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 13);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        assert!(0x2::kiosk::has_item(arg1, arg0.nft_id), 12);
        let (v1, v2) = 0x2::kiosk::new(arg5);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::set_owner_custom(&mut v4, &v3, v0);
        let (v5, v6) = 0x2::kiosk::purchase<T0>(arg1, arg0.nft_id, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        0x2::kiosk::place<T0>(&mut v4, &v3, v5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, v0);
        arg0.prize_claimed = true;
        let v10 = PrizeClaimed{
            raffle_id       : 0x2::object::id<HybridRaffle>(arg0),
            winner          : v0,
            nft_id          : arg0.nft_id,
            winner_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v4),
        };
        0x2::event::emit<PrizeClaimed>(v10);
    }

    public entry fun create_raffle<T0: store + key>(arg0: &GlobalConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::transfer_policy::TransferPolicy<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 5);
        assert!(arg5 > 0, 10);
        assert!(arg6 > 0, 11);
        assert!(arg7 > 0, 7);
        assert!(0x2::kiosk::has_item(arg1, arg2), 12);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg2), 12);
        assert!(!0x2::kiosk::is_listed(arg1, arg2), 20);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9) + arg7;
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let (v3, v4) = 0x2::kiosk::purchase<T0>(arg1, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg10));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg8, v4);
        let v8 = HybridRaffle{
            id             : 0x2::object::new(arg10),
            name           : arg3,
            description    : arg4,
            creator        : v0,
            ticket_price   : arg5,
            max_tickets    : arg6,
            tickets_sold   : 0,
            end_time       : v1,
            active         : true,
            nft_id         : arg2,
            kiosk_id       : v2,
            winner_address : 0x1::option::none<address>(),
            prize_claimed  : false,
            ticket_holders : 0x1::vector::empty<address>(),
            is_locked      : true,
        };
        let v9 = 0x2::object::id<HybridRaffle>(&v8);
        let v10 = NFTEscrow<T0>{
            id                : 0x2::object::new(arg10),
            nft               : v3,
            raffle_id         : v9,
            original_kiosk_id : v2,
        };
        let v11 = HybridRaffleCreated{
            raffle_id    : v9,
            creator      : v0,
            nft_id       : arg2,
            kiosk_id     : v2,
            ticket_price : arg5,
            max_tickets  : arg6,
            end_time     : v1,
        };
        0x2::event::emit<HybridRaffleCreated>(v11);
        0x2::transfer::share_object<HybridRaffle>(v8);
        0x2::transfer::share_object<NFTEscrow<T0>>(v10);
    }

    public entry fun create_raffle_direct<T0: store + key>(arg0: &GlobalConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 5);
        assert!(arg6 > 0, 10);
        assert!(arg7 > 0, 11);
        assert!(arg8 > 0, 7);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        assert!(0x2::kiosk::has_item(arg1, arg3), 12);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg3), 12);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9) + arg8;
        0x2::kiosk::list<T0>(arg1, arg2, arg3, 0);
        let v2 = HybridRaffle{
            id             : 0x2::object::new(arg10),
            name           : arg4,
            description    : arg5,
            creator        : v0,
            ticket_price   : arg6,
            max_tickets    : arg7,
            tickets_sold   : 0,
            end_time       : v1,
            active         : true,
            nft_id         : arg3,
            kiosk_id       : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            winner_address : 0x1::option::none<address>(),
            prize_claimed  : false,
            ticket_holders : 0x1::vector::empty<address>(),
            is_locked      : true,
        };
        let v3 = HybridRaffleCreated{
            raffle_id    : 0x2::object::id<HybridRaffle>(&v2),
            creator      : v0,
            nft_id       : arg3,
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            ticket_price : arg6,
            max_tickets  : arg7,
            end_time     : v1,
        };
        0x2::event::emit<HybridRaffleCreated>(v3);
        0x2::transfer::share_object<HybridRaffle>(v2);
    }

    public entry fun end_raffle(arg0: &mut HybridRaffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.end_time || arg0.tickets_sold == arg0.max_tickets, 15);
        assert!(arg0.tickets_sold > 0, 3);
        arg0.active = false;
        let v1 = 0x2::object::id<HybridRaffle>(arg0);
        let v2 = 0x2::object::id_to_bytes(&v1);
        let v3 = 0x2::tx_context::sender(arg2);
        let v4 = 0x2::bcs::to_bytes<address>(&v3);
        let v5 = (v0 % 982451653 + simple_hash(&v2) % 982451653 + simple_hash(&v4) % 982451653 + arg0.tickets_sold % 982451653) % 4294967296 % arg0.tickets_sold;
        let v6 = *0x1::vector::borrow<address>(&arg0.ticket_holders, v5);
        arg0.winner_address = 0x1::option::some<address>(v6);
        let v7 = RaffleEnded{
            raffle_id    : v1,
            winner       : v6,
            nft_id       : arg0.nft_id,
            random_seed  : 0x1::vector::empty<u8>(),
            winner_index : v5,
        };
        0x2::event::emit<RaffleEnded>(v7);
    }

    fun hash_accumulate(arg0: &vector<u8>, arg1: u64, arg2: u64) : u64 {
        if (arg1 >= 0x1::vector::length<u8>(arg0)) {
            arg2
        } else {
            hash_accumulate(arg0, arg1 + 1, arg2 + (*0x1::vector::borrow<u8>(arg0, arg1) as u64))
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                       : 0x2::object::new(arg0),
            primary_fee_percentage   : 250,
            secondary_fee_percentage : 500,
            primary_fee_address      : 0x2::tx_context::sender(arg0),
            secondary_fee_address    : 0x2::tx_context::sender(arg0),
            admin_addresses          : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
            is_initialized           : true,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    fun simple_hash(arg0: &vector<u8>) : u64 {
        if (0x1::vector::length<u8>(arg0) == 0) {
            return 0
        };
        hash_accumulate(arg0, 0, 0)
    }

    public entry fun update_fee_addresses(arg0: &mut GlobalConfig, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
        arg0.primary_fee_address = arg1;
        arg0.secondary_fee_address = arg2;
    }

    public entry fun update_fees(arg0: &mut GlobalConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 4);
        arg0.primary_fee_percentage = arg1;
        arg0.secondary_fee_percentage = arg2;
    }

    // decompiled from Move bytecode v6
}

