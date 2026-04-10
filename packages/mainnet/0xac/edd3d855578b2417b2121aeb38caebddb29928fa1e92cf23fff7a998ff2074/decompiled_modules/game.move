module 0x10282d3d39d47373d69d01c643de30bb186a6f68119fb5793701e41aeaedb09e::game {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GAME has drop {
        dummy_field: bool,
    }

    struct GameState<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        bub_pool: 0x2::balance::Balance<T0>,
        bublz_pool: 0x2::balance::Balance<T1>,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_extractor_power: u64,
        total_drill_power: u64,
        camp_count: u64,
        paused: bool,
        pool_emission_bps: u64,
        gold_per_sui: u64,
        bub_unit: u64,
        bublz_unit: u64,
        camps: 0x2::table::Table<address, address>,
    }

    struct TroopData has store {
        troop_types: vector<u8>,
        troop_hp: vector<u64>,
        troop_max_hp: vector<u64>,
        troop_atk: vector<u64>,
        troop_born_ms: vector<u64>,
        troop_gear: vector<u8>,
        barracks_training: u8,
        barracks_done_ms: u64,
        factory_training: u8,
        factory_done_ms: u64,
    }

    struct WallData has store {
        walls_basic: u64,
        walls_reinforced: u64,
        walls_fortified: u64,
        damaged_basic: u64,
        damaged_reinforced: u64,
        damaged_fortified: u64,
    }

    struct CombatData has store {
        defense_tactic: u8,
        last_tactic_change_ms: u64,
        last_raid_sent_ms: u64,
        raids_today: u8,
        raids_today_reset_ms: u64,
        last_raided_ms: u64,
        raids_received_today: u8,
        raids_received_reset_ms: u64,
        shield_expires_ms: u64,
        shield_cooldown_ms: u64,
    }

    struct LabData has store {
        research: vector<u8>,
        research_type: u8,
        research_done_ms: u64,
        gear_craft_tier: u8,
        gear_craft_troop: u64,
        gear_craft_born_ms: u64,
        gear_craft_done_ms: u64,
        conversion_type: u8,
        conversion_done_ms: u64,
    }

    struct ConsumableData has store {
        healing_tides: u64,
        war_tonics: u64,
        iron_shells: u64,
        scout_lenses: u64,
        haste_tonics: u64,
        iron_shell_expires_ms: u64,
    }

    struct Camp has key {
        id: 0x2::object::UID,
        owner: address,
        game_id: address,
        name: 0x1::string::String,
        buildings: vector<u8>,
        build_timers: vector<u64>,
        pending_bub: u64,
        safe_bub: u64,
        pending_bublz: u64,
        safe_bublz: u64,
        gold: u64,
        shards: u64,
        crystals: u64,
        cores: u64,
        extractor_power: u64,
        drill_power: u64,
        last_production_ms: u64,
        last_lock_ms: u64,
        last_gold_ms: u64,
        last_claim_ms: u64,
        troops: TroopData,
        walls: WallData,
        combat: CombatData,
        lab: LabData,
        consumables: ConsumableData,
        referrer: address,
        has_referrer: bool,
        power_level: u64,
    }

    struct CampCreated has copy, drop {
        owner: address,
        camp_id: address,
    }

    struct BuildStarted has copy, drop {
        owner: address,
        building_id: u8,
        target_level: u8,
        done_ms: u64,
    }

    struct BuildCompleted has copy, drop {
        owner: address,
        building_id: u8,
        new_level: u8,
    }

    struct TokensClaimed has copy, drop {
        player: address,
        bub: u64,
        bublz: u64,
        burned_bub: u64,
        burned_bublz: u64,
    }

    struct TroopTrained has copy, drop {
        owner: address,
        troop_type: u8,
    }

    struct BattleResult has copy, drop {
        attacker: address,
        defender: address,
        stars: u8,
        bub_stolen: u64,
        bublz_stolen: u64,
        shards_earned: u64,
        crystals_earned: u64,
        troops_lost: u64,
        tactic_mult: u64,
    }

    struct ShieldActivated has copy, drop {
        owner: address,
        expires_ms: u64,
    }

    fun apply_lock(arg0: &mut Camp, arg1: u64) {
        if (arg1 < arg0.last_lock_ms + 3600000) {
            return
        };
        let v0 = (arg1 - arg0.last_lock_ms) / 3600000;
        let v1 = v0 * 200;
        let v2 = if (v1 > 10000) {
            10000
        } else {
            v1
        };
        if (arg0.pending_bub > 0) {
            let v3 = (((arg0.pending_bub as u128) * (v2 as u128) / (10000 as u128)) as u64);
            arg0.pending_bub = arg0.pending_bub - v3;
            arg0.safe_bub = arg0.safe_bub + v3;
        };
        if (arg0.pending_bublz > 0) {
            let v4 = (((arg0.pending_bublz as u128) * (v2 as u128) / (10000 as u128)) as u64);
            arg0.pending_bublz = arg0.pending_bublz - v4;
            arg0.safe_bublz = arg0.safe_bublz + v4;
        };
        arg0.last_lock_ms = arg0.last_lock_ms + v0 * 3600000;
    }

    public entry fun attack<T0, T1>(arg0: &GameState<T0, T1>, arg1: &mut Camp, arg2: &mut Camp, arg3: vector<u8>, arg4: u8, arg5: bool, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg2.game_id, 47);
        assert!(arg4 < 3, 23);
        assert!(0x2::tx_context::sender(arg8) == arg1.owner, 2);
        assert!(arg1.owner != arg2.owner, 18);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x1::vector::length<u8>(&arg3);
        assert!(v1 > 0, 41);
        tick<T0, T1>(arg0, arg1, arg7);
        tick<T0, T1>(arg0, arg2, arg7);
        clean_expired_troops(arg1, v0);
        if (v0 >= arg1.combat.raids_today_reset_ms + 86400000) {
            arg1.combat.raids_today = 0;
            arg1.combat.raids_today_reset_ms = v0;
        };
        assert!(arg1.combat.raids_today < 5, 9);
        let v2 = (*0x1::vector::borrow<u8>(&arg1.buildings, (0 as u64)) as u64);
        let v3 = (*0x1::vector::borrow<u8>(&arg2.buildings, (0 as u64)) as u64);
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            v3 - v2
        };
        assert!(v4 <= 1, 44);
        assert!(v0 >= arg2.combat.shield_expires_ms, 11);
        assert!(v0 >= arg2.combat.last_raided_ms + 21600000, 12);
        let v5 = *0x1::vector::borrow<u8>(&arg1.buildings, (12 as u64));
        assert!(v5 > 0, 36);
        assert!(v1 <= get_dock_capacity(v5), 13);
        if (arg5) {
            assert!(arg1.consumables.war_tonics > 0, 33);
            arg1.consumables.war_tonics = arg1.consumables.war_tonics - 1;
        };
        if (arg1.combat.shield_expires_ms > v0) {
            arg1.combat.shield_expires_ms = 0;
        };
        let v6 = 0;
        while (v6 < v1) {
            let v7 = *0x1::vector::borrow<u8>(&arg3, v6);
            assert!((v7 as u64) < 0x1::vector::length<u8>(&arg1.troops.troop_types), 16);
            let v8 = v6 + 1;
            while (v8 < v1) {
                assert!(*0x1::vector::borrow<u8>(&arg3, v8) != v7, 42);
                v8 = v8 + 1;
            };
            v6 = v6 + 1;
        };
        let v9 = 0;
        let v10 = 0;
        v6 = 0;
        while (v6 < v1) {
            let v11 = (*0x1::vector::borrow<u8>(&arg3, v6) as u64);
            if (*0x1::vector::borrow<u8>(&arg1.troops.troop_types, v11) == 8) {
                v10 = v10 + 1;
            };
            let v12 = if (arg5) {
                20
            } else {
                0
            };
            v9 = v9 + (*0x1::vector::borrow<u64>(&arg1.troops.troop_atk, v11) as u128) * ((100 + get_gear_bonus(*0x1::vector::borrow<u8>(&arg1.troops.troop_gear, v11)) + v12) as u128) / 100;
            v6 = v6 + 1;
        };
        assert!(v10 <= 1, 43);
        let v13 = get_tactic_multiplier(arg4, arg2.combat.defense_tactic);
        let v14 = 0x2::random::new_generator(arg6, arg8);
        let v15 = ((v9 * (v13 as u128) * ((85 + 0x2::random::generate_u64_in_range(&mut v14, 0, 30)) as u128) / 10000) as u64);
        let v16 = (*0x1::vector::borrow<u8>(&arg2.buildings, (5 as u64)) as u64) * 60 + (*0x1::vector::borrow<u8>(&arg2.buildings, (6 as u64)) as u64) * 75 + (*0x1::vector::borrow<u8>(&arg2.buildings, (7 as u64)) as u64) * 60 + (*0x1::vector::borrow<u8>(&arg2.buildings, (8 as u64)) as u64) * 60 + arg2.walls.walls_basic * 15 + arg2.walls.walls_reinforced * 35 + arg2.walls.walls_fortified * 70;
        let v17 = v16;
        if (v0 < arg2.consumables.iron_shell_expires_ms) {
            v17 = v16 * 120 / 100;
        };
        let v18 = if (v1 >= 20) {
            35
        } else {
            (v1 as u64) * 35 / 20
        };
        let v19 = v17 * (100 - v18) / 100;
        let v20 = if (v15 > v19 * 120 / 100) {
            3
        } else if (v15 > v19 * 85 / 100) {
            2
        } else if (v15 > v19 * 60 / 100) {
            1
        } else {
            0
        };
        if (v0 >= arg2.combat.raids_received_reset_ms + 86400000) {
            arg2.combat.raids_received_today = 0;
            arg2.combat.raids_received_reset_ms = v0;
        };
        let v21 = get_diminish_mult(arg2.combat.raids_received_today);
        let v22 = 0;
        let v23 = 0;
        let v24 = 0;
        let v25 = v24;
        let v26 = 0;
        let v27 = v26;
        if (v20 > 0) {
            let v28 = if (v20 == 1) {
                15
            } else if (v20 == 2) {
                25
            } else {
                40
            };
            let v29 = (((arg2.pending_bub as u128) * (v28 as u128) * (v21 as u128) / 10000) as u64);
            v22 = v29;
            let v30 = (((arg2.pending_bublz as u128) * (v28 as u128) * (v21 as u128) / 10000) as u64);
            v23 = v30;
            arg2.pending_bub = arg2.pending_bub - v29;
            arg2.pending_bublz = arg2.pending_bublz - v30;
            arg1.pending_bub = arg1.pending_bub + v29;
            arg1.pending_bublz = arg1.pending_bublz + v30;
            if (v20 >= 1) {
                v25 = v24 + 2;
            };
            if (v20 >= 2) {
                v25 = v25 + 3;
                v27 = v26 + 1;
            };
            if (v20 >= 3) {
                v25 = v25 + 5;
                v27 = v27 + 2;
            };
            arg1.shards = arg1.shards + v25;
            arg1.crystals = arg1.crystals + v27;
            if (v20 == 3) {
                if (0x2::random::generate_u64_in_range(&mut v14, 0, 4) == 0) {
                    arg1.cores = arg1.cores + 1;
                };
            };
            damage_walls(arg2, v20);
        } else {
            let v31 = arg1.pending_bub * 5 / 100;
            let v32 = arg1.pending_bublz * 5 / 100;
            arg1.pending_bub = arg1.pending_bub - v31;
            arg1.pending_bublz = arg1.pending_bublz - v32;
            arg2.pending_bub = arg2.pending_bub + v31;
            arg2.pending_bublz = arg2.pending_bublz + v32;
        };
        let v33 = if (v20 == 0) {
            30
        } else if (v20 == 1) {
            20
        } else if (v20 == 2) {
            15
        } else {
            10
        };
        let v34 = 0;
        while (v34 < v1) {
            let v35 = (*0x1::vector::borrow<u8>(&arg3, v34) as u64);
            let v36 = *0x1::vector::borrow<u64>(&arg1.troops.troop_hp, v35);
            let v37 = v36 * v33 / 100;
            let v38 = if (v36 > v37) {
                v36 - v37
            } else {
                1
            };
            *0x1::vector::borrow_mut<u64>(&mut arg1.troops.troop_hp, v35) = v38;
            v34 = v34 + 1;
        };
        let v39 = if (v15 == 0) {
            40
        } else {
            let v40 = v19 * 100 / v15 * 3;
            if (v40 > 40) {
                40
            } else {
                v40
            }
        };
        let v41 = v39;
        if (v20 == 0) {
            let v42 = v39 * 150 / 100;
            v41 = v42;
            if (v42 > 50) {
                v41 = 50;
            };
        };
        let v43 = 0;
        let v44 = &mut arg3;
        sort_desc(v44);
        v6 = 0;
        while (v6 < 0x1::vector::length<u8>(&arg3) && v43 < (v1 as u64) * v41 / 100) {
            let v45 = (*0x1::vector::borrow<u8>(&arg3, v6) as u64);
            if (v45 < 0x1::vector::length<u8>(&arg1.troops.troop_types)) {
                remove_troop(arg1, v45);
                v43 = v43 + 1;
            };
            v6 = v6 + 1;
        };
        arg1.combat.raids_today = arg1.combat.raids_today + 1;
        if (v20 > 0) {
            arg1.combat.last_raid_sent_ms = v0;
        };
        arg2.combat.last_raided_ms = v0;
        arg2.combat.raids_received_today = arg2.combat.raids_received_today + 1;
        recalc_power(arg1);
        recalc_power(arg2);
        let v46 = BattleResult{
            attacker        : arg1.owner,
            defender        : arg2.owner,
            stars           : v20,
            bub_stolen      : v22,
            bublz_stolen    : v23,
            shards_earned   : v25,
            crystals_earned : v27,
            troops_lost     : v43,
            tactic_mult     : v13,
        };
        0x2::event::emit<BattleResult>(v46);
    }

    public entry fun buy_gold<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2) / 1000000000;
        assert!(v0 > 0, 7);
        let v1 = v0 * arg0.gold_per_sui;
        process_sui_payment<T0, T1>(arg2, v0 * 1000000000, arg1.owner, arg0, arg3);
        arg1.gold = arg1.gold + v1;
    }

    public entry fun buy_resources<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        let v0 = if (arg2 == 0) {
            let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3) / 5000000000;
            assert!(v1 > 0, 7);
            arg1.shards = arg1.shards + v1 * 10;
            v1 * 5000000000
        } else if (arg2 == 1) {
            let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3) / 10000000000;
            assert!(v2 > 0, 7);
            arg1.crystals = arg1.crystals + v2 * 5;
            v2 * 10000000000
        } else {
            assert!(arg2 == 2, 37);
            let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg3) / 8000000000;
            assert!(v3 > 0, 7);
            arg1.cores = arg1.cores + v3;
            v3 * 8000000000
        };
        process_sui_payment<T0, T1>(arg3, v0, arg1.owner, arg0, arg4);
    }

    public entry fun buy_shield<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.combat.shield_cooldown_ms, 17);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 25000000000, 7);
        process_sui_payment<T0, T1>(arg2, 25000000000, arg1.owner, arg0, arg4);
        arg1.combat.shield_expires_ms = v0 + 86400000;
        arg1.combat.shield_cooldown_ms = v0 + 604800000;
        let v1 = ShieldActivated{
            owner      : arg1.owner,
            expires_ms : arg1.combat.shield_expires_ms,
        };
        0x2::event::emit<ShieldActivated>(v1);
    }

    fun can_build_at_hall(arg0: u8, arg1: u8) : bool {
        if (arg0 == 1 || arg0 == 4) {
            arg1 >= 1
        } else if (arg0 == 5) {
            arg1 >= 2
        } else {
            let v1 = if (arg0 == 9) {
                true
            } else if (arg0 == 7) {
                true
            } else {
                arg0 == 12
            };
            v1 && arg1 >= 3 || arg0 == 6 && arg1 >= 4 || (arg0 == 8 || arg0 == 2) && arg1 >= 5 || (arg0 == 10 || arg0 == 3) && arg1 >= 6 || arg0 == 11 && arg1 >= 5
        }
    }

    fun can_train_troop(arg0: u8, arg1: u8, arg2: u8) : bool {
        arg0 <= 4 && ((arg0 == 0 || arg0 == 1) && arg1 >= 1 || arg0 == 2 && arg1 >= 3 || arg0 == 3 && arg1 >= 4 || arg1 >= 5) || arg0 == 5 && arg2 >= 1 || arg0 == 6 && arg2 >= 3 || arg0 == 7 && arg2 >= 5 || arg2 >= 7
    }

    public entry fun claim_tokens<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        assert!(*0x1::vector::borrow<u8>(&arg1.buildings, (12 as u64)) > 0, 36);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.last_claim_ms + 259200000, 8);
        tick<T0, T1>(arg0, arg1, arg2);
        assert!(arg1.safe_bub > 0 || arg1.safe_bublz > 0, 40);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x2::balance::value<T0>(&arg0.bub_pool);
        let v6 = if (arg1.safe_bub > v5) {
            v5
        } else {
            arg1.safe_bub
        };
        if (v6 > 0) {
            let v7 = v6 * 1000 / 10000;
            let v8 = if (arg1.has_referrer) {
                v6 * 500 / 10000
            } else {
                0
            };
            let v9 = v6 - v7 - v8;
            v1 = v9;
            v3 = v7;
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bub_pool, v9), arg3), arg1.owner);
            };
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bub_pool, v7), arg3), @0x0);
            };
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bub_pool, v8), arg3), arg1.referrer);
            };
        };
        let v10 = 0x2::balance::value<T1>(&arg0.bublz_pool);
        let v11 = if (arg1.safe_bublz > v10) {
            v10
        } else {
            arg1.safe_bublz
        };
        if (v11 > 0) {
            let v12 = v11 * 1000 / 10000;
            let v13 = if (arg1.has_referrer) {
                v11 * 500 / 10000
            } else {
                0
            };
            let v14 = v11 - v12 - v13;
            v2 = v14;
            v4 = v12;
            if (v14 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bublz_pool, v14), arg3), arg1.owner);
            };
            if (v12 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bublz_pool, v12), arg3), @0x0);
            };
            if (v13 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bublz_pool, v13), arg3), arg1.referrer);
            };
        };
        arg1.safe_bub = arg1.safe_bub - v6;
        arg1.safe_bublz = arg1.safe_bublz - v11;
        arg1.last_claim_ms = v0;
        let v15 = TokensClaimed{
            player       : arg1.owner,
            bub          : v1,
            bublz        : v2,
            burned_bub   : v3,
            burned_bublz : v4,
        };
        0x2::event::emit<TokensClaimed>(v15);
    }

    fun clean_expired_troops(arg0: &mut Camp, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(&arg0.troops.troop_types);
        while (v0 > 0) {
            v0 = v0 - 1;
            if (arg1 >= *0x1::vector::borrow<u64>(&arg0.troops.troop_born_ms, v0) + 1209600000) {
                remove_troop(arg0, v0);
            };
        };
    }

    public entry fun collect_gold(arg0: &mut Camp, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        collect_gold_internal(arg0, 0x2::clock::timestamp_ms(arg1));
    }

    fun collect_gold_internal(arg0: &mut Camp, arg1: u64) {
        let v0 = *0x1::vector::borrow<u8>(&arg0.buildings, (1 as u64));
        if (v0 == 0) {
            arg0.last_gold_ms = arg1;
            return
        };
        arg0.gold = arg0.gold + (((get_gold_per_hour(v0) as u128) * ((arg1 - arg0.last_gold_ms) as u128) / (3600000 as u128)) as u64);
        arg0.last_gold_ms = arg1;
    }

    public entry fun complete_conversion(arg0: &mut Camp, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(arg0.lab.conversion_type != 255, 35);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.lab.conversion_done_ms, 35);
        if (arg0.lab.conversion_type == 0) {
            arg0.crystals = arg0.crystals + 1;
        } else {
            arg0.cores = arg0.cores + 1;
        };
        arg0.lab.conversion_type = 255;
        arg0.lab.conversion_done_ms = 0;
    }

    public entry fun complete_gear_craft(arg0: &mut Camp, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(arg0.lab.gear_craft_tier != 255, 32);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.lab.gear_craft_done_ms, 32);
        let v0 = arg0.lab.gear_craft_troop;
        if (v0 < 0x1::vector::length<u8>(&arg0.troops.troop_types) && *0x1::vector::borrow<u64>(&arg0.troops.troop_born_ms, v0) == arg0.lab.gear_craft_born_ms) {
            *0x1::vector::borrow_mut<u8>(&mut arg0.troops.troop_gear, v0) = arg0.lab.gear_craft_tier;
        };
        arg0.lab.gear_craft_tier = 255;
        arg0.lab.gear_craft_troop = 0;
        arg0.lab.gear_craft_born_ms = 0;
        arg0.lab.gear_craft_done_ms = 0;
    }

    public entry fun complete_research(arg0: &mut Camp, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(arg0.lab.research_type != 255, 30);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.lab.research_done_ms, 30);
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg0.lab.research, (arg0.lab.research_type as u64));
        *v0 = *v0 + 1;
        arg0.lab.research_type = 255;
        arg0.lab.research_done_ms = 0;
        recalc_power(arg0);
    }

    public entry fun complete_training(arg0: &mut Camp, arg1: bool, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let (v1, v2) = if (arg1) {
            let v1 = arg0.troops.barracks_training;
            (v1, arg0.troops.barracks_done_ms)
        } else {
            let v1 = arg0.troops.factory_training;
            (v1, arg0.troops.factory_done_ms)
        };
        assert!(v1 != 255, 26);
        assert!(v0 >= v2, 27);
        let v3 = *0x1::vector::borrow<u8>(&arg0.lab.research, (v1 as u64));
        let (v4, v5) = get_troop_stats(v1);
        let v6 = v4 + v4 * (v3 as u64) * 10 / 100;
        0x1::vector::push_back<u8>(&mut arg0.troops.troop_types, v1);
        0x1::vector::push_back<u64>(&mut arg0.troops.troop_hp, v6);
        0x1::vector::push_back<u64>(&mut arg0.troops.troop_max_hp, v6);
        0x1::vector::push_back<u64>(&mut arg0.troops.troop_atk, v5 + v5 * (v3 as u64) * 10 / 100);
        0x1::vector::push_back<u64>(&mut arg0.troops.troop_born_ms, v0);
        0x1::vector::push_back<u8>(&mut arg0.troops.troop_gear, 0);
        if (arg1) {
            arg0.troops.barracks_training = 255;
            arg0.troops.barracks_done_ms = 0;
        } else {
            arg0.troops.factory_training = 255;
            arg0.troops.factory_done_ms = 0;
        };
        recalc_power(arg0);
        let v7 = TroopTrained{
            owner      : arg0.owner,
            troop_type : v1,
        };
        0x2::event::emit<TroopTrained>(v7);
    }

    public entry fun complete_upgrade<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        assert!((arg2 as u64) < 13, 15);
        let v0 = *0x1::vector::borrow<u64>(&arg1.build_timers, (arg2 as u64));
        assert!(v0 > 0, 6);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0, 6);
        tick<T0, T1>(arg0, arg1, arg3);
        let v1 = *0x1::vector::borrow<u8>(&arg1.buildings, (arg2 as u64)) + 1;
        *0x1::vector::borrow_mut<u8>(&mut arg1.buildings, (arg2 as u64)) = v1;
        *0x1::vector::borrow_mut<u64>(&mut arg1.build_timers, (arg2 as u64)) = 0;
        if (arg2 == 2) {
            let v2 = get_production_power(v1);
            arg1.extractor_power = v2;
            arg0.total_extractor_power = arg0.total_extractor_power - arg1.extractor_power + v2;
        } else if (arg2 == 3) {
            let v3 = get_production_power(v1);
            arg1.drill_power = v3;
            arg0.total_drill_power = arg0.total_drill_power - arg1.drill_power + v3;
        };
        recalc_power(arg1);
        let v4 = BuildCompleted{
            owner       : arg1.owner,
            building_id : arg2,
            new_level   : v1,
        };
        0x2::event::emit<BuildCompleted>(v4);
    }

    public entry fun craft_consumable(arg0: &mut Camp, arg1: u8, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(arg2 > 0 && arg2 <= 1000, 37);
        assert!(*0x1::vector::borrow<u8>(&arg0.buildings, (11 as u64)) > 0, 21);
        let (v0, v1) = get_consumable_cost(arg1);
        assert!(arg0.gold >= v0 * arg2, 7);
        assert!(arg0.shards >= v1 * arg2, 7);
        arg0.gold = arg0.gold - v0 * arg2;
        arg0.shards = arg0.shards - v1 * arg2;
        if (arg1 == 0) {
            arg0.consumables.healing_tides = arg0.consumables.healing_tides + arg2;
        } else if (arg1 == 1) {
            arg0.consumables.war_tonics = arg0.consumables.war_tonics + arg2;
        } else if (arg1 == 2) {
            arg0.consumables.iron_shells = arg0.consumables.iron_shells + arg2;
        } else if (arg1 == 3) {
            arg0.consumables.scout_lenses = arg0.consumables.scout_lenses + arg2;
        } else {
            assert!(arg1 == 4, 37);
            arg0.consumables.haste_tonics = arg0.consumables.haste_tonics + arg2;
        };
    }

    public entry fun create_camp<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::string::String, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x1::string::length(&arg3) >= 1, 48);
        assert!(0x1::string::length(&arg3) <= 32, 46);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::table::contains<address, address>(&arg0.camps, v0), 20);
        assert!(0x2::coin::value<T1>(&arg2) >= 25000000000000, 7);
        process_bublz_payment<T0, T1>(arg2, 25000000000000, v0, arg0, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000000000, 7);
        process_sui_payment<T0, T1>(arg1, 1000000000, v0, arg0, arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 13) {
            if (v4 == 0) {
                0x1::vector::push_back<u8>(&mut v2, 1);
            } else if (v4 == 1) {
                0x1::vector::push_back<u8>(&mut v2, 1);
            } else {
                0x1::vector::push_back<u8>(&mut v2, 0);
            };
            0x1::vector::push_back<u64>(&mut v3, 0);
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::empty<u8>();
        v4 = 0;
        while (v4 < 9) {
            0x1::vector::push_back<u8>(&mut v5, 0);
            v4 = v4 + 1;
        };
        let v6 = if (arg4 != @0x0) {
            if (arg4 != v0) {
                0x2::table::contains<address, address>(&arg0.camps, arg4)
            } else {
                false
            }
        } else {
            false
        };
        let v7 = TroopData{
            troop_types       : 0x1::vector::empty<u8>(),
            troop_hp          : 0x1::vector::empty<u64>(),
            troop_max_hp      : 0x1::vector::empty<u64>(),
            troop_atk         : 0x1::vector::empty<u64>(),
            troop_born_ms     : 0x1::vector::empty<u64>(),
            troop_gear        : 0x1::vector::empty<u8>(),
            barracks_training : 255,
            barracks_done_ms  : 0,
            factory_training  : 255,
            factory_done_ms   : 0,
        };
        let v8 = WallData{
            walls_basic        : 0,
            walls_reinforced   : 0,
            walls_fortified    : 0,
            damaged_basic      : 0,
            damaged_reinforced : 0,
            damaged_fortified  : 0,
        };
        let v9 = CombatData{
            defense_tactic          : 0,
            last_tactic_change_ms   : 0,
            last_raid_sent_ms       : 0,
            raids_today             : 0,
            raids_today_reset_ms    : v1,
            last_raided_ms          : 0,
            raids_received_today    : 0,
            raids_received_reset_ms : v1,
            shield_expires_ms       : 0,
            shield_cooldown_ms      : 0,
        };
        let v10 = LabData{
            research           : v5,
            research_type      : 255,
            research_done_ms   : 0,
            gear_craft_tier    : 255,
            gear_craft_troop   : 0,
            gear_craft_born_ms : 0,
            gear_craft_done_ms : 0,
            conversion_type    : 255,
            conversion_done_ms : 0,
        };
        let v11 = ConsumableData{
            healing_tides         : 0,
            war_tonics            : 0,
            iron_shells           : 0,
            scout_lenses          : 0,
            haste_tonics          : 0,
            iron_shell_expires_ms : 0,
        };
        let v12 = Camp{
            id                 : 0x2::object::new(arg6),
            owner              : v0,
            game_id            : 0x2::object::uid_to_address(&arg0.id),
            name               : arg3,
            buildings          : v2,
            build_timers       : v3,
            pending_bub        : 0,
            safe_bub           : 0,
            pending_bublz      : 0,
            safe_bublz         : 0,
            gold               : 500,
            shards             : 0,
            crystals           : 0,
            cores              : 0,
            extractor_power    : 0,
            drill_power        : 0,
            last_production_ms : v1,
            last_lock_ms       : v1,
            last_gold_ms       : v1,
            last_claim_ms      : v1,
            troops             : v7,
            walls              : v8,
            combat             : v9,
            lab                : v10,
            consumables        : v11,
            referrer           : arg4,
            has_referrer       : v6,
            power_level        : 120,
        };
        let v13 = 0x2::object::uid_to_address(&v12.id);
        0x2::table::add<address, address>(&mut arg0.camps, v0, v13);
        arg0.camp_count = arg0.camp_count + 1;
        let v14 = CampCreated{
            owner   : v0,
            camp_id : v13,
        };
        0x2::event::emit<CampCreated>(v14);
        0x2::transfer::share_object<Camp>(v12);
    }

    public entry fun create_game<T0, T1>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = GameState<T0, T1>{
            id                    : 0x2::object::new(arg3),
            bub_pool              : 0x2::balance::zero<T0>(),
            bublz_pool            : 0x2::balance::zero<T1>(),
            sui_treasury          : 0x2::balance::zero<0x2::sui::SUI>(),
            total_extractor_power : 0,
            total_drill_power     : 0,
            camp_count            : 0,
            paused                : false,
            pool_emission_bps     : 200,
            gold_per_sui          : 1000,
            bub_unit              : arg1,
            bublz_unit            : arg2,
            camps                 : 0x2::table::new<address, address>(arg3),
        };
        0x2::transfer::share_object<GameState<T0, T1>>(v0);
    }

    fun damage_walls(arg0: &mut Camp, arg1: u8) {
        let v0 = if (arg1 == 1) {
            10
        } else if (arg1 == 2) {
            20
        } else {
            35
        };
        let v1 = arg0.walls.damaged_basic;
        let v2 = arg0.walls.damaged_reinforced;
        let v3 = arg0.walls.damaged_fortified;
        let v4 = (arg0.walls.walls_basic + arg0.walls.walls_reinforced + arg0.walls.walls_fortified) * v0 / 100;
        let v5 = if (v4 > arg0.walls.walls_basic) {
            arg0.walls.walls_basic
        } else {
            v4
        };
        arg0.walls.walls_basic = arg0.walls.walls_basic - v5;
        arg0.walls.damaged_basic = arg0.walls.damaged_basic + v5;
        let v6 = v4 - v5;
        let v7 = v6;
        if (v6 > 0) {
            let v8 = if (v6 > arg0.walls.walls_reinforced) {
                arg0.walls.walls_reinforced
            } else {
                v6
            };
            arg0.walls.walls_reinforced = arg0.walls.walls_reinforced - v8;
            arg0.walls.damaged_reinforced = arg0.walls.damaged_reinforced + v8;
            v7 = v6 - v8;
        };
        if (v7 > 0) {
            let v9 = if (v7 > arg0.walls.walls_fortified) {
                arg0.walls.walls_fortified
            } else {
                v7
            };
            arg0.walls.walls_fortified = arg0.walls.walls_fortified - v9;
            arg0.walls.damaged_fortified = arg0.walls.damaged_fortified + v9;
        };
        let v10 = (v1 + v2 + v3) * v0 / 100;
        let v11 = if (v10 > v1) {
            v1
        } else {
            v10
        };
        arg0.walls.damaged_basic = arg0.walls.damaged_basic - v11;
        let v12 = v10 - v11;
        v7 = v12;
        if (v12 > 0) {
            let v13 = if (v12 > v2) {
                v2
            } else {
                v12
            };
            arg0.walls.damaged_reinforced = arg0.walls.damaged_reinforced - v13;
            v7 = v12 - v13;
        };
        if (v7 > 0) {
            let v14 = if (v7 > v3) {
                v3
            } else {
                v7
            };
            arg0.walls.damaged_fortified = arg0.walls.damaged_fortified - v14;
        };
    }

    public entry fun dismantle_bubbler<T0: store + key>(arg0: &AdminCap, arg1: &mut Camp, arg2: T0, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 12, 37);
        let (v0, v1, v2) = get_dismantle_yields(arg3);
        arg1.shards = arg1.shards + v0;
        arg1.crystals = arg1.crystals + v1;
        arg1.cores = arg1.cores + v2;
        0x2::transfer::public_transfer<T0>(arg2, @0x0);
        recalc_power(arg1);
    }

    public entry fun dismantle_bubcoin_bubbler(arg0: &mut Camp, arg1: 0xe39b9ba59dd4c523df7a3a8d0eacf0e18576a88b38138b58ccbf1f0daa8aa64d::game::BubbleGenerator, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        let v0 = 0xe39b9ba59dd4c523df7a3a8d0eacf0e18576a88b38138b58ccbf1f0daa8aa64d::game::get_tier(&arg1);
        assert!(v0 <= 12, 37);
        let (v1, v2, v3) = get_dismantle_yields(v0);
        arg0.shards = arg0.shards + v1;
        arg0.crystals = arg0.crystals + v2;
        arg0.cores = arg0.cores + v3;
        0x2::transfer::public_transfer<0xe39b9ba59dd4c523df7a3a8d0eacf0e18576a88b38138b58ccbf1f0daa8aa64d::game::BubbleGenerator>(arg1, @0x0);
        recalc_power(arg0);
    }

    public entry fun emergency_drain_bub<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 19);
        let v0 = 0x2::balance::value<T0>(&arg0.bub_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bub_pool, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun emergency_drain_bublz<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 19);
        let v0 = 0x2::balance::value<T1>(&arg0.bublz_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bublz_pool, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    fun get_activity_multiplier(arg0: &Camp, arg1: u64) : u64 {
        if (*0x1::vector::borrow<u8>(&arg0.buildings, (0 as u64)) < 3) {
            return 10000
        };
        let v0 = arg0.combat.last_raid_sent_ms;
        if (v0 == 0) {
            return 5000
        };
        let v1 = arg1 - v0;
        if (v1 <= 86400000) {
            10000
        } else if (v1 <= 86400000 * 2) {
            5000
        } else if (v1 <= 86400000 * 3) {
            2000
        } else {
            500
        }
    }

    fun get_build_time(arg0: u8) : u64 {
        if (arg0 <= 1) {
            60000
        } else if (arg0 == 2) {
            1800000
        } else if (arg0 == 3) {
            7200000
        } else if (arg0 == 4) {
            14400000
        } else if (arg0 == 5) {
            28800000
        } else if (arg0 == 6) {
            43200000
        } else if (arg0 == 7) {
            64800000
        } else if (arg0 == 8) {
            86400000
        } else if (arg0 == 9) {
            129600000
        } else {
            172800000
        }
    }

    public fun get_camp_buildings(arg0: &Camp) : &vector<u8> {
        &arg0.buildings
    }

    public fun get_camp_gold(arg0: &Camp) : u64 {
        arg0.gold
    }

    public fun get_camp_owner(arg0: &Camp) : address {
        arg0.owner
    }

    public fun get_camp_pending(arg0: &Camp) : (u64, u64) {
        (arg0.pending_bub, arg0.pending_bublz)
    }

    public fun get_camp_power(arg0: &Camp) : u64 {
        arg0.power_level
    }

    public fun get_camp_resources(arg0: &Camp) : (u64, u64, u64) {
        (arg0.shards, arg0.crystals, arg0.cores)
    }

    public fun get_camp_safe(arg0: &Camp) : (u64, u64) {
        (arg0.safe_bub, arg0.safe_bublz)
    }

    public fun get_camp_shield(arg0: &Camp) : u64 {
        arg0.combat.shield_expires_ms
    }

    public fun get_camp_troops(arg0: &Camp) : u64 {
        0x1::vector::length<u8>(&arg0.troops.troop_types)
    }

    public fun get_camp_walls(arg0: &Camp) : (u64, u64, u64) {
        (arg0.walls.walls_basic, arg0.walls.walls_reinforced, arg0.walls.walls_fortified)
    }

    fun get_consumable_cost(arg0: u8) : (u64, u64) {
        let (v0, v1) = if (arg0 == 0) {
            (0, 1000)
        } else {
            let (v2, v3) = if (arg0 == 1) {
                (1000, 0)
            } else if (arg0 == 2) {
                (1500, 0)
            } else if (arg0 == 3) {
                (0, 5)
            } else {
                assert!(arg0 == 4, 37);
                (500, 0)
            };
            (v3, v2)
        };
        (v1, v0)
    }

    fun get_conversion_time(arg0: u8) : u64 {
        if (arg0 == 0) {
            7200000
        } else {
            28800000
        }
    }

    fun get_diminish_mult(arg0: u8) : u64 {
        if (arg0 == 0) {
            100
        } else if (arg0 == 1) {
            50
        } else if (arg0 == 2) {
            25
        } else {
            10
        }
    }

    fun get_dismantle_yields(arg0: u8) : (u64, u64, u64) {
        if (arg0 == 0) {
            (1, 0, 0)
        } else if (arg0 == 1) {
            (2, 0, 0)
        } else if (arg0 == 2) {
            (3, 0, 0)
        } else if (arg0 == 3) {
            (5, 0, 0)
        } else if (arg0 == 4) {
            (8, 0, 0)
        } else if (arg0 == 5) {
            (12, 0, 0)
        } else if (arg0 == 6) {
            (18, 1, 0)
        } else if (arg0 == 7) {
            (25, 2, 0)
        } else if (arg0 == 8) {
            (35, 4, 0)
        } else if (arg0 == 9) {
            (45, 6, 0)
        } else if (arg0 == 10) {
            (55, 9, 1)
        } else if (arg0 == 11) {
            (65, 12, 3)
        } else {
            (80, 15, 5)
        }
    }

    fun get_dock_capacity(arg0: u8) : u64 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            4
        } else if (arg0 == 2) {
            6
        } else if (arg0 == 3) {
            8
        } else if (arg0 == 4) {
            10
        } else if (arg0 == 5) {
            12
        } else if (arg0 == 6) {
            14
        } else if (arg0 == 7) {
            16
        } else if (arg0 == 8) {
            18
        } else if (arg0 == 9) {
            19
        } else {
            20
        }
    }

    fun get_gear_bonus(arg0: u8) : u64 {
        if (arg0 == 1) {
            8
        } else if (arg0 == 2) {
            18
        } else if (arg0 == 3) {
            30
        } else {
            0
        }
    }

    fun get_gear_cost(arg0: u8) : (u64, u64, u64) {
        if (arg0 == 1) {
            (5, 0, 0)
        } else if (arg0 == 2) {
            (0, 3, 0)
        } else {
            (0, 0, 1)
        }
    }

    fun get_gear_craft_time(arg0: u8) : u64 {
        if (arg0 == 1) {
            14400000
        } else if (arg0 == 2) {
            43200000
        } else {
            86400000
        }
    }

    fun get_gold_per_hour(arg0: u8) : u64 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            10
        } else if (arg0 == 2) {
            18
        } else if (arg0 == 3) {
            30
        } else if (arg0 == 4) {
            48
        } else if (arg0 == 5) {
            72
        } else if (arg0 == 6) {
            100
        } else if (arg0 == 7) {
            140
        } else if (arg0 == 8) {
            190
        } else if (arg0 == 9) {
            250
        } else {
            320
        }
    }

    fun get_max_army(arg0: u8, arg1: u8) : u64 {
        let v0 = if (arg0 == 0) {
            0
        } else if (arg0 <= 2) {
            5 + ((arg0 as u64) - 1) * 3
        } else if (arg0 <= 5) {
            10 + ((arg0 as u64) - 3) * 2
        } else {
            16 + ((arg0 as u64) - 6) * 2
        };
        let v1 = if (arg1 == 0) {
            0
        } else if (arg1 <= 3) {
            2 + (arg1 as u64) - 1
        } else {
            4 + (arg1 as u64) - 3
        };
        v0 + v1
    }

    fun get_power_tier(arg0: u64) : u8 {
        if (arg0 <= 500) {
            0
        } else if (arg0 <= 1500) {
            1
        } else if (arg0 <= 3500) {
            2
        } else if (arg0 <= 6000) {
            3
        } else {
            4
        }
    }

    fun get_production_power(arg0: u8) : u64 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            10
        } else if (arg0 == 2) {
            25
        } else if (arg0 == 3) {
            50
        } else if (arg0 == 4) {
            85
        } else if (arg0 == 5) {
            130
        } else if (arg0 == 6) {
            190
        } else if (arg0 == 7) {
            260
        } else if (arg0 == 8) {
            350
        } else if (arg0 == 9) {
            460
        } else {
            600
        }
    }

    fun get_research_cost(arg0: u8) : (u64, u64, u64, u64) {
        if (arg0 == 1) {
            (100, 5, 0, 0)
        } else {
            let (v4, v5, v6, v7) = if (arg0 == 2) {
                (15, 0, 0, 400)
            } else {
                let (v8, v9, v10, v11) = if (arg0 == 3) {
                    (1000, 0, 3, 0)
                } else if (arg0 == 4) {
                    (1800, 0, 8, 0)
                } else {
                    (2800, 0, 0, 1)
                };
                (v9, v10, v11, v8)
            };
            (v7, v4, v5, v6)
        }
    }

    fun get_research_time(arg0: u8) : u64 {
        if (arg0 == 1) {
            14400000
        } else if (arg0 == 2) {
            43200000
        } else if (arg0 == 3) {
            86400000
        } else if (arg0 == 4) {
            172800000
        } else {
            259200000
        }
    }

    fun get_tactic_multiplier(arg0: u8, arg1: u8) : u64 {
        if (arg0 == arg1) {
            100
        } else {
            let v1 = if (arg0 == 0 && arg1 == 2) {
                true
            } else if (arg0 == 1 && arg1 == 0) {
                true
            } else {
                arg0 == 2 && arg1 == 1
            };
            if (v1) {
                125
            } else {
                75
            }
        }
    }

    fun get_train_time(arg0: u8) : u64 {
        if (arg0 == 0) {
            300000
        } else if (arg0 == 1) {
            480000
        } else if (arg0 == 2) {
            600000
        } else if (arg0 == 3) {
            600000
        } else if (arg0 == 4) {
            480000
        } else if (arg0 == 5) {
            1200000
        } else if (arg0 == 6) {
            1500000
        } else if (arg0 == 7) {
            1800000
        } else {
            3600000
        }
    }

    fun get_troop_bub_cost(arg0: u8) : u64 {
        if (arg0 == 0) {
            5
        } else if (arg0 == 1) {
            10
        } else if (arg0 == 2) {
            15
        } else if (arg0 == 3) {
            15
        } else if (arg0 == 4) {
            10
        } else if (arg0 == 5) {
            60
        } else if (arg0 == 6) {
            80
        } else if (arg0 == 7) {
            100
        } else {
            200
        }
    }

    fun get_troop_gold_cost(arg0: u8) : u64 {
        if (arg0 == 0) {
            80
        } else if (arg0 == 1) {
            150
        } else if (arg0 == 2) {
            120
        } else if (arg0 == 3) {
            140
        } else if (arg0 == 4) {
            100
        } else if (arg0 == 5) {
            450
        } else if (arg0 == 6) {
            600
        } else if (arg0 == 7) {
            500
        } else {
            1500
        }
    }

    fun get_troop_stats(arg0: u8) : (u64, u64) {
        if (arg0 == 0) {
            (100, 20)
        } else if (arg0 == 1) {
            (250, 10)
        } else if (arg0 == 2) {
            (60, 40)
        } else {
            let (v2, v3) = if (arg0 == 3) {
                (35, 80)
            } else {
                let (v4, v5) = if (arg0 == 4) {
                    (90, 30)
                } else if (arg0 == 5) {
                    (500, 50)
                } else if (arg0 == 6) {
                    (200, 75)
                } else if (arg0 == 7) {
                    (300, 45)
                } else {
                    (1000, 100)
                };
                (v5, v4)
            };
            (v3, v2)
        }
    }

    fun get_upgrade_bub_cost(arg0: u8) : u64 {
        if (arg0 <= 1) {
            0
        } else if (arg0 == 2) {
            40
        } else if (arg0 == 3) {
            80
        } else if (arg0 == 4) {
            200
        } else if (arg0 == 5) {
            400
        } else if (arg0 == 6) {
            800
        } else if (arg0 == 7) {
            1400
        } else if (arg0 == 8) {
            2200
        } else if (arg0 == 9) {
            3400
        } else {
            5200
        }
    }

    fun get_upgrade_bublz_cost(arg0: u8) : u64 {
        if (arg0 <= 1) {
            0
        } else if (arg0 == 2) {
            3000
        } else if (arg0 == 3) {
            8000
        } else if (arg0 == 4) {
            15000
        } else if (arg0 == 5) {
            25000
        } else if (arg0 == 6) {
            40000
        } else if (arg0 == 7) {
            55000
        } else if (arg0 == 8) {
            70000
        } else if (arg0 == 9) {
            85000
        } else {
            85000
        }
    }

    fun get_upgrade_gold_cost(arg0: u8) : u64 {
        if (arg0 <= 1) {
            25
        } else if (arg0 == 2) {
            100
        } else if (arg0 == 3) {
            250
        } else if (arg0 == 4) {
            750
        } else if (arg0 == 5) {
            1500
        } else if (arg0 == 6) {
            3000
        } else if (arg0 == 7) {
            6000
        } else if (arg0 == 8) {
            10000
        } else if (arg0 == 9) {
            17500
        } else {
            25000
        }
    }

    fun get_wall_cost(arg0: u8) : (u64, u64, u64, u64) {
        if (arg0 == 0) {
            (3, 0, 10, 25)
        } else if (arg0 == 1) {
            (0, 1, 25, 50)
        } else {
            (0, 3, 50, 100)
        }
    }

    public entry fun heal_troop(arg0: &mut Camp, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(arg1 < 0x1::vector::length<u8>(&arg0.troops.troop_types), 16);
        let v0 = *0x1::vector::borrow<u64>(&arg0.troops.troop_max_hp, arg1);
        let v1 = *0x1::vector::borrow<u64>(&arg0.troops.troop_hp, arg1);
        if (v1 >= v0) {
            return
        };
        let v2 = (v0 - v1 + 9) / 10;
        assert!(arg0.gold >= v2, 7);
        arg0.gold = arg0.gold - v2;
        *0x1::vector::borrow_mut<u64>(&mut arg0.troops.troop_hp, arg1) = v0;
    }

    public entry fun hourly_lock<T0, T1>(arg0: &GameState<T0, T1>, arg1: &mut Camp, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        tick<T0, T1>(arg0, arg1, arg2);
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun place_wall<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: u8, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg6) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        assert!(arg2 <= 2, 28);
        assert!(arg3 > 0 && arg3 <= 30, 37);
        let v0 = *0x1::vector::borrow<u8>(&arg1.buildings, (0 as u64));
        if (arg2 == 1) {
            assert!(v0 >= 3, 3);
        };
        if (arg2 == 2) {
            assert!(v0 >= 6, 3);
        };
        assert!(arg1.walls.walls_basic + arg1.walls.walls_reinforced + arg1.walls.walls_fortified + arg1.walls.damaged_basic + arg1.walls.damaged_reinforced + arg1.walls.damaged_fortified + arg3 <= 30, 37);
        tick<T0, T1>(arg0, arg1, arg5);
        let (v1, v2, v3, v4) = get_wall_cost(arg2);
        assert!(arg1.shards >= v1 * arg3, 7);
        assert!(arg1.crystals >= v2 * arg3, 7);
        assert!(arg1.gold >= v4 * arg3, 7);
        let v5 = v3 * arg3 * arg0.bub_unit;
        assert!(0x2::coin::value<T0>(&arg4) >= v5, 7);
        arg1.shards = arg1.shards - v1 * arg3;
        arg1.crystals = arg1.crystals - v2 * arg3;
        arg1.gold = arg1.gold - v4 * arg3;
        process_bub_payment<T0, T1>(arg4, v5, arg1.owner, arg0, arg6);
        if (arg2 == 0) {
            arg1.walls.walls_basic = arg1.walls.walls_basic + arg3;
        } else if (arg2 == 1) {
            arg1.walls.walls_reinforced = arg1.walls.walls_reinforced + arg3;
        } else {
            arg1.walls.walls_fortified = arg1.walls.walls_fortified + arg3;
        };
        recalc_power(arg1);
    }

    fun process_bub_payment<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut GameState<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        let v0 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, arg1, arg4));
        0x2::balance::join<T0>(&mut arg3.bub_pool, 0x2::balance::split<T0>(&mut v0, arg1 * 9000 / 10000));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), @0x0);
    }

    fun process_bublz_payment<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: address, arg3: &mut GameState<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg0, arg2);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg0, arg2);
        let v0 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, arg1, arg4));
        0x2::balance::join<T1>(&mut arg3.bublz_pool, 0x2::balance::split<T1>(&mut v0, arg1 * 9000 / 10000));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg4), @0x0);
    }

    fun process_sui_payment<T0, T1>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut GameState<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.sui_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg4)));
    }

    fun recalc_power(arg0: &mut Camp) {
        let v0 = 0;
        let v1 = 1;
        while (v1 < 13) {
            v0 = v0 + (*0x1::vector::borrow<u8>(&arg0.buildings, v1) as u64);
            v1 = v1 + 1;
        };
        let v2 = 0;
        v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0.troops.troop_types)) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg0.troops.troop_atk, v1);
            v1 = v1 + 1;
        };
        let v3 = 0;
        v1 = 0;
        while (v1 < 9) {
            v3 = v3 + (*0x1::vector::borrow<u8>(&arg0.lab.research, v1) as u64);
            v1 = v1 + 1;
        };
        arg0.power_level = (*0x1::vector::borrow<u8>(&arg0.buildings, (0 as u64)) as u64) * 100 + v0 * 20 + v2 * 2 + arg0.walls.walls_basic * 15 + arg0.walls.walls_reinforced * 35 + arg0.walls.walls_fortified * 70 + v3 * 50;
    }

    fun remove_troop(arg0: &mut Camp, arg1: u64) {
        0x1::vector::swap_remove<u8>(&mut arg0.troops.troop_types, arg1);
        0x1::vector::swap_remove<u64>(&mut arg0.troops.troop_hp, arg1);
        0x1::vector::swap_remove<u64>(&mut arg0.troops.troop_max_hp, arg1);
        0x1::vector::swap_remove<u64>(&mut arg0.troops.troop_atk, arg1);
        0x1::vector::swap_remove<u64>(&mut arg0.troops.troop_born_ms, arg1);
        0x1::vector::swap_remove<u8>(&mut arg0.troops.troop_gear, arg1);
    }

    public entry fun repair_walls(arg0: &mut Camp, arg1: u8, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(arg1 <= 2, 28);
        assert!(arg2 > 0 && arg2 <= 200, 37);
        let (v0, v1) = if (arg1 == 0) {
            (arg0.walls.damaged_basic, 12)
        } else if (arg1 == 1) {
            (arg0.walls.damaged_reinforced, 25)
        } else {
            (arg0.walls.damaged_fortified, 50)
        };
        let v2 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        assert!(arg0.gold >= v1 * v2, 7);
        arg0.gold = arg0.gold - v1 * v2;
        if (arg1 == 0) {
            arg0.walls.damaged_basic = arg0.walls.damaged_basic - v2;
            arg0.walls.walls_basic = arg0.walls.walls_basic + v2;
        } else if (arg1 == 1) {
            arg0.walls.damaged_reinforced = arg0.walls.damaged_reinforced - v2;
            arg0.walls.walls_reinforced = arg0.walls.walls_reinforced + v2;
        } else {
            arg0.walls.damaged_fortified = arg0.walls.damaged_fortified - v2;
            arg0.walls.walls_fortified = arg0.walls.walls_fortified + v2;
        };
        recalc_power(arg0);
    }

    public entry fun seed_bub_pool<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.bub_pool, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun seed_bublz_pool<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.bublz_pool, 0x2::coin::into_balance<T1>(arg2));
    }

    public entry fun set_defense_tactic(arg0: &mut Camp, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(arg1 < 3, 23);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.combat.last_tactic_change_ms == 0 || v0 >= arg0.combat.last_tactic_change_ms + 86400000, 24);
        arg0.combat.defense_tactic = arg1;
        arg0.combat.last_tactic_change_ms = v0;
    }

    public entry fun set_emission_rate<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64) {
        arg0.pool_emission_bps = arg2;
    }

    public entry fun set_gold_rate<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: u64) {
        arg0.gold_per_sui = arg2;
    }

    public entry fun set_paused<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    fun snapshot_production<T0, T1>(arg0: &GameState<T0, T1>, arg1: &mut Camp, arg2: u64) {
        if (arg2 <= arg1.last_production_ms) {
            return
        };
        let v0 = arg2 - arg1.last_production_ms;
        let v1 = v0;
        if (v0 > 172800000) {
            v1 = 172800000;
        };
        let v2 = get_activity_multiplier(arg1, arg2);
        if (arg1.extractor_power > 0 && arg0.total_extractor_power > 0) {
            arg1.pending_bub = arg1.pending_bub + ((((((((((((0x2::balance::value<T0>(&arg0.bub_pool) as u128) * (arg0.pool_emission_bps as u128) / (10000 as u128)) as u64) as u128) * (arg1.extractor_power as u128) / (arg0.total_extractor_power as u128)) as u64) as u128) * (v1 as u128) / (86400000 as u128)) as u64) as u128) * (v2 as u128) / (10000 as u128)) as u64);
        };
        if (arg1.drill_power > 0 && arg0.total_drill_power > 0) {
            arg1.pending_bublz = arg1.pending_bublz + ((((((((((((0x2::balance::value<T1>(&arg0.bublz_pool) as u128) * (arg0.pool_emission_bps as u128) / (10000 as u128)) as u64) as u128) * (arg1.drill_power as u128) / (arg0.total_drill_power as u128)) as u64) as u128) * (v1 as u128) / (86400000 as u128)) as u64) as u128) * (v2 as u128) / (10000 as u128)) as u64);
        };
        arg1.last_production_ms = arg2;
    }

    fun sort_desc(arg0: &mut vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 <= 1) {
            return
        };
        let v1 = 0;
        while (v1 < v0 - 1) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                if (*0x1::vector::borrow<u8>(arg0, v2) > *0x1::vector::borrow<u8>(arg0, v1)) {
                    0x1::vector::swap<u8>(arg0, v1, v2);
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public entry fun speed_up_build<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg5) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        assert!((arg2 as u64) < 13, 15);
        let v0 = *0x1::vector::borrow<u64>(&arg1.build_timers, (arg2 as u64));
        assert!(v0 > 0, 6);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (v0 <= v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg1.owner);
            return
        };
        let v2 = (v0 - v1 + 3600000 - 1) / 3600000 * 1000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 7);
        process_sui_payment<T0, T1>(arg3, v2, arg1.owner, arg0, arg5);
        *0x1::vector::borrow_mut<u64>(&mut arg1.build_timers, (arg2 as u64)) = v1;
    }

    public entry fun start_conversion<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg5) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        assert!(*0x1::vector::borrow<u8>(&arg1.buildings, (11 as u64)) > 0, 21);
        assert!(arg1.lab.conversion_type == 255, 34);
        assert!(arg2 <= 1, 37);
        let v0 = if (arg2 == 0) {
            assert!(arg1.shards >= 10, 7);
            arg1.shards = arg1.shards - 10;
            50 * arg0.bub_unit
        } else {
            assert!(arg1.crystals >= 10, 7);
            arg1.crystals = arg1.crystals - 10;
            200 * arg0.bub_unit
        };
        assert!(0x2::coin::value<T0>(&arg3) >= v0, 7);
        process_bub_payment<T0, T1>(arg3, v0, arg1.owner, arg0, arg5);
        arg1.lab.conversion_type = arg2;
        arg1.lab.conversion_done_ms = 0x2::clock::timestamp_ms(arg4) + get_conversion_time(arg2);
    }

    public entry fun start_gear_craft(arg0: &mut Camp, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 2);
        assert!(*0x1::vector::borrow<u8>(&arg0.buildings, (11 as u64)) > 0, 21);
        assert!(arg0.lab.gear_craft_tier == 255, 31);
        assert!(arg1 >= 1 && arg1 <= 3, 37);
        assert!(arg2 < 0x1::vector::length<u8>(&arg0.troops.troop_types), 16);
        assert!(*0x1::vector::borrow<u8>(&arg0.troops.troop_gear, arg2) == 0, 39);
        let (v0, v1, v2) = get_gear_cost(arg1);
        assert!(arg0.shards >= v0, 7);
        assert!(arg0.crystals >= v1, 7);
        assert!(arg0.cores >= v2, 7);
        arg0.shards = arg0.shards - v0;
        arg0.crystals = arg0.crystals - v1;
        arg0.cores = arg0.cores - v2;
        arg0.lab.gear_craft_tier = arg1;
        arg0.lab.gear_craft_troop = arg2;
        arg0.lab.gear_craft_born_ms = *0x1::vector::borrow<u64>(&arg0.troops.troop_born_ms, arg2);
        arg0.lab.gear_craft_done_ms = 0x2::clock::timestamp_ms(arg3) + get_gear_craft_time(arg1);
    }

    public entry fun start_research<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg5) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        assert!((arg2 as u64) < 9, 16);
        assert!(*0x1::vector::borrow<u8>(&arg1.buildings, (11 as u64)) > 0, 21);
        assert!(arg1.lab.research_type == 255, 29);
        let v0 = *0x1::vector::borrow<u8>(&arg1.lab.research, (arg2 as u64));
        assert!(v0 < 5, 22);
        let v1 = v0 + 1;
        let (v2, v3, v4, v5) = get_research_cost(v1);
        assert!(arg1.shards >= v3, 7);
        assert!(arg1.crystals >= v4, 7);
        assert!(arg1.cores >= v5, 7);
        let v6 = v2 * arg0.bub_unit;
        assert!(0x2::coin::value<T0>(&arg3) >= v6, 7);
        arg1.shards = arg1.shards - v3;
        arg1.crystals = arg1.crystals - v4;
        arg1.cores = arg1.cores - v5;
        process_bub_payment<T0, T1>(arg3, v6, arg1.owner, arg0, arg5);
        arg1.lab.research_type = arg2;
        arg1.lab.research_done_ms = 0x2::clock::timestamp_ms(arg4) + get_research_time(v1);
    }

    public entry fun start_training<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg5) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        assert!((arg2 as u64) < 9, 16);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        clean_expired_troops(arg1, v0);
        let v1 = *0x1::vector::borrow<u8>(&arg1.buildings, (9 as u64));
        let v2 = *0x1::vector::borrow<u8>(&arg1.buildings, (10 as u64));
        assert!(can_train_troop(arg2, v1, v2), 3);
        assert!(0x1::vector::length<u8>(&arg1.troops.troop_types) < get_max_army(v1, v2), 14);
        let v3 = get_troop_gold_cost(arg2);
        assert!(arg1.gold >= v3, 7);
        arg1.gold = arg1.gold - v3;
        let v4 = get_troop_bub_cost(arg2) * arg0.bub_unit;
        assert!(0x2::coin::value<T0>(&arg3) >= v4, 7);
        process_bub_payment<T0, T1>(arg3, v4, arg1.owner, arg0, arg5);
        if (arg2 <= 4) {
            assert!(arg1.troops.barracks_training == 255, 25);
            arg1.troops.barracks_training = arg2;
            arg1.troops.barracks_done_ms = v0 + get_train_time(arg2);
        } else {
            assert!(arg1.troops.factory_training == 255, 25);
            arg1.troops.factory_training = arg2;
            arg1.troops.factory_done_ms = v0 + get_train_time(arg2);
        };
    }

    public entry fun start_upgrade<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &mut Camp, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 19);
        assert!(0x2::tx_context::sender(arg6) == arg1.owner, 2);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.game_id, 47);
        assert!((arg2 as u64) < 13, 15);
        assert!(arg2 != 4, 15);
        let v0 = *0x1::vector::borrow<u8>(&arg1.buildings, (arg2 as u64));
        assert!(v0 < 10, 4);
        let v1 = v0 + 1;
        assert!(*0x1::vector::borrow<u64>(&arg1.build_timers, (arg2 as u64)) == 0, 5);
        if (arg2 != 0) {
            let v2 = *0x1::vector::borrow<u8>(&arg1.buildings, (0 as u64));
            assert!(can_build_at_hall(arg2, v2), 3);
            assert!(v0 < v2, 3);
        };
        tick<T0, T1>(arg0, arg1, arg5);
        let v3 = get_upgrade_gold_cost(v1);
        assert!(arg1.gold >= v3, 7);
        arg1.gold = arg1.gold - v3;
        let v4 = get_upgrade_bub_cost(v1) * arg0.bub_unit;
        let v5 = get_upgrade_bublz_cost(v1) * arg0.bublz_unit;
        assert!(0x2::coin::value<T0>(&arg3) >= v4, 7);
        assert!(0x2::coin::value<T1>(&arg4) >= v5, 7);
        process_bub_payment<T0, T1>(arg3, v4, arg1.owner, arg0, arg6);
        process_bublz_payment<T0, T1>(arg4, v5, arg1.owner, arg0, arg6);
        if (v1 == 1) {
            *0x1::vector::borrow_mut<u8>(&mut arg1.buildings, (arg2 as u64)) = 1;
            if (arg2 == 2) {
                let v6 = get_production_power(1);
                arg1.extractor_power = v6;
                arg0.total_extractor_power = arg0.total_extractor_power + v6;
            } else if (arg2 == 3) {
                let v7 = get_production_power(1);
                arg1.drill_power = v7;
                arg0.total_drill_power = arg0.total_drill_power + v7;
            };
            recalc_power(arg1);
            let v8 = BuildCompleted{
                owner       : arg1.owner,
                building_id : arg2,
                new_level   : 1,
            };
            0x2::event::emit<BuildCompleted>(v8);
        } else {
            let v9 = 0x2::clock::timestamp_ms(arg5);
            let v10 = get_build_time(v1);
            *0x1::vector::borrow_mut<u64>(&mut arg1.build_timers, (arg2 as u64)) = v9 + v10;
            let v11 = BuildStarted{
                owner        : arg1.owner,
                building_id  : arg2,
                target_level : v1,
                done_ms      : v9 + v10,
            };
            0x2::event::emit<BuildStarted>(v11);
        };
    }

    fun tick<T0, T1>(arg0: &GameState<T0, T1>, arg1: &mut Camp, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        snapshot_production<T0, T1>(arg0, arg1, v0);
        collect_gold_internal(arg1, v0);
        apply_lock(arg1, v0);
    }

    public entry fun use_haste_tonic(arg0: &mut Camp, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(arg0.consumables.haste_tonics > 0, 33);
        assert!((arg1 as u64) < 13, 15);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.build_timers, (arg1 as u64));
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(*v0 > 0 && *v0 > v1, 6);
        let v2 = *v0 - v1;
        assert!(v2 > get_build_time(*0x1::vector::borrow<u8>(&arg0.buildings, (arg1 as u64)) + 1) / 2, 49);
        *v0 = v1 + v2 / 2;
        arg0.consumables.haste_tonics = arg0.consumables.haste_tonics - 1;
    }

    public entry fun use_healing_tide(arg0: &mut Camp, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
        assert!(arg0.consumables.healing_tides > 0, 33);
        arg0.consumables.healing_tides = arg0.consumables.healing_tides - 1;
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0.troops.troop_types)) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.troops.troop_hp, v0) = *0x1::vector::borrow<u64>(&arg0.troops.troop_max_hp, v0);
            v0 = v0 + 1;
        };
    }

    public entry fun use_iron_shell(arg0: &mut Camp, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(arg0.consumables.iron_shells > 0, 33);
        arg0.consumables.iron_shells = arg0.consumables.iron_shells - 1;
        arg0.consumables.iron_shell_expires_ms = 0x2::clock::timestamp_ms(arg1) + 28800000;
    }

    public entry fun use_scout_lens(arg0: &mut Camp, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
        assert!(arg0.consumables.scout_lenses > 0, 33);
        arg0.consumables.scout_lenses = arg0.consumables.scout_lenses - 1;
    }

    public entry fun withdraw_treasury<T0, T1>(arg0: &mut GameState<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v7
}

