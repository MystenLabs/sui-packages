module 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::chess {
    struct Global has key {
        id: 0x2::object::UID,
        total_chesses: u64,
        total_battle: u64,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Chess has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        lineup: 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::LineUp,
        cards_pool: 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::LineUp,
        gold: u64,
        win: u8,
        lose: u8,
        challenge_win: u8,
        challenge_lose: u8,
        creator: address,
        gold_cost: u64,
        arena: bool,
        arena_checked: bool,
    }

    struct FightEvent has copy, drop {
        chess_id: address,
        v1: address,
        v1_name: 0x1::string::String,
        v1_win: u8,
        v1_lose: u8,
        v1_challenge_win: u8,
        v1_challenge_lose: u8,
        v2_name: 0x1::string::String,
        v2_lineup: 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::LineUp,
        res: u8,
    }

    fun battle(arg0: &0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Global, arg1: &mut 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::Global, arg2: &mut 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::Global, arg3: &mut Chess, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.lose <= 2, 1);
        let v0 = false;
        let v1 = if (arg3.win >= 10) {
            assert!(arg3.arena, 18);
            assert!(arg3.challenge_lose <= 2, 1);
            v0 = true;
            *0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::get_lineup_by_rank(arg2, 19 - arg3.challenge_win)
        } else {
            0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::select_random_lineup(arg3.win, arg3.lose, arg1, arg3.arena, arg4)
        };
        let v2 = &mut v1;
        if (fight(arg3, v2, v0, arg4)) {
            if (v0) {
                arg3.challenge_win = arg3.challenge_win + 1;
                0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::rank_forward(arg2, arg3.lineup);
            } else {
                arg3.win = arg3.win + 1;
                0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::record_player_lineup(arg3.win - 1, arg3.lose, arg1, arg3.lineup, arg3.arena);
                if (arg3.win == 10) {
                    0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::record_player_lineup(arg3.win, arg3.lose, arg1, arg3.lineup, arg3.arena);
                };
            };
        } else if (v0) {
            arg3.challenge_lose = arg3.challenge_lose + 1;
        } else {
            arg3.lose = arg3.lose + 1;
            0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::record_player_lineup(arg3.win, arg3.lose - 1, arg1, arg3.lineup, arg3.arena);
        };
        if (arg3.lose <= 2) {
            refresh_cards_pools(arg0, arg3, arg4);
        };
    }

    public entry fun check_out_arena(arg0: &mut Global, arg1: Chess, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.arena, 4);
        let Chess {
            id             : v0,
            name           : _,
            lineup         : _,
            cards_pool     : _,
            gold           : _,
            win            : _,
            lose           : _,
            challenge_win  : _,
            challenge_lose : _,
            creator        : _,
            gold_cost      : _,
            arena          : _,
            arena_checked  : v12,
        } = arg1;
        if (!v12) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::estimate_reward(get_total_shui_amount(arg0), arg1.gold_cost, arg1.win)), arg2), 0x2::tx_context::sender(arg2));
        };
        0x2::object::delete(v0);
    }

    public entry fun check_out_arena_fee(arg0: &mut Global, arg1: &mut Chess, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.arena, 4);
        assert!(!arg1.arena_checked, 20);
        arg1.arena_checked = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::estimate_reward(get_total_shui_amount(arg0), arg1.gold_cost, arg1.win)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_rank_reward(arg0: &mut 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::Global, arg1: Chess, arg2: &0x2::clock::Clock, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::query_left_challenge_time(arg0, arg2) == 0, 19);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::get_creator(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::get_lineup_by_rank(arg0, arg3)) == v0) {
            let Chess {
                id             : v1,
                name           : _,
                lineup         : _,
                cards_pool     : _,
                gold           : _,
                win            : _,
                lose           : _,
                challenge_win  : _,
                challenge_lose : _,
                creator        : _,
                gold_cost      : _,
                arena          : _,
                arena_checked  : _,
            } = arg1;
            0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::send_reward_by_rank(arg0, arg3, arg4);
            0x2::object::delete(v1);
        } else {
            0x2::transfer::public_transfer<Chess>(arg1, v0);
        };
    }

    public fun fight(arg0: &mut Chess, arg1: &mut 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::LineUp, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = arg0.lineup;
        let v1 = *arg1;
        let v2 = &mut arg0.lineup;
        let v3 = *0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::get_roles(&v0);
        0x1::vector::reverse<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&mut v3);
        let v4 = *0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::get_roles(&v1);
        0x1::vector::reverse<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&mut v4);
        if (0x1::vector::length<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&v3) == 0) {
            return false
        };
        let v5 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::init_role();
        let v6 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::init_role();
        let v7 = 0;
        let v8 = 0;
        while (0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::fight::some_alive(&v5, &v3) && 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::fight::some_alive(&v6, &v4)) {
            while (0x1::vector::length<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&v3) > 0 && (0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_hp(&v5) == 0 || 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(&v5) == 0x1::string::utf8(b"none") || 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(&v5) == 0x1::string::utf8(b"init"))) {
                v5 = 0x1::vector::pop_back<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&mut v3);
                if (0x1::vector::length<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&v3) < 5) {
                    v7 = v7 + 1;
                };
            };
            while (0x1::vector::length<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&v4) > 0 && (0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_hp(&v6) == 0 || 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(&v6) == 0x1::string::utf8(b"none") || 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(&v6) == 0x1::string::utf8(b"init"))) {
                v6 = 0x1::vector::pop_back<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&mut v4);
                if (0x1::vector::length<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&v4) < 5) {
                    v8 = v8 + 1;
                };
            };
            while (0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_hp(&v5) > 0 && 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_hp(&v6) > 0) {
                0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::fight::action(v7, &mut v5, &mut v6, &mut v3, &mut v4, v2);
                0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::fight::action(v8, &mut v6, &mut v5, &mut v4, &mut v3, v2);
            };
        };
        let v9 = arg0.win;
        let v10 = v9;
        let v11 = arg0.lose;
        let v12 = v11;
        let v13 = arg0.challenge_win;
        let v14 = v13;
        let v15 = arg0.challenge_lose;
        let v16 = v15;
        let v17 = if (0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::fight::some_alive(&v6, &v4)) {
            if (arg2) {
                v14 = v13 + 1;
            } else {
                v10 = v9 + 1;
            };
            false
        } else {
            if (arg2) {
                v16 = v15 + 1;
            } else {
                v12 = v11 + 1;
            };
            true
        };
        let v18 = FightEvent{
            chess_id          : 0x2::object::id_address<Chess>(arg0),
            v1                : 0x2::tx_context::sender(arg3),
            v1_name           : arg0.name,
            v1_win            : v10,
            v1_lose           : v12,
            v1_challenge_win  : v14,
            v1_challenge_lose : v16,
            v2_name           : 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::get_name(arg1),
            v2_lineup         : *arg1,
            res               : 2,
        };
        0x2::event::emit<FightEvent>(v18);
        v17
    }

    public fun get_total_shui_amount(arg0: &Global) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id            : 0x2::object::new(arg0),
            total_chesses : 0,
            total_battle  : 0,
            balance_SUI   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun lock_reward(arg0: &mut Global, arg1: &mut 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::Global, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xbe379359ac6e9d0fc0b867f147f248f1c2d9fc019a9a708adfcbe15fc3130c18, 6);
        assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::query_left_challenge_time(arg1, arg2) == 0, 19);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI) / 10;
        0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::top_up_challenge_pool(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, v0));
        let v1 = 0;
        while (v1 < 20) {
            0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::push_reward_amount(arg1, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::get_reward_amount_by_rank(arg1, v0, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::calculate_scores(arg1), v1));
            v1 = v1 + 1;
        };
        0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::lock_pool(arg1);
    }

    public entry fun mint_arena_chess(arg0: &0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Global, arg1: &mut Global, arg2: 0x1::string::String, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg3);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, arg3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::check_ticket_gold_cost(v2), 3);
        let v3 = Chess{
            id             : 0x2::object::new(arg4),
            name           : arg2,
            lineup         : 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::empty(arg4),
            cards_pool     : 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::generate_random_cards(arg0, arg4),
            gold           : 10,
            win            : 0,
            lose           : 0,
            challenge_win  : 0,
            challenge_lose : 0,
            creator        : v0,
            gold_cost      : v2,
            arena          : true,
            arena_checked  : false,
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v2, arg4)));
        if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
        arg1.total_chesses = arg1.total_chesses + 1;
        0x2::transfer::public_transfer<Chess>(v3, v0);
    }

    public entry fun mint_chess(arg0: &0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Global, arg1: &mut Global, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Chess{
            id             : 0x2::object::new(arg3),
            name           : arg2,
            lineup         : 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::empty(arg3),
            cards_pool     : 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::generate_random_cards(arg0, arg3),
            gold           : 10,
            win            : 0,
            lose           : 0,
            challenge_win  : 0,
            challenge_lose : 0,
            creator        : v0,
            gold_cost      : 0,
            arena          : false,
            arena_checked  : true,
        };
        arg1.total_chesses = arg1.total_chesses + 1;
        0x2::transfer::public_transfer<Chess>(v1, v0);
    }

    public entry fun operate_and_battle(arg0: &mut Global, arg1: &0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Global, arg2: &mut 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::Global, arg3: &mut 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::challenge::Global, arg4: &mut Chess, arg5: vector<0x1::string::String>, arg6: u8, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg7) == 6, 2);
        let v0 = arg4.lineup;
        let v1 = arg4.cards_pool;
        0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::verify::verify_operation(arg1, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::get_mut_roles(&mut v0), 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::get_mut_roles(&mut v1), arg5, arg6, arg7, arg4.name, (arg4.gold as u8), arg4.gold_cost, arg8);
        if (arg4.challenge_win + arg4.challenge_lose >= 20) {
            arg4.gold = 0;
        } else {
            arg4.gold = 10;
        };
        arg4.lineup = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::parse_lineup_str_vec(arg4.name, arg1, arg7, arg4.gold_cost, arg8);
        0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::set_hash(&mut arg4.lineup, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::get_hash(&arg4.lineup));
        battle(arg1, arg2, arg3, arg4, arg8);
        arg0.total_battle = arg0.total_battle + 1;
    }

    fun refresh_cards_pools(arg0: &0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Global, arg1: &mut Chess, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.cards_pool = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::generate_random_cards(arg0, arg2);
    }

    public fun withdraw(arg0: u64, arg1: &mut Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xbe379359ac6e9d0fc0b867f147f248f1c2d9fc019a9a708adfcbe15fc3130c18, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance_SUI, arg0), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

