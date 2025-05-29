module 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::raffle_core {
    struct RAFFLE_CORE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Raffle has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        min_tickets: u64,
        creation_time: u64,
        end_time: u64,
        is_active: bool,
        winner: 0x1::option::Option<address>,
        winner_ticket_number: 0x1::option::Option<u64>,
        vault_id: 0x2::object::ID,
        ticket_manager_id: 0x2::object::ID,
    }

    struct RaffleRegistry has store, key {
        id: 0x2::object::UID,
        active_raffles: 0x2::vec_set::VecSet<0x2::object::ID>,
        completed_raffles: 0x2::vec_set::VecSet<0x2::object::ID>,
        total_raffles_created: u64,
        paused: bool,
    }

    struct WinnerCertificate has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        winner: address,
        winning_ticket: u64,
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

    struct WinnerSelected has copy, drop {
        raffle_id: 0x2::object::ID,
        winner: address,
        tickets_sold: u64,
        winning_ticket: u64,
    }

    struct PrizeClaimed has copy, drop {
        prize_type: 0x1::string::String,
        prize_name: 0x1::string::String,
    }

    struct RaffleCancelled has copy, drop {
        raffle_id: 0x2::object::ID,
        creator: address,
        reason: 0x1::string::String,
    }

    struct SystemPauseToggled has copy, drop {
        paused: bool,
        toggled_by: address,
    }

    public entry fun buy_individual_tickets(arg0: &Raffle, arg1: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.end_time, 2);
        assert!(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(arg1) == arg0.ticket_manager_id, 12);
        0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::buy_individual_tickets(arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4), arg5);
    }

    public entry fun buy_tickets(arg0: &Raffle, arg1: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.end_time, 2);
        assert!(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(arg1) == arg0.ticket_manager_id, 12);
        0x2::transfer::public_transfer<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketBatch>(0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::buy_tickets(arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4), arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun cancel_raffle(arg0: &mut RaffleRegistry, arg1: &mut Raffle, arg2: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager, arg3: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault, arg4: 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::DepositReceipt, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg1.creator, 7);
        assert!(arg1.is_active, 1);
        assert!(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(arg2) == arg1.ticket_manager_id, 12);
        assert!(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(arg3) == arg1.vault_id, 12);
        let (_, _, _, _, _, v5, _, _) = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::get_manager_info(arg2);
        if (v5 > 0) {
            0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::process_refunds(arg2, arg6);
        };
        assert!(0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::get_prize_type(arg3) == 0x1::string::utf8(b"TOKEN"), 13);
        0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::reclaim_prize<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg4, 0x2::tx_context::epoch(arg6), arg6);
        arg1.is_active = false;
        arg1.winner = 0x1::option::none<address>();
        let v8 = 0x2::object::id<Raffle>(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.active_raffles, &v8)) {
            let v9 = 0x2::object::id<Raffle>(arg1);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_raffles, &v9);
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.completed_raffles, 0x2::object::id<Raffle>(arg1));
        };
        let v10 = RaffleCancelled{
            raffle_id : 0x2::object::id<Raffle>(arg1),
            creator   : arg1.creator,
            reason    : 0x1::string::utf8(arg5),
        };
        0x2::event::emit<RaffleCancelled>(v10);
    }

    public entry fun create_kiosk_nft_raffle(arg0: &mut RaffleRegistry, arg1: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::fee_manager::FeeManager, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(arg15 > 0, 8);
        assert!(arg14 <= arg13, 9);
        let v0 = 0x2::clock::timestamp_ms(arg16);
        0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::fee_manager::process_creation_fee(arg1, arg6, 0x2::object::id_from_address(@0x0), v0, arg17);
        let (v1, v2) = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::create_kiosk_nft_vault(arg2, arg3, arg4, 0x1::string::utf8(arg5), 0x1::string::utf8(arg10), 0x1::string::utf8(arg11), v0, arg17);
        let v3 = v1;
        let v4 = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::create_ticket_manager(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(&v3), arg12, arg13, arg17);
        let v5 = Raffle{
            id                   : 0x2::object::new(arg17),
            creator              : 0x2::tx_context::sender(arg17),
            name                 : 0x1::string::utf8(arg7),
            description          : 0x1::string::utf8(arg8),
            image_url            : 0x1::string::utf8(arg9),
            min_tickets          : arg14,
            creation_time        : v0,
            end_time             : v0 + arg15,
            is_active            : true,
            winner               : 0x1::option::none<address>(),
            winner_ticket_number : 0x1::option::none<u64>(),
            vault_id             : 0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(&v3),
            ticket_manager_id    : 0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(&v4),
        };
        let v6 = 0x2::object::id<Raffle>(&v5);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_raffles, v6);
        arg0.total_raffles_created = arg0.total_raffles_created + 1;
        let v7 = RaffleCreated{
            raffle_id    : v6,
            creator      : 0x2::tx_context::sender(arg17),
            prize_type   : 0x1::string::utf8(b"KIOSK_NFT"),
            prize_name   : 0x1::string::utf8(arg10),
            name         : 0x1::string::utf8(arg7),
            ticket_price : arg12,
            max_tickets  : arg13,
            min_tickets  : arg14,
            end_time     : v0 + arg15,
        };
        0x2::event::emit<RaffleCreated>(v7);
        0x2::transfer::public_transfer<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::DepositReceipt>(v2, 0x2::tx_context::sender(arg17));
        0x2::transfer::public_share_object<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(v3);
        0x2::transfer::public_share_object<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(v4);
        0x2::transfer::public_share_object<Raffle>(v5);
    }

    public entry fun create_nft_raffle<T0: store + key>(arg0: &mut RaffleRegistry, arg1: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::fee_manager::FeeManager, arg2: T0, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(arg12 > 0, 8);
        assert!(arg11 <= arg10, 9);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::fee_manager::process_creation_fee(arg1, arg3, 0x2::object::id_from_address(@0x0), v0, arg14);
        let (v1, v2) = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::create_nft_vault<T0>(arg2, 0x1::string::utf8(arg7), 0x1::string::utf8(arg8), v0, arg14);
        let v3 = v1;
        let v4 = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::create_ticket_manager(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(&v3), arg9, arg10, arg14);
        let v5 = Raffle{
            id                   : 0x2::object::new(arg14),
            creator              : 0x2::tx_context::sender(arg14),
            name                 : 0x1::string::utf8(arg4),
            description          : 0x1::string::utf8(arg5),
            image_url            : 0x1::string::utf8(arg6),
            min_tickets          : arg11,
            creation_time        : v0,
            end_time             : v0 + arg12,
            is_active            : true,
            winner               : 0x1::option::none<address>(),
            winner_ticket_number : 0x1::option::none<u64>(),
            vault_id             : 0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(&v3),
            ticket_manager_id    : 0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(&v4),
        };
        let v6 = 0x2::object::id<Raffle>(&v5);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_raffles, v6);
        arg0.total_raffles_created = arg0.total_raffles_created + 1;
        let v7 = RaffleCreated{
            raffle_id    : v6,
            creator      : 0x2::tx_context::sender(arg14),
            prize_type   : 0x1::string::utf8(b"NFT"),
            prize_name   : 0x1::string::utf8(arg7),
            name         : 0x1::string::utf8(arg4),
            ticket_price : arg9,
            max_tickets  : arg10,
            min_tickets  : arg11,
            end_time     : v0 + arg12,
        };
        0x2::event::emit<RaffleCreated>(v7);
        0x2::transfer::public_transfer<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::DepositReceipt>(v2, 0x2::tx_context::sender(arg14));
        0x2::transfer::public_share_object<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(v3);
        0x2::transfer::public_share_object<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(v4);
        0x2::transfer::public_share_object<Raffle>(v5);
    }

    public entry fun create_secure_kiosk_nft_raffle<T0: store + key>(arg0: &mut RaffleRegistry, arg1: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::fee_manager::FeeManager, arg2: &0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::raffle_kiosk::RaffleKiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &0x2::transfer_policy::TransferPolicy<T0>, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(arg18 > 0, 8);
        assert!(arg17 <= arg16, 9);
        let v0 = 0x2::clock::timestamp_ms(arg19);
        0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::fee_manager::process_creation_fee(arg1, arg9, 0x2::object::id_from_address(@0x0), v0, arg20);
        let (v1, v2) = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::create_escrowed_kiosk_nft_vault(0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::raffle_kiosk::receive_nft_from_kiosk<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::object::id_from_address(@0x0), arg20), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::string::utf8(arg13), 0x1::string::utf8(arg14), v0, arg20);
        let v3 = v1;
        let v4 = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::create_ticket_manager(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(&v3), arg15, arg16, arg20);
        let v5 = Raffle{
            id                   : 0x2::object::new(arg20),
            creator              : 0x2::tx_context::sender(arg20),
            name                 : 0x1::string::utf8(arg10),
            description          : 0x1::string::utf8(arg11),
            image_url            : 0x1::string::utf8(arg12),
            min_tickets          : arg17,
            creation_time        : v0,
            end_time             : v0 + arg18,
            is_active            : true,
            winner               : 0x1::option::none<address>(),
            winner_ticket_number : 0x1::option::none<u64>(),
            vault_id             : 0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(&v3),
            ticket_manager_id    : 0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(&v4),
        };
        let v6 = 0x2::object::id<Raffle>(&v5);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_raffles, v6);
        arg0.total_raffles_created = arg0.total_raffles_created + 1;
        let v7 = RaffleCreated{
            raffle_id    : v6,
            creator      : 0x2::tx_context::sender(arg20),
            prize_type   : 0x1::string::utf8(b"ESCROWED_KIOSK_NFT"),
            prize_name   : 0x1::string::utf8(arg13),
            name         : 0x1::string::utf8(arg10),
            ticket_price : arg15,
            max_tickets  : arg16,
            min_tickets  : arg17,
            end_time     : v0 + arg18,
        };
        0x2::event::emit<RaffleCreated>(v7);
        0x2::transfer::public_transfer<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::DepositReceipt>(v2, 0x2::tx_context::sender(arg20));
        0x2::transfer::public_share_object<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(v3);
        0x2::transfer::public_share_object<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(v4);
        0x2::transfer::public_share_object<Raffle>(v5);
    }

    public entry fun create_token_raffle(arg0: &mut RaffleRegistry, arg1: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::fee_manager::FeeManager, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(arg12 > 0, 8);
        assert!(arg11 <= arg10, 9);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::fee_manager::process_creation_fee(arg1, arg3, 0x2::object::id_from_address(@0x0), v0, arg14);
        let (v1, v2) = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::create_token_vault(arg2, 0x1::string::utf8(arg7), 0x1::string::utf8(arg8), v0, arg14);
        let v3 = v1;
        let v4 = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::create_ticket_manager(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(&v3), arg9, arg10, arg14);
        let v5 = Raffle{
            id                   : 0x2::object::new(arg14),
            creator              : 0x2::tx_context::sender(arg14),
            name                 : 0x1::string::utf8(arg4),
            description          : 0x1::string::utf8(arg5),
            image_url            : 0x1::string::utf8(arg6),
            min_tickets          : arg11,
            creation_time        : v0,
            end_time             : v0 + arg12,
            is_active            : true,
            winner               : 0x1::option::none<address>(),
            winner_ticket_number : 0x1::option::none<u64>(),
            vault_id             : 0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(&v3),
            ticket_manager_id    : 0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(&v4),
        };
        let v6 = 0x2::object::id<Raffle>(&v5);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_raffles, v6);
        arg0.total_raffles_created = arg0.total_raffles_created + 1;
        let v7 = RaffleCreated{
            raffle_id    : v6,
            creator      : 0x2::tx_context::sender(arg14),
            prize_type   : 0x1::string::utf8(b"TOKEN"),
            prize_name   : 0x1::string::utf8(arg7),
            name         : 0x1::string::utf8(arg4),
            ticket_price : arg9,
            max_tickets  : arg10,
            min_tickets  : arg11,
            end_time     : v0 + arg12,
        };
        0x2::event::emit<RaffleCreated>(v7);
        0x2::transfer::public_transfer<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::DepositReceipt>(v2, 0x2::tx_context::sender(arg14));
        0x2::transfer::public_share_object<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(v3);
        0x2::transfer::public_share_object<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(v4);
        0x2::transfer::public_share_object<Raffle>(v5);
    }

    fun determine_winner(arg0: &0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : (address, u64) {
        let (_, _, _, _, _, v5, _, _) = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::get_manager_info(arg0);
        let v8 = 0x2::random::new_generator(arg1, arg2);
        let v9 = 0x2::random::generate_u64_in_range(&mut v8, 0, v5);
        (0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::find_ticket_owner(arg0, v9), v9)
    }

    public fun get_active_raffles(arg0: &RaffleRegistry) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x2::vec_set::into_keys<0x2::object::ID>(arg0.active_raffles);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_certificate_info(arg0: &WinnerCertificate) : (0x2::object::ID, 0x2::object::ID, address, u64) {
        (0x2::object::id<WinnerCertificate>(arg0), arg0.raffle_id, arg0.winner, arg0.winning_ticket)
    }

    public fun get_completed_raffles(arg0: &RaffleRegistry) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x2::vec_set::into_keys<0x2::object::ID>(arg0.completed_raffles);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_raffle_info(arg0: &Raffle) : (0x2::object::ID, address, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, bool, 0x1::option::Option<address>, 0x1::option::Option<u64>, 0x2::object::ID, 0x2::object::ID) {
        (0x2::object::id<Raffle>(arg0), arg0.creator, arg0.name, arg0.description, arg0.image_url, arg0.min_tickets, arg0.creation_time, arg0.end_time, arg0.is_active, arg0.winner, arg0.winner_ticket_number, arg0.vault_id, arg0.ticket_manager_id)
    }

    public fun get_registry_stats(arg0: &RaffleRegistry) : (u64, u64, u64, bool) {
        (arg0.total_raffles_created, 0x2::vec_set::size<0x2::object::ID>(&arg0.active_raffles), 0x2::vec_set::size<0x2::object::ID>(&arg0.completed_raffles), arg0.paused)
    }

    public fun has_met_min_tickets(arg0: &Raffle, arg1: &0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager) : bool {
        assert!(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(arg1) == arg0.ticket_manager_id, 12);
        let (_, _, _, _, _, v5, _, _) = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::get_manager_info(arg1);
        v5 >= arg0.min_tickets
    }

    fun init(arg0: RAFFLE_CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RAFFLE_CORE>(arg0, arg1);
        let v1 = 0x2::display::new<Raffle>(&v0, arg1);
        0x2::display::add<Raffle>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Raffle>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Raffle>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Raffle>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::update_version<Raffle>(&mut v1);
        let v2 = 0x2::display::new<WinnerCertificate>(&v0, arg1);
        0x2::display::add<WinnerCertificate>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Raffle Winner Certificate"));
        0x2::display::add<WinnerCertificate>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Certificate for winning raffle {raffle_id}"));
        0x2::display::add<WinnerCertificate>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://sui-raffles.io/winner-image/{raffle_id}"));
        0x2::display::update_version<WinnerCertificate>(&mut v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = RaffleRegistry{
            id                    : 0x2::object::new(arg1),
            active_raffles        : 0x2::vec_set::empty<0x2::object::ID>(),
            completed_raffles     : 0x2::vec_set::empty<0x2::object::ID>(),
            total_raffles_created : 0,
            paused                : false,
        };
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v5);
        0x2::transfer::public_transfer<0x2::display::Display<Raffle>>(v1, v5);
        0x2::transfer::public_transfer<0x2::display::Display<WinnerCertificate>>(v2, v5);
        0x2::transfer::public_transfer<AdminCap>(v3, v5);
        0x2::transfer::public_share_object<RaffleRegistry>(v4);
    }

    public entry fun process_refunds(arg0: &mut RaffleRegistry, arg1: &mut Raffle, arg2: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager, arg3: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault, arg4: 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::DepositReceipt, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) >= arg1.end_time, 3);
        assert!(arg1.is_active, 1);
        assert!(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(arg2) == arg1.ticket_manager_id, 12);
        assert!(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(arg3) == arg1.vault_id, 12);
        assert!(0x2::tx_context::sender(arg6) == arg1.creator, 7);
        let (_, _, _, _, _, v5, _, _) = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::get_manager_info(arg2);
        assert!(v5 < arg1.min_tickets, 10);
        0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::process_refunds(arg2, arg6);
        assert!(0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::get_prize_type(arg3) == 0x1::string::utf8(b"TOKEN"), 13);
        0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::reclaim_prize<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6);
        arg1.is_active = false;
        let v8 = 0x2::object::id<Raffle>(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.active_raffles, &v8)) {
            let v9 = 0x2::object::id<Raffle>(arg1);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_raffles, &v9);
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.completed_raffles, 0x2::object::id<Raffle>(arg1));
        };
        let v10 = RaffleCancelled{
            raffle_id : 0x2::object::id<Raffle>(arg1),
            creator   : arg1.creator,
            reason    : 0x1::string::utf8(b"Minimum tickets not met"),
        };
        0x2::event::emit<RaffleCancelled>(v10);
    }

    public entry fun select_winner(arg0: &mut RaffleRegistry, arg1: &mut Raffle, arg2: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager, arg3: &mut 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_active, 1);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg1.end_time, 3);
        assert!(0x1::option::is_none<address>(&arg1.winner), 5);
        assert!(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::TicketManager>(arg2) == arg1.ticket_manager_id, 12);
        assert!(0x2::object::id<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::PrizeVault>(arg3) == arg1.vault_id, 12);
        let (_, _, _, _, _, v5, _, _) = 0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::get_manager_info(arg2);
        assert!(v5 >= arg1.min_tickets, 4);
        let (v8, v9) = determine_winner(arg2, arg4, arg6);
        arg1.winner = 0x1::option::some<address>(v8);
        arg1.winner_ticket_number = 0x1::option::some<u64>(v9);
        arg1.is_active = false;
        let v10 = 0x2::object::id<Raffle>(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.active_raffles, &v10)) {
            let v11 = 0x2::object::id<Raffle>(arg1);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_raffles, &v11);
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.completed_raffles, 0x2::object::id<Raffle>(arg1));
        };
        0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::ticket_manager::deactivate(arg2, arg6);
        let v12 = WinnerCertificate{
            id             : 0x2::object::new(arg6),
            raffle_id      : 0x2::object::id<Raffle>(arg1),
            winner         : v8,
            winning_ticket : v9,
        };
        let v13 = WinnerSelected{
            raffle_id      : 0x2::object::id<Raffle>(arg1),
            winner         : v8,
            tickets_sold   : v5,
            winning_ticket : v9,
        };
        0x2::event::emit<WinnerSelected>(v13);
        0x2::transfer::public_transfer<WinnerCertificate>(v12, v8);
        0x2::transfer::public_transfer<0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::ClaimTicket>(0x631127646e506f2042d067549bd88cb00a4a17c362b2132908fab3dad7b3e6c0::prize_vault::issue_claim_ticket(arg3, v8, 0x2::clock::timestamp_ms(arg5), arg6), v8);
    }

    public entry fun toggle_system_pause(arg0: &mut RaffleRegistry, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.paused = arg2;
        let v0 = SystemPauseToggled{
            paused     : arg2,
            toggled_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SystemPauseToggled>(v0);
    }

    // decompiled from Move bytecode v6
}

