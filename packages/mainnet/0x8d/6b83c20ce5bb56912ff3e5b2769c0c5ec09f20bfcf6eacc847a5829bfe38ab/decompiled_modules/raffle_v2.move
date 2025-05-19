module 0x8d6b83c20ce5bb56912ff3e5b2769c0c5ec09f20bfcf6eacc847a5829bfe38ab::raffle_v2 {
    struct RAFFLE_V2 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RaffleManager has key {
        id: 0x2::object::UID,
        active_raffles: 0x2::vec_set::VecSet<0x2::object::ID>,
        fee_recipient: address,
        fee_percentage: u64,
        total_fees_collected: u64,
        total_raffles_created: u64,
        paused: bool,
    }

    struct Raffle has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        ticket_price: u64,
        max_tickets: u64,
        min_tickets: u64,
        tickets_sold: u64,
        total_value: u64,
        creation_time: u64,
        end_time: u64,
        participants: 0x2::vec_map::VecMap<address, u64>,
        is_active: bool,
        winner: 0x1::option::Option<address>,
        prize_type: 0x1::string::String,
        prize_name: 0x1::string::String,
        proceeds: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        owner: address,
        ticket_number: u64,
        purchase_time: u64,
    }

    struct WinnerCertificate has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        winner: address,
    }

    struct RaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        prize_type: 0x1::string::String,
        prize_name: 0x1::string::String,
        name: 0x1::string::String,
        ticket_price: u64,
        max_tickets: u64,
        min_tickets: u64,
        end_time: u64,
    }

    struct TicketPurchased has copy, drop {
        raffle_id: 0x2::object::ID,
        buyer: address,
        quantity: u64,
        ticket_ids: vector<0x2::object::ID>,
        ticket_numbers: vector<u64>,
        amount_paid: u64,
    }

    struct WinnerSelected has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        tickets_sold: u64,
        winning_ticket: u64,
    }

    struct PrizeClaimed has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        prize_type: 0x1::string::String,
    }

    struct RefundIssued has copy, drop {
        raffle_id: 0x2::object::ID,
        participant: address,
        refund_amount: u64,
    }

    struct RaffleCancelled has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        reason: 0x1::string::String,
    }

    struct SystemConfigChanged has copy, drop {
        admin: address,
        parameter: 0x1::string::String,
        new_value: 0x1::string::String,
    }

    struct PrizeData has store, key {
        id: 0x2::object::UID,
        data: vector<u8>,
    }

    struct PrizeBytes has store, key {
        id: 0x2::object::UID,
        bytes: vector<u8>,
    }

    public entry fun bulk_refund(arg0: &mut RaffleManager, arg1: &mut Raffle, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg3), 8);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.end_time, 3);
        assert!(arg1.is_active, 1);
        assert!(!has_met_min_tickets(arg1), 15);
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg1.proceeds), 16);
        let v0 = arg1.participants;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<address, u64>(&v0)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<address, u64>(&v0, v1);
            let v4 = *v3 * arg1.ticket_price;
            if (0x2::vec_map::contains<address, u64>(&arg1.participants, v2) && 0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg1.proceeds)) {
                let v5 = 0x1::option::borrow_mut<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.proceeds);
                if (0x2::coin::value<0x2::sui::SUI>(v5) >= v4) {
                    let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg1.participants, v2);
                    let v8 = RefundIssued{
                        raffle_id     : 0x2::object::id<Raffle>(arg1),
                        participant   : *v2,
                        refund_amount : v4,
                    };
                    0x2::event::emit<RefundIssued>(v8);
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(v5, v4, arg3), *v2);
                };
            };
            v1 = v1 + 1;
        };
        arg1.is_active = false;
        let v9 = 0x2::object::id<Raffle>(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.active_raffles, &v9)) {
            let v10 = 0x2::object::id<Raffle>(arg1);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_raffles, &v10);
        };
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg1.proceeds)) {
            let v11 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.proceeds);
            if (0x2::coin::value<0x2::sui::SUI>(&v11) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v11, arg1.creator);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v11);
            };
        };
    }

    public entry fun buy_tickets(arg0: &mut Raffle, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time, 2);
        assert!(arg0.tickets_sold + arg2 <= arg0.max_tickets, 5);
        let v0 = arg0.ticket_price * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 4);
        if (0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.proceeds)) {
            0x1::option::fill<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.proceeds, 0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg4));
        } else {
            0x2::coin::join<0x2::sui::SUI>(0x1::option::borrow_mut<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.proceeds), 0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg4));
        };
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
                purchase_time : 0x2::clock::timestamp_ms(arg3),
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x2::object::id<Ticket>(&v9));
            0x1::vector::push_back<u64>(&mut v6, v8);
            0x2::transfer::public_transfer<Ticket>(v9, v1);
            v7 = v7 + 1;
        };
        arg0.tickets_sold = arg0.tickets_sold + arg2;
        arg0.total_value = arg0.total_value + v0;
        let v10 = TicketPurchased{
            raffle_id      : 0x2::object::id<Raffle>(arg0),
            buyer          : v1,
            quantity       : arg2,
            ticket_ids     : v5,
            ticket_numbers : v6,
            amount_paid    : v0,
        };
        0x2::event::emit<TicketPurchased>(v10);
    }

    public entry fun cancel_raffle(arg0: &mut RaffleManager, arg1: &mut Raffle, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg3), 8);
        assert!(arg1.is_active, 1);
        arg1.is_active = false;
        let v0 = 0x2::object::id<Raffle>(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.active_raffles, &v0)) {
            let v1 = 0x2::object::id<Raffle>(arg1);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_raffles, &v1);
        };
        arg1.winner = 0x1::option::none<address>();
        let v2 = RaffleCancelled{
            raffle_id : 0x2::object::id<Raffle>(arg1),
            creator   : 0x2::tx_context::sender(arg3),
            reason    : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<RaffleCancelled>(v2);
    }

    public entry fun claim_nft_prize<T0: store + key>(arg0: &RaffleManager, arg1: &mut Raffle, arg2: WinnerCertificate, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.raffle_id == 0x2::object::id<Raffle>(arg1), 7);
        assert!(arg2.winner == 0x2::tx_context::sender(arg3), 7);
        assert!(0x1::option::is_some<address>(&arg1.winner), 10);
        let v0 = *0x1::option::borrow<address>(&arg1.winner);
        assert!(v0 == 0x2::tx_context::sender(arg3), 7);
        assert!(0x1::string::utf8(b"NFT") == arg1.prize_type, 17);
        let v1 = extract_nft<T0>(arg1);
        distribute_proceeds(arg1, arg0, arg3);
        let v2 = PrizeClaimed{
            raffle_id  : 0x2::object::id<Raffle>(arg1),
            winner     : v0,
            prize_type : arg1.prize_type,
        };
        0x2::event::emit<PrizeClaimed>(v2);
        0x2::transfer::public_transfer<T0>(v1, v0);
        let WinnerCertificate {
            id        : v3,
            raffle_id : _,
            winner    : _,
        } = arg2;
        0x2::object::delete(v3);
    }

    public entry fun claim_prize(arg0: &RaffleManager, arg1: &mut Raffle, arg2: WinnerCertificate, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.raffle_id == 0x2::object::id<Raffle>(arg1), 7);
        assert!(arg2.winner == 0x2::tx_context::sender(arg3), 7);
        assert!(0x1::option::is_some<address>(&arg1.winner), 10);
        let v0 = *0x1::option::borrow<address>(&arg1.winner);
        assert!(v0 == 0x2::tx_context::sender(arg3), 7);
        let v1 = arg1.prize_type;
        if (0x1::string::utf8(b"TOKEN") == v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, b"prize"), v0);
        } else {
            let v2 = PrizeData{
                id   : 0x2::object::new(arg3),
                data : b"Use claim_nft_prize<T> with the correct NFT type for this prize",
            };
            0x2::transfer::public_transfer<PrizeData>(v2, v0);
        };
        distribute_proceeds(arg1, arg0, arg3);
        let v3 = PrizeClaimed{
            raffle_id  : 0x2::object::id<Raffle>(arg1),
            winner     : v0,
            prize_type : v1,
        };
        0x2::event::emit<PrizeClaimed>(v3);
        let WinnerCertificate {
            id        : v4,
            raffle_id : _,
            winner    : _,
        } = arg2;
        0x2::object::delete(v4);
    }

    public entry fun claim_refund(arg0: &mut Raffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 3);
        assert!(arg0.is_active, 1);
        assert!(!has_met_min_tickets(arg0), 15);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.participants, &v0), 16);
        let v1 = *0x2::vec_map::get<address, u64>(&arg0.participants, &v0) * arg0.ticket_price;
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.proceeds), 16);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.participants, &v0);
        let v4 = 0x1::option::borrow_mut<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.proceeds);
        assert!(0x2::coin::value<0x2::sui::SUI>(v4) >= v1, 16);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(v4, v1, arg2);
        let v6 = RefundIssued{
            raffle_id     : 0x2::object::id<Raffle>(arg0),
            participant   : v0,
            refund_amount : v1,
        };
        0x2::event::emit<RefundIssued>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, v0);
    }

    public entry fun claim_token_prize(arg0: &RaffleManager, arg1: &mut Raffle, arg2: WinnerCertificate, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.raffle_id == 0x2::object::id<Raffle>(arg1), 7);
        assert!(arg2.winner == 0x2::tx_context::sender(arg3), 7);
        assert!(0x1::option::is_some<address>(&arg1.winner), 10);
        let v0 = *0x1::option::borrow<address>(&arg1.winner);
        assert!(v0 == 0x2::tx_context::sender(arg3), 7);
        assert!(0x1::string::utf8(b"TOKEN") == arg1.prize_type, 17);
        let v1 = 0x2::dynamic_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, b"prize");
        distribute_proceeds(arg1, arg0, arg3);
        let v2 = PrizeClaimed{
            raffle_id  : 0x2::object::id<Raffle>(arg1),
            winner     : v0,
            prize_type : arg1.prize_type,
        };
        0x2::event::emit<PrizeClaimed>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        let WinnerCertificate {
            id        : v3,
            raffle_id : _,
            winner    : _,
        } = arg2;
        0x2::object::delete(v3);
    }

    public entry fun create_nft_raffle<T0: store + key>(arg0: &mut RaffleManager, arg1: T0, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 21);
        assert!(arg10 > 0, 18);
        assert!(arg7 > 0, 19);
        assert!(arg8 > 0, 20);
        assert!(arg9 <= arg8, 13);
        let v0 = take_payment_from_sender(arg2, 1000000000, arg12);
        let v1 = 0x2::clock::timestamp_ms(arg11);
        let v2 = 0x2::tx_context::sender(arg12);
        let v3 = Raffle{
            id            : 0x2::object::new(arg12),
            creator       : v2,
            name          : 0x1::string::utf8(arg3),
            description   : 0x1::string::utf8(arg4),
            image_url     : 0x1::string::utf8(arg5),
            ticket_price  : arg7,
            max_tickets   : arg8,
            min_tickets   : arg9,
            tickets_sold  : 0,
            total_value   : 0,
            creation_time : v1,
            end_time      : v1 + arg10,
            participants  : 0x2::vec_map::empty<address, u64>(),
            is_active     : true,
            winner        : 0x1::option::none<address>(),
            prize_type    : 0x1::string::utf8(b"NFT"),
            prize_name    : 0x1::string::utf8(arg6),
            proceeds      : 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>(),
        };
        let v4 = 0x2::object::id<Raffle>(&v3);
        let v5 = &mut v3;
        store_nft<T0>(v5, arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_raffles, v4);
        arg0.total_raffles_created = arg0.total_raffles_created + 1;
        arg0.total_fees_collected = arg0.total_fees_collected + 1000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.fee_recipient);
        let v6 = RaffleCreated{
            raffle_id    : v4,
            creator      : v2,
            prize_type   : 0x1::string::utf8(b"NFT"),
            prize_name   : 0x1::string::utf8(arg6),
            name         : 0x1::string::utf8(arg3),
            ticket_price : arg7,
            max_tickets  : arg8,
            min_tickets  : arg9,
            end_time     : v1 + arg10,
        };
        0x2::event::emit<RaffleCreated>(v6);
        0x2::transfer::share_object<Raffle>(v3);
    }

    public entry fun create_token_raffle(arg0: &mut RaffleManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 21);
        assert!(arg10 > 0, 18);
        assert!(arg7 > 0, 19);
        assert!(arg8 > 0, 20);
        assert!(arg9 <= arg8, 13);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 17);
        let v1 = take_payment_from_sender(arg2, 1000000000, arg12);
        let v2 = 0x2::clock::timestamp_ms(arg11);
        let v3 = if (0x1::vector::length<u8>(&arg6) == 0) {
            0x1::string::utf8(b"SUI Token Prize")
        } else {
            0x1::string::utf8(arg6)
        };
        let v4 = 0x2::tx_context::sender(arg12);
        let v5 = Raffle{
            id            : 0x2::object::new(arg12),
            creator       : v4,
            name          : 0x1::string::utf8(arg3),
            description   : 0x1::string::utf8(arg4),
            image_url     : 0x1::string::utf8(arg5),
            ticket_price  : arg7,
            max_tickets   : arg8,
            min_tickets   : arg9,
            tickets_sold  : 0,
            total_value   : 0,
            creation_time : v2,
            end_time      : v2 + arg10,
            participants  : 0x2::vec_map::empty<address, u64>(),
            is_active     : true,
            winner        : 0x1::option::none<address>(),
            prize_type    : 0x1::string::utf8(b"TOKEN"),
            prize_name    : v3,
            proceeds      : 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>(),
        };
        let v6 = 0x2::object::id<Raffle>(&v5);
        0x2::dynamic_field::add<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v5.id, b"prize", arg1);
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v5.id, b"prize_value", v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_raffles, v6);
        arg0.total_raffles_created = arg0.total_raffles_created + 1;
        arg0.total_fees_collected = arg0.total_fees_collected + 1000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg0.fee_recipient);
        let v7 = RaffleCreated{
            raffle_id    : v6,
            creator      : v4,
            prize_type   : 0x1::string::utf8(b"TOKEN"),
            prize_name   : v3,
            name         : 0x1::string::utf8(arg3),
            ticket_price : arg7,
            max_tickets  : arg8,
            min_tickets  : arg9,
            end_time     : v2 + arg10,
        };
        0x2::event::emit<RaffleCreated>(v7);
        0x2::transfer::share_object<Raffle>(v5);
    }

    fun distribute_proceeds(arg0: &mut Raffle, arg1: &RaffleManager, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.proceeds)) {
            let v0 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.proceeds);
            let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0) * arg1.fee_percentage / 10000;
            if (v1 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1, arg2), arg1.fee_recipient);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.creator);
        };
    }

    public fun extract_nft<T0: store + key>(arg0: &mut Raffle) : T0 {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, 0x1::string::String>(&arg0.id, b"prize_type_info");
        assert!(0x1::string::utf8(b"NFT") == arg0.prize_type, 17);
        let v1 = 0x1::string::as_bytes(v0);
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v3 = 0x1::vector::length<u8>(v1) == 0x1::vector::length<u8>(&v2);
        let v4 = v3;
        if (v3) {
            let v5 = 0;
            while (v5 < 0x1::vector::length<u8>(v1) && v4) {
                v4 = *0x1::vector::borrow<u8>(v1, v5) == *0x1::vector::borrow<u8>(&v2, v5);
                v5 = v5 + 1;
            };
        };
        assert!(v4, 17);
        0x2::dynamic_field::remove<vector<u8>, T0>(&mut arg0.id, b"prize")
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
        abort 22
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

    public fun get_raffle_info(arg0: &Raffle) : (0x2::object::ID, address, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, bool, 0x1::option::Option<address>, 0x1::string::String, 0x1::string::String) {
        (0x2::object::id<Raffle>(arg0), arg0.creator, arg0.name, arg0.description, arg0.image_url, arg0.ticket_price, arg0.max_tickets, arg0.min_tickets, arg0.tickets_sold, arg0.end_time, arg0.is_active, arg0.winner, arg0.prize_type, arg0.prize_name)
    }

    public fun get_system_stats(arg0: &RaffleManager) : (u64, u64, bool, address, u64) {
        (arg0.total_raffles_created, arg0.total_fees_collected, arg0.paused, arg0.fee_recipient, arg0.fee_percentage)
    }

    public fun get_ticket_info(arg0: &Ticket) : (0x2::object::ID, 0x2::object::ID, address, u64, u64) {
        (0x2::object::id<Ticket>(arg0), arg0.raffle_id, arg0.owner, arg0.ticket_number, arg0.purchase_time)
    }

    public fun has_met_min_tickets(arg0: &Raffle) : bool {
        arg0.tickets_sold >= arg0.min_tickets
    }

    public fun has_tickets(arg0: &Raffle, arg1: address) : (bool, u64) {
        if (0x2::vec_map::contains<address, u64>(&arg0.participants, &arg1)) {
            (true, *0x2::vec_map::get<address, u64>(&arg0.participants, &arg1))
        } else {
            (false, 0)
        }
    }

    fun init(arg0: RAFFLE_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RAFFLE_V2>(arg0, arg1);
        let v1 = 0x2::display::new<Ticket>(&v0, arg1);
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Raffle Ticket #{ticket_number}"));
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Ticket for raffle {raffle_id}"));
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"https://sui-raffles.io/ticket/{raffle_id}/{ticket_number}"));
        0x2::display::add<Ticket>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://sui-raffles.io/ticket-image/{raffle_id}"));
        0x2::display::update_version<Ticket>(&mut v1);
        let v2 = 0x2::display::new<WinnerCertificate>(&v0, arg1);
        0x2::display::add<WinnerCertificate>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Raffle Winner Certificate"));
        0x2::display::add<WinnerCertificate>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Certificate for winning raffle {raffle_id}"));
        0x2::display::add<WinnerCertificate>(&mut v2, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"https://sui-raffles.io/winner/{raffle_id}"));
        0x2::display::add<WinnerCertificate>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://sui-raffles.io/winner-image/{raffle_id}"));
        0x2::display::update_version<WinnerCertificate>(&mut v2);
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = RaffleManager{
            id                    : 0x2::object::new(arg1),
            active_raffles        : 0x2::vec_set::empty<0x2::object::ID>(),
            fee_recipient         : v3,
            fee_percentage        : 250,
            total_fees_collected  : 0,
            total_raffles_created : 0,
            paused                : false,
        };
        let v5 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v3);
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(v1, v3);
        0x2::transfer::public_transfer<0x2::display::Display<WinnerCertificate>>(v2, v3);
        0x2::transfer::public_transfer<AdminCap>(v5, v3);
        0x2::transfer::share_object<RaffleManager>(v4);
    }

    public entry fun select_winner(arg0: &mut RaffleManager, arg1: &mut Raffle, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_active, 1);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.end_time, 3);
        assert!(0x1::option::is_none<address>(&arg1.winner), 6);
        assert!(arg1.tickets_sold > 0, 9);
        assert!(has_met_min_tickets(arg1), 14);
        let v0 = 0x2::random::new_generator(arg2, arg4);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, arg1.tickets_sold);
        let v2 = find_ticket_owner(arg1, v1);
        arg1.winner = 0x1::option::some<address>(v2);
        arg1.is_active = false;
        let v3 = WinnerCertificate{
            id        : 0x2::object::new(arg4),
            raffle_id : 0x2::object::id<Raffle>(arg1),
            winner    : v2,
        };
        let v4 = 0x2::object::id<Raffle>(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.active_raffles, &v4)) {
            let v5 = 0x2::object::id<Raffle>(arg1);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_raffles, &v5);
        };
        let v6 = WinnerSelected{
            raffle_id      : 0x2::object::id<Raffle>(arg1),
            winner         : v2,
            tickets_sold   : arg1.tickets_sold,
            winning_ticket : v1,
        };
        0x2::event::emit<WinnerSelected>(v6);
        0x2::transfer::public_transfer<WinnerCertificate>(v3, v2);
    }

    public entry fun set_fee_percentage(arg0: &mut RaffleManager, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2500, 11);
        arg0.fee_percentage = arg2;
        let v0 = 0x1::vector::empty<u8>();
        if (arg2 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            let v1 = 0x1::vector::empty<u8>();
            while (arg2 > 0) {
                0x1::vector::push_back<u8>(&mut v1, ((arg2 % 10 + 48) as u8));
                arg2 = arg2 / 10;
            };
            let v2 = 0x1::vector::length<u8>(&v1);
            while (v2 > 0) {
                v2 = v2 - 1;
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, v2));
            };
        };
        let v3 = SystemConfigChanged{
            admin     : 0x2::tx_context::sender(arg3),
            parameter : 0x1::string::utf8(b"fee_percentage"),
            new_value : 0x1::string::utf8(v0),
        };
        0x2::event::emit<SystemConfigChanged>(v3);
    }

    public entry fun set_fee_recipient(arg0: &mut RaffleManager, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.fee_recipient = arg2;
        let v0 = SystemConfigChanged{
            admin     : 0x2::tx_context::sender(arg3),
            parameter : 0x1::string::utf8(b"fee_recipient"),
            new_value : 0x1::string::utf8(b"address:"),
        };
        0x2::event::emit<SystemConfigChanged>(v0);
    }

    public entry fun set_system_pause(arg0: &mut RaffleManager, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.paused = arg2;
        let v0 = if (arg2) {
            0x1::string::utf8(b"true")
        } else {
            0x1::string::utf8(b"false")
        };
        let v1 = SystemConfigChanged{
            admin     : 0x2::tx_context::sender(arg3),
            parameter : 0x1::string::utf8(b"system_paused"),
            new_value : v0,
        };
        0x2::event::emit<SystemConfigChanged>(v1);
    }

    public fun store_nft<T0: store + key>(arg0: &mut Raffle, arg1: T0) {
        0x2::dynamic_field::add<vector<u8>, T0>(&mut arg0.id, b"prize", arg1);
        0x2::dynamic_field::add<vector<u8>, 0x1::ascii::String>(&mut arg0.id, b"prize_type_info", 0x1::type_name::into_string(0x1::type_name::get<T0>()));
    }

    public fun take_payment_from_sender(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg1, 4);
        0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

