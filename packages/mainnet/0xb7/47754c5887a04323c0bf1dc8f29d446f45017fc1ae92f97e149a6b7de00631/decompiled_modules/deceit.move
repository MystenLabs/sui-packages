module 0xb747754c5887a04323c0bf1dc8f29d446f45017fc1ae92f97e149a6b7de00631::deceit {
    struct State has key {
        id: 0x2::object::UID,
        score: 0x2::table::Table<address, u256>,
        game_records: 0x2::table::Table<u64, Game>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Player has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        user_add: address,
        prompt: 0x1::string::String,
    }

    struct Game has store {
        name: 0x1::string::String,
        responses: 0x1::option::Option<0x1::string::String>,
        players: vector<address>,
        winners: vector<address>,
    }

    struct GameCreated has copy, drop {
        name: 0x1::string::String,
        game_id: u64,
        players: vector<address>,
    }

    struct GameConcluded has copy, drop {
        name: 0x1::string::String,
        game_id: u64,
        winners: vector<address>,
    }

    public entry fun edit_prompt(arg0: &mut Player, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.prompt = arg1;
    }

    entry fun game_concluded(arg0: u64, arg1: 0x1::string::String, arg2: u64, arg3: vector<address>, arg4: &AdminCap, arg5: &mut 0x2::coin::TreasuryCap<0xb747754c5887a04323c0bf1dc8f29d446f45017fc1ae92f97e149a6b7de00631::gold::GOLD>, arg6: &mut State, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Game>(&mut arg6.game_records, arg0);
        v0.responses = 0x1::option::some<0x1::string::String>(arg1);
        v0.winners = arg3;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = *0x1::vector::borrow<address>(&arg3, v1);
            let v3 = 0x2::table::borrow_mut<address, u256>(&mut arg6.score, v2);
            *v3 = *v3 + 1;
            0xb747754c5887a04323c0bf1dc8f29d446f45017fc1ae92f97e149a6b7de00631::gold::mint(arg5, arg2, v2, arg7);
            v1 = v1 + 1;
        };
        let v4 = GameConcluded{
            name    : v0.name,
            game_id : arg0,
            winners : arg3,
        };
        0x2::event::emit<GameConcluded>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id           : 0x2::object::new(arg0),
            score        : 0x2::table::new<address, u256>(arg0),
            game_records : 0x2::table::new<u64, Game>(arg0),
        };
        0x2::transfer::share_object<State>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_player(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Player{
            id       : 0x2::object::new(arg2),
            name     : arg0,
            user_add : v0,
            prompt   : arg1,
        };
        0x2::transfer::transfer<Player>(v1, v0);
    }

    entry fun start_game(arg0: 0x1::string::String, arg1: vector<address>, arg2: &AdminCap, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            name      : arg0,
            responses : 0x1::option::none<0x1::string::String>(),
            players   : arg1,
            winners   : 0x1::vector::empty<address>(),
        };
        let v1 = 0x2::table::length<u64, Game>(&arg3.game_records);
        0x2::table::add<u64, Game>(&mut arg3.game_records, v1, v0);
        let v2 = GameCreated{
            name    : arg0,
            game_id : v1,
            players : arg1,
        };
        0x2::event::emit<GameCreated>(v2);
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

