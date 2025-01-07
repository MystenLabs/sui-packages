module 0xaedc995cdaf677ffffdb7ca184de0d167f47b502384977940c4420871c932b04::wolf_game {
    struct WOLF_GAME has drop {
        dummy_field: bool,
    }

    struct WolfGame has store, key {
        id: 0x2::object::UID,
        game: u64,
        player: address,
        type: 0x1::string::String,
        idx: u64,
    }

    struct WolfGameMaintainer has key {
        id: 0x2::object::UID,
        maintainer_address: address,
        game_count: u64,
        sheep_count: u64,
        wolf_count: u64,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        items: 0x2::object_table::ObjectTable<0x2::object::ID, WitnessCarrier>,
        timestamp: u64,
        exp_eta: u64,
        max_count: u64,
        min_gap: u64,
        status: u64,
    }

    struct NewGameEvent has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
    }

    struct WitnessCarrier has store, key {
        id: 0x2::object::UID,
        game: WolfGame,
        owner: address,
        timestamp: u64,
    }

    public fun id(arg0: &WolfGame) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public entry fun mint(arg0: &mut WolfGameMaintainer, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = merge_and_split(arg1, arg0.fee * arg3, arg4);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg4));
        assert!(arg0.status == 1, 1);
        let v2 = 0;
        while (v2 < arg3) {
            arg0.game_count = arg0.game_count + 1;
            if (arg2 == 0x1::string::utf8(b"sheep")) {
                let v3 = 0x2::tx_context::sender(arg4);
                arg0.sheep_count = arg0.sheep_count + 1;
                let v4 = WolfGame{
                    id     : 0x2::object::new(arg4),
                    game   : arg0.sheep_count + 1,
                    player : v3,
                    type   : arg2,
                    idx    : arg0.sheep_count + 1,
                };
                let v5 = NewGameEvent{
                    game_id : 0x2::object::uid_to_inner(&v4.id),
                    player  : v3,
                };
                0x2::event::emit<NewGameEvent>(v5);
                0x2::transfer::transfer<WolfGame>(v4, v3);
            };
            if (arg2 == 0x1::string::utf8(b"wolf")) {
                let v6 = 0x2::tx_context::sender(arg4);
                arg0.wolf_count = arg0.wolf_count + 1;
                let v7 = WolfGame{
                    id     : 0x2::object::new(arg4),
                    game   : arg0.wolf_count + 1,
                    player : v6,
                    type   : arg2,
                    idx    : arg0.wolf_count + 1,
                };
                let v8 = NewGameEvent{
                    game_id : 0x2::object::uid_to_inner(&v7.id),
                    player  : v6,
                };
                0x2::event::emit<NewGameEvent>(v8);
                0x2::transfer::transfer<WolfGame>(v7, v6);
            };
            v2 = v2 + 1;
        };
    }

    public entry fun add_to_stake(arg0: &mut WolfGameMaintainer, arg1: vector<WolfGame>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<WolfGame>(&arg1);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<WolfGame>(&mut arg1);
            assert!(0x2::tx_context::sender(arg3) == v1.player, 1);
            let v2 = WitnessCarrier{
                id        : 0x2::object::new(arg3),
                game      : v1,
                owner     : 0x2::tx_context::sender(arg3),
                timestamp : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::object_table::add<0x2::object::ID, WitnessCarrier>(&mut arg0.items, 0x2::object::id<WolfGame>(&v1), v2);
            let v3 = &mut arg0.id;
            record_staked(v3, 0x2::tx_context::sender(arg3), 0x2::object::id<WitnessCarrier>(&v2));
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<WolfGame>(arg1);
    }

    public entry fun change_exp_eta(arg0: &mut WolfGameMaintainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.exp_eta = arg1;
    }

    public entry fun change_fee(arg0: &mut WolfGameMaintainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.fee = arg1;
    }

    public entry fun change_maintainer(arg0: &mut WolfGameMaintainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.maintainer_address = arg1;
    }

    public entry fun change_max_count(arg0: &mut WolfGameMaintainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.max_count = arg1;
    }

    public entry fun change_min_gap(arg0: &mut WolfGameMaintainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.min_gap = arg1;
    }

    public entry fun change_status(arg0: &mut WolfGameMaintainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.status = arg1;
    }

    public(friend) fun create_maintainer(arg0: &mut 0x2::tx_context::TxContext) : WolfGameMaintainer {
        WolfGameMaintainer{
            id                 : 0x2::object::new(arg0),
            maintainer_address : 0x2::tx_context::sender(arg0),
            game_count         : 0,
            sheep_count        : 0,
            wolf_count         : 0,
            fee                : 5000000000,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            items              : 0x2::object_table::new<0x2::object::ID, WitnessCarrier>(arg0),
            timestamp          : 0,
            exp_eta            : 0,
            max_count          : 20000,
            min_gap            : 1000,
            status             : 0,
        }
    }

    public fun idx(arg0: &WolfGame) : &u64 {
        &arg0.idx
    }

    fun init(arg0: WOLF_GAME, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiWolfGame#{idx}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://wolfgame.s3.amazonaws.com/{type}/{idx}.svg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Wolf Game is a fun. Come on!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suixen.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Wolf Game"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suixen.xyz/game.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Wolf Game"));
        let v4 = 0x2::package::claim<WOLF_GAME>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<WolfGame>(&v4, v0, v2, arg1);
        0x2::display::update_version<WolfGame>(&mut v5);
        let v6 = create_maintainer(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WolfGame>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<WolfGameMaintainer>(v6);
    }

    fun merge_and_split(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg1, v1);
        (0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1, arg2), v0)
    }

    public entry fun pay_maintainer(arg0: &mut WolfGameMaintainer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.maintainer_address, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun player(arg0: &WolfGame) : &address {
        &arg0.player
    }

    fun record_staked(arg0: &mut 0x2::object::UID, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::dynamic_field::exists_<address>(arg0, arg1)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<address, vector<0x2::object::ID>>(arg0, arg1), arg2);
        } else {
            0x2::dynamic_field::add<address, vector<0x2::object::ID>>(arg0, arg1, 0x1::vector::singleton<0x2::object::ID>(arg2));
        };
    }

    public entry fun remove_from_stake(arg0: &mut WolfGameMaintainer, arg1: &mut 0x2::coin::TreasuryCap<0xaedc995cdaf677ffffdb7ca184de0d167f47b502384977940c4420871c932b04::exp::EXP>, arg2: vector<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg2);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg2);
            assert!(0x2::object_table::contains<0x2::object::ID, WitnessCarrier>(&arg0.items, v1), 0);
            let WitnessCarrier {
                id        : v2,
                game      : v3,
                owner     : v4,
                timestamp : v5,
            } = 0x2::object_table::remove<0x2::object::ID, WitnessCarrier>(&mut arg0.items, v1);
            let v6 = v2;
            assert!(0x2::tx_context::sender(arg4) == v4, 1);
            0x2::object::delete(v6);
            let v7 = 0x2::clock::timestamp_ms(arg3);
            assert!(v7 - v5 >= arg0.min_gap, 3);
            let v8 = &mut arg0.id;
            remove_staked(v8, 0x2::tx_context::sender(arg4), 0x2::object::uid_to_inner(&v6));
            0x2::transfer::public_transfer<WolfGame>(v3, 0x2::tx_context::sender(arg4));
            0xaedc995cdaf677ffffdb7ca184de0d167f47b502384977940c4420871c932b04::exp::mint(arg1, (v7 - v5) / 1000 * arg0.exp_eta, 0x2::tx_context::sender(arg4), arg4);
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
    }

    fun remove_staked(arg0: &mut 0x2::object::UID, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::dynamic_field::exists_<address>(arg0, arg1)) {
            let v0 = 0x2::dynamic_field::borrow_mut<address, vector<0x2::object::ID>>(arg0, arg1);
            let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg2);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(v0, v2);
            };
        };
    }

    public entry fun set_timestamp(arg0: &mut WolfGameMaintainer, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.timestamp = 0x2::clock::timestamp_ms(arg1);
    }

    public fun type(arg0: &WolfGame) : &0x1::string::String {
        &arg0.type
    }

    // decompiled from Move bytecode v6
}

