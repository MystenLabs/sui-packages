module 0x2e0c1b9daa1b7994c39680a0f3a6b3f805cd750eae23550ee0ce5abded4beb7::flow_raffle {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        primary_fee_percentage: u64,
        secondary_fee_percentage: u64,
        primary_fee_address: address,
        secondary_fee_address: address,
        admin_addresses: vector<address>,
        whitelisted_nft_types: vector<0x1::string::String>,
        is_initialized: bool,
        min_raffle_duration: u64,
        max_raffle_duration: u64,
    }

    struct HybridRaffle has key {
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
        entropy_sources: vector<vector<u8>>,
    }

    struct NFTEscrow<T0: store + key> has key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        nft: T0,
        original_kiosk: 0x2::object::ID,
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
        tickets_purchased: u64,
        total_tickets_sold: u64,
        payment_amount: u64,
    }

    struct RaffleEnded has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        total_tickets: u64,
        randomness_seed: vector<u8>,
    }

    struct PrizeClaimed has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        nft_id: 0x2::object::ID,
        claim_method: 0x1::string::String,
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
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 1);
        if (!0x1::vector::contains<address>(&arg0.admin_addresses, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admin_addresses, arg1);
            let v1 = AdminAdded{
                admin_address : arg1,
                added_by      : v0,
            };
            0x2::event::emit<AdminAdded>(v1);
        };
    }

    public entry fun buy_ticket(arg0: &mut HybridRaffle, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.active, 5);
        assert!(v1 < arg0.end_time, 7);
        assert!(arg2 > 0 && arg2 <= 20, 16);
        assert!(arg0.tickets_sold + arg2 <= arg0.max_tickets, 3);
        let v2 = arg0.ticket_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 11);
        let v3 = 0;
        while (v3 < arg2) {
            0x1::vector::push_back<address>(&mut arg0.ticket_holders, v0);
            v3 = v3 + 1;
        };
        arg0.tickets_sold = arg0.tickets_sold + arg2;
        0x1::vector::push_back<vector<u8>>(&mut arg0.entropy_sources, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::push_back<vector<u8>>(&mut arg0.entropy_sources, 0x2::bcs::to_bytes<address>(&v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg4), @0x0);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v4 = TicketPurchased{
            raffle_id          : 0x2::object::id<HybridRaffle>(arg0),
            buyer              : v0,
            tickets_purchased  : arg2,
            total_tickets_sold : arg0.tickets_sold,
            payment_amount     : v2,
        };
        0x2::event::emit<TicketPurchased>(v4);
    }

    public entry fun claim_prize_kiosk_escrow<T0: store + key>(arg0: &mut HybridRaffle, arg1: NFTEscrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!arg0.active, 7);
        assert!(!arg0.prize_claimed, 8);
        assert!(arg0.nft_source_type == 0, 15);
        assert!(0x1::option::is_some<address>(&arg0.winner_address), 9);
        assert!(*0x1::option::borrow<address>(&arg0.winner_address) == v0, 9);
        assert!(arg1.raffle_id == 0x2::object::id<HybridRaffle>(arg0), 1);
        arg0.prize_claimed = true;
        let NFTEscrow {
            id             : v1,
            raffle_id      : _,
            nft            : v3,
            original_kiosk : _,
        } = arg1;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<T0>(v3, v0);
        let v5 = PrizeClaimed{
            raffle_id    : 0x2::object::id<HybridRaffle>(arg0),
            winner       : v0,
            nft_id       : arg0.nft_id,
            claim_method : 0x1::string::utf8(b"kiosk_escrow"),
        };
        0x2::event::emit<PrizeClaimed>(v5);
    }

    public entry fun claim_prize_wallet<T0: store + key>(arg0: &mut HybridRaffle, arg1: NFTEscrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!arg0.active, 7);
        assert!(!arg0.prize_claimed, 8);
        assert!(arg0.nft_source_type == 0, 15);
        assert!(0x1::option::is_some<address>(&arg0.winner_address), 9);
        assert!(*0x1::option::borrow<address>(&arg0.winner_address) == v0, 9);
        assert!(arg1.raffle_id == 0x2::object::id<HybridRaffle>(arg0), 1);
        arg0.prize_claimed = true;
        let NFTEscrow {
            id             : v1,
            raffle_id      : _,
            nft            : v3,
            original_kiosk : _,
        } = arg1;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<T0>(v3, v0);
        let v5 = PrizeClaimed{
            raffle_id    : 0x2::object::id<HybridRaffle>(arg0),
            winner       : v0,
            nft_id       : arg0.nft_id,
            claim_method : 0x1::string::utf8(b"wallet"),
        };
        0x2::event::emit<PrizeClaimed>(v5);
    }

    public entry fun create_kiosk_escrow_raffle<T0: store + key>(arg0: &GlobalConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::kiosk::PurchaseCap<T0>, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 0);
        assert!(arg6 > 0, 2);
        assert!(arg7 > 0 && arg7 <= 10000, 3);
        assert!(arg8 >= arg0.min_raffle_duration && arg8 <= arg0.max_raffle_duration, 4);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9) + arg8;
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v3 = 0x2::kiosk::purchase_cap_item<T0>(&arg2);
        assert!(0x2::kiosk::purchase_cap_min_price<T0>(&arg2) == 0, 11);
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<T0>(arg1, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg10));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v5);
        let v9 = 0x1::vector::empty<vector<u8>>();
        let v10 = 0x2::clock::timestamp_ms(arg9);
        0x1::vector::push_back<vector<u8>>(&mut v9, 0x2::bcs::to_bytes<u64>(&v10));
        0x1::vector::push_back<vector<u8>>(&mut v9, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::push_back<vector<u8>>(&mut v9, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v11 = HybridRaffle{
            id              : 0x2::object::new(arg10),
            name            : arg4,
            description     : arg5,
            creator         : v0,
            ticket_price    : arg6,
            max_tickets     : arg7,
            tickets_sold    : 0,
            end_time        : v1,
            active          : true,
            nft_source_type : 0,
            kiosk_id        : 0x1::option::some<0x2::object::ID>(v2),
            nft_source_id   : v2,
            nft_id          : v3,
            nft_metadata    : 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"")),
            winner_address  : 0x1::option::none<address>(),
            prize_claimed   : false,
            ticket_holders  : 0x1::vector::empty<address>(),
            entropy_sources : v9,
        };
        let v12 = 0x2::object::id<HybridRaffle>(&v11);
        let v13 = NFTEscrow<T0>{
            id             : 0x2::object::new(arg10),
            raffle_id      : v12,
            nft            : v4,
            original_kiosk : v2,
        };
        let v14 = HybridRaffleCreated{
            raffle_id    : v12,
            creator      : v0,
            kiosk_id     : 0x1::option::some<0x2::object::ID>(v2),
            nft_id       : v3,
            source_type  : 0,
            ticket_price : arg6,
            max_tickets  : arg7,
            end_time     : v1,
            nft_metadata : 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"")),
        };
        0x2::event::emit<HybridRaffleCreated>(v14);
        0x2::transfer::share_object<HybridRaffle>(v11);
        0x2::transfer::share_object<NFTEscrow<T0>>(v13);
    }

    public entry fun create_wallet_raffle<T0: store + key>(arg0: &GlobalConfig, arg1: T0, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_initialized, 0);
        assert!(arg4 > 0, 2);
        assert!(arg5 > 0 && arg5 <= 10000, 3);
        assert!(arg6 >= arg0.min_raffle_duration && arg6 <= arg0.max_raffle_duration, 4);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7) + arg6;
        let v2 = 0x2::object::id<T0>(&arg1);
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = 0x2::clock::timestamp_ms(arg7);
        0x1::vector::push_back<vector<u8>>(&mut v3, 0x2::bcs::to_bytes<u64>(&v4));
        0x1::vector::push_back<vector<u8>>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::push_back<vector<u8>>(&mut v3, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v5 = HybridRaffle{
            id              : 0x2::object::new(arg8),
            name            : arg2,
            description     : arg3,
            creator         : v0,
            ticket_price    : arg4,
            max_tickets     : arg5,
            tickets_sold    : 0,
            end_time        : v1,
            active          : true,
            nft_source_type : 0,
            kiosk_id        : 0x1::option::none<0x2::object::ID>(),
            nft_source_id   : v2,
            nft_id          : v2,
            nft_metadata    : 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"")),
            winner_address  : 0x1::option::none<address>(),
            prize_claimed   : false,
            ticket_holders  : 0x1::vector::empty<address>(),
            entropy_sources : v3,
        };
        let v6 = 0x2::object::id<HybridRaffle>(&v5);
        let v7 = NFTEscrow<T0>{
            id             : 0x2::object::new(arg8),
            raffle_id      : v6,
            nft            : arg1,
            original_kiosk : v2,
        };
        let v8 = HybridRaffleCreated{
            raffle_id    : v6,
            creator      : v0,
            kiosk_id     : 0x1::option::none<0x2::object::ID>(),
            nft_id       : v2,
            source_type  : 0,
            ticket_price : arg4,
            max_tickets  : arg5,
            end_time     : v1,
            nft_metadata : 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"")),
        };
        0x2::event::emit<HybridRaffleCreated>(v8);
        0x2::transfer::share_object<HybridRaffle>(v5);
        0x2::transfer::share_object<NFTEscrow<T0>>(v7);
    }

    public entry fun end_raffle(arg0: &mut HybridRaffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(arg0.active, 5);
        assert!(v0 >= arg0.end_time || arg0.tickets_sold >= arg0.max_tickets, 6);
        assert!(arg0.tickets_sold > 0, 14);
        arg0.active = false;
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&arg0.entropy_sources)) {
            0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&arg0.entropy_sources, v3));
            v3 = v3 + 1;
        };
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg0.tickets_sold));
        let v4 = 0x2::hash::keccak256(&v2);
        let v5 = if (0x1::vector::length<u8>(&v4) >= 8) {
            (*0x1::vector::borrow<u8>(&v4, 0) as u64) + ((*0x1::vector::borrow<u8>(&v4, 1) as u64) << 8) + ((*0x1::vector::borrow<u8>(&v4, 2) as u64) << 16) + ((*0x1::vector::borrow<u8>(&v4, 3) as u64) << 24) + ((*0x1::vector::borrow<u8>(&v4, 4) as u64) << 32) + ((*0x1::vector::borrow<u8>(&v4, 5) as u64) << 40) + ((*0x1::vector::borrow<u8>(&v4, 6) as u64) << 48) + ((*0x1::vector::borrow<u8>(&v4, 7) as u64) << 56)
        } else {
            (*0x1::vector::borrow<u8>(&v4, 0) as u64)
        };
        let v6 = *0x1::vector::borrow<address>(&arg0.ticket_holders, v5 % arg0.tickets_sold);
        arg0.winner_address = 0x1::option::some<address>(v6);
        let v7 = RaffleEnded{
            raffle_id       : 0x2::object::id<HybridRaffle>(arg0),
            winner          : v6,
            total_tickets   : arg0.tickets_sold,
            randomness_seed : v4,
        };
        0x2::event::emit<RaffleEnded>(v7);
    }

    public fun get_raffle_info(arg0: &HybridRaffle) : (0x1::string::String, 0x1::string::String, address, u64, u64, u64, u64, bool) {
        (arg0.name, arg0.description, arg0.creator, arg0.ticket_price, arg0.max_tickets, arg0.tickets_sold, arg0.end_time, arg0.active)
    }

    public fun get_winner_info(arg0: &HybridRaffle) : (0x1::option::Option<address>, bool) {
        (arg0.winner_address, arg0.prize_claimed)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                       : 0x2::object::new(arg0),
            primary_fee_percentage   : 1000,
            secondary_fee_percentage : 500,
            primary_fee_address      : 0x2::tx_context::sender(arg0),
            secondary_fee_address    : 0x2::tx_context::sender(arg0),
            admin_addresses          : v0,
            whitelisted_nft_types    : 0x1::vector::empty<0x1::string::String>(),
            is_initialized           : true,
            min_raffle_duration      : 3600000,
            max_raffle_duration      : 2592000000,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public entry fun remove_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 1);
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
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 1);
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
        assert!(0x1::vector::contains<address>(&arg0.admin_addresses, &v0), 1);
        assert!(arg1 + arg2 <= 5000, 13);
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

