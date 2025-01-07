module 0x22e37d9361de781e50ee04f1c4670449ecc43e8b748fbe2f6e84b77dbde3796e::game {
    struct Logs has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        ended: bool,
        participants: u64,
        winner: 0x1::option::Option<address>,
    }

    struct GameJoined has copy, drop {
        string: 0x1::string::String,
        player: address,
        game: 0x2::object::ID,
    }

    struct GameWon has copy, drop {
        player: address,
        game: 0x2::object::ID,
    }

    public entry fun create_game(arg0: &mut Logs, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id           : 0x2::object::new(arg1),
            ended        : false,
            participants : 0,
            winner       : 0x1::option::none<address>(),
        };
        arg0.count = arg0.count + 1;
        0x2::transfer::share_object<Game>(v0);
    }

    public fun game_won(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameWon{
            player : 0x2::tx_context::sender(arg1),
            game   : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<GameWon>(v0);
        arg0.ended = true;
    }

    fun generate_name(arg0: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = vector[0, 1, 2, 3, 4];
        let v1 = 0x1::string::utf8(b"");
        while (0x1::vector::length<u64>(&v0) != 0) {
            let v2 = 0x1::vector::remove<u64>(&mut v0, 0x22e37d9361de781e50ee04f1c4670449ecc43e8b748fbe2f6e84b77dbde3796e::random::generate_number(0x1::vector::length<u64>(&v0), arg0));
            let v3 = 0x1::string::utf8(b"huisq");
            0x1::string::append(&mut v1, 0x1::string::sub_string(&v3, v2, v2 + 1));
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Logs{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::share_object<Logs>(v0);
    }

    public fun is_game_ended(arg0: &Game) : &bool {
        &arg0.ended
    }

    public entry fun join_game(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.ended, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = generate_name(arg1);
        let v2 = GameJoined{
            string : v1,
            player : v0,
            game   : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<GameJoined>(v2);
        arg0.participants = arg0.participants + 1;
        if (v1 == 0x1::string::utf8(b"huisq")) {
            game_won(arg0, arg1);
        };
    }

    public fun participants(arg0: &Game) : &u64 {
        &arg0.participants
    }

    public fun winner(arg0: &Game) : &address {
        0x1::option::borrow<address>(&arg0.winner)
    }

    // decompiled from Move bytecode v6
}

