module 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_duel {
    struct HouseMatch has key {
        id: 0x2::object::UID,
        player: address,
        player_session: address,
        player_miner: 0x1::option::Option<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>,
        house_miner: 0x1::option::Option<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>,
        house_miner_id: 0x2::object::ID,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        player_hp: u64,
        house_hp: u64,
        player_stamina: u64,
        house_stamina: u64,
        round: u8,
        resolved: bool,
        player_gem_uses: u8,
        player_shield_uses: u8,
        house_gem_uses: u8,
        house_shield_uses: u8,
        history: vector<HouseRoundLog>,
    }

    struct HouseRoundLog has copy, drop, store {
        round: u8,
        player_move: u8,
        house_move: u8,
        player_dealt: u64,
        house_dealt: u64,
        player_self_damage: u64,
        house_self_damage: u64,
        player_hp: u64,
        house_hp: u64,
        player_stamina: u64,
        house_stamina: u64,
    }

    struct HouseMatchCreated has copy, drop {
        match_id: 0x2::object::ID,
        player: address,
        player_session: address,
        house_miner_id: 0x2::object::ID,
        extra_wager_mist: u64,
    }

    struct HouseRoundResolved has copy, drop {
        match_id: 0x2::object::ID,
        round: u8,
        player_move: u8,
        house_move: u8,
        player_dealt: u64,
        house_dealt: u64,
        player_self_damage: u64,
        house_self_damage: u64,
        player_hp: u64,
        house_hp: u64,
        player_stamina: u64,
        house_stamina: u64,
    }

    struct HouseDuelResolved has copy, drop {
        match_id: 0x2::object::ID,
        player_won: bool,
        house_miner_id: 0x2::object::ID,
    }

    fun apply_player_move(arg0: &mut HouseMatch, arg1: u8) {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else if (arg1 == 3) {
            true
        } else if (arg1 == 4) {
            true
        } else {
            arg1 == 5
        };
        assert!(v0, 3);
        if (arg1 == 3) {
            assert!(arg0.player_gem_uses < 2, 5);
            arg0.player_gem_uses = arg0.player_gem_uses + 1;
        } else if (arg1 == 4) {
            assert!(arg0.player_shield_uses < 3, 6);
            arg0.player_shield_uses = arg0.player_shield_uses + 1;
        };
    }

    fun apply_stamina_cost(arg0: u8, arg1: u64) : (u64, u64) {
        let v0 = saturating_add_capped(arg1, 2, 100);
        if (arg0 != 0 && arg0 != 1) {
            return (v0, 0)
        };
        let v1 = if (arg0 == 0) {
            10
        } else {
            45
        };
        if (v1 <= v0) {
            (v0 - v1, 0)
        } else {
            let v4 = (v1 - v0) / 2;
            let v5 = if (v4 > damage_for(arg0)) {
                damage_for(arg0)
            } else {
                v4
            };
            (0, v5)
        }
    }

    public fun create_house_match(arg0: &mut 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::Treasury, arg1: 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == 1000000000, 0);
        assert!(0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::holds_miner(arg0, arg2), 1);
        0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::fund_treasury(arg0, arg4);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        if (v1 > 0) {
            assert!(0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::treasury_balance(arg0) >= v1, 8);
            0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::coin::into_balance<0x2::sui::SUI>(0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::payout(arg0, v1, arg6)));
        };
        let v3 = HouseMatch{
            id                 : 0x2::object::new(arg6),
            player             : v0,
            player_session     : arg3,
            player_miner       : 0x1::option::some<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(arg1),
            house_miner        : 0x1::option::some<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::take_miner(arg0, arg2)),
            house_miner_id     : arg2,
            pot                : v2,
            player_hp          : 100,
            house_hp           : 100,
            player_stamina     : 100,
            house_stamina      : 100,
            round              : 0,
            resolved           : false,
            player_gem_uses    : 0,
            player_shield_uses : 0,
            house_gem_uses     : 0,
            house_shield_uses  : 0,
            history            : 0x1::vector::empty<HouseRoundLog>(),
        };
        let v4 = HouseMatchCreated{
            match_id         : 0x2::object::id<HouseMatch>(&v3),
            player           : v0,
            player_session   : arg3,
            house_miner_id   : arg2,
            extra_wager_mist : v1,
        };
        0x2::event::emit<HouseMatchCreated>(v4);
        0x2::transfer::share_object<HouseMatch>(v3);
    }

    fun damage_for(arg0: u8) : u64 {
        if (arg0 == 0) {
            10
        } else if (arg0 == 1) {
            20
        } else if (arg0 == 5) {
            20
        } else {
            0
        }
    }

    public fun forfeit_house_match(arg0: &mut HouseMatch, arg1: &mut 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.player, 7);
        resolve_house_wins(arg0, arg1, arg2);
    }

    fun legal_house_moves(arg0: u8, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, 2);
        if (arg0 < 2) {
            0x1::vector::push_back<u8>(&mut v0, 3);
        };
        if (arg1 < 3) {
            0x1::vector::push_back<u8>(&mut v0, 4);
        };
        v0
    }

    fun pick_house_move(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u8) : u8 {
        let v0 = 0;
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        while (v3 < 5) {
            let v4 = if (v3 == 0) {
                0
            } else if (v3 == 1) {
                1
            } else if (v3 == 2) {
                2
            } else if (v3 == 3) {
                3
            } else {
                4
            };
            if (v4 == 3 && arg5 < 2 || v4 == 4 && arg6 < 3 || true) {
                let (v5, v6, _, _, _, _, _, _) = simulate_round(arg0, v4, arg2, arg1, arg4, arg3);
                let v13 = if (v5 == 0) {
                    2
                } else if (v6 > 0) {
                    1
                } else {
                    0
                };
                let v14 = if (!v2) {
                    true
                } else if (v13 > v1) {
                    true
                } else {
                    v13 == v1 && v6 + 100 - v5 > 0
                };
                if (v14) {
                    v0 = v4;
                    v2 = true;
                };
            };
            v3 = v3 + 1;
        };
        v0
    }

    fun pick_house_move_dumb(arg0: &mut 0x2::random::RandomGenerator, arg1: u8, arg2: u8) : u8 {
        let v0 = legal_house_moves(arg1, arg2);
        *0x1::vector::borrow<u8>(&v0, 0x2::random::generate_u64_in_range(arg0, 0, 0x1::vector::length<u8>(&v0) - 1))
    }

    public fun rebind_house_session(arg0: &mut HouseMatch, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.player, 7);
        arg0.player_session = arg1;
    }

    fun resolve_house_round(arg0: &mut HouseMatch, arg1: &mut 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::Treasury, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3 == 3) {
            arg0.house_gem_uses = arg0.house_gem_uses + 1;
        } else if (arg3 == 4) {
            arg0.house_shield_uses = arg0.house_shield_uses + 1;
        };
        let (v0, v1, v2, v3, v4, v5, v6, v7) = simulate_round(arg2, arg3, arg0.player_hp, arg0.house_hp, arg0.player_stamina, arg0.house_stamina);
        arg0.player_hp = v0;
        arg0.house_hp = v1;
        arg0.player_stamina = v2;
        arg0.house_stamina = v3;
        arg0.round = arg0.round + 1;
        let v8 = HouseRoundResolved{
            match_id           : 0x2::object::id<HouseMatch>(arg0),
            round              : arg0.round,
            player_move        : arg2,
            house_move         : arg3,
            player_dealt       : v4,
            house_dealt        : v5,
            player_self_damage : v6,
            house_self_damage  : v7,
            player_hp          : arg0.player_hp,
            house_hp           : arg0.house_hp,
            player_stamina     : arg0.player_stamina,
            house_stamina      : arg0.house_stamina,
        };
        0x2::event::emit<HouseRoundResolved>(v8);
        let v9 = HouseRoundLog{
            round              : arg0.round,
            player_move        : arg2,
            house_move         : arg3,
            player_dealt       : v4,
            house_dealt        : v5,
            player_self_damage : v6,
            house_self_damage  : v7,
            player_hp          : arg0.player_hp,
            house_hp           : arg0.house_hp,
            player_stamina     : arg0.player_stamina,
            house_stamina      : arg0.house_stamina,
        };
        0x1::vector::push_back<HouseRoundLog>(&mut arg0.history, v9);
        if (arg0.player_hp == 0) {
            resolve_house_wins(arg0, arg1, arg4);
        } else if (arg0.house_hp == 0) {
            resolve_player_wins(arg0, arg4);
        } else if (arg0.round >= 50) {
            if (arg0.player_hp > arg0.house_hp) {
                resolve_player_wins(arg0, arg4);
            } else {
                resolve_house_wins(arg0, arg1, arg4);
            };
        };
    }

    fun resolve_house_wins(arg0: &mut HouseMatch, arg1: &mut 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.resolved = true;
        0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::deposit_nft(arg1, 0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.player_miner));
        0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::deposit_nft(arg1, 0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.house_miner));
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v0 > 0) {
            0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::fund_treasury(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v0), arg2));
        };
        let v1 = HouseDuelResolved{
            match_id       : 0x2::object::id<HouseMatch>(arg0),
            player_won     : false,
            house_miner_id : arg0.house_miner_id,
        };
        0x2::event::emit<HouseDuelResolved>(v1);
    }

    fun resolve_player_wins(arg0: &mut HouseMatch, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.resolved = true;
        let v0 = arg0.player;
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.player_miner), v0);
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.house_miner), v0);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v1 > 0) {
            let v2 = v1 / 2;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v2), arg1), v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v1 - v2), arg1), v0);
        };
        let v3 = HouseDuelResolved{
            match_id       : 0x2::object::id<HouseMatch>(arg0),
            player_won     : true,
            house_miner_id : arg0.house_miner_id,
        };
        0x2::event::emit<HouseDuelResolved>(v3);
    }

    fun saturating_add_capped(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 + arg1;
        if (v0 > arg2) {
            arg2
        } else {
            v0
        }
    }

    fun saturating_sub(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    fun simulate_round(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, v1) = apply_stamina_cost(arg0, arg4);
        let (v2, v3) = apply_stamina_cost(arg1, arg5);
        let v4 = damage_for(arg0);
        let v5 = v4;
        let v6 = damage_for(arg1);
        let v7 = v6;
        if (arg1 == 2) {
            v5 = v4 / 2;
        };
        if (arg0 == 2) {
            v7 = v6 / 2;
        };
        if (arg1 == 4) {
            v5 = 0;
            v7 = v7 + 6;
        };
        if (arg0 == 4) {
            v7 = 0;
            v5 = v5 + 6;
        };
        let v8 = saturating_sub(saturating_sub(arg2, v7), v1);
        let v9 = v8;
        let v10 = saturating_sub(saturating_sub(arg3, v5), v3);
        let v11 = v10;
        if (arg0 == 3) {
            v9 = saturating_add_capped(v8, 18, 100);
        };
        if (arg1 == 3) {
            v11 = saturating_add_capped(v10, 18, 100);
        };
        (v9, v11, v0, v2, v5, v7, v1, v3)
    }

    public fun submit_house_move(arg0: &mut HouseMatch, arg1: &mut 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::Treasury, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 4);
        assert!(0x2::tx_context::sender(arg3) == arg0.player_session, 2);
        apply_player_move(arg0, arg2);
        let v0 = pick_house_move(arg2, arg0.house_hp, arg0.player_hp, arg0.house_stamina, arg0.player_stamina, arg0.house_gem_uses, arg0.house_shield_uses);
        resolve_house_round(arg0, arg1, arg2, v0, arg3);
    }

    entry fun submit_house_move_v2(arg0: &mut HouseMatch, arg1: &mut 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::Treasury, arg2: u8, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 4);
        assert!(0x2::tx_context::sender(arg4) == arg0.player_session, 2);
        apply_player_move(arg0, arg2);
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = if (0x2::random::generate_u32_in_range(&mut v0, 0, 99) < 35) {
            pick_house_move(arg2, arg0.house_hp, arg0.player_hp, arg0.house_stamina, arg0.player_stamina, arg0.house_gem_uses, arg0.house_shield_uses)
        } else {
            let v2 = &mut v0;
            pick_house_move_dumb(v2, arg0.house_gem_uses, arg0.house_shield_uses)
        };
        resolve_house_round(arg0, arg1, arg2, v1, arg4);
    }

    // decompiled from Move bytecode v7
}

