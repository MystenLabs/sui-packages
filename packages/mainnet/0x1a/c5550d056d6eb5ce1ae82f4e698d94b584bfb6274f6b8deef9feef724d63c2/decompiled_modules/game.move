module 0x1ac5550d056d6eb5ce1ae82f4e698d94b584bfb6274f6b8deef9feef724d63c2::game {
    struct Comment has drop, store {
        author: address,
        message: 0x1::string::String,
        timestamp: u64,
    }

    struct SuidokuGame has store, key {
        id: 0x2::object::UID,
        puzzle: vector<u8>,
        solution: vector<u8>,
        current_state: vector<u8>,
        difficulty: u8,
        commentary_enabled: bool,
        comments: vector<Comment>,
        reward: 0x1::option::Option<0x2::balance::Balance<0x2::sui::SUI>>,
        help_requests: vector<address>,
        completed: bool,
        created_at: u64,
    }

    struct GameInfo has copy, drop, store {
        game_id: 0x2::object::ID,
        owner: address,
        difficulty: u8,
        completed: bool,
        has_reward: bool,
    }

    struct GameRegistry has key {
        id: 0x2::object::UID,
        games: 0x2::table::Table<0x2::object::ID, GameInfo>,
        total_games: u64,
        admins: vector<address>,
    }

    public entry fun add_admin(arg0: &mut GameRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 8);
        if (!0x1::vector::contains<address>(&arg0.admins, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        };
    }

    public entry fun add_comment(arg0: &mut SuidokuGame, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.commentary_enabled, 3);
        let v0 = Comment{
            author    : 0x2::tx_context::sender(arg2),
            message   : 0x1::string::utf8(arg1),
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x1::vector::push_back<Comment>(&mut arg0.comments, v0);
    }

    public entry fun add_reward(arg0: &mut SuidokuGame, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&arg0.reward)) {
            0x2::balance::join<0x2::sui::SUI>(0x1::option::borrow_mut<0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.reward), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        } else {
            0x1::option::fill<0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.reward, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        };
    }

    public entry fun claim_reward(arg0: &mut SuidokuGame, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.completed, 1);
        assert!(0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&arg0.reward), 5);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.help_requests, &v0), 4);
        let v1 = 0x1::option::extract<0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.reward);
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x1::option::fill<0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.reward, v1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, 0x2::balance::value<0x2::sui::SUI>(&v1) / (0x1::vector::length<address>(&arg0.help_requests) as u64)), arg1), v0);
    }

    fun generate_puzzle(arg0: u8, arg1: &0x2::tx_context::TxContext) : (vector<u8>, vector<u8>) {
        if (arg0 == 1) {
            get_easy_puzzle(0x2::tx_context::epoch(arg1) % 3)
        } else if (arg0 == 2) {
            get_medium_puzzle(0x2::tx_context::epoch(arg1) % 3)
        } else {
            get_hard_puzzle(0x2::tx_context::epoch(arg1) % 3)
        }
    }

    fun get_easy_puzzle(arg0: u64) : (vector<u8>, vector<u8>) {
        if (arg0 == 0) {
            (x"050300000700000000060000010905000000000908000000000600080000000600000003040000080003000001070000000200000006000600000000020800000000040109000005000000000800000709", x"050304060708090102060702010905030408010908030402050607080509070601040203040206080503070901070103090204080506090601050307020804020807040109060305030405020806010709")
        } else {
            (x"000000020600070001060800000700000900010900000004050000080200010000000400000004060002090000000500000003000208000009030000000704000400000500000306070003000108000000", x"040305020609070801060802050701040903010907080304050602080206010905030407030704060802090105090501070403060208050109030206080704020408090507010306070603040108020509")
        }
    }

    fun get_hard_puzzle(arg0: u64) : (vector<u8>, vector<u8>) {
        (x"000000060000040000070000000003060000000000000901000800000000000000000000000500010800000003000000030006000405000400020000000600090003000000000000000200000000010000", x"050801060702040309070902080403060501030604050901070802040308090507020106020506010804090703010709030206080405080405020109030607090103070605050204060207040308010905")
    }

    fun get_medium_puzzle(arg0: u64) : (vector<u8>, vector<u8>) {
        (x"000000000000060800000000000703000009030009000000000405040900000000000000080003000500090002000000000000000306090600000000030008070000060800000000000208000000000000", x"010702050409060803060405080703020109030809020601070405040906030207080501080103040506090702020507010908040306090604070105030208070301060802050904050208090304010607")
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = GameRegistry{
            id          : 0x2::object::new(arg0),
            games       : 0x2::table::new<0x2::object::ID, GameInfo>(arg0),
            total_games : 0,
            admins      : v0,
        };
        0x2::transfer::share_object<GameRegistry>(v1);
    }

    public fun is_admin(arg0: &GameRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    fun is_complete(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun is_valid_move(arg0: &vector<u8>, arg1: u8, arg2: u8, arg3: u8) : bool {
        let v0 = 0;
        while (v0 < 9) {
            if (v0 != (arg2 as u64)) {
                if (*0x1::vector::borrow<u8>(arg0, (arg1 as u64) * 9 + v0) == arg3) {
                    return false
                };
            };
            v0 = v0 + 1;
        };
        let v1 = 0;
        while (v1 < 9) {
            if (v1 != (arg1 as u64)) {
                if (*0x1::vector::borrow<u8>(arg0, v1 * 9 + (arg2 as u64)) == arg3) {
                    return false
                };
            };
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 3) {
            let v3 = 0;
            while (v3 < 3) {
                let v4 = arg1 / 3 * 3 + v2;
                let v5 = arg2 / 3 * 3 + v3;
                if (v4 != arg1 || v5 != arg2) {
                    if (*0x1::vector::borrow<u8>(arg0, (v4 as u64) * 9 + (v5 as u64)) == arg3) {
                        return false
                    };
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        true
    }

    public entry fun make_move(arg0: &mut SuidokuGame, arg1: u8, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 1);
        assert!(arg1 < 9 && arg2 < 9, 6);
        assert!(arg3 >= 1 && arg3 <= 9, 7);
        let v0 = (arg1 as u64) * 9 + (arg2 as u64);
        assert!(*0x1::vector::borrow<u8>(&arg0.puzzle, v0) == 0, 0);
        *0x1::vector::borrow_mut<u8>(&mut arg0.current_state, v0) = arg3;
        assert!(is_valid_move(&arg0.current_state, arg1, arg2, arg3), 0);
        if (is_complete(&arg0.current_state)) {
            arg0.completed = true;
        };
    }

    public entry fun mint_game(arg0: u8, arg1: bool, arg2: &mut GameRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1 && arg0 <= 3, 2);
        let (v0, v1) = generate_puzzle(arg0, arg3);
        let v2 = 0x2::object::new(arg3);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = SuidokuGame{
            id                 : v2,
            puzzle             : v0,
            solution           : v1,
            current_state      : v0,
            difficulty         : arg0,
            commentary_enabled : arg1,
            comments           : 0x1::vector::empty<Comment>(),
            reward             : 0x1::option::none<0x2::balance::Balance<0x2::sui::SUI>>(),
            help_requests      : 0x1::vector::empty<address>(),
            completed          : false,
            created_at         : 0x2::tx_context::epoch(arg3),
        };
        let v6 = GameInfo{
            game_id    : v3,
            owner      : v4,
            difficulty : arg0,
            completed  : false,
            has_reward : false,
        };
        0x2::table::add<0x2::object::ID, GameInfo>(&mut arg2.games, v3, v6);
        arg2.total_games = arg2.total_games + 1;
        0x2::transfer::public_transfer<SuidokuGame>(v5, v4);
    }

    public entry fun remove_admin(arg0: &mut GameRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 8);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v1) == arg1) {
                0x1::vector::remove<address>(&mut arg0.admins, v1);
                break
            };
            v1 = v1 + 1;
        };
    }

    public entry fun request_help(arg0: &mut SuidokuGame, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.help_requests)) {
            if (*0x1::vector::borrow<address>(&arg0.help_requests, v1) == v0) {
                return
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<address>(&mut arg0.help_requests, v0);
    }

    public entry fun toggle_commentary(arg0: &mut SuidokuGame, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.commentary_enabled = !arg0.commentary_enabled;
    }

    // decompiled from Move bytecode v6
}

