module 0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::street_gambit {
    struct PlayerState has key {
        id: 0x2::object::UID,
        player: 0x2::table::Table<address, vector<u8>>,
    }

    struct GameStartedEvent has copy, drop {
        player: address,
        card1: u8,
        card2: u8,
        timestamp: u64,
    }

    struct GameResultEvent has copy, drop {
        player: address,
        card1: u8,
        card2: u8,
        middle_card: u8,
        guess_value: bool,
        has_won: bool,
        points_earned: u64,
    }

    fun generate_cards(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : (u8, u8) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 13);
        let v2 = if (v1 <= 2) {
            0x2::random::generate_u8_in_range(&mut v0, v1 + 2, 13)
        } else if (v1 >= 11) {
            0x2::random::generate_u8_in_range(&mut v0, 1, v1 - 2)
        } else if (0x2::random::generate_u8_in_range(&mut v0, 0, 1) == 0) {
            0x2::random::generate_u8_in_range(&mut v0, 1, v1 - 2)
        } else {
            0x2::random::generate_u8_in_range(&mut v0, v1 + 2, 13)
        };
        if (v1 > v2) {
            (v2, v1)
        } else {
            (v1, v2)
        }
    }

    fun generate_middle_card(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u8_in_range(&mut v0, 1, 13)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerState{
            id     : 0x2::object::new(arg0),
            player : 0x2::table::new<address, vector<u8>>(arg0),
        };
        0x2::transfer::share_object<PlayerState>(v0);
    }

    entry fun make_bet(arg0: &mut 0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::QuestRegistry, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg2: &mut PlayerState, arg3: bool, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg1, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, vector<u8>>(&arg2.player, v0), 0);
        let v1 = 0x2::table::remove<address, vector<u8>>(&mut arg2.player, v0);
        let v2 = *0x1::vector::borrow<u8>(&v1, 0);
        let v3 = *0x1::vector::borrow<u8>(&v1, 1);
        let v4 = generate_middle_card(arg4, arg5);
        let v5 = v4 > v2 && v4 < v3;
        let v6 = v5;
        let v7 = if (v5 == arg3) {
            v6 = true;
            0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::get_earn_point(arg0)
        } else {
            0
        };
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::add_current_quest_point(arg0, (v7 as u64));
        let v8 = GameResultEvent{
            player        : v0,
            card1         : v2,
            card2         : v3,
            middle_card   : v4,
            guess_value   : arg3,
            has_won       : v6,
            points_earned : v7,
        };
        0x2::event::emit<GameResultEvent>(v8);
    }

    entry fun start_game(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::QuestRegistry, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg2: &mut 0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::QuestTicket, arg3: &mut PlayerState, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg1, 1);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::validate_quest_status(arg0);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::decrease_ticket_count(arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = generate_cards(arg5, arg6);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = &mut v3;
        0x1::vector::push_back<u8>(v4, v1);
        0x1::vector::push_back<u8>(v4, v2);
        0x2::table::add<address, vector<u8>>(&mut arg3.player, 0x2::tx_context::sender(arg6), v3);
        let v5 = GameStartedEvent{
            player    : v0,
            card1     : v1,
            card2     : v2,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<GameStartedEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

