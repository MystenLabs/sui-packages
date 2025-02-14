module 0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::between_cards {
    struct GameState has key {
        id: 0x2::object::UID,
        player_states: 0x2::table::Table<address, PlayerState>,
        paused: bool,
    }

    struct PlayerState has store {
        lives: u8,
        cooldown_start: u64,
        current_game: 0x1::option::Option<CurrentGame>,
        total_points: u64,
    }

    struct CurrentGame has drop, store {
        card1: u8,
        card2: u8,
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
        bet_between: bool,
        won: bool,
        points_earned: u64,
        lives_remaining: u8,
        total_points: u64,
        timestamp: u64,
    }

    struct CooldownStartedEvent has copy, drop {
        player: address,
        start_time: u64,
        end_time: u64,
    }

    struct GamePausedEvent has copy, drop {
        timestamp: u64,
    }

    struct GameResumedEvent has copy, drop {
        timestamp: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun emergency_pause(arg0: &AdminCap, arg1: &0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::version::Version, arg2: &mut GameState, arg3: &0x2::clock::Clock) {
        0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::version::check_version(arg1, 1);
        assert!(!arg2.paused, 5);
        arg2.paused = true;
        let v0 = GamePausedEvent{timestamp: 0x2::clock::timestamp_ms(arg3)};
        0x2::event::emit<GamePausedEvent>(v0);
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

    public fun get_player_state(arg0: &0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::version::Version, arg1: &GameState, arg2: address) : (u8, u64, 0x1::option::Option<CurrentGame>, u64) {
        0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::version::check_version(arg0, 1);
        if (!0x2::table::contains<address, PlayerState>(&arg1.player_states, arg2)) {
            return (3, 0, 0x1::option::none<CurrentGame>(), 0)
        };
        let v0 = 0x2::table::borrow<address, PlayerState>(&arg1.player_states, arg2);
        let v1 = if (0x1::option::is_some<CurrentGame>(&v0.current_game)) {
            let v2 = 0x1::option::borrow<CurrentGame>(&v0.current_game);
            let v3 = CurrentGame{
                card1 : v2.card1,
                card2 : v2.card2,
            };
            0x1::option::some<CurrentGame>(v3)
        } else {
            0x1::option::none<CurrentGame>()
        };
        (v0.lives, v0.cooldown_start, v1, v0.total_points)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameState{
            id            : 0x2::object::new(arg0),
            player_states : 0x2::table::new<address, PlayerState>(arg0),
            paused        : false,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GameState>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun make_bet(arg0: &0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::version::Version, arg1: &mut GameState, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::version::check_version(arg0, 1);
        assert!(!arg1.paused, 4);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, PlayerState>(&arg1.player_states, v0), 7);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::table::borrow_mut<address, PlayerState>(&mut arg1.player_states, v0);
        assert!(0x1::option::is_some<CurrentGame>(&v2.current_game), 2);
        let v3 = 0x1::option::extract<CurrentGame>(&mut v2.current_game);
        let v4 = generate_middle_card(arg4, arg5);
        let v5 = v4 > v3.card1 && v4 < v3.card2;
        let v6 = arg2 == v5;
        let v7 = if (v6) {
            5
        } else {
            0
        };
        if (v6) {
            v2.total_points = v2.total_points + v7;
        };
        if (!v6) {
            v2.lives = v2.lives - 1;
            if (v2.lives == 0) {
                v2.cooldown_start = v1;
                let v8 = CooldownStartedEvent{
                    player     : v0,
                    start_time : v1,
                    end_time   : v1 + 86400000,
                };
                0x2::event::emit<CooldownStartedEvent>(v8);
            };
        };
        let v9 = GameResultEvent{
            player          : v0,
            card1           : v3.card1,
            card2           : v3.card2,
            middle_card     : v4,
            bet_between     : arg2,
            won             : v6,
            points_earned   : v7,
            lives_remaining : v2.lives,
            total_points    : v2.total_points,
            timestamp       : v1,
        };
        0x2::event::emit<GameResultEvent>(v9);
    }

    public fun resume_game(arg0: &AdminCap, arg1: &0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::version::Version, arg2: &mut GameState, arg3: &0x2::clock::Clock) {
        0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::version::check_version(arg1, 1);
        assert!(arg2.paused, 6);
        arg2.paused = false;
        let v0 = GameResumedEvent{timestamp: 0x2::clock::timestamp_ms(arg3)};
        0x2::event::emit<GameResumedEvent>(v0);
    }

    public fun start_game(arg0: &0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::version::Version, arg1: &mut GameState, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        0x5addb57e7192457ca915cf5634288666b0c5b8ecf34cd9506d1bef3a3cee9780::version::check_version(arg0, 1);
        assert!(arg1.paused == false, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (!0x2::table::contains<address, PlayerState>(&arg1.player_states, v0)) {
            let v2 = PlayerState{
                lives          : 3,
                cooldown_start : 0,
                current_game   : 0x1::option::none<CurrentGame>(),
                total_points   : 0,
            };
            0x2::table::add<address, PlayerState>(&mut arg1.player_states, v0, v2);
        };
        let v3 = 0x2::table::borrow_mut<address, PlayerState>(&mut arg1.player_states, v0);
        if (v3.lives == 0) {
            assert!(v1 >= v3.cooldown_start + 86400000, 3);
            v3.lives = 3;
            v3.cooldown_start = 0;
        };
        assert!(v3.lives > 0, 0);
        assert!(0x1::option::is_none<CurrentGame>(&v3.current_game), 1);
        let (v4, v5) = generate_cards(arg3, arg4);
        let v6 = CurrentGame{
            card1 : v4,
            card2 : v5,
        };
        v3.current_game = 0x1::option::some<CurrentGame>(v6);
        let v7 = GameStartedEvent{
            player    : v0,
            card1     : v4,
            card2     : v5,
            timestamp : v1,
        };
        0x2::event::emit<GameStartedEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

