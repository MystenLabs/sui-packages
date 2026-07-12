module 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::combat {
    struct HpKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FoodEaten has copy, drop {
        player_id: 0x2::object::ID,
        food_kind: u16,
        qty: u64,
        hp_after: u64,
    }

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

    public fun current_hp(arg0: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry) : u64 {
        let v0 = HpKey{dummy_field: false};
        if (0x2::dynamic_field::exists<HpKey>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid(arg0), v0)) {
            let v2 = HpKey{dummy_field: false};
            0x1::u64::min(*0x2::dynamic_field::borrow<HpKey, u64>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid(arg0), v2), max_hp(arg0, arg1))
        } else {
            max_hp(arg0, arg1)
        }
    }

    public fun eat(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: u16, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::assert_version(arg1);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg4, arg5);
        assert!(arg3 > 0, 13906834745574817805);
        let v0 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item(arg1, arg2);
        let v1 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item_heal(&v0);
        assert!(v1 > 0, 13906834754164359175);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::debit_item(arg0, arg2, arg3);
        let v2 = 0x1::u64::min(current_hp(arg0, arg1) + v1 * arg3, max_hp(arg0, arg1));
        set_hp(arg0, v2);
        let v3 = FoodEaten{
            player_id : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            food_kind : arg2,
            qty       : arg3,
            hp_after  : v2,
        };
        0x2::event::emit<FoodEaten>(v3);
    }

    fun max_hp(arg0: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry) : u64 {
        100 + (0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::skill_level(arg0, 11) as u64) * 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::hp_per_level(arg1)
    }

    fun resolve_battle(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::assert_version(arg1);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg3, arg4);
        let v0 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::take_action(arg0);
        assert!(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::action_kind(&v0) == 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::kind_battle(), 13906835548733440009);
        let v1 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::action_params(&v0);
        let v2 = (*0x1::vector::borrow<u64>(&v1, 0) as u16);
        let v3 = *0x1::vector::borrow<u64>(&v1, 1);
        let v4 = (*0x1::vector::borrow<u64>(&v1, 2) as u8);
        let v5 = (*0x1::vector::borrow<u64>(&v1, 3) as u16);
        let v6 = *0x1::vector::borrow<u64>(&v1, 4);
        let v7 = 0x1::u64::max(*0x1::vector::borrow<u64>(&v1, 6), 1);
        let v8 = *0x1::vector::borrow<u64>(&v1, 7);
        let v9 = (0x1::u64::min(0x1::u64::max(0x2::clock::timestamp_ms(arg3), 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::action_started_at_ms(&v0)), 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::action_started_at_ms(&v0) + 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::max_offline_ms(arg1)) - 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::action_started_at_ms(&v0)) / *0x1::vector::borrow<u64>(&v1, 5);
        let v10 = v8 / v7;
        let v11 = v10 <= 0x1::u64::min(v9, v3) && v10 < v3;
        let v12 = 0x1::u64::min(0x1::u64::min(v9, v10), v3);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_enemies(arg0, v2, v3 - v12);
        let v13 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy(arg1, v2);
        let v14 = v12 * v7;
        let v15 = if (v6 > 0) {
            let v16 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item(arg1, v5);
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item_heal(&v16)
        } else {
            0
        };
        let v17 = v8 - v6 * v15;
        let v18 = 0;
        if (v11) {
            set_hp(arg0, 0);
        } else {
            let v19 = if (v15 > 0) {
                0x1::u64::min(ceil_div(v14, v15), v6)
            } else {
                0
            };
            let v20 = v6 - v19;
            v18 = v20;
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_item(arg0, v5, v20);
            let v21 = v19 * v15;
            let v22 = if (v14 > v21) {
                v14 - v21
            } else {
                0
            };
            let v23 = if (v22 >= v17) {
                1
            } else {
                v17 - v22
            };
            set_hp(arg0, v23);
        };
        let v24 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_xp_per_kill(&v13) * v12;
        route_stance_xp(arg0, v4, v24);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_xp(arg0, 11, v24 / 3);
        let v25 = 0x2::random::new_generator(arg2, arg4);
        let v26 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_loot_kinds(&v13);
        let v27 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_loot_qtys(&v13);
        let v28 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_loot_chances_bp(&v13);
        let v29 = vector[];
        let v30 = 0;
        while (v30 < 0x1::vector::length<u16>(&v26)) {
            let v31 = (v12 as u128) * (*0x1::vector::borrow<u64>(&v28, v30) as u128);
            let v32 = ((v31 % 10000) as u64);
            let v33 = if (v32 > 0 && 0x2::random::generate_u64_in_range(&mut v25, 0, 9999) < v32) {
                1
            } else {
                0
            };
            let v34 = (((v31 / 10000) as u64) + v33) * *0x1::vector::borrow<u64>(&v27, v30);
            0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_item(arg0, *0x1::vector::borrow<u16>(&v26, v30), v34);
            0x1::vector::push_back<u64>(&mut v29, v34);
            v30 = v30 + 1;
        };
        let v35 = v12 * 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_coin_min(&v13);
        let v36 = v12 * 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::enemy_coin_max(&v13);
        let v37 = if (v36 > v35) {
            0x2::random::generate_u64_in_range(&mut v25, v35, v36)
        } else {
            v35
        };
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::credit_coins(arg0, v37);
        let v38 = BattleResolved{
            player_id     : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            enemy         : v2,
            committed     : v3,
            kills         : v12,
            knocked_out   : v11,
            stance        : v4,
            xp_gained     : v24,
            coins_gained  : v37,
            food_refunded : v18,
            loot_kinds    : v26,
            loot_qtys     : v29,
        };
        0x2::event::emit<BattleResolved>(v38);
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

    fun set_hp(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: u64) {
        let v0 = HpKey{dummy_field: false};
        if (0x2::dynamic_field::exists<HpKey>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid(arg0), v0)) {
            let v1 = HpKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<HpKey, u64>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v1) = arg1;
        } else {
            let v2 = HpKey{dummy_field: false};
            0x2::dynamic_field::add<HpKey, u64>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v2, arg1);
        };
    }

    public fun start_battle(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: u16, arg3: u64, arg4: u8, arg5: u16, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::assert_version(arg1);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg7, arg8);
        assert!(current_hp(arg0, arg1) > 0, 13906835205136187403);
        assert!(arg3 >= 1 && arg3 <= 500, 13906835209430761477);
        assert!(arg4 <= 4, 13906835213725597699);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::debit_enemies(arg0, arg2, arg3);
        let v0 = 0;
        if (arg6 > 0) {
            let v1 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item(arg1, arg5);
            let v2 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::item_heal(&v1);
            v0 = v2;
            assert!(v2 > 0, 13906835243790630919);
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
        0x1::vector::push_back<u64>(v15, current_hp(arg0, arg1) + arg6 * v0);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::start_action(arg0, 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::kind_battle(), v14, arg7);
    }

    public fun start_hunt(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::assert_version(arg1);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg2, arg3);
        assert!(current_hp(arg0, arg1) > 0, 13906834848653901835);
        let v0 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::location(arg1, 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::location(arg0));
        let v1 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::location_enemy_ids(&v0);
        assert!(0x1::vector::length<u16>(&v1) > 0, 13906834857243181057);
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::start_action(arg0, 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::kind_hunt(), vector[], arg2);
    }

    entry fun stop_battle(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        resolve_battle(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

