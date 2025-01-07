module 0x496748d4d94c241583d915fb6e81f52601dc2c813af3d5e9584d5643d69f1afd::nfticketdraw {
    struct Game has key {
        id: 0x2::object::UID,
        cost_in_coin: u64,
        participants: u32,
        end_time: u64,
        winner: 0x1::option::Option<u32>,
        balance: 0x2::balance::Balance<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>,
    }

    struct Ticket has key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        participant_index: u32,
    }

    struct GameCreated has copy, drop {
        game_id: 0x2::object::ID,
        end_time: u64,
        cost_in_coin: u64,
    }

    struct TicketPurchased has copy, drop {
        game_id: 0x2::object::ID,
        participant_index: u32,
        ticket_id: 0x2::object::ID,
    }

    struct WinnerDetermined has copy, drop {
        game_id: 0x2::object::ID,
        winner_index: u32,
    }

    struct RewardRedeemed has copy, drop {
        game_id: 0x2::object::ID,
        participant_index: u32,
        amount: u64,
    }

    public fun buy_ticket(arg0: &mut Game, arg1: 0x2::coin::Coin<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Ticket {
        assert!(arg0.end_time > 0x2::clock::timestamp_ms(arg2), 1);
        assert!(0x2::coin::value<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(&arg1) == arg0.cost_in_coin, 2);
        arg0.participants = arg0.participants + 1;
        0x2::coin::put<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(&mut arg0.balance, arg1);
        let v0 = Ticket{
            id                : 0x2::object::new(arg3),
            game_id           : 0x2::object::id<Game>(arg0),
            participant_index : arg0.participants,
        };
        let v1 = TicketPurchased{
            game_id           : 0x2::object::id<Game>(arg0),
            participant_index : v0.participant_index,
            ticket_id         : 0x2::object::id<Ticket>(&v0),
        };
        0x2::event::emit<TicketPurchased>(v1);
        v0
    }

    public fun create(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id           : 0x2::object::new(arg2),
            cost_in_coin : arg1,
            participants : 0,
            end_time     : arg0,
            winner       : 0x1::option::none<u32>(),
            balance      : 0x2::balance::zero<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(),
        };
        let v1 = GameCreated{
            game_id      : 0x2::object::id<Game>(&v0),
            end_time     : arg0,
            cost_in_coin : arg1,
        };
        0x2::event::emit<GameCreated>(v1);
        0x2::transfer::share_object<Game>(v0);
    }

    public fun destroy_ticket(arg0: Ticket) {
        let Ticket {
            id                : v0,
            game_id           : _,
            participant_index : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun determine_winner(arg0: &mut Game, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_time <= 0x2::clock::timestamp_ms(arg2), 0);
        assert!(0x1::option::is_none<u32>(&arg0.winner), 1);
        assert!(arg0.participants > 0, 5);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let v1 = 0x2::random::generate_u32_in_range(&mut v0, 1, arg0.participants);
        arg0.winner = 0x1::option::some<u32>(v1);
        let v2 = WinnerDetermined{
            game_id      : 0x2::object::id<Game>(arg0),
            winner_index : v1,
        };
        0x2::event::emit<WinnerDetermined>(v2);
    }

    public fun redeem(arg0: Ticket, arg1: Game, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN> {
        assert!(0x2::object::id<Game>(&arg1) == arg0.game_id, 3);
        assert!(0x1::option::contains<u32>(&arg1.winner, &arg0.participant_index), 4);
        destroy_ticket(arg0);
        let Game {
            id           : v0,
            cost_in_coin : _,
            participants : _,
            end_time     : _,
            winner       : _,
            balance      : v5,
        } = arg1;
        0x2::object::delete(v0);
        let v6 = RewardRedeemed{
            game_id           : 0x2::object::id<Game>(&arg1),
            participant_index : arg0.participant_index,
            amount            : 0x2::balance::value<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(&arg1.balance),
        };
        0x2::event::emit<RewardRedeemed>(v6);
        0x2::coin::from_balance<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(v5, arg2)
    }

    // decompiled from Move bytecode v6
}

