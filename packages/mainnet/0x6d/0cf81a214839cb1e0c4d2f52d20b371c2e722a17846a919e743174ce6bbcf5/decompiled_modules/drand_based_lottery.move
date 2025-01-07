module 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::drand_based_lottery {
    struct Game has store, key {
        id: 0x2::object::UID,
        round: u64,
        status: u8,
        participants: u64,
        winner: 0x1::option::Option<u64>,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        participant_index: u64,
    }

    struct GameWinner has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
    }

    public entry fun close(arg0: &mut Game, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(arg0.status == 0, 0);
        0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::drand_lib::verify_drand_signature(arg1, arg2, closing_round(arg0.round));
        arg0.status = 1;
    }

    fun closing_round(arg0: u64) : u64 {
        arg0 - 2
    }

    public entry fun complete(arg0: &mut Game, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(arg0.status != 2, 1);
        0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::drand_lib::verify_drand_signature(arg1, arg2, arg0.round);
        arg0.status = 2;
        let v0 = 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::drand_lib::derive_randomness(arg1);
        arg0.winner = 0x1::option::some<u64>(0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::drand_lib::safe_selection(arg0.participants, &v0));
    }

    public entry fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id           : 0x2::object::new(arg1),
            round        : arg0,
            status       : 0,
            participants : 0,
            winner       : 0x1::option::none<u64>(),
        };
        0x2::transfer::public_share_object<Game>(v0);
    }

    public entry fun delete_game_winner(arg0: GameWinner) {
        let GameWinner {
            id      : v0,
            game_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun delete_ticket(arg0: Ticket) {
        let Ticket {
            id                : v0,
            game_id           : _,
            participant_index : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_game_winner_game_id(arg0: &GameWinner) : &0x2::object::ID {
        &arg0.game_id
    }

    public fun get_ticket_game_id(arg0: &Ticket) : &0x2::object::ID {
        &arg0.game_id
    }

    public entry fun just_check_drand(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) {
        0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::drand_lib::verify_drand_signature(arg0, arg1, arg2);
    }

    public entry fun participate(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 0);
        let v0 = Ticket{
            id                : 0x2::object::new(arg1),
            game_id           : 0x2::object::id<Game>(arg0),
            participant_index : arg0.participants,
        };
        arg0.participants = arg0.participants + 1;
        0x2::transfer::public_transfer<Ticket>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun redeem(arg0: &Ticket, arg1: &Game, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Game>(arg1) == arg0.game_id, 3);
        assert!(0x1::option::contains<u64>(&arg1.winner, &arg0.participant_index), 3);
        let v0 = GameWinner{
            id      : 0x2::object::new(arg2),
            game_id : arg0.game_id,
        };
        0x2::transfer::public_transfer<GameWinner>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

