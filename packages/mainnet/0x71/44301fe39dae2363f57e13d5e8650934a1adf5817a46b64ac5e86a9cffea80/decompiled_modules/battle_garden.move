module 0x7144301fe39dae2363f57e13d5e8650934a1adf5817a46b64ac5e86a9cffea80::battle_garden {
    struct Status has copy, drop, store {
        block_turns: u8,
        next_turn_penalty: u64,
        poison_ticks: u8,
        poison_dpt: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        issuer: address,
        treasury: address,
        entry_fee: u64,
        winner_payout: u64,
        treasury_share: u64,
        paused: bool,
    }

    struct MatchmakingQueue has key {
        id: 0x2::object::UID,
        waiting: 0x1::option::Option<Pending>,
        bank: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Pending has copy, drop, store {
        player: address,
        entry_fee_snapshot: u64,
    }

    struct Battle has key {
        id: 0x2::object::UID,
        player1: address,
        player2: address,
        p1_growth: u64,
        p2_growth: u64,
        turn: u8,
        finished: bool,
        winner: 0x1::option::Option<address>,
        p1_moves: vector<u8>,
        p2_moves: vector<u8>,
        p1_status: Status,
        p2_status: Status,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        battle_entry_fee: u64,
        winner_payout: u64,
        treasury_share: u64,
        treasury_addr: address,
    }

    struct SaplingNFT has store, key {
        id: 0x2::object::UID,
        issuer: address,
        name: 0x1::string::String,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct BattleUpdate has copy, drop, store {
        battle_id: 0x2::object::ID,
        player1: address,
        player2: address,
        player1_moves: vector<u8>,
        player2_moves: vector<u8>,
        player1_growth: u64,
        player2_growth: u64,
        winner: 0x1::option::Option<address>,
    }

    struct BATTLE_GARDEN has drop {
        dummy_field: bool,
    }

    fun add_growth(arg0: u64, arg1: u64) : u64 {
        clamp(arg0 + arg1, 0, 100)
    }

    fun apply_damage(arg0: u64, arg1: &mut Status) : u64 {
        if (arg1.block_turns > 0) {
            arg1.block_turns = arg1.block_turns - 1;
            0
        } else {
            arg0
        }
    }

    fun clamp(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        }
    }

    fun clone_vec_u8(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun emit_update(arg0: &Battle) {
        let v0 = BattleUpdate{
            battle_id      : 0x2::object::uid_to_inner(&arg0.id),
            player1        : arg0.player1,
            player2        : arg0.player2,
            player1_moves  : clone_vec_u8(&arg0.p1_moves),
            player2_moves  : clone_vec_u8(&arg0.p2_moves),
            player1_growth : arg0.p1_growth,
            player2_growth : arg0.p2_growth,
            winner         : arg0.winner,
        };
        0x2::event::emit<BattleUpdate>(v0);
    }

    fun eq_str(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) != 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun finalize_with_cfg(arg0: &mut Battle, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.finished, 103);
        assert!(0x1::option::is_some<address>(&arg0.winner), 105);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) >= arg1.winner_payout + arg1.treasury_share, 105);
        let v0 = 0x1::option::extract<address>(&mut arg0.winner);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.vault, arg1.winner_payout, arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.vault, arg1.treasury_share, arg2), arg1.treasury);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.vault, v1, arg2), v0);
        };
    }

    fun finish_and_payout(arg0: &mut Battle, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 103);
        arg0.finished = true;
        arg0.winner = 0x1::option::some<address>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) >= arg0.winner_payout + arg0.treasury_share, 105);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.vault, arg0.winner_payout, arg2), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.vault, arg0.treasury_share, arg2), arg0.treasury_addr);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.vault, v0, arg2), arg1);
        };
        emit_update(arg0);
    }

    fun gen_moves(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, 3);
        0x1::vector::push_back<u8>(v1, 4);
        0x1::vector::push_back<u8>(v1, 5);
        0x1::vector::push_back<u8>(v1, 6);
        0x1::vector::push_back<u8>(v1, 7);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = &mut v2;
        0x1::vector::push_back<u8>(v3, 20);
        0x1::vector::push_back<u8>(v3, 21);
        0x1::vector::push_back<u8>(v3, 22);
        0x1::vector::push_back<u8>(v3, 23);
        0x1::vector::push_back<u8>(v3, 24);
        0x1::vector::push_back<u8>(v3, 25);
        0x1::vector::push_back<u8>(v3, 26);
        0x1::vector::push_back<u8>(v3, 27);
        0x1::vector::push_back<u8>(v3, 28);
        0x1::vector::push_back<u8>(v3, 29);
        0x1::vector::push_back<u8>(v3, 30);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0x1::vector::length<u8>(&v0);
        let v6 = 0x1::vector::length<u8>(&v2);
        let v7 = 0x2::random::new_generator(arg0, arg1);
        let v8 = 0x2::random::generate_u64(&mut v7) % v5;
        let v9 = 0x2::random::generate_u64(&mut v7);
        let v10 = if (v8 == v9 % v5) {
            (v8 + 1) % v5
        } else {
            v9 % v5
        };
        0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, v8));
        0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, v10));
        let v11 = 0x2::random::generate_u64(&mut v7) % v6;
        let v12 = 0x2::random::generate_u64(&mut v7);
        let v13 = if (v11 == v12 % v6) {
            (v11 + 1) % v6
        } else {
            v12 % v6
        };
        0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, v11));
        0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, v13));
        v4
    }

    fun init(arg0: BATTLE_GARDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Config{
            id             : 0x2::object::new(arg1),
            admin          : v0,
            issuer         : v0,
            treasury       : v0,
            entry_fee      : 3000000000,
            winner_payout  : 5000000000,
            treasury_share : 1000000000,
            paused         : false,
        };
        let v2 = MatchmakingQueue{
            id      : 0x2::object::new(arg1),
            waiting : 0x1::option::none<Pending>(),
            bank    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v3 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Config>(v1);
        0x2::transfer::share_object<MatchmakingQueue>(v2);
        0x2::transfer::public_transfer<MintCap>(v3, v0);
    }

    public fun join_queue(arg0: &Config, arg1: &mut MatchmakingQueue, arg2: &SaplingNFT, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 107);
        assert!(arg2.issuer == arg0.issuer, 101);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = arg0.entry_fee;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v1, 104);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.bank, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        if (0x1::option::is_some<Pending>(&arg1.waiting)) {
            let v2 = 0x1::option::extract<Pending>(&mut arg1.waiting);
            spawn_battle(arg1, v2.player, v0, v2.entry_fee_snapshot, arg0, arg4, arg5);
        } else {
            let v3 = Pending{
                player             : v0,
                entry_fee_snapshot : v1,
            };
            0x1::option::fill<Pending>(&mut arg1.waiting, v3);
        };
    }

    fun map_ability_name(arg0: vector<u8>) : u8 {
        if (eq_str(arg0, b"ThornSpikeBomb")) {
            1
        } else if (eq_str(arg0, b"RazorLeafSword")) {
            2
        } else if (eq_str(arg0, b"TumbleweedMace")) {
            3
        } else if (eq_str(arg0, b"ShovelSpear")) {
            4
        } else if (eq_str(arg0, b"ThornedWhip")) {
            5
        } else if (eq_str(arg0, b"AcornSlingshot")) {
            6
        } else if (eq_str(arg0, b"StoneNunchuck")) {
            7
        } else if (eq_str(arg0, b"CactusShield")) {
            8
        } else if (eq_str(arg0, b"LifeAbsorb")) {
            9
        } else if (eq_str(arg0, b"Poison")) {
            10
        } else if (eq_str(arg0, b"WitherTouch")) {
            11
        } else if (eq_str(arg0, b"PollenCloud")) {
            12
        } else if (eq_str(arg0, b"FungalRot")) {
            13
        } else if (eq_str(arg0, b"RootsUp")) {
            20
        } else if (eq_str(arg0, b"SunBeam")) {
            21
        } else if (eq_str(arg0, b"RainStorm")) {
            22
        } else if (eq_str(arg0, b"WhiteMold")) {
            23
        } else if (eq_str(arg0, b"GreenhouseGas")) {
            24
        } else if (eq_str(arg0, b"PotassiumPowerUp")) {
            25
        } else if (eq_str(arg0, b"PhotosyntheticSurge")) {
            26
        } else if (eq_str(arg0, b"BarkskinArmor")) {
            27
        } else if (eq_str(arg0, b"SapOverflow")) {
            28
        } else if (eq_str(arg0, b"CloudCover")) {
            29
        } else if (eq_str(arg0, b"ShadowCanopy")) {
            30
        } else {
            0
        }
    }

    public fun mint_sapling(arg0: &MintCap, arg1: &Config, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SaplingNFT{
            id     : 0x2::object::new(arg4),
            issuer : arg1.issuer,
            name   : arg3,
        };
        0x2::transfer::public_transfer<SaplingNFT>(v0, arg2);
    }

    fun miss(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext, arg2: u64) : bool {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64(&mut v0) % 100 < arg2
    }

    fun rand_inclusive(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext, arg2: u64, arg3: u64) : u64 {
        if (arg3 <= arg2) {
            arg2
        } else {
            let v1 = 0x2::random::new_generator(arg0, arg1);
            arg2 + 0x2::random::generate_u64(&mut v1) % (arg3 - arg2 + 1)
        }
    }

    fun resolve_move(arg0: u8, arg1: &mut u64, arg2: &mut u64, arg3: &mut Status, arg4: &mut Status, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0 == 1) {
            *arg2 = sub_growth(*arg2, apply_damage(10, arg4));
        } else if (arg0 == 2) {
            *arg2 = sub_growth(*arg2, apply_damage(8, arg4));
        } else if (arg0 == 3) {
            *arg2 = sub_growth(*arg2, apply_damage(12, arg4));
        } else if (arg0 == 4) {
            *arg2 = sub_growth(*arg2, apply_damage(7, arg4));
        } else if (arg0 == 5) {
            *arg2 = sub_growth(*arg2, apply_damage(9, arg4));
        } else if (arg0 == 6) {
            *arg2 = sub_growth(*arg2, apply_damage(6, arg4));
        } else if (arg0 == 7) {
            *arg2 = sub_growth(*arg2, apply_damage(11, arg4));
        } else if (arg0 == 8) {
            arg3.block_turns = 1;
            *arg2 = sub_growth(*arg2, 5);
        } else if (arg0 == 9) {
            *arg2 = sub_growth(*arg2, apply_damage(8, arg4));
            *arg1 = add_growth(*arg1, 4);
        } else if (arg0 == 10) {
            arg4.poison_ticks = 2;
            arg4.poison_dpt = 5;
        } else if (arg0 == 11) {
            if (!miss(arg5, arg6, 20)) {
                *arg2 = sub_growth(*arg2, apply_damage(15, arg4));
            };
        } else if (arg0 == 12) {
            if (!miss(arg5, arg6, 50)) {
                *arg2 = sub_growth(*arg2, apply_damage(10, arg4));
            } else {
                arg4.block_turns = arg4.block_turns + 1;
            };
        } else if (arg0 == 13) {
            let v0 = apply_damage(7, arg4);
            *arg2 = sub_growth(*arg2, v0);
            arg4.next_turn_penalty = arg4.next_turn_penalty + 3;
        } else if (arg0 == 20) {
            *arg1 = add_growth(*arg1, 10);
        } else if (arg0 == 21) {
            *arg1 = add_growth(*arg1, rand_inclusive(arg5, arg6, 8, 12));
        } else if (arg0 == 22) {
            *arg1 = add_growth(*arg1, 15);
        } else if (arg0 == 23) {
            let v1 = if (miss(arg5, arg6, 20)) {
                5
            } else {
                0
            };
            *arg1 = add_growth(*arg1, 10 + v1);
        } else if (arg0 == 24) {
            *arg1 = add_growth(*arg1, rand_inclusive(arg5, arg6, 12, 18));
        } else if (arg0 == 25) {
            if (!miss(arg5, arg6, 10)) {
                *arg1 = add_growth(*arg1, 20);
            };
        } else if (arg0 == 26) {
            *arg1 = add_growth(*arg1, rand_inclusive(arg5, arg6, 15, 20));
        } else if (arg0 == 27) {
            *arg1 = add_growth(*arg1, 10);
            arg3.block_turns = 1;
        } else if (arg0 == 28) {
            *arg1 = add_growth(*arg1, 12);
        } else if (arg0 == 29) {
            *arg1 = add_growth(*arg1, 8);
            if (!miss(arg5, arg6, 50)) {
                arg3.block_turns = arg3.block_turns + 1;
            };
        } else if (arg0 == 30) {
            *arg1 = add_growth(*arg1, rand_inclusive(arg5, arg6, 10, 15));
        };
    }

    public fun set_economics(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 100);
        arg0.entry_fee = arg1;
        arg0.winner_payout = arg2;
        arg0.treasury_share = arg3;
    }

    public fun set_paused(arg0: &mut Config, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        arg0.paused = arg1;
    }

    fun spawn_battle(arg0: &mut MatchmakingQueue, arg1: address, arg2: address, arg3: u64, arg4: &Config, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bank, 2 * arg3), arg6);
        let v1 = gen_moves(arg5, arg6);
        let v2 = gen_moves(arg5, arg6);
        let v3 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v4 = Status{
            block_turns       : 0,
            next_turn_penalty : 0,
            poison_ticks      : 0,
            poison_dpt        : 0,
        };
        let v5 = Battle{
            id               : 0x2::object::new(arg6),
            player1          : arg1,
            player2          : arg2,
            p1_growth        : 0,
            p2_growth        : 0,
            turn             : 0,
            finished         : false,
            winner           : 0x1::option::none<address>(),
            p1_moves         : v1,
            p2_moves         : v2,
            p1_status        : v3,
            p2_status        : v4,
            vault            : 0x2::coin::into_balance<0x2::sui::SUI>(v0),
            battle_entry_fee : arg3,
            winner_payout    : arg4.winner_payout,
            treasury_share   : arg4.treasury_share,
            treasury_addr    : arg4.treasury,
        };
        let v6 = BattleUpdate{
            battle_id      : 0x2::object::uid_to_inner(&v5.id),
            player1        : arg1,
            player2        : arg2,
            player1_moves  : clone_vec_u8(&v5.p1_moves),
            player2_moves  : clone_vec_u8(&v5.p2_moves),
            player1_growth : 0,
            player2_growth : 0,
            winner         : 0x1::option::none<address>(),
        };
        0x2::event::emit<BattleUpdate>(v6);
        0x2::transfer::share_object<Battle>(v5);
    }

    fun sub_growth(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun use_ability(arg0: &mut Battle, arg1: vector<u8>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = map_ability_name(arg1);
        assert!(v0 != 0, 106);
        use_ability_id(arg0, v0, arg2, arg3);
    }

    public fun use_ability_id(arg0: &mut Battle, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finished, 103);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.turn == 0 && v0 == arg0.player1 || arg0.turn == 1 && v0 == arg0.player2, 102);
        assert!(arg1 != 0, 106);
        if (arg0.turn == 0) {
            if (arg0.p1_status.next_turn_penalty > 0) {
                arg0.p1_growth = sub_growth(arg0.p1_growth, arg0.p1_status.next_turn_penalty);
                arg0.p1_status.next_turn_penalty = 0;
            };
            if (arg0.p1_status.poison_ticks > 0) {
                arg0.p1_growth = sub_growth(arg0.p1_growth, arg0.p1_status.poison_dpt);
                arg0.p1_status.poison_ticks = arg0.p1_status.poison_ticks - 1;
            };
            let v1 = &mut arg0.p1_growth;
            let v2 = &mut arg0.p2_growth;
            let v3 = &mut arg0.p1_status;
            let v4 = &mut arg0.p2_status;
            resolve_move(arg1, v1, v2, v3, v4, arg2, arg3);
            arg0.p1_growth = clamp(arg0.p1_growth, 0, 100);
            arg0.p2_growth = clamp(arg0.p2_growth, 0, 100);
            if (arg0.p1_growth >= 100) {
                finish_and_payout(arg0, v0, arg3);
            } else {
                arg0.turn = 1;
                emit_update(arg0);
            };
        } else {
            if (arg0.p2_status.next_turn_penalty > 0) {
                arg0.p2_growth = sub_growth(arg0.p2_growth, arg0.p2_status.next_turn_penalty);
                arg0.p2_status.next_turn_penalty = 0;
            };
            if (arg0.p2_status.poison_ticks > 0) {
                arg0.p2_growth = sub_growth(arg0.p2_growth, arg0.p2_status.poison_dpt);
                arg0.p2_status.poison_ticks = arg0.p2_status.poison_ticks - 1;
            };
            let v5 = &mut arg0.p2_growth;
            let v6 = &mut arg0.p1_growth;
            let v7 = &mut arg0.p2_status;
            let v8 = &mut arg0.p1_status;
            resolve_move(arg1, v5, v6, v7, v8, arg2, arg3);
            arg0.p2_growth = clamp(arg0.p2_growth, 0, 100);
            arg0.p1_growth = clamp(arg0.p1_growth, 0, 100);
            if (arg0.p2_growth >= 100) {
                finish_and_payout(arg0, v0, arg3);
            } else {
                arg0.turn = 0;
                emit_update(arg0);
            };
        };
    }

    // decompiled from Move bytecode v6
}

