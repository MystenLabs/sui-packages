module 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::snl {
    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
    }

    struct CreateFeeCollectorEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        fee_collector_id: 0x2::object::ID,
    }

    struct CreateGameEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        game_id: 0x2::object::ID,
        round: u64,
        max_number: u16,
        min_number: u16,
        pay_fee_bp: u16,
        win_fee_bp: u16,
        ticket_price: u64,
        create_at: u64,
    }

    struct FinishGameCommitEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        game_id: 0x2::object::ID,
        win_number: u16,
        commit_end_at: u64,
    }

    struct FinishGameRevealEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        game_id: 0x2::object::ID,
        pool_balance: u64,
        winner_fee: u64,
        winner_ticket_number: u64,
        per_ticket_reward: u64,
        reveal_end_at: u64,
    }

    struct BuyTicketsEvent has copy, drop {
        tickets: vector<Ticket>,
        total_price: u64,
        game_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        buy_at: u64,
    }

    struct Ticket has copy, drop {
        ticket_id: 0x2::object::ID,
        signature: vector<u8>,
    }

    struct RevealTicketsEvent has copy, drop {
        ticket_ids: vector<0x2::object::ID>,
        game_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        owner: address,
        reveal_at: u64,
    }

    entry fun claim_fees<T0>(arg0: &0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin::AdminCap, arg1: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::FeeCollector<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::claim_fees<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun buy_tickets<T0>(arg0: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>, arg1: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::FeeCollector<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_version<T0>(arg0) == 1, 13);
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::get_version<T0>(arg1) == 1, 13);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 > 0, 12);
        let v1 = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_ticket_price<T0>(arg0) * v0;
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 8);
        let v2 = 0x2::coin::into_balance<T0>(arg2);
        let v3 = 0;
        let v4 = 0x1::vector::empty<Ticket>();
        while (v3 < v0) {
            let v5 = 0x1::vector::borrow<vector<u8>>(&arg3, v3);
            assert!(0x1::vector::length<u8>(v5) == 97, 10);
            let v6 = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::create_ticket_commit<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_ticket_price<T0>(arg0)), arg5), *v5, arg5);
            let v7 = Ticket{
                ticket_id : 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&v6),
                signature : *v5,
            };
            0x1::vector::push_back<Ticket>(&mut v4, v7);
            0x2::transfer::public_transfer<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(v6, 0x2::tx_context::sender(arg5));
            v3 = v3 + 1;
        };
        let v8 = BuyTicketsEvent{
            tickets     : v4,
            total_price : v1,
            game_id     : 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>>(arg0),
            coin_type   : 0x1::type_name::get<T0>(),
            buy_at      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BuyTicketsEvent>(v8);
        if (0x2::balance::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
    }

    public entry fun buy_tickets_zklogin<T0>(arg0: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>, arg1: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::FeeCollector<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<vector<u8>>, arg4: u256, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_reveal::check_zk_login_issuer(0x2::tx_context::sender(arg7), arg4, &arg5), 14);
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_version<T0>(arg0) == 1, 13);
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::get_version<T0>(arg1) == 1, 13);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 > 0, 12);
        let v1 = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_ticket_price<T0>(arg0) * v0;
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 8);
        let v2 = 0x2::coin::into_balance<T0>(arg2);
        let v3 = 0;
        let v4 = 0x1::vector::empty<Ticket>();
        while (v3 < v0) {
            let v5 = 0x1::vector::borrow<vector<u8>>(&arg3, v3);
            assert!(0x1::vector::length<u8>(v5) == 97, 10);
            let v6 = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::create_ticket_commit<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_ticket_price<T0>(arg0)), arg7), *v5, arg7);
            let v7 = Ticket{
                ticket_id : 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&v6),
                signature : *v5,
            };
            0x1::vector::push_back<Ticket>(&mut v4, v7);
            0x2::transfer::public_transfer<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(v6, 0x2::tx_context::sender(arg7));
            v3 = v3 + 1;
        };
        let v8 = BuyTicketsEvent{
            tickets     : v4,
            total_price : v1,
            game_id     : 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>>(arg0),
            coin_type   : 0x1::type_name::get<T0>(),
            buy_at      : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<BuyTicketsEvent>(v8);
        if (0x2::balance::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
    }

    public entry fun create_counter<T0>(arg0: &0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::counter::Counter<T0>>(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::counter::new<T0>(arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun create_fee_collector<T0>(arg0: &0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::new<T0>(1, arg1);
        0x2::transfer::public_share_object<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::FeeCollector<T0>>(v0);
        let v1 = CreateFeeCollectorEvent{
            coin_type        : 0x1::type_name::get<T0>(),
            fee_collector_id : 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::FeeCollector<T0>>(&v0),
        };
        0x2::event::emit<CreateFeeCollectorEvent>(v1);
    }

    public entry fun create_game<T0>(arg0: &0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin::AdminCap, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u64, arg6: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::counter::Counter<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::new_and_shared<T0>(1, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = CreateGameEvent{
            coin_type    : 0x1::type_name::get<T0>(),
            game_id      : v0,
            round        : 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::counter::get_count<T0>(arg6),
            max_number   : arg1,
            min_number   : arg2,
            pay_fee_bp   : arg3,
            win_fee_bp   : arg4,
            ticket_price : arg5,
            create_at    : v1,
        };
        0x2::event::emit<CreateGameEvent>(v2);
    }

    entry fun finish_game_commit<T0>(arg0: &0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin::AdminCap, arg1: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_version<T0>(arg1) == 1, 13);
        0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::create_random_winner_number<T0>(arg1, arg2, arg3, arg4);
        let v0 = FinishGameCommitEvent{
            coin_type     : 0x1::type_name::get<T0>(),
            game_id       : 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>>(arg1),
            win_number    : 0x1::option::destroy_some<u16>(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_win_number<T0>(arg1)),
            commit_end_at : 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_commit_end_time<T0>(arg1),
        };
        0x2::event::emit<FinishGameCommitEvent>(v0);
    }

    entry fun finish_game_reveal<T0>(arg0: &0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin::AdminCap, arg1: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>, arg2: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::FeeCollector<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_version<T0>(arg1) == 1, 13);
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::get_version<T0>(arg2) == 1, 13);
        0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::add_pool_balance<T0>(arg1, 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::claim_last_round_pool_balance<T0>(arg2, arg4));
        if (0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_total_winner_ticket_num<T0>(arg1) > 0) {
            let (v0, v1) = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::to_happy_end_state<T0>(arg1, arg2, arg3, arg4);
            let v2 = FinishGameRevealEvent{
                coin_type            : 0x1::type_name::get<T0>(),
                game_id              : 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>>(arg1),
                pool_balance         : 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_total_balance<T0>(arg1),
                winner_fee           : v0,
                winner_ticket_number : 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_total_winner_ticket_num<T0>(arg1),
                per_ticket_reward    : v1,
                reveal_end_at        : 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_reveal_end_time<T0>(arg1),
            };
            0x2::event::emit<FinishGameRevealEvent>(v2);
        } else {
            0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::to_sad_end_state<T0>(arg1, arg2, arg3, arg4);
            let v3 = FinishGameRevealEvent{
                coin_type            : 0x1::type_name::get<T0>(),
                game_id              : 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>>(arg1),
                pool_balance         : 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_total_balance<T0>(arg1),
                winner_fee           : 0,
                winner_ticket_number : 0,
                per_ticket_reward    : 0,
                reveal_end_at        : 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_reveal_end_time<T0>(arg1),
            };
            0x2::event::emit<FinishGameRevealEvent>(v3);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin::new(arg0);
        0x2::transfer::public_transfer<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin::AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = InitEvent{admin_cap_id: 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin::AdminCap>(&v0)};
        0x2::event::emit<InitEvent>(v1);
    }

    entry fun migrate<T0>(arg0: &0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin::AdminCap, arg1: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>, arg2: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::FeeCollector<T0>) {
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_version<T0>(arg1) < 1, 13);
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::get_version<T0>(arg2) < 1, 13);
        0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::set_version<T0>(arg1, 1);
        0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::fee_collector::set_version<T0>(arg2, 1);
    }

    public entry fun reveal_tickets<T0>(arg0: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>, arg1: vector<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_version<T0>(arg0) == 1, 13);
        assert!(0x1::string::length(&arg2) <= 64, 11);
        assert!(0x1::vector::length<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&arg1) > 0, 12);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::length<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&arg1);
        while (v1 < v3) {
            let v4 = v3 - v1 - 1;
            assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::get_game_id(0x1::vector::borrow<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&arg1, v4)) == 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>>(arg0), 9);
            let v5 = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_message<T0>(arg0, arg2);
            let v6 = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::get_signature(0x1::vector::borrow<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&arg1, v4));
            if (0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_reveal::verify_personal_message_signature(&v6, &v5, v0)) {
                0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::add_winner<T0>(arg0, v0);
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(0x1::vector::borrow<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&arg1, v4)));
            0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::burn_ticket_commit(0x1::vector::pop_back<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&mut arg1));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(arg1);
        let v7 = RevealTicketsEvent{
            ticket_ids : v2,
            game_id    : 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>>(arg0),
            coin_type  : 0x1::type_name::get<T0>(),
            owner      : v0,
            reveal_at  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RevealTicketsEvent>(v7);
    }

    public entry fun reveal_tickets_v2<T0>(arg0: &mut 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>, arg1: vector<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_version<T0>(arg0) == 1, 13);
        assert!(0x1::string::length(&arg2) <= 64, 11);
        assert!(0x1::vector::length<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&arg1) > 0, 12);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::length<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&arg1);
        while (v1 < v3) {
            let v4 = v3 - v1 - 1;
            assert!(0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::get_game_id(0x1::vector::borrow<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&arg1, v4)) == 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>>(arg0), 9);
            let v5 = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::get_message<T0>(arg0, arg2);
            let v6 = 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::get_signature(0x1::vector::borrow<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&arg1, v4));
            if (0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_reveal::verify_personal_message_signature_for_zk_login_inner(&v6, &v5)) {
                0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::add_winner<T0>(arg0, v0);
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(0x1::vector::borrow<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&arg1, v4)));
            0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::burn_ticket_commit(0x1::vector::pop_back<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(&mut arg1));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::ticket_commit::TicketCommit>(arg1);
        let v7 = RevealTicketsEvent{
            ticket_ids : v2,
            game_id    : 0x2::object::id<0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::game::Game<T0>>(arg0),
            coin_type  : 0x1::type_name::get<T0>(),
            owner      : v0,
            reveal_at  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RevealTicketsEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

