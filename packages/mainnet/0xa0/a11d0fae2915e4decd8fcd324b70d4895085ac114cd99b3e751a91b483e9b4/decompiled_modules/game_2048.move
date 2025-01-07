module 0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_2048 {
    struct GAME_2048 has drop {
        dummy_field: bool,
    }

    struct Game2048 has store, key {
        id: 0x2::object::UID,
        game: u64,
        player: address,
        active_board: 0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::GameBoard2048,
        move_count: u64,
        score: u64,
        top_tile: u64,
        game_over: bool,
    }

    struct GameMove2048 has store {
        direction: u64,
        player: address,
    }

    struct Game2048Maintainer has key {
        id: 0x2::object::UID,
        maintainer_address: address,
        game_count: u64,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct NewGameEvent2048 has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        score: u64,
        packed_spaces: u64,
    }

    struct GameMoveEvent2048 has copy, drop {
        game_id: 0x2::object::ID,
        direction: u64,
        move_count: u64,
        packed_spaces: u64,
        last_tile: vector<u64>,
        top_tile: u64,
        score: u64,
        game_over: bool,
    }

    struct GameOverEvent2048 has copy, drop {
        game_id: 0x2::object::ID,
        top_tile: u64,
        score: u64,
    }

    public fun active_board(arg0: &Game2048) : &0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::GameBoard2048 {
        &arg0.active_board
    }

    public entry fun change_fee(arg0: &mut Game2048Maintainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.fee = arg1;
    }

    public entry fun change_maintainer(arg0: &mut Game2048Maintainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.maintainer_address = arg1;
    }

    public entry fun create(arg0: &mut Game2048Maintainer, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = merge_and_split(arg1, arg0.fee, arg2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg2));
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::default(0x2::object::uid_to_bytes(&v3));
        let v5 = *0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::score(&v4);
        let v6 = Game2048{
            id           : v3,
            game         : arg0.game_count + 1,
            player       : v2,
            active_board : v4,
            move_count   : 0,
            score        : v5,
            top_tile     : *0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::top_tile(&v4),
            game_over    : false,
        };
        let v7 = NewGameEvent2048{
            game_id       : 0x2::object::uid_to_inner(&v6.id),
            player        : v2,
            score         : v5,
            packed_spaces : *0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::packed_spaces(&v4),
        };
        0x2::event::emit<NewGameEvent2048>(v7);
        arg0.game_count = arg0.game_count + 1;
        0x2::transfer::transfer<Game2048>(v6, v2);
    }

    public(friend) fun create_maintainer(arg0: &mut 0x2::tx_context::TxContext) : Game2048Maintainer {
        Game2048Maintainer{
            id                 : 0x2::object::new(arg0),
            maintainer_address : 0x2::tx_context::sender(arg0),
            game_count         : 0,
            fee                : 5000000000,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun id(arg0: &Game2048) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: GAME_2048, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui 2048"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://raw.githubusercontent.com/s2048/sui2048/main/images/{top_tile}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui 2048 is a 100% on-chain game. Play to airdrop!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://s2048.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui 2048"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://raw.githubusercontent.com/s2048/sui2048/main/logo/projects2048.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SUI2048"));
        let v4 = 0x2::package::claim<GAME_2048>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Game2048>(&v4, v0, v2, arg1);
        0x2::display::update_version<Game2048>(&mut v5);
        let v6 = create_maintainer(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Game2048>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Game2048Maintainer>(v6);
    }

    public entry fun make_move(arg0: &mut Game2048, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.active_board;
        let v1 = 0x2::object::new(arg2);
        0x2::object::delete(v1);
        0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::move_direction(&mut v0, arg1, 0x2::object::uid_to_bytes(&v1));
        let v2 = arg0.move_count + 1;
        let v3 = *0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::top_tile(&v0);
        let v4 = *0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::score(&v0);
        let v5 = *0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::game_over(&v0);
        let v6 = GameMoveEvent2048{
            game_id       : 0x2::object::uid_to_inner(&arg0.id),
            direction     : arg1,
            move_count    : v2,
            packed_spaces : *0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::packed_spaces(&v0),
            last_tile     : *0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::last_tile(&v0),
            top_tile      : v3,
            score         : v4,
            game_over     : v5,
        };
        0x2::event::emit<GameMoveEvent2048>(v6);
        if (v5) {
            let v7 = GameOverEvent2048{
                game_id  : 0x2::object::uid_to_inner(&arg0.id),
                top_tile : v3,
                score    : v4,
            };
            0x2::event::emit<GameOverEvent2048>(v7);
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

    public fun move_count(arg0: &Game2048) : &u64 {
        &arg0.move_count
    }

    public entry fun pay_maintainer(arg0: &mut Game2048Maintainer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.maintainer_address, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun player(arg0: &Game2048) : &address {
        &arg0.player
    }

    public fun score(arg0: &Game2048) : &u64 {
        0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::score(active_board(arg0))
    }

    public fun top_tile(arg0: &Game2048) : &u64 {
        0xa0a11d0fae2915e4decd8fcd324b70d4895085ac114cd99b3e751a91b483e9b4::game_board_2048::top_tile(active_board(arg0))
    }

    // decompiled from Move bytecode v6
}

