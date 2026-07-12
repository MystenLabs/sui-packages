module 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::combat {
    struct HuntResolved has copy, drop {
        player_id: 0x2::object::ID,
        finds: u64,
        xp_gained: u64,
        enemy_ids: vector<u16>,
        counts: vector<u64>,
    }

    struct BattleResolved has copy, drop {
        player_id: 0x2::object::ID,
        enemy: u16,
        committed: u64,
        kills: u64,
        knocked_out: bool,
        stance: u8,
        xp_gained: u64,
        coins_gained: u64,
        food_refunded: u64,
        loot_kinds: vector<u16>,
        loot_qtys: vector<u64>,
    }

    fun ceil_div(arg0: u64, arg1: u64) : u64 {
        (arg0 + arg1 - 1) / arg1
    }

    fun resolve_battle(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::assert_version(arg1);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg3, arg4);
        let v0 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::take_action(arg0);
        assert!(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::action_kind(&v0) == 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::kind_battle(), 13906835243790761993);
        let v1 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::action_params(&v0);
        let v2 = (*0x1::vector::borrow<u64>(&v1, 0) as u16);
        let v3 = *0x1::vector::borrow<u64>(&v1, 1);
        let v4 = (*0x1::vector::borrow<u64>(&v1, 2) as u8);
        let v5 = (*0x1::vector::borrow<u64>(&v1, 3) as u16);
        let v6 = *0x1::vector::borrow<u64>(&v1, 4);
        let v7 = 0x1::u64::max(*0x1::vector::borrow<u64>(&v1, 6), 1);
        let v8 = (0x1::u64::min(0x1::u64::max(0x2::clock::timestamp_ms(arg3), 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::action_started_at_ms(&v0)), 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::action_started_at_ms(&v0) + 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::max_offline_ms(arg1)) - 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::action_started_at_ms(&v0)) / *0x1::vector::borrow<u64>(&v1, 5);
        let v9 = *0x1::vector::borrow<u64>(&v1, 7) / v7;
        let v10 = v9 <= 0x1::u64::min(v8, v3) && v9 < v3;
        let v11 = 0x1::u64::min(0x1::u64::min(v8, v9), v3);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_enemies(arg0, v2, v3 - v11);
        let v12 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy(arg1, v2);
        let v13 = 0;
        if (v6 > 0 && !v10) {
            let v14 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item(arg1, v5);
            let v15 = 50 + (0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::skill_level(arg0, 11) as u64) * 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::hp_per_level(arg1);
            let v16 = v11 * v7;
            let v17 = if (v16 > v15) {
                ceil_div(v16 - v15, 0x1::u64::max(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item_heal(&v14), 1))
            } else {
                0
            };
            let v18 = v6 - 0x1::u64::min(v17, v6);
            v13 = v18;
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_item(arg0, v5, v18);
        };
        let v19 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_xp_per_kill(&v12) * v11;
        route_stance_xp(arg0, v4, v19);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_xp(arg0, 11, v19 / 3);
        let v20 = 0x2::random::new_generator(arg2, arg4);
        let v21 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_loot_kinds(&v12);
        let v22 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_loot_qtys(&v12);
        let v23 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_loot_chances_bp(&v12);
        let v24 = vector[];
        let v25 = 0;
        while (v25 < 0x1::vector::length<u16>(&v21)) {
            let v26 = (v11 as u128) * (*0x1::vector::borrow<u64>(&v23, v25) as u128);
            let v27 = ((v26 % 10000) as u64);
            let v28 = if (v27 > 0 && 0x2::random::generate_u64_in_range(&mut v20, 0, 9999) < v27) {
                1
            } else {
                0
            };
            let v29 = (((v26 / 10000) as u64) + v28) * *0x1::vector::borrow<u64>(&v22, v25);
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_item(arg0, *0x1::vector::borrow<u16>(&v21, v25), v29);
            0x1::vector::push_back<u64>(&mut v24, v29);
            v25 = v25 + 1;
        };
        let v30 = v11 * 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_coin_min(&v12);
        let v31 = v11 * 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_coin_max(&v12);
        let v32 = if (v31 > v30) {
            0x2::random::generate_u64_in_range(&mut v20, v30, v31)
        } else {
            v30
        };
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_coins(arg0, v32);
        let v33 = BattleResolved{
            player_id     : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            enemy         : v2,
            committed     : v3,
            kills         : v11,
            knocked_out   : v10,
            stance        : v4,
            xp_gained     : v19,
            coins_gained  : v32,
            food_refunded : v13,
            loot_kinds    : v21,
            loot_qtys     : v24,
        };
        0x2::event::emit<BattleResolved>(v33);
    }

    public(friend) fun resolve_hunt(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = ((((0x1::u64::min(0x1::u64::max(0x2::clock::timestamp_ms(arg3), arg2), arg2 + 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::max_offline_ms(arg1)) - arg2) as u128) * (0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::hunt_finds_per_hour_base(arg1) as u128) * ((100 + (0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::skill_level(arg0, 6) as u64) + (0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::skill_level(arg0, 10) as u64)) as u128) / 100 / 3600000) as u64);
        let v1 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::location(arg1, 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::location(arg0));
        let v2 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::location_enemy_ids(&v1);
        let v3 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::location_enemy_weights(&v1);
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v3)) {
            v4 = v4 + *0x1::vector::borrow<u64>(&v3, v5);
            v5 = v5 + 1;
        };
        let v6 = vector[];
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u16>(&v2)) {
            let v10 = if (v4 == 0) {
                0
            } else {
                (((v0 as u128) * (*0x1::vector::borrow<u64>(&v3, v9) as u128) / (v4 as u128)) as u64)
            };
            0x1::vector::push_back<u64>(&mut v6, v10);
            v7 = v7 + v10;
            v9 = v9 + 1;
        };
        if (v0 > v7 && 0x1::vector::length<u64>(&v6) > 0) {
            let v11 = 0x1::vector::borrow_mut<u64>(&mut v6, v8);
            *v11 = *v11 + v0 - v7;
        };
        let v12 = 0;
        while (v12 < 0x1::vector::length<u16>(&v2)) {
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_enemies(arg0, *0x1::vector::borrow<u16>(&v2, v12), *0x1::vector::borrow<u64>(&v6, v12));
            v12 = v12 + 1;
        };
        let v13 = v0 * 80;
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_xp(arg0, 6, v13);
        let v14 = HuntResolved{
            player_id : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            finds     : v0,
            xp_gained : v13,
            enemy_ids : v2,
            counts    : v6,
        };
        0x2::event::emit<HuntResolved>(v14);
    }

    fun route_stance_xp(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: u8, arg2: u64) {
        if (arg1 == 4) {
            let v0 = arg2 / 4;
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_xp(arg0, 7, v0);
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_xp(arg0, 8, v0);
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_xp(arg0, 9, v0);
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_xp(arg0, 10, v0);
        } else {
            let v1 = if (arg1 == 0) {
                7
            } else if (arg1 == 1) {
                8
            } else if (arg1 == 2) {
                9
            } else {
                10
            };
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_xp(arg0, v1, arg2);
        };
    }

    public fun start_battle(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: u16, arg3: u64, arg4: u8, arg5: u16, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::assert_version(arg1);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg7, arg8);
        assert!(arg3 >= 1 && arg3 <= 500, 13906834908783050757);
        assert!(arg4 <= 4, 13906834913077886979);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::debit_enemies(arg0, arg2, arg3);
        let v0 = 0;
        if (arg6 > 0) {
            let v1 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item(arg1, arg5);
            let v2 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item_heal(&v1);
            v0 = v2;
            assert!(v2 > 0, 13906834943142920199);
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::debit_item(arg0, arg5, arg6);
        };
        let v3 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy(arg1, arg2);
        let (v4, v5, v6, v7) = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment::equipped_bonuses(arg0);
        let v8 = (0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::skill_level(arg0, 7) as u64) * 3 + ((0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::skill_level(arg0, 9) as u64) + v6) * 1 + v4;
        let v9 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_defence(&v3) / 2;
        let v10 = if (v8 > v9) {
            v8 - v9
        } else {
            1
        };
        let v11 = ceil_div(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_hp(&v3), v10);
        let v12 = ((0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::skill_level(arg0, 8) as u64) * 2 + v5) / 2;
        let v13 = if (0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_attack(&v3) > v12) {
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_attack(&v3) - v12
        } else {
            1
        };
        let v14 = 0x1::vector::empty<u64>();
        let v15 = &mut v14;
        0x1::vector::push_back<u64>(v15, (arg2 as u64));
        0x1::vector::push_back<u64>(v15, arg3);
        0x1::vector::push_back<u64>(v15, (arg4 as u64));
        0x1::vector::push_back<u64>(v15, (arg5 as u64));
        0x1::vector::push_back<u64>(v15, arg6);
        0x1::vector::push_back<u64>(v15, 0x1::u64::max(v11 * 3000 * 100 / (100 + (0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::skill_level(arg0, 10) as u64) + v7), 3000));
        0x1::vector::push_back<u64>(v15, 0x1::u64::max(v13 * v11, 1));
        0x1::vector::push_back<u64>(v15, 50 + (0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::skill_level(arg0, 11) as u64) * 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::hp_per_level(arg1) + arg6 * v0);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::start_action(arg0, 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::kind_battle(), v14, arg7);
    }

    public fun start_hunt(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::assert_version(arg1);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg2, arg3);
        let v0 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::location(arg1, 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::location(arg0));
        let v1 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::location_enemy_ids(&v0);
        assert!(0x1::vector::length<u16>(&v1) > 0, 13906834560890437633);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::start_action(arg0, 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::kind_hunt(), vector[], arg2);
    }

    entry fun stop_battle(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        resolve_battle(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

