module 0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::chess {
    struct Global has key {
        id: 0x2::object::UID,
        total_chesses: u64,
        total_battle: u64,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        version: u64,
        manager: address,
    }

    struct Chess has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        lineup: 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::LineUp,
        cards_pool: 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::LineUp,
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
        v2_lineup: 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::LineUp,
        res: u8,
    }

    fun fight(arg0: &mut Chess, arg1: &0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::LineUp, arg2: bool, arg3: &0x2::tx_context::TxContext) : bool {
        let v0 = arg0.lineup;
        let v1 = *arg1;
        let v2 = *0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::get_roles(&v0);
        0x1::vector::reverse<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&mut v2);
        let v3 = *0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::get_roles(&v1);
        0x1::vector::reverse<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&mut v3);
        let v4 = 0x1::vector::pop_back<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&mut v2);
        let v5 = &mut v4;
        let v6 = 0x1::vector::pop_back<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&mut v3);
        let v7 = &mut v6;
        0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::remove_none_roles(&mut v2);
        0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::remove_none_roles(&mut v3);
        let v8 = 0x2::vec_map::empty<0x1::string::String, 0x43511aee799bf4de32a617733993c346b4117e26fa17c16bfd5f90611f38194f::utils::Int_wrapper>();
        let v9 = 0x2::vec_map::empty<0x1::string::String, 0x43511aee799bf4de32a617733993c346b4117e26fa17c16bfd5f90611f38194f::utils::Int_wrapper>();
        0x2::vec_map::insert<0x1::string::String, 0x43511aee799bf4de32a617733993c346b4117e26fa17c16bfd5f90611f38194f::utils::Int_wrapper>(&mut v9, 0x1::string::utf8(b"invalid"), 0x43511aee799bf4de32a617733993c346b4117e26fa17c16bfd5f90611f38194f::utils::generate_wrapper_with_value(0));
        loop {
            if (0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_speed(v5) >= 0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_speed(v7)) {
                0x12c1af04ffbe5d3ad037fbbe5ac7439660fe6d4e2dda99a7ccc505a05f4df438::fight::action(v5, v7, &mut v2, &mut v3, &mut v8);
                if (0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_hp(v7) == 0 && 0x1::vector::length<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&v3) > 0) {
                    let v10 = 0x1::vector::pop_back<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&mut v3);
                    v7 = &mut v10;
                    continue
                };
                if (0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_hp(v7) == 0) {
                    break
                };
                0x12c1af04ffbe5d3ad037fbbe5ac7439660fe6d4e2dda99a7ccc505a05f4df438::fight::action(v7, v5, &mut v3, &mut v2, &mut v9);
                if (0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_hp(v5) == 0 && 0x1::vector::length<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&v2) > 0) {
                    let v11 = 0x1::vector::pop_back<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&mut v2);
                    v5 = &mut v11;
                };
                if (0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_hp(v5) == 0) {
                    break
                } else {
                    continue
                };
            };
            0x12c1af04ffbe5d3ad037fbbe5ac7439660fe6d4e2dda99a7ccc505a05f4df438::fight::action(v7, v5, &mut v3, &mut v2, &mut v9);
            if (0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_hp(v5) == 0 && 0x1::vector::length<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&v2) > 0) {
                let v12 = 0x1::vector::pop_back<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&mut v2);
                v5 = &mut v12;
                continue
            };
            if (0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_hp(v5) == 0) {
                break
            };
            0x12c1af04ffbe5d3ad037fbbe5ac7439660fe6d4e2dda99a7ccc505a05f4df438::fight::action(v5, v7, &mut v2, &mut v3, &mut v8);
            if (0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_hp(v7) == 0 && 0x1::vector::length<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&v3) > 0) {
                let v13 = 0x1::vector::pop_back<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(&mut v3);
                v7 = &mut v13;
            };
            if (0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_hp(v7) == 0) {
                break
            };
        };
        let v14 = 0x1::string::utf8(b"--------After the battle---------");
        0x1::debug::print<0x1::string::String>(&v14);
        let v15 = 0x1::string::utf8(b"My acting hero");
        0x1::debug::print<0x1::string::String>(&v15);
        0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::print_role_short(v5);
        let v16 = 0x1::string::utf8(b"My rest team");
        0x1::debug::print<0x1::string::String>(&v16);
        0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::print_roles_short(&v2);
        let v17 = 0x1::string::utf8(b"Enmey acting hero");
        0x1::debug::print<0x1::string::String>(&v17);
        0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::print_role_short(v7);
        let v18 = 0x1::string::utf8(b"Enmey rest team");
        0x1::debug::print<0x1::string::String>(&v18);
        0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::print_roles_short(&v3);
        let v19 = 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::get_mut_roles(&mut arg0.lineup);
        if (0x2::vec_map::size<0x1::string::String, 0x43511aee799bf4de32a617733993c346b4117e26fa17c16bfd5f90611f38194f::utils::Int_wrapper>(&v8) > 0) {
            let v20 = 0x1::string::utf8(b"--------miao--------");
            0x1::debug::print<0x1::string::String>(&v20);
            0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::permenant_increase_role_hp(v19, &v8);
        };
        let v21 = 0x1::string::utf8(b"--------Permenant roles After the battle---------");
        0x1::debug::print<0x1::string::String>(&v21);
        0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::print_roles_short(v19);
        let v22 = if (0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_hp(v5) > 0) {
            if (arg2) {
                arg0.challenge_win = arg0.challenge_win + 1;
            } else {
                arg0.win = arg0.win + 1;
            };
            true
        } else {
            if (arg2) {
                arg0.challenge_lose = arg0.challenge_lose + 1;
            } else {
                arg0.lose = arg0.lose + 1;
            };
            false
        };
        let v23 = FightEvent{
            chess_id          : 0x2::object::id_address<Chess>(arg0),
            v1                : 0x2::tx_context::sender(arg3),
            v1_name           : arg0.name,
            v1_win            : arg0.win,
            v1_lose           : arg0.lose,
            v1_challenge_win  : arg0.challenge_win,
            v1_challenge_lose : arg0.challenge_lose,
            v2_name           : 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::get_name(arg1),
            v2_lineup         : *arg1,
            res               : 2,
        };
        0x2::event::emit<FightEvent>(v23);
        v22
    }

    fun battle(arg0: &0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Global, arg1: &mut 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::Global, arg2: &mut 0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::Global, arg3: &mut Chess, arg4: &mut 0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::MetaIdentity, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.lose <= 2, 1);
        let v0 = false;
        let v1 = if (arg3.win >= 10) {
            assert!(arg3.arena, 18);
            assert!(arg3.challenge_lose <= 2, 1);
            v0 = true;
            *0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::get_lineup_by_rank(arg2, 20 - arg3.challenge_win)
        } else {
            0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::select_random_lineup(arg3.win, arg3.lose, arg1, arg3.arena, arg5)
        };
        if (fight(arg3, &v1, v0, arg5)) {
            if (v0) {
                0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::rank_forward(arg2, arg3.lineup);
                0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::record_update_best_rank(arg4, 0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::find_rank(arg2, &arg3.lineup));
            } else {
                0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::record_player_lineup(arg3.win - 1, arg3.lose, arg1, arg3.lineup, arg3.arena);
                if (arg3.win == 10) {
                    0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::record_player_lineup(arg3.win, arg3.lose, arg1, arg3.lineup, arg3.arena);
                };
            };
            0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::record_add_win(arg4);
        } else {
            if (!v0) {
                0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::record_player_lineup(arg3.win, arg3.lose - 1, arg1, arg3.lineup, arg3.arena);
            };
            0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::record_add_lose(arg4);
        };
        if (arg3.lose <= 2) {
            refresh_cards_pools(arg0, arg3, arg5);
        };
    }

    public fun change_manager(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 8);
        arg0.manager = arg1;
    }

    entry fun check_out_arena(arg0: &mut Global, arg1: Chess, arg2: &mut 0x2::tx_context::TxContext) {
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
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x43511aee799bf4de32a617733993c346b4117e26fa17c16bfd5f90611f38194f::utils::estimate_reward(get_total_sui_amount(arg0), arg1.gold_cost, arg1.win)), arg2), 0x2::tx_context::sender(arg2));
        };
        0x2::object::delete(v0);
    }

    entry fun check_out_arena_fee(arg0: &mut Global, arg1: &mut Chess, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 9);
        assert!(arg1.arena, 4);
        assert!(!arg1.arena_checked, 20);
        arg1.arena_checked = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x43511aee799bf4de32a617733993c346b4117e26fa17c16bfd5f90611f38194f::utils::estimate_reward(get_total_sui_amount(arg0), arg1.gold_cost, arg1.win)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_rank_reward(arg0: &mut 0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::Global, arg1: Chess, arg2: &0x2::clock::Clock, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::query_left_challenge_time(arg0, arg2) == 0, 19);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::get_creator(0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::get_lineup_by_rank(arg0, arg3)) == v0) {
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
            0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::send_reward_by_rank(arg0, arg3, arg4);
            0x2::object::delete(v1);
        } else {
            0x2::transfer::public_transfer<Chess>(arg1, v0);
        };
    }

    public fun get_total_sui_amount(arg0: &Global) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id            : 0x2::object::new(arg0),
            total_chesses : 0,
            total_battle  : 0,
            balance_SUI   : 0x2::balance::zero<0x2::sui::SUI>(),
            version       : 1,
            manager       : @0xb2a79beac8a092b336f560ba27f278382bcab2da831c64e546d7e0e087acc4fe,
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun lock_reward(arg0: &mut Global, arg1: &mut 0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::Global, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xb2a79beac8a092b336f560ba27f278382bcab2da831c64e546d7e0e087acc4fe, 6);
        assert!(0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::query_left_challenge_time(arg1, arg2) == 0, 19);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI) / 10;
        0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::top_up_challenge_pool(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, v0));
        let v1 = 1;
        while (v1 <= 20) {
            0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::push_reward_amount(arg1, 0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::get_reward_amount_by_rank(arg1, v0, 0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::calculate_scores(arg1), v1));
            v1 = v1 + 1;
        };
        0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::lock_pool(arg1);
    }

    entry fun mint_arena_chess(arg0: &0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Global, arg1: &mut Global, arg2: &mut 0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::RewardsGlobal, arg3: 0x1::string::String, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 9);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, arg4);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        let v3 = v2 / 20;
        assert!(0x43511aee799bf4de32a617733993c346b4117e26fa17c16bfd5f90611f38194f::utils::check_ticket_gold_cost(v2), 3);
        let v4 = Chess{
            id             : 0x2::object::new(arg5),
            name           : arg3,
            lineup         : 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::empty(arg5),
            cards_pool     : 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::generate_random_cards(arg0, arg5),
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
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v2 - v3, arg5)));
        0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::top_up_balance_pool(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
        arg1.total_chesses = arg1.total_chesses + 1;
        0x2::transfer::public_transfer<Chess>(v4, v0);
    }

    entry fun mint_chess(arg0: &0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Global, arg1: &mut Global, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 9);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Chess{
            id             : 0x2::object::new(arg3),
            name           : arg2,
            lineup         : 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::empty(arg3),
            cards_pool     : 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::generate_random_cards(arg0, arg3),
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

    entry fun mint_invite_arena_chess(arg0: &0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Global, arg1: &mut Global, arg2: &mut 0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::RewardsGlobal, arg3: 0x1::string::String, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: &mut 0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::MetaInfoGlobal, arg6: &0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::MetaIdentity, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 9);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, arg4);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        let v3 = v2 / 10;
        assert!(0x43511aee799bf4de32a617733993c346b4117e26fa17c16bfd5f90611f38194f::utils::check_ticket_gold_cost(v2), 3);
        let v4 = Chess{
            id             : 0x2::object::new(arg7),
            name           : arg3,
            lineup         : 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::empty(arg7),
            cards_pool     : 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::generate_random_cards(arg0, arg7),
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
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v2 - v3, arg7)));
        0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::top_up_rewards_pool(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg7)), 0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::get_invited_metaId(arg6), v3);
        if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
        arg1.total_chesses = arg1.total_chesses + 1;
        0x2::transfer::public_transfer<Chess>(v4, v0);
        0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::record_invited_success(arg5, arg6);
    }

    public entry fun operate_and_battle(arg0: &mut Global, arg1: &0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Global, arg2: &mut 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::Global, arg3: &mut 0x255cafab94384ff817450535c39d55c65007fcce9cbef1b1f53fec14f67f3dd4::challenge::Global, arg4: &mut Chess, arg5: vector<0x1::string::String>, arg6: u8, arg7: vector<0x1::string::String>, arg8: &mut 0xcd53b9b1f6bec17a3a2643eaf9bd60577e13341f4cfc50f029f3fe51bf493ade::metaIdentity::MetaIdentity, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg7) == 6, 2);
        let v0 = arg4.lineup;
        let v1 = 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::get_mut_roles(&mut v0);
        let v2 = 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::get_mut_roles(&mut arg4.cards_pool);
        let v3 = verify_operation(arg1, v1, v2, arg5, arg6, arg7, arg4.name, (arg4.gold as u8), arg4.gold_cost, arg9);
        if (arg4.challenge_win + arg4.challenge_lose >= 20) {
            arg4.gold = 0;
        } else {
            arg4.gold = 10;
        };
        0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::set_hash(&mut v3, 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::get_hash(&arg4.lineup));
        arg4.lineup = v3;
        battle(arg1, arg2, arg3, arg4, arg8, arg9);
        arg0.total_battle = arg0.total_battle + 1;
    }

    fun refresh_cards_pools(arg0: &0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Global, arg1: &mut Chess, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.cards_pool = 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::generate_random_cards(arg0, arg2);
    }

    public fun split_amount(arg0: u64, arg1: &mut Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xb2a79beac8a092b336f560ba27f278382bcab2da831c64e546d7e0e087acc4fe, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance_SUI, arg0), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun top_up_arena_pool(arg0: &mut Global, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0), arg2)));
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    public fun upgradeVersion(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 8);
        arg0.version = arg1;
    }

    fun verify_operation(arg0: &0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Global, arg1: &mut vector<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>, arg2: &mut vector<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>, arg3: vector<0x1::string::String>, arg4: u8, arg5: vector<0x1::string::String>, arg6: 0x1::string::String, arg7: u8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::LineUp {
        let v0 = 0;
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        while (0x1::vector::length<0x1::string::String>(&arg3) > 0) {
            let v1 = 0x1::vector::pop_back<0x1::string::String>(&mut arg3);
            if (v1 == 0x1::string::utf8(b"refresh")) {
                let v2 = arg7;
                arg7 = v2 - 2;
                let v3 = v0 + 1;
                v0 = v3;
                if (v3 == 6) {
                    v0 = 0;
                };
                0x1::debug::print<0x1::string::String>(&v1);
                continue
            };
            let (v4, v5) = 0x43511aee799bf4de32a617733993c346b4117e26fa17c16bfd5f90611f38194f::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
            let v6 = v5;
            let v7 = v4;
            assert!(0x1::vector::length<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg1) > v6, 7);
            if (v1 == 0x1::string::utf8(b"buy_upgrade")) {
                let v8 = v7 + 5 * v0;
                0x1::debug::print<0x1::string::String>(&v1);
                0x1::debug::print<u64>(&v8);
                0x1::debug::print<u64>(&v6);
                let v9 = 0x1::vector::length<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg2);
                0x1::debug::print<u64>(&v9);
                assert!(0x1::vector::length<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg2) > v8, 7);
                let v10 = 0x1::vector::borrow_mut<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg2, v8);
                assert!(0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_class(v10) != 0x1::string::utf8(b"none"), 2);
                let v11 = 0x1::vector::borrow_mut<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg1, v6);
                assert!(0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_class(v11) != 0x1::string::utf8(b"none"), 2);
                assert!(0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::upgrade(arg0, v10, v11), 3);
                0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::set_class(v10, 0x1::string::utf8(b"none"));
                let v12 = arg7;
                arg7 = v12 - 0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_gold_cost(v10);
                continue
            };
            if (v1 == 0x1::string::utf8(b"buy")) {
                let v13 = v7 + 5 * v0;
                0x1::debug::print<0x1::string::String>(&v1);
                0x1::debug::print<u64>(&v7);
                0x1::debug::print<u64>(&v13);
                0x1::debug::print<u64>(&v6);
                assert!(0x1::vector::length<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg2) > v13, 7);
                let v14 = 0x1::vector::borrow_mut<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg2, v13);
                assert!(0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_class(v14) != 0x1::string::utf8(b"none"), 2);
                let v15 = 0x1::vector::borrow_mut<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg1, v6);
                assert!(0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_class(v15) == 0x1::string::utf8(b"none"), 1);
                0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::set_role(v15, v14);
                0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::set_class(v14, 0x1::string::utf8(b"none"));
                let v16 = arg7;
                arg7 = v16 - 0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_gold_cost(v14);
                continue
            };
            if (v1 == 0x1::string::utf8(b"swap")) {
                0x1::debug::print<0x1::string::String>(&v1);
                0x1::debug::print<u64>(&v7);
                0x1::debug::print<u64>(&v6);
                0x1::vector::swap<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg1, v7, v6);
                continue
            };
            if (v1 == 0x1::string::utf8(b"sell")) {
                assert!(0x1::vector::length<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg1) > v7, 7);
                let v17 = 0x1::vector::borrow_mut<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg1, v7);
                0x1::debug::print<0x1::string::String>(&v1);
                0x1::debug::print<u64>(&v7);
                0x1::debug::print<u64>(&v6);
                assert!(0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_class(v17) != 0x1::string::utf8(b"none"), 1);
                0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::set_class(v17, 0x1::string::utf8(b"none"));
                let v18 = arg7;
                arg7 = v18 + 0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_sell_gold_cost(v17);
                continue
            };
            if (v1 == 0x1::string::utf8(b"upgrade")) {
                assert!(v7 != v6, 4);
                assert!(0x1::vector::length<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg1) > v7, 7);
                let v19 = *0x1::vector::borrow<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg1, v7);
                let v20 = 0x1::vector::borrow_mut<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg1, v6);
                0x1::debug::print<0x1::string::String>(&v1);
                0x1::debug::print<u64>(&v7);
                0x1::debug::print<u64>(&v6);
                assert!(0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_class(&v19) != 0x1::string::utf8(b"none"), 2);
                assert!(0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::get_class(v20) != 0x1::string::utf8(b"none"), 2);
                assert!(0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::upgrade(arg0, &v19, v20), 3);
                0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::set_class(0x1::vector::borrow_mut<0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::Role>(arg1, v7), 0x1::string::utf8(b"none"));
            };
        };
        let v21 = 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::parse_lineup_str_vec(arg6, arg0, arg5, arg8, arg9);
        assert!(0x386c8cd21b7ba319b8e18eedcb32b119ec966940236bab0e2e037806089568a9::role::check_roles_equality(arg1, 0xa54718d01b0389f1d2cc05241efd0df098b4bf4ae4d26d3f306e0447da4ba87f::lineup::get_roles(&v21)), 5);
        assert!(arg7 == arg4, 6);
        let v22 = 0x1::string::utf8(b"Gold left: ");
        0x1::debug::print<0x1::string::String>(&v22);
        0x1::debug::print<u8>(&arg7);
        v21
    }

    // decompiled from Move bytecode v6
}

