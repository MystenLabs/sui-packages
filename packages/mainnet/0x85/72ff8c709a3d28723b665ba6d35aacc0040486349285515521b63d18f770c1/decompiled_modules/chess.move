module 0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::chess {
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
        lineup: 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::LineUp,
        cards_pool_roles: vector<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>,
        cards_pool_items: vector<0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::Item>,
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
        v2_lineup: 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::LineUp,
        res: u8,
    }

    fun fight(arg0: &mut Chess, arg1: &0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::LineUp, arg2: bool, arg3: &0x2::tx_context::TxContext) : bool {
        let v0 = arg0.lineup;
        let v1 = *arg1;
        let v2 = *0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_roles(&v0);
        0x1::vector::reverse<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v2);
        let v3 = *0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_roles(&v1);
        0x1::vector::reverse<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v3);
        let v4 = 0x1::vector::pop_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v2);
        let v5 = &mut v4;
        let v6 = 0x1::vector::pop_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v3);
        let v7 = &mut v6;
        0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::remove_none_roles(&mut v2);
        0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::remove_none_roles(&mut v3);
        let v8 = 0x2::vec_map::empty<0x1::string::String, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::Int_wrapper>();
        let v9 = 0x2::vec_map::empty<0x1::string::String, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::Int_wrapper>();
        0x2::vec_map::insert<0x1::string::String, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::Int_wrapper>(&mut v9, 0x1::string::utf8(b"invalid"), 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::generate_wrapper_with_value(0));
        loop {
            let v10 = 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_speed(v5);
            let v11 = 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_speed(v7);
            let v12 = v10 > v11;
            if (v10 == v11) {
                let v13 = 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_hash(arg1);
                let v14 = 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_hash(&v0);
                if (*0x1::vector::borrow<u8>(&v14, 0) > *0x1::vector::borrow<u8>(&v13, 0)) {
                    v12 = true;
                } else {
                    v12 = false;
                };
            };
            if (v12) {
                0x6e704f4fcdc267b0e01ae244bf740f99a9f5bfaa08c105ad7294d0dbba1a33e2::fight::action(v5, v7, &mut v2, &mut v3, &mut v8);
                if (0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_hp(v7) == 0 && 0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&v3) > 0) {
                    let v15 = 0x1::vector::pop_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v3);
                    v7 = &mut v15;
                    continue
                };
                if (0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_hp(v7) == 0) {
                    break
                };
                0x6e704f4fcdc267b0e01ae244bf740f99a9f5bfaa08c105ad7294d0dbba1a33e2::fight::action(v7, v5, &mut v3, &mut v2, &mut v9);
                if (0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_hp(v5) == 0 && 0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&v2) > 0) {
                    let v16 = 0x1::vector::pop_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v2);
                    v5 = &mut v16;
                };
                if (0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_hp(v5) == 0) {
                    break
                } else {
                    continue
                };
            };
            0x6e704f4fcdc267b0e01ae244bf740f99a9f5bfaa08c105ad7294d0dbba1a33e2::fight::action(v7, v5, &mut v3, &mut v2, &mut v9);
            if (0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_hp(v5) == 0 && 0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&v2) > 0) {
                let v17 = 0x1::vector::pop_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v2);
                v5 = &mut v17;
                continue
            };
            if (0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_hp(v5) == 0) {
                break
            };
            0x6e704f4fcdc267b0e01ae244bf740f99a9f5bfaa08c105ad7294d0dbba1a33e2::fight::action(v5, v7, &mut v2, &mut v3, &mut v8);
            if (0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_hp(v7) == 0 && 0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&v3) > 0) {
                let v18 = 0x1::vector::pop_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v3);
                v7 = &mut v18;
            };
            if (0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_hp(v7) == 0) {
                break
            };
        };
        let v19 = 0x1::string::utf8(b"--------After the battle---------");
        0x1::debug::print<0x1::string::String>(&v19);
        let v20 = 0x1::string::utf8(b"My acting hero");
        0x1::debug::print<0x1::string::String>(&v20);
        0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::print_role_short(v5);
        let v21 = 0x1::string::utf8(b"My rest team");
        0x1::debug::print<0x1::string::String>(&v21);
        0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::print_roles_short(&v2);
        let v22 = 0x1::string::utf8(b"Enmey acting hero");
        0x1::debug::print<0x1::string::String>(&v22);
        0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::print_role_short(v7);
        let v23 = 0x1::string::utf8(b"Enmey rest team");
        0x1::debug::print<0x1::string::String>(&v23);
        0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::print_roles_short(&v3);
        let v24 = 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_mut_roles(&mut arg0.lineup);
        if (0x2::vec_map::size<0x1::string::String, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::Int_wrapper>(&v8) > 0) {
            let v25 = 0x1::string::utf8(b"--------miao--------");
            0x1::debug::print<0x1::string::String>(&v25);
            0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::permenant_increase_role_hp(v24, &v8);
        };
        let v26 = 0x1::string::utf8(b"--------Permenant roles After the battle---------");
        0x1::debug::print<0x1::string::String>(&v26);
        0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::print_roles_short(v24);
        let v27 = if (0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_hp(v5) > 0) {
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
        let v28 = FightEvent{
            chess_id          : 0x2::object::id_address<Chess>(arg0),
            v1                : 0x2::tx_context::sender(arg3),
            v1_name           : arg0.name,
            v1_win            : arg0.win,
            v1_lose           : arg0.lose,
            v1_challenge_win  : arg0.challenge_win,
            v1_challenge_lose : arg0.challenge_lose,
            v2_name           : 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_name(arg1),
            v2_lineup         : *arg1,
            res               : 2,
        };
        0x2::event::emit<FightEvent>(v28);
        v27
    }

    fun battle(arg0: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg1: &mut 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::Global, arg2: &mut 0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::Global, arg3: &mut Chess, arg4: &mut 0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::MetaIdentity, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.lose <= 2, 1);
        let v0 = false;
        let v1 = if (arg3.win >= 10) {
            assert!(arg3.arena, 18);
            assert!(arg3.challenge_lose <= 2, 1);
            v0 = true;
            *0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::get_lineup_by_rank(arg2, 20 - arg3.challenge_win)
        } else {
            0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::select_random_lineup(arg3.win, arg3.lose, arg1, arg3.arena, arg5)
        };
        if (fight(arg3, &v1, v0, arg5)) {
            if (v0) {
                0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::rank_forward(arg2, arg3.lineup);
                0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::record_update_best_rank(arg4, 0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::find_rank(arg2, &arg3.lineup));
            } else {
                0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::record_player_lineup(arg3.win - 1, arg3.lose, arg1, arg3.lineup, arg3.arena);
                if (arg3.win == 10) {
                    0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::record_player_lineup(arg3.win, arg3.lose, arg1, arg3.lineup, arg3.arena);
                };
            };
            0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::record_add_win(arg4);
        } else {
            if (!v0) {
                0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::record_player_lineup(arg3.win, arg3.lose - 1, arg1, arg3.lineup, arg3.arena);
            };
            0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::record_add_lose(arg4);
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
            id               : v0,
            name             : _,
            lineup           : _,
            cards_pool_roles : _,
            cards_pool_items : _,
            gold             : _,
            win              : _,
            lose             : _,
            challenge_win    : _,
            challenge_lose   : _,
            creator          : _,
            gold_cost        : _,
            arena            : _,
            arena_checked    : v13,
        } = arg1;
        if (!v13) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::estimate_reward(get_total_sui_amount(arg0), arg1.gold_cost, arg1.win)), arg2), 0x2::tx_context::sender(arg2));
        };
        0x2::object::delete(v0);
    }

    entry fun check_out_arena_fee(arg0: &mut Global, arg1: &mut Chess, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 9);
        assert!(arg1.arena, 4);
        assert!(!arg1.arena_checked, 20);
        arg1.arena_checked = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::estimate_reward(get_total_sui_amount(arg0), arg1.gold_cost, arg1.win)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_rank_reward(arg0: &mut 0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::Global, arg1: Chess, arg2: &0x2::clock::Clock, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::query_left_challenge_time(arg0, arg2) == 0, 19);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_creator(0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::get_lineup_by_rank(arg0, arg3)) == v0) {
            let Chess {
                id               : v1,
                name             : _,
                lineup           : _,
                cards_pool_roles : _,
                cards_pool_items : _,
                gold             : _,
                win              : _,
                lose             : _,
                challenge_win    : _,
                challenge_lose   : _,
                creator          : _,
                gold_cost        : _,
                arena            : _,
                arena_checked    : _,
            } = arg1;
            0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::send_reward_by_rank(arg0, arg3, arg4);
            0x2::object::delete(v1);
        } else {
            0x2::transfer::public_transfer<Chess>(arg1, v0);
        };
    }

    entry fun create_random_items_for_cards(arg0: &0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::ItemsGlobal, arg1: &mut 0x2::tx_context::TxContext) : vector<0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::Item> {
        let v0 = 0x1::vector::empty<0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::Item>();
        let v1 = 0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::get_items_keys(arg0);
        let v2 = 0;
        while (v2 < 18) {
            0x1::vector::push_back<0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::Item>(&mut v0, 0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::get_item_by_name(arg0, 0x1::vector::borrow<0x1::string::String>(&v1, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_random_num(0, 10, v2, arg1))));
            v2 = v2 + 1;
        };
        v0
    }

    entry fun create_random_roles_for_cards(arg0: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg1: &mut 0x2::tx_context::TxContext) : vector<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role> {
        let v0 = 0x1::vector::empty<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>();
        let v1 = 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_chars_keys(arg0);
        let v2 = 0;
        while (v2 < 30) {
            0x1::vector::push_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v0, 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_role_by_class(arg0, *0x1::vector::borrow<0x1::string::String>(&v1, 5 * 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_random_num(0, 15, v2, arg1))));
            v2 = v2 + 1;
        };
        v0
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
            manager       : @0xbe379359ac6e9d0fc0b867f147f248f1c2d9fc019a9a708adfcbe15fc3130c18,
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun lock_reward(arg0: &mut Global, arg1: &mut 0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::Global, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xbe379359ac6e9d0fc0b867f147f248f1c2d9fc019a9a708adfcbe15fc3130c18, 6);
        assert!(0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::query_left_challenge_time(arg1, arg2) == 0, 19);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI) / 10;
        0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::top_up_challenge_pool(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, v0));
        let v1 = 1;
        while (v1 <= 20) {
            0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::push_reward_amount(arg1, 0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::get_reward_amount_by_rank(arg1, v0, 0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::calculate_scores(arg1), v1));
            v1 = v1 + 1;
        };
        0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::lock_pool(arg1);
    }

    entry fun mint_arena_chess(arg0: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg1: &mut Global, arg2: &mut 0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::RewardsGlobal, arg3: &0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::ItemsGlobal, arg4: 0x1::string::String, arg5: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 9);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg5);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, arg5);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        let v3 = v2 / 20;
        assert!(0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::check_ticket_gold_cost(v2), 3);
        let v4 = 0x2::object::new(arg6);
        let v5 = 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::empty(arg6);
        let v6 = create_random_items_for_cards(arg3, arg6);
        let v7 = create_random_roles_for_cards(arg0, arg6);
        let v8 = Chess{
            id               : v4,
            name             : arg4,
            lineup           : v5,
            cards_pool_roles : v7,
            cards_pool_items : v6,
            gold             : 10,
            win              : 0,
            lose             : 0,
            challenge_win    : 0,
            challenge_lose   : 0,
            creator          : v0,
            gold_cost        : v2,
            arena            : true,
            arena_checked    : false,
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v2 - v3, arg6)));
        0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::top_up_balance_pool(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg6)));
        if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
        arg1.total_chesses = arg1.total_chesses + 1;
        0x2::transfer::public_transfer<Chess>(v8, v0);
    }

    entry fun mint_chess(arg0: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg1: &0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::ItemsGlobal, arg2: &mut Global, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 9);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::empty(arg4);
        let v3 = create_random_items_for_cards(arg1, arg4);
        let v4 = Chess{
            id               : v1,
            name             : arg3,
            lineup           : v2,
            cards_pool_roles : create_random_roles_for_cards(arg0, arg4),
            cards_pool_items : v3,
            gold             : 10,
            win              : 0,
            lose             : 0,
            challenge_win    : 0,
            challenge_lose   : 0,
            creator          : v0,
            gold_cost        : 0,
            arena            : false,
            arena_checked    : true,
        };
        arg2.total_chesses = arg2.total_chesses + 1;
        0x2::transfer::public_transfer<Chess>(v4, v0);
    }

    entry fun mint_invite_arena_chess(arg0: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg1: &mut Global, arg2: &0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::ItemsGlobal, arg3: &mut 0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::RewardsGlobal, arg4: 0x1::string::String, arg5: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &mut 0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::MetaInfoGlobal, arg7: &0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::MetaIdentity, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 9);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg5);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, arg5);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        let v3 = v2 / 10;
        assert!(0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::check_ticket_gold_cost(v2), 3);
        let v4 = 0x2::object::new(arg8);
        let v5 = 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::empty(arg8);
        let v6 = create_random_items_for_cards(arg2, arg8);
        let v7 = create_random_roles_for_cards(arg0, arg8);
        let v8 = Chess{
            id               : v4,
            name             : arg4,
            lineup           : v5,
            cards_pool_roles : v7,
            cards_pool_items : v6,
            gold             : 10,
            win              : 0,
            lose             : 0,
            challenge_win    : 0,
            challenge_lose   : 0,
            creator          : v0,
            gold_cost        : v2,
            arena            : true,
            arena_checked    : false,
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v2 - v3, arg8)));
        0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::top_up_rewards_pool(arg3, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg8)), 0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::get_invited_metaId(arg7), v3);
        if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
        arg1.total_chesses = arg1.total_chesses + 1;
        0x2::transfer::public_transfer<Chess>(v8, v0);
        0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::record_invited_success(arg6, arg7);
    }

    public entry fun operate_and_battle(arg0: &mut Global, arg1: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg2: &0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::ItemsGlobal, arg3: &mut 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::Global, arg4: &mut 0x403402d86e16ff3dc413de207ee246a2af8b01fe04ed04584d945457c0653041::challenge::Global, arg5: &mut Chess, arg6: vector<0x1::string::String>, arg7: u8, arg8: vector<0x1::string::String>, arg9: &mut 0x8572ff8c709a3d28723b665ba6d35aacc0040486349285515521b63d18f770c1::metaIdentity::MetaIdentity, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg8) == 6, 2);
        let v0 = arg5.lineup;
        0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_mut_roles(&mut v0);
        0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_mut_roles(&mut arg5.lineup);
        let v1 = 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::parse_lineup_str_vec(arg5.name, arg1, arg8, arg5.gold_cost, arg10);
        if (arg5.challenge_win + arg5.challenge_lose >= 20) {
            arg5.gold = 0;
        } else {
            arg5.gold = 10;
        };
        0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::set_hash(&mut v1, 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_hash(&arg5.lineup));
        arg5.lineup = v1;
        let v2 = create_random_items_for_cards(arg2, arg10);
        arg5.cards_pool_items = v2;
        battle(arg1, arg3, arg4, arg5, arg9, arg10);
        arg0.total_battle = arg0.total_battle + 1;
    }

    fun refresh_cards_pools(arg0: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg1: &mut Chess, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.cards_pool_roles = create_random_roles_for_cards(arg0, arg2);
    }

    public fun split_amount(arg0: u64, arg1: &mut Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xbe379359ac6e9d0fc0b867f147f248f1c2d9fc019a9a708adfcbe15fc3130c18, 6);
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

    fun verify_operation(arg0: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg1: &0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::ItemsGlobal, arg2: &mut vector<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>, arg3: &mut vector<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>, arg4: vector<0x1::string::String>, arg5: u8, arg6: vector<0x1::string::String>, arg7: 0x1::string::String, arg8: u8, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::LineUp {
        let v0 = 0;
        0x1::vector::reverse<0x1::string::String>(&mut arg4);
        while (0x1::vector::length<0x1::string::String>(&arg4) > 0) {
            let v1 = 0x1::vector::pop_back<0x1::string::String>(&mut arg4);
            if (v1 == 0x1::string::utf8(b"refresh")) {
                let v2 = arg8;
                arg8 = v2 - 2;
                let v3 = v0 + 1;
                v0 = v3;
                if (v3 == 6) {
                    v0 = 0;
                };
                0x1::debug::print<0x1::string::String>(&v1);
                continue
            };
            let v4 = 0x1::vector::pop_back<0x1::string::String>(&mut arg4);
            let v5 = 0;
            let v6 = 0x1::string::utf8(b"none");
            let v7 = if (v1 == 0x1::string::utf8(b"use_chess") || v1 == 0x1::string::utf8(b"buy_item") || v1 == 0x1::string::utf8(b"use_item")) {
                let (v8, v9) = 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_left_string_right_number(&v4);
                let v7 = v9;
                v6 = v8;
                v7
            } else {
                let (v10, v11) = 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_left_right_number(v4);
                let v7 = v11;
                v5 = v10;
                v7
            };
            assert!(0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2) > v7, 7);
            if (v1 == 0x1::string::utf8(b"buy_upgrade")) {
                let v12 = v5 + 5 * v0;
                0x1::debug::print<0x1::string::String>(&v1);
                0x1::debug::print<u64>(&v12);
                0x1::debug::print<u64>(&v7);
                let v13 = 0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg3);
                0x1::debug::print<u64>(&v13);
                let v14;
                assert!(0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg3) > v12, 7);
                let v15 = 0x1::vector::borrow_mut<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg3, v12);
                assert!(0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_class(v15) != 0x1::string::utf8(b"none"), 2);
                v14 = 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_gold_cost(v15);
                let v16 = 0x1::vector::borrow_mut<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2, v7);
                assert!(0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_class(v16) != 0x1::string::utf8(b"none"), 2);
                assert!(0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::upgrade(arg0, v15, v16), 3);
                0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::set_class(v15, 0x1::string::utf8(b"none"));
                let v17 = arg8;
                arg8 = v17 - v14;
                continue
            };
            if (v1 == 0x1::string::utf8(b"buy")) {
                let v18 = v5 + 5 * v0;
                0x1::debug::print<0x1::string::String>(&v1);
                0x1::debug::print<u64>(&v5);
                0x1::debug::print<u64>(&v18);
                0x1::debug::print<u64>(&v7);
                assert!(0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg3) > v18, 7);
                let v19 = 0x1::vector::borrow_mut<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg3, v18);
                assert!(0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_class(v19) != 0x1::string::utf8(b"none"), 2);
                let v14 = 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_gold_cost(v19);
                let v20 = 0x1::vector::borrow_mut<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2, v7);
                assert!(0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_class(v20) == 0x1::string::utf8(b"none"), 1);
                0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::set_role(v20, v19);
                0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::set_class(v19, 0x1::string::utf8(b"none"));
                let v21 = arg8;
                arg8 = v21 - v14;
                continue
            };
            if (v1 == 0x1::string::utf8(b"swap")) {
                0x1::debug::print<0x1::string::String>(&v1);
                0x1::debug::print<u64>(&v5);
                0x1::debug::print<u64>(&v7);
                0x1::vector::swap<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2, v5, v7);
                continue
            };
            if (v1 == 0x1::string::utf8(b"sell")) {
                assert!(0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2) > v5, 7);
                let v22 = 0x1::vector::borrow_mut<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2, v5);
                0x1::debug::print<0x1::string::String>(&v1);
                0x1::debug::print<u64>(&v5);
                0x1::debug::print<u64>(&v7);
                assert!(0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_class(v22) != 0x1::string::utf8(b"none"), 1);
                0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::set_class(v22, 0x1::string::utf8(b"none"));
                let v23 = arg8;
                arg8 = v23 + 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_sell_gold_cost(v22);
                continue
            };
            if (v1 == 0x1::string::utf8(b"upgrade")) {
                assert!(v5 != v7, 4);
                assert!(0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2) > v5, 7);
                let v24 = *0x1::vector::borrow<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2, v5);
                let v25 = 0x1::vector::borrow_mut<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2, v7);
                0x1::debug::print<0x1::string::String>(&v1);
                0x1::debug::print<u64>(&v5);
                0x1::debug::print<u64>(&v7);
                assert!(0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_class(&v24) != 0x1::string::utf8(b"none"), 2);
                assert!(0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_class(v25) != 0x1::string::utf8(b"none"), 2);
                assert!(0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::upgrade(arg0, &v24, v25), 3);
                0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::set_class(0x1::vector::borrow_mut<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2, v5), 0x1::string::utf8(b"none"));
                continue
            };
            if (v1 == 0x1::string::utf8(b"use_item")) {
                let v26 = v6;
                let v27 = 0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::get_item_by_name(arg1, &v26);
                let v28 = 0x1::vector::borrow_mut<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2, v7);
                if (v26 == 0x1::string::utf8(b"red_potion") || v26 == 0x1::string::utf8(b"purple_potion") || v26 == 0x1::string::utf8(b"whet_stone") || v26 == 0x1::string::utf8(b"chicken_drumstick")) {
                    0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::apply_item_group(arg2, &v27);
                } else {
                    0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::apply_item_single(v28, &v27);
                };
                let v29 = 0x1::string::utf8(b"use_item: item_name-to_index");
                0x1::debug::print<0x1::string::String>(&v29);
                0x1::debug::print<0x1::string::String>(&v26);
                0x1::debug::print<u64>(&v7);
                continue
            };
            if (v1 == 0x1::string::utf8(b"use_chess")) {
                let v30 = v6;
                let v31 = 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_role_by_class(arg0, v30);
                let v32 = 0x1::vector::borrow_mut<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(arg2, v7);
                let v33 = 0x1::string::utf8(b"use_chess: new_class-old_class");
                0x1::debug::print<0x1::string::String>(&v33);
                0x1::debug::print<0x1::string::String>(&v30);
                let v34 = 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_class(v32);
                0x1::debug::print<0x1::string::String>(&v34);
                0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::set_role(v32, &v31);
                continue
            };
            if (v1 == 0x1::string::utf8(b"buy_item")) {
                let v35 = v6;
                let v36 = 0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::get_item_by_name(arg1, &v35);
                let v14 = 0x35d64a33293caff0697d14a38aeb373f9d725d6a542212e75e1091e71f5f5422::item::get_item_price(&v36);
                let v37 = arg8;
                arg8 = v37 - v14;
                let v38 = 0x1::string::utf8(b"buy_item: item_name-cost");
                0x1::debug::print<0x1::string::String>(&v38);
                0x1::debug::print<0x1::string::String>(&v35);
                0x1::debug::print<u8>(&v14);
            };
        };
        let v39 = 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::parse_lineup_str_vec(arg7, arg0, arg6, arg9, arg10);
        assert!(0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::check_roles_equality(arg2, 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup::get_roles(&v39)), 5);
        assert!(arg8 == arg5, 6);
        let v40 = 0x1::string::utf8(b"Gold left: ");
        0x1::debug::print<0x1::string::String>(&v40);
        0x1::debug::print<u8>(&arg8);
        v39
    }

    // decompiled from Move bytecode v6
}

