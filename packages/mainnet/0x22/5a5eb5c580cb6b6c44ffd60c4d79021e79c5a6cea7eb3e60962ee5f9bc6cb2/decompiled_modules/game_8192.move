module 0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_8192 {
    struct GAME_8192 has drop {
        dummy_field: bool,
    }

    struct Game8192 has store, key {
        id: 0x2::object::UID,
        game: u64,
        player: address,
        active_board: 0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::GameBoard8192,
        move_count: u64,
        score: u64,
        top_tile: u64,
        game_over: bool,
    }

    struct GameMove8192 has store {
        direction: u64,
        player: address,
    }

    struct Game8192Maintainer has key {
        id: 0x2::object::UID,
        maintainer_address: address,
        game_count: u64,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct NewGameEvent8192 has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        score: u64,
        packed_spaces: u64,
    }

    struct GameMoveEvent8192 has copy, drop {
        game_id: 0x2::object::ID,
        direction: u64,
        move_count: u64,
        packed_spaces: u64,
        last_tile: vector<u64>,
        top_tile: u64,
        score: u64,
        game_over: bool,
    }

    struct GameOverEvent8192 has copy, drop {
        game_id: 0x2::object::ID,
        top_tile: u64,
        score: u64,
    }

    public fun active_board(arg0: &Game8192) : &0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::GameBoard8192 {
        &arg0.active_board
    }

    public entry fun change_fee(arg0: &mut Game8192Maintainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.fee = arg1;
    }

    public entry fun change_maintainer(arg0: &mut Game8192Maintainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.maintainer_address = arg1;
    }

    public entry fun create(arg0: &mut Game8192Maintainer, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = merge_and_split(arg1, arg0.fee, arg2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg2));
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::default(0x2::object::uid_to_bytes(&v3));
        let v5 = *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::score(&v4);
        let v6 = Game8192{
            id           : v3,
            game         : arg0.game_count + 1,
            player       : v2,
            active_board : v4,
            move_count   : 0,
            score        : v5,
            top_tile     : *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::top_tile(&v4),
            game_over    : false,
        };
        let v7 = NewGameEvent8192{
            game_id       : 0x2::object::uid_to_inner(&v6.id),
            player        : v2,
            score         : v5,
            packed_spaces : *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::packed_spaces(&v4),
        };
        0x2::event::emit<NewGameEvent8192>(v7);
        arg0.game_count = arg0.game_count + 1;
        0x2::transfer::transfer<Game8192>(v6, v2);
    }

    public(friend) fun create_maintainer(arg0: &mut 0x2::tx_context::TxContext) : Game8192Maintainer {
        Game8192Maintainer{
            id                 : 0x2::object::new(arg0),
            maintainer_address : 0x2::tx_context::sender(arg0),
            game_count         : 0,
            fee                : 200000000,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun id(arg0: &Game8192) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: GAME_8192, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui 8192"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui8192.s3.amazonaws.com/{top_tile}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui 8192 is a fun, 100% on-chain game. Combine the tiles to get a high score!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ethoswallet.github.io/Sui8192/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui 8192"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui8192.s3.amazonaws.com/sui-8192.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ethos"));
        let v4 = 0x2::package::claim<GAME_8192>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Game8192>(&v4, v0, v2, arg1);
        0x2::display::update_version<Game8192>(&mut v5);
        let v6 = create_maintainer(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Game8192>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Game8192Maintainer>(v6);
    }

    public entry fun make_move(arg0: &mut Game8192, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.active_board;
        let v1 = 0x2::object::new(arg2);
        0x2::object::delete(v1);
        0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::move_direction(&mut v0, arg1, 0x2::object::uid_to_bytes(&v1));
        let v2 = arg0.move_count + 1;
        let v3 = *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::top_tile(&v0);
        let v4 = *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::score(&v0);
        let v5 = *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::game_over(&v0);
        let v6 = GameMoveEvent8192{
            game_id       : 0x2::object::uid_to_inner(&arg0.id),
            direction     : arg1,
            move_count    : v2,
            packed_spaces : *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::packed_spaces(&v0),
            last_tile     : *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::last_tile(&v0),
            top_tile      : v3,
            score         : v4,
            game_over     : v5,
        };
        0x2::event::emit<GameMoveEvent8192>(v6);
        if (v5) {
            let v7 = GameOverEvent8192{
                game_id  : 0x2::object::uid_to_inner(&arg0.id),
                top_tile : v3,
                score    : v4,
            };
            0x2::event::emit<GameOverEvent8192>(v7);
        };
        arg0.move_count = v2;
        arg0.active_board = v0;
        arg0.score = v4;
        arg0.top_tile = v3;
        arg0.game_over = v5;
    }

    fun merge_and_split(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg1, v1);
        (0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1, arg2), v0)
    }

    public fun move_count(arg0: &Game8192) : &u64 {
        &arg0.move_count
    }

    public entry fun pay_maintainer(arg0: &mut Game8192Maintainer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.maintainer_address, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun player(arg0: &Game8192) : &address {
        &arg0.player
    }

    public fun score(arg0: &Game8192) : &u64 {
        0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::score(active_board(arg0))
    }

    public fun top_tile(arg0: &Game8192) : &u64 {
        0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192::top_tile(active_board(arg0))
    }

    // decompiled from Move bytecode v6
}

