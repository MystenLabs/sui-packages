module 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::game {
    struct BuffEntry has copy, drop, store {
        kind: u8,
        last_active_round: u16,
        value: u64,
        spawn_index: u16,
    }

    struct Player has store {
        owner: address,
        pos: u16,
        cash: u64,
        in_hospital_turns: u8,
        bankrupt: bool,
        cards: vector<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::CardEntry>,
        last_tile_id: u16,
        next_tile_id: u16,
        temple_levels: vector<u8>,
        buffs: vector<BuffEntry>,
    }

    struct NpcInst has copy, drop, store {
        tile_id: u16,
        kind: u8,
        consumable: bool,
        spawn_index: u16,
    }

    struct NpcSpawnEntry has copy, drop, store {
        npc_kind: u8,
        next_active_round: u16,
    }

    struct Seat has key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        player: address,
        player_index: u8,
    }

    struct Building has copy, drop, store {
        owner: u8,
        level: u8,
        building_type: u8,
    }

    struct Tile has copy, drop, store {
        npc_on: u16,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        status: u8,
        template_map_id: 0x2::object::ID,
        players: vector<Player>,
        round: u16,
        turn: u8,
        active_idx: u8,
        has_rolled: bool,
        tiles: vector<Tile>,
        buildings: vector<Building>,
        npc_on: vector<NpcInst>,
        npc_spawn_pool: vector<NpcSpawnEntry>,
        max_rounds: u8,
        price_rise_days: u8,
        winner: 0x1::option::Option<address>,
        pending_decision: u8,
        decision_tile: u16,
        decision_amount: u64,
    }

    fun get_player_card_count(arg0: &Game, arg1: address, arg2: u8) : u8 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Player>(&arg0.players)) {
            let v1 = 0x1::vector::borrow<Player>(&arg0.players, v0);
            if (v1.owner == arg1) {
                return 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::get_player_card_count(&v1.cards, arg2)
            };
            v0 = v0 + 1;
        };
        0
    }

    fun advance_turn(arg0: &mut Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x1::vector::length<Player>(&arg0.players) as u8);
        let v1 = 0;
        let v2 = false;
        loop {
            if (arg0.active_idx + 1 >= v0) {
                v2 = true;
            };
            arg0.active_idx = (arg0.active_idx + 1) % v0;
            v1 = v1 + 1;
            if (!0x1::vector::borrow<Player>(&arg0.players, (arg0.active_idx as u64)).bankrupt) {
                break
            };
            if (v1 >= v0) {
                break
            };
        };
        arg0.turn = arg0.active_idx;
        if (v2) {
            arg0.round = arg0.round + 1;
            refresh_at_round_end(arg0, arg1, arg2, arg3, arg4);
            if (arg0.max_rounds > 0) {
                if (arg0.round >= (arg0.max_rounds as u16)) {
                    arg0.status = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::STATUS_ENDED();
                    let v3 = find_richest_player(arg0);
                    arg0.winner = v3;
                    0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_game_ended_event(0x2::object::uid_to_inner(&arg0.id), v3, (arg0.round as u16), (arg0.turn as u8), 1);
                };
            };
        };
        arg0.has_rolled = false;
    }

    fun apply_buff(arg0: &mut Player, arg1: u8, arg2: u16, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BuffEntry>(&arg0.buffs)) {
            let v1 = *0x1::vector::borrow<BuffEntry>(&arg0.buffs, v0);
            if (v1.kind == arg1) {
                0x1::vector::remove<BuffEntry>(&mut arg0.buffs, v0);
                break
            };
            v0 = v0 + 1;
        };
        let v2 = BuffEntry{
            kind              : arg1,
            last_active_round : arg2,
            value             : arg3,
            spawn_index       : 65535,
        };
        0x1::vector::push_back<BuffEntry>(&mut arg0.buffs, v2);
    }

    fun apply_buff_with_source(arg0: &mut Player, arg1: u8, arg2: u16, arg3: u64, arg4: u16) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BuffEntry>(&arg0.buffs)) {
            let v1 = *0x1::vector::borrow<BuffEntry>(&arg0.buffs, v0);
            if (v1.kind == arg1) {
                0x1::vector::remove<BuffEntry>(&mut arg0.buffs, v0);
                break
            };
            v0 = v0 + 1;
        };
        let v2 = BuffEntry{
            kind              : arg1,
            last_active_round : arg2,
            value             : arg3,
            spawn_index       : arg4,
        };
        0x1::vector::push_back<BuffEntry>(&mut arg0.buffs, v2);
    }

    fun apply_card_effect_with_collectors(arg0: &mut Game, arg1: u8, arg2: u8, arg3: &vector<u16>, arg4: &mut vector<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcChangeItem>, arg5: &mut vector<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::BuffChangeItem>, arg6: &mut vector<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>, arg7: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate) {
        if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_MOVE_CTRL()) {
            assert!(0x1::vector::length<u16>(arg3) >= 2, 5005);
            let v0 = (*0x1::vector::borrow<u16>(arg3, 0) as u8);
            assert!((v0 as u64) < 0x1::vector::length<Player>(&arg0.players), 1006);
            let v1 = 0;
            let v2 = 1;
            while (v2 < 0x1::vector::length<u16>(arg3)) {
                let v3 = *0x1::vector::borrow<u16>(arg3, v2);
                assert!(v3 >= 1 && v3 <= 6, 5005);
                v1 = v1 + (v3 as u64);
                v2 = v2 + 1;
            };
            let v4 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (v0 as u64));
            apply_buff(v4, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_MOVE_CTRL(), arg0.round, v1);
            0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::BuffChangeItem>(arg5, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_buff_change(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_MOVE_CTRL(), 0x1::vector::borrow<Player>(&arg0.players, (v0 as u64)).owner, 0x1::option::some<u16>(arg0.round)));
        } else if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_RENT_FREE()) {
            let v5 = if (0x1::vector::length<u16>(arg3) > 0) {
                (*0x1::vector::borrow<u16>(arg3, 0) as u8)
            } else {
                arg1
            };
            assert!((v5 as u64) < 0x1::vector::length<Player>(&arg0.players), 1006);
            let v6 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (v5 as u64));
            apply_buff(v6, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_RENT_FREE(), arg0.round + 1, 0);
            0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::BuffChangeItem>(arg5, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_buff_change(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_RENT_FREE(), 0x1::vector::borrow<Player>(&arg0.players, (v5 as u64)).owner, 0x1::option::some<u16>(arg0.round + 1)));
        } else if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_FREEZE()) {
            assert!(0x1::vector::length<u16>(arg3) >= 1, 5005);
            let v7 = (*0x1::vector::borrow<u16>(arg3, 0) as u8);
            assert!((v7 as u64) < 0x1::vector::length<Player>(&arg0.players), 1006);
            assert!(v7 != arg1, 5003);
            let v8 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (v7 as u64));
            apply_buff(v8, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_FROZEN(), arg0.round + 1, 0);
            0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::BuffChangeItem>(arg5, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_buff_change(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_FROZEN(), 0x1::vector::borrow<Player>(&arg0.players, (v7 as u64)).owner, 0x1::option::some<u16>(arg0.round + 1)));
        } else {
            let v9 = if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_BARRIER()) {
                true
            } else if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_BOMB()) {
                true
            } else {
                arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_DOG()
            };
            if (v9) {
                assert!(0x1::vector::length<u16>(arg3) >= 1, 5005);
                let v10 = *0x1::vector::borrow<u16>(arg3, 0);
                let v11 = if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_BARRIER()) {
                    0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_BARRIER()
                } else if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_BOMB()) {
                    0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_BOMB()
                } else {
                    0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_DOG()
                };
                if (0x1::vector::borrow<Tile>(&arg0.tiles, (v10 as u64)).npc_on == 65535) {
                    place_npc_internal(arg0, v10, v11, is_npc_consumable(v11), arg4);
                };
            } else if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_CLEANSE()) {
                let v12 = 0;
                while (v12 < 0x1::vector::length<u16>(arg3)) {
                    remove_npc_internal(arg0, *0x1::vector::borrow<u16>(arg3, v12), arg4);
                    v12 = v12 + 1;
                };
            } else if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_TURN()) {
                let v13 = if (0x1::vector::length<u16>(arg3) > 0) {
                    (*0x1::vector::borrow<u16>(arg3, 0) as u8)
                } else {
                    arg1
                };
                assert!((v13 as u64) < 0x1::vector::length<Player>(&arg0.players), 1006);
                let v14 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (v13 as u64));
                assert!(v14.last_tile_id != 65535, 5006);
                v14.next_tile_id = v14.last_tile_id;
            };
        };
    }

    public(friend) fun apply_defi_reward(arg0: &mut Game, arg1: u8, arg2: u8, arg3: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
        if (has_defi_buff(v0, arg2)) {
            return false
        };
        v0.cash = v0.cash + 2000;
        let v1 = BuffEntry{
            kind              : arg2,
            last_active_round : 9999,
            value             : 150,
            spawn_index       : 65535,
        };
        0x1::vector::push_back<BuffEntry>(&mut v0.buffs, v1);
        true
    }

    entry fun buy_building(arg0: &mut Game, arg1: &Seat, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg3: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        validate_map(arg0, arg3);
        validate_seat_and_turn(arg0, arg1);
        assert!(arg0.pending_decision == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_BUY_PROPERTY(), 6006);
        let v0 = arg1.player_index;
        let v1 = 0x1::vector::borrow<Player>(&arg0.players, (v0 as u64));
        let v2 = v1.pos;
        assert!(v2 == arg0.decision_tile, 2003);
        let v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg3, v2);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_kind(v3);
        let v4 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_building_id(v3);
        assert!(v4 != 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::no_building(), 2004);
        assert!(0x1::vector::borrow<Building>(&arg0.buildings, (v4 as u64)).owner == 255, 2005);
        let v5 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_building(arg3, v4);
        let v6 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::building_price(v5);
        assert!(v6 > 0, 2008);
        let v7 = v6 * calculate_price_index(arg0);
        assert!(v1.cash > v7, 2010);
        let (v8, _) = try_execute_buy_building(arg0, v0, v4, v2, v7, v5);
        assert!(v8, 2010);
        let v10 = 0x1::vector::borrow<Building>(&arg0.buildings, (v4 as u64)).building_type;
        clear_decision_state(arg0);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_building_decision_event(0x2::object::uid_to_inner(&arg0.id), arg1.player, arg0.round, arg0.turn, false, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_building_decision_info(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_BUY_PROPERTY(), v4, v2, v7, 1, v10));
        advance_turn(arg0, arg2, arg3, arg4, arg5);
    }

    fun calculate_building_price(arg0: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::BuildingStatic, arg1: &Building, arg2: u8, arg3: u8, arg4: &Game, arg5: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData) : u64 {
        if (arg3 <= arg2) {
            return 0
        };
        let v0 = calculate_price_factor(arg4);
        let v1 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::building_size(arg0);
        if (v1 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::SIZE_1X1()) {
            let v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::building_price(arg0);
            let v4 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::get_building_upgrade_costs(arg5);
            let v5 = if ((arg2 as u64) < 0x1::vector::length<u64>(v4)) {
                *0x1::vector::borrow<u64>(v4, (arg2 as u64))
            } else {
                0
            };
            if ((arg3 as u64) < 0x1::vector::length<u64>(v4)) {
                let v6 = (v3 + v5) * v0 / 10000;
                let v7 = (v3 + *0x1::vector::borrow<u64>(v4, (arg3 as u64))) * v0 / 10000;
                if (v7 > v6) {
                    v7 - v6
                } else {
                    0
                }
            } else {
                return 0
            }
        } else if (v1 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::SIZE_2X2()) {
            if (arg1.building_type == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUILDING_TEMPLE() && arg2 > 0) {
                return 0
            };
            let v8 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::get_large_building_costs(arg5);
            let v9 = if (arg2 > 0) {
                ((arg2 - 1) as u64)
            } else {
                0
            };
            let v10 = ((arg3 - 1) as u64);
            let v11 = if (arg2 > 0 && v9 < 0x1::vector::length<u64>(v8)) {
                *0x1::vector::borrow<u64>(v8, v9)
            } else {
                0
            };
            if (v10 < 0x1::vector::length<u64>(v8)) {
                let v12 = *0x1::vector::borrow<u64>(v8, v10);
                let v13 = if (v12 > v11) {
                    v12 - v11
                } else {
                    v12
                };
                v13 * v0 / 10000
            } else {
                return 0
            }
        } else {
            0
        }
    }

    fun calculate_price_factor(arg0: &Game) : u64 {
        calculate_price_index(arg0) * 20
    }

    fun calculate_price_index(arg0: &Game) : u64 {
        (arg0.round as u64) / (arg0.price_rise_days as u64) + 1
    }

    fun calculate_single_tile_rent(arg0: u64, arg1: u8, arg2: u64, arg3: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData) : u64 {
        let v0 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::get_rent_multipliers(arg3);
        let v1 = if ((arg1 as u64) < 0x1::vector::length<u64>(v0)) {
            *0x1::vector::borrow<u64>(v0, (arg1 as u64))
        } else {
            100
        };
        arg0 * v1 * arg2 / 10000
    }

    fun calculate_temple_bonus(arg0: u64, arg1: &vector<u8>, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData) : u64 {
        let v0 = 0;
        let v1 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::get_temple_multipliers(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg1)) {
            let v3 = *0x1::vector::borrow<u8>(arg1, v2);
            if (v3 > 0 && (v3 as u64) <= 0x1::vector::length<u64>(v1)) {
                v0 = v0 + arg0 * *0x1::vector::borrow<u64>(v1, ((v3 - 1) as u64)) / 100;
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun calculate_toll(arg0: &Game, arg1: u16, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg3: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData) : u64 {
        let v0 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_building_id(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg2, arg1));
        if (v0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::no_building()) {
            return 0
        };
        let v1 = 0x1::vector::borrow<Building>(&arg0.buildings, (v0 as u64)).owner;
        if (v1 == 255) {
            return 0
        };
        let v2 = get_chain_buildings(arg0, arg2, v0);
        let v3 = find_owner_temples(arg0, v1);
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u16>(&v2)) {
            let v6 = *0x1::vector::borrow<u16>(&v2, v5);
            let v7 = calculate_single_tile_rent(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::building_price(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_building(arg2, v6)), 0x1::vector::borrow<Building>(&arg0.buildings, (v6 as u64)).level, calculate_price_index(arg0), arg3);
            let v8 = v4 + v7;
            v4 = v8 + calculate_temple_bonus(v7, &v3, arg3);
            v5 = v5 + 1;
        };
        v4
    }

    fun clean_expired_npcs(arg0: &mut Game) {
    }

    fun clean_turn_state(arg0: &mut Game, arg1: u8) {
        process_and_clear_expired_buffs(arg0, arg1);
    }

    fun clear_decision_state(arg0: &mut Game) {
        arg0.pending_decision = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_NONE();
        arg0.decision_tile = 0;
        arg0.decision_amount = 0;
    }

    fun clear_expired_buffs(arg0: &mut Player, arg1: u16) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BuffEntry>(&arg0.buffs)) {
            let v1 = *0x1::vector::borrow<BuffEntry>(&arg0.buffs, v0);
            if (v1.last_active_round < arg1) {
                0x1::vector::remove<BuffEntry>(&mut arg0.buffs, v0);
                continue
            };
            v0 = v0 + 1;
        };
    }

    fun consume_npc_if_consumable(arg0: &mut Game, arg1: u16, arg2: &NpcInst) : bool {
        if (arg2.consumable) {
            let v1 = 0x1::vector::borrow<Tile>(&arg0.tiles, (arg1 as u64)).npc_on;
            assert!(v1 != 65535, 2002);
            0x1::vector::swap_remove<NpcInst>(&mut arg0.npc_on, (v1 as u64));
            0x1::vector::borrow_mut<Tile>(&mut arg0.tiles, (arg1 as u64)).npc_on = 65535;
            if ((v1 as u64) < 0x1::vector::length<NpcInst>(&arg0.npc_on)) {
                0x1::vector::borrow_mut<Tile>(&mut arg0.tiles, (0x1::vector::borrow<NpcInst>(&arg0.npc_on, (v1 as u64)).tile_id as u64)).npc_on = v1;
            };
            true
        } else {
            false
        }
    }

    entry fun create_game(arg0: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = parse_game_params(&arg2);
        let v3 = 0x2::object::new(arg3);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x1::vector::empty<Tile>();
        let v6 = 0;
        while (v6 < 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile_count(arg1)) {
            let v7 = Tile{npc_on: 65535};
            0x1::vector::push_back<Tile>(&mut v5, v7);
            v6 = v6 + 1;
        };
        let v8 = 0x1::vector::empty<Building>();
        let v9 = 0;
        while (v9 < 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_building_count(arg1)) {
            let v10 = Building{
                owner         : 255,
                level         : 0,
                building_type : 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUILDING_NONE(),
            };
            0x1::vector::push_back<Building>(&mut v8, v10);
            v9 = v9 + 1;
        };
        let v11 = Game{
            id               : v3,
            status           : 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::STATUS_READY(),
            template_map_id  : 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_map_id(arg1),
            players          : 0x1::vector::empty<Player>(),
            round            : 0,
            turn             : 0,
            active_idx       : 0,
            has_rolled       : false,
            tiles            : v5,
            buildings        : v8,
            npc_on           : 0x1::vector::empty<NpcInst>(),
            npc_spawn_pool   : init_npc_spawn_pool(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::get_npc_spawn_weights(arg0)),
            max_rounds       : v2,
            price_rise_days  : v1,
            winner           : 0x1::option::none<address>(),
            pending_decision : 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_NONE(),
            decision_tile    : 0,
            decision_amount  : 0,
        };
        let v12 = 0x2::tx_context::sender(arg3);
        let v13 = create_player_with_cash(v12, v0, arg3);
        0x1::vector::push_back<Player>(&mut v11.players, v13);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_game_created_event(v4, v12, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_map_id(arg1));
        let v14 = Seat{
            id           : 0x2::object::new(arg3),
            game_id      : v4,
            player       : v12,
            player_index : 0,
        };
        0x2::transfer::share_object<Game>(v11);
        0x2::transfer::transfer<Seat>(v14, v12);
    }

    fun create_player_with_cash(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Player {
        let v0 = 0x1::vector::empty<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::CardEntry>();
        0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::CardEntry>(&mut v0, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::new_card_entry(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_MOVE_CTRL(), 1));
        0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::CardEntry>(&mut v0, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::new_card_entry(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_BARRIER(), 1));
        0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::CardEntry>(&mut v0, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::new_card_entry(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_CLEANSE(), 1));
        Player{
            owner             : arg0,
            pos               : 0,
            cash              : arg1,
            in_hospital_turns : 0,
            bankrupt          : false,
            cards             : v0,
            last_tile_id      : 65535,
            next_tile_id      : 65535,
            temple_levels     : b"",
            buffs             : 0x1::vector::empty<BuffEntry>(),
        }
    }

    entry fun decide_rent_payment(arg0: &mut Game, arg1: &Seat, arg2: bool, arg3: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg4: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        validate_map(arg0, arg4);
        validate_seat_and_turn(arg0, arg1);
        assert!(arg0.pending_decision == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_PAY_RENT(), 6006);
        let v0 = arg1.player_index;
        let v1 = arg0.decision_tile;
        let v2 = arg0.decision_amount;
        let v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_building_id(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg4, v1));
        assert!(v3 != 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::no_building(), 2004);
        let v4 = 0x1::vector::borrow<Building>(&arg0.buildings, (v3 as u64));
        assert!(v4.owner != 255, 2006);
        let v5 = v4.owner;
        if (arg2) {
            assert!(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::player_has_card(&0x1::vector::borrow<Player>(&arg0.players, (v0 as u64)).cards, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_RENT_FREE()), 5004);
            assert!(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::use_player_card(&mut 0x1::vector::borrow_mut<Player>(&mut arg0.players, (v0 as u64)).cards, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_RENT_FREE()), 5004);
        } else {
            let v6 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (v0 as u64));
            assert!(v6.cash >= v2, 2010);
            v6.cash = v6.cash - v2;
            let v7 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (v5 as u64));
            v7.cash = v7.cash + v2;
        };
        clear_decision_state(arg0);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_rent_decision_event(0x2::object::uid_to_inner(&arg0.id), arg0.round, arg0.turn, false, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_rent_decision_info(arg1.player, 0x1::vector::borrow<Player>(&arg0.players, (v5 as u64)).owner, v3, v1, v2, arg2));
        advance_turn(arg0, arg3, arg4, arg5, arg6);
    }

    fun execute_step_movement_with_choices(arg0: &mut Game, arg1: u8, arg2: u8, arg3: &vector<u16>, arg4: &mut vector<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StepEffect>, arg5: &mut vector<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>, arg6: bool, arg7: bool, arg8: bool, arg9: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg10: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg11: &mut 0x2::random::RandomGenerator) {
        let v0 = 0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64));
        let v1 = v0.pos;
        let v2 = v0.last_tile_id;
        let v3 = v0.next_tile_id;
        if (is_buff_active(v0, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_FROZEN(), arg0.round)) {
            0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StepEffect>(arg4, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_step_effect(0, v1, v1, 0, 0x1::vector::empty<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CardDrawItem>(), 0x1::option::none<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcStepEvent>(), 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StopEffect>(handle_tile_stop_with_collector(arg0, arg1, v1, arg5, arg6, arg7, arg8, arg9, arg10, arg11))));
            return
        };
        let v4 = 0;
        let v5 = 0;
        while (v5 < arg2) {
            let v6 = *0x1::vector::borrow<u16>(arg3, (v5 as u64));
            if (v5 == 0 && v3 != 65535) {
                assert!(v6 == v3, 4003);
                assert!(is_valid_neighbor(arg10, v1, v6, 65535), 4003);
                v3 = 65535;
            } else if (v6 == v2) {
                let v7 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_valid_neighbors(arg10, v1);
                assert!(0x1::vector::length<u16>(&v7) == 1 && *0x1::vector::borrow<u16>(&v7, 0) == v2, 4003);
            } else {
                assert!(is_valid_neighbor(arg10, v1, v6, v2), 4003);
            };
            let v8 = 0x1::vector::empty<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CardDrawItem>();
            0x1::option::none<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StopEffect>();
            let v9 = 0x1::vector::borrow<Tile>(&arg0.tiles, (v6 as u64)).npc_on;
            if (v9 != 65535) {
                let v10 = *0x1::vector::borrow<NpcInst>(&arg0.npc_on, (v9 as u64));
                if (is_hospital_npc(v10.kind)) {
                    0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64)).pos = v6;
                    let v11 = find_nearest_hospital(arg0, v6, arg10, arg9);
                    send_to_hospital_internal(arg0, arg1, v11, arg9);
                    let v12 = consume_npc_if_consumable(arg0, v6, &v10);
                    0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StepEffect>(arg4, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_step_effect(v4, v1, v6, arg2 - v5 - 1, v8, 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcStepEvent>(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_npc_step_event(v6, v10.kind, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::npc_result_send_hospital(), v12, 0x1::option::some<u16>(v11))), 0x1::option::none<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StopEffect>()));
                    break
                };
                if (v10.kind == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_BARRIER()) {
                    0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64)).pos = v6;
                    let v13 = handle_tile_stop_with_collector(arg0, arg1, v6, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
                    0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StepEffect>(arg4, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_step_effect(v4, v1, v6, arg2 - v5 - 1, v8, 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcStepEvent>(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_npc_step_event(v6, v10.kind, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::npc_result_barrier_stop(), false, 0x1::option::none<u16>())), 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StopEffect>(v13)));
                    break
                };
            };
            0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64)).pos = v6;
            if (v5 < arg2 - 1) {
                if (0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_kind(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg10, v6)) == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::TILE_CARD()) {
                    let (v14, _) = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::draw_card_on_pass(0x2::random::generate_u8(arg11));
                    0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::give_card_to_player(&mut 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64)).cards, v14, 1);
                    0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CardDrawItem>(&mut v8, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_card_draw_item(v6, v14, 1, true));
                };
                0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StepEffect>(arg4, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_step_effect(v4, v1, v6, arg2 - v5 - 1, v8, 0x1::option::none<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcStepEvent>(), 0x1::option::none<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StopEffect>()));
            } else {
                let v16 = handle_tile_stop_with_collector(arg0, arg1, v6, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
                0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StepEffect>(arg4, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_step_effect(v4, v1, v6, 0, v8, 0x1::option::none<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcStepEvent>(), 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StopEffect>(v16)));
            };
            v4 = v4 + 1;
            v5 = v5 + 1;
        };
        let v17 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
        v17.last_tile_id = v2;
        v17.next_tile_id = v3;
    }

    fun find_nearest_hospital(arg0: &Game, arg1: u16, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg3: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData) : u16 {
        let v0 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_hospital_ids(arg2);
        if (0x1::vector::is_empty<u16>(&v0)) {
            return arg1
        };
        *0x1::vector::borrow<u16>(&v0, 0)
    }

    fun find_owner_temples(arg0: &Game, arg1: u8) : vector<u8> {
        0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64)).temple_levels
    }

    public(friend) fun find_player_index(arg0: &Game, arg1: address) : u8 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Player>(&arg0.players)) {
            if (0x1::vector::borrow<Player>(&arg0.players, v0).owner == arg1) {
                return (v0 as u8)
            };
            v0 = v0 + 1;
        };
        abort 1006
    }

    fun find_richest_player(arg0: &Game) : 0x1::option::Option<address> {
        let v0 = 0;
        let v1 = 0x1::option::none<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Player>(&arg0.players)) {
            let v3 = 0x1::vector::borrow<Player>(&arg0.players, v2);
            if (!v3.bankrupt) {
                if (v3.cash > v0) {
                    v0 = v3.cash;
                    v1 = 0x1::option::some<address>(v3.owner);
                };
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun game_uid(arg0: &Game) : &0x2::object::UID {
        &arg0.id
    }

    fun get_active_player_address(arg0: &Game) : address {
        0x1::vector::borrow<Player>(&arg0.players, (arg0.active_idx as u64)).owner
    }

    fun get_active_player_index(arg0: &Game) : u8 {
        arg0.active_idx
    }

    fun get_buff_value(arg0: &Player, arg1: u8, arg2: u16) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BuffEntry>(&arg0.buffs)) {
            let v1 = *0x1::vector::borrow<BuffEntry>(&arg0.buffs, v0);
            if (v1.kind == arg1 && v1.last_active_round >= arg2) {
                return v1.value
            };
            v0 = v0 + 1;
        };
        0
    }

    fun get_chain_buildings(arg0: &Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg2: u16) : vector<u16> {
        if ((arg2 as u64) >= 0x1::vector::length<Building>(&arg0.buildings)) {
            return vector[]
        };
        if (0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::building_size(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_building(arg1, arg2)) != 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::SIZE_1X1()) {
            let v0 = 0x1::vector::empty<u16>();
            0x1::vector::push_back<u16>(&mut v0, arg2);
            return v0
        };
        let v1 = 0x1::vector::borrow<Building>(&arg0.buildings, (arg2 as u64)).owner;
        if (v1 == 255) {
            let v2 = 0x1::vector::empty<u16>();
            0x1::vector::push_back<u16>(&mut v2, arg2);
            return v2
        };
        let v3 = 0x1::vector::empty<u16>();
        0x1::vector::push_back<u16>(&mut v3, arg2);
        let v4 = arg2;
        loop {
            let v5 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::building_chain_next_id(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_building(arg1, v4));
            if (v5 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::no_building()) {
                break
            };
            if ((v5 as u64) >= 0x1::vector::length<Building>(&arg0.buildings)) {
                break
            };
            if (0x1::vector::contains<u16>(&v3, &v5)) {
                break
            };
            if (0x1::vector::borrow<Building>(&arg0.buildings, (v5 as u64)).owner != v1) {
                break
            };
            0x1::vector::push_back<u16>(&mut v3, v5);
            v4 = v5;
        };
        v4 = arg2;
        let v6 = vector[];
        loop {
            let v7 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::building_chain_prev_id(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_building(arg1, v4));
            if (v7 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::no_building()) {
                break
            };
            if ((v7 as u64) >= 0x1::vector::length<Building>(&arg0.buildings)) {
                break
            };
            if (0x1::vector::contains<u16>(&v3, &v7)) {
                break
            };
            if (0x1::vector::borrow<Building>(&arg0.buildings, (v7 as u64)).owner != v1) {
                break
            };
            0x1::vector::push_back<u16>(&mut v6, v7);
            v4 = v7;
        };
        let v8 = vector[];
        let v9 = 0x1::vector::length<u16>(&v6);
        while (v9 > 0) {
            0x1::vector::push_back<u16>(&mut v8, *0x1::vector::borrow<u16>(&v6, v9 - 1));
            v9 = v9 - 1;
        };
        v9 = 0;
        while (v9 < 0x1::vector::length<u16>(&v3)) {
            0x1::vector::push_back<u16>(&mut v8, *0x1::vector::borrow<u16>(&v3, v9));
            v9 = v9 + 1;
        };
        v8
    }

    fun get_current_turn(arg0: &Game) : (u16, u8) {
        (arg0.round, arg0.turn)
    }

    fun get_dice_value(arg0: &Game, arg1: u8, arg2: &mut 0x2::random::RandomGenerator) : u8 {
        let v0 = 0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64));
        if (is_buff_active(v0, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_MOVE_CTRL(), arg0.round)) {
            return (get_buff_value(v0, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_MOVE_CTRL(), arg0.round) as u8)
        };
        0x2::random::generate_u8_in_range(arg2, 1, 6)
    }

    fun get_game_status(arg0: &Game) : u8 {
        arg0.status
    }

    fun get_player_by_seat(arg0: &Game, arg1: &Seat) : &Player {
        0x1::vector::borrow<Player>(&arg0.players, (arg1.player_index as u64))
    }

    fun get_player_cash(arg0: &Game, arg1: address) : u64 {
        0x1::vector::borrow<Player>(&arg0.players, (find_player_index(arg0, arg1) as u64)).cash
    }

    fun get_player_count(arg0: &Game) : u64 {
        0x1::vector::length<Player>(&arg0.players)
    }

    fun get_player_mut_by_seat(arg0: &mut Game, arg1: &Seat) : &mut Player {
        0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1.player_index as u64))
    }

    fun get_player_position(arg0: &Game, arg1: address) : u16 {
        0x1::vector::borrow<Player>(&arg0.players, (find_player_index(arg0, arg1) as u64)).pos
    }

    fun get_round(arg0: &Game) : u16 {
        arg0.round
    }

    fun get_seat_player(arg0: &Seat) : address {
        arg0.player
    }

    fun get_template_map_id(arg0: &Game) : 0x2::object::ID {
        arg0.template_map_id
    }

    fun get_tile_level(arg0: &Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg3: u16) : u8 {
        let v0 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_building_id(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg1, arg3));
        if (v0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::no_building()) {
            return 0
        };
        0x1::vector::borrow<Building>(&arg0.buildings, (v0 as u64)).level
    }

    fun get_tile_owner(arg0: &Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg3: u16) : address {
        let v0 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_building_id(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg1, arg3));
        assert!(v0 != 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::no_building(), 2002);
        let v1 = 0x1::vector::borrow<Building>(&arg0.buildings, (v0 as u64));
        assert!(v1.owner != 255, 2002);
        0x1::vector::borrow<Player>(&arg0.players, (v1.owner as u64)).owner
    }

    fun get_turn_in_round(arg0: &Game) : u8 {
        arg0.turn
    }

    fun handle_bankruptcy(arg0: &mut Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg3: address, arg4: 0x1::option::Option<address>) {
        let v0 = find_player_index(arg0, arg3);
        0x1::vector::borrow_mut<Player>(&mut arg0.players, (v0 as u64)).bankrupt = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Building>(&arg0.buildings)) {
            let v2 = 0x1::vector::borrow_mut<Building>(&mut arg0.buildings, v1);
            if (v2.owner == v0) {
                v2.owner = 255;
            };
            v1 = v1 + 1;
        };
        0x1::vector::borrow_mut<Player>(&mut arg0.players, (v0 as u64)).temple_levels = b"";
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_bankrupt_event(0x2::object::uid_to_inner(&arg0.id), arg3, 0, arg4);
        let v3 = 0;
        let v4 = 0x1::option::none<address>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<Player>(&arg0.players)) {
            let v6 = 0x1::vector::borrow<Player>(&arg0.players, v5);
            if (!v6.bankrupt) {
                v3 = v3 + 1;
                v4 = 0x1::option::some<address>(v6.owner);
            };
            v5 = v5 + 1;
        };
        if (v3 == 1) {
            arg0.status = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::STATUS_ENDED();
            arg0.winner = v4;
            0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_game_ended_event(0x2::object::uid_to_inner(&arg0.id), v4, (arg0.round as u16), (arg0.turn as u8), 2);
        };
    }

    fun handle_buff_expired(arg0: &mut Game, arg1: &BuffEntry) {
        if (arg1.spawn_index == 65535) {
            return
        };
        0x1::vector::borrow_mut<NpcSpawnEntry>(&mut arg0.npc_spawn_pool, (arg1.spawn_index as u64)).next_active_round = arg0.round + 2;
    }

    fun handle_hospital_stop(arg0: &mut Game, arg1: u8, arg2: u16) {
        0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64)).in_hospital_turns = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DEFAULT_HOSPITAL_TURNS();
    }

    fun handle_npc_consumed(arg0: &mut Game, arg1: &NpcInst, arg2: bool) {
        if (arg1.spawn_index == 65535) {
            return
        };
        let v0 = 0x1::vector::borrow_mut<NpcSpawnEntry>(&mut arg0.npc_spawn_pool, (arg1.spawn_index as u64));
        if (arg2) {
        } else {
            v0.next_active_round = arg0.round + 2;
        };
    }

    fun handle_skip_turn(arg0: &mut Game, arg1: u8) {
        let v0 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
        v0.in_hospital_turns = v0.in_hospital_turns - 1;
        let v1 = v0.in_hospital_turns;
        let v2 = arg0.round;
        let v3 = arg0.turn;
        clean_turn_state(arg0, arg1);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_skip_turn_event(0x2::object::uid_to_inner(&arg0.id), v0.owner, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::SKIP_HOSPITAL(), v1, v2, v3);
    }

    fun handle_tile_stop_with_collector(arg0: &mut Game, arg1: u8, arg2: u16, arg3: &mut vector<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>, arg4: bool, arg5: bool, arg6: bool, arg7: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg8: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg9: &mut 0x2::random::RandomGenerator) : 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StopEffect {
        let v0 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg8, arg2);
        let v1 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_kind(v0);
        let v2 = 0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64)).owner;
        let v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_none();
        let v4 = 0;
        let v5 = 0x1::option::none<address>();
        let v6 = 0x1::option::none<u8>();
        let v7 = 0x1::option::none<u8>();
        let v8 = 0x1::vector::empty<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CardDrawItem>();
        let v9 = 0x1::option::none<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::BuildingDecisionInfo>();
        let v10 = 0x1::option::none<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::RentDecisionInfo>();
        let v11 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_building_id(v0);
        if (v11 != 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::no_building()) {
            let v12 = 0x1::vector::borrow<Building>(&arg0.buildings, (v11 as u64));
            let v13 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_building(arg8, v11);
            if (v12.owner == 255) {
                let v14 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::building_price(v13) * calculate_price_index(arg0);
                if (arg4) {
                    let (v15, v16) = try_execute_buy_building(arg0, arg1, v11, arg2, v14, v13);
                    let v17 = v16;
                    if (v15) {
                        v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_building_unowned();
                        if (0x1::option::is_some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(&v17)) {
                            0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(arg3, 0x1::option::destroy_some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(v17));
                        };
                        let v18 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_building_decision_info(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_BUY_PROPERTY(), v11, arg2, v14, 1, 0x1::vector::borrow<Building>(&arg0.buildings, (v11 as u64)).building_type);
                        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_building_decision_event(0x2::object::uid_to_inner(&arg0.id), v2, arg0.round, arg0.turn, true, v18);
                        v9 = 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::BuildingDecisionInfo>(v18);
                    } else {
                        v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_building_unowned();
                        arg0.pending_decision = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_BUY_PROPERTY();
                        arg0.decision_tile = arg2;
                        arg0.decision_amount = v14;
                    };
                } else {
                    v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_building_unowned();
                    arg0.pending_decision = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_BUY_PROPERTY();
                    arg0.decision_tile = arg2;
                    arg0.decision_amount = v14;
                };
            } else {
                let v19 = v12.owner;
                if (v19 != arg1) {
                    let v20 = v12.level;
                    let v21 = calculate_toll(arg0, arg2, arg8, arg7);
                    let v22 = 0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64));
                    if (is_buff_active(v22, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_RENT_FREE(), arg0.round)) {
                        v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_building_no_rent();
                        v5 = 0x1::option::some<address>(0x1::vector::borrow<Player>(&arg0.players, (v19 as u64)).owner);
                        v6 = 0x1::option::some<u8>(v20);
                        v4 = 0;
                    } else if (0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::player_has_card(&v22.cards, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_RENT_FREE()) || arg6) {
                        let (v23, v24, v25) = try_execute_rent_payment(arg0, arg1, v19, arg2, v21, arg6);
                        let v26 = v24;
                        if (v23) {
                            if (v25) {
                                v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_building_no_rent();
                                let v27 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_rent_decision_info(v2, 0x1::vector::borrow<Player>(&arg0.players, (v19 as u64)).owner, v11, arg2, v21, true);
                                0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_rent_decision_event(0x2::object::uid_to_inner(&arg0.id), arg0.round, arg0.turn, true, v27);
                                v10 = 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::RentDecisionInfo>(v27);
                            } else {
                                v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_building_toll();
                                let v28 = 0;
                                while (v28 < 0x1::vector::length<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(&v26)) {
                                    0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(arg3, *0x1::vector::borrow<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(&v26, v28));
                                    v28 = v28 + 1;
                                };
                                v4 = v21;
                                let v29 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_rent_decision_info(v2, 0x1::vector::borrow<Player>(&arg0.players, (v19 as u64)).owner, v11, arg2, v21, false);
                                0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_rent_decision_event(0x2::object::uid_to_inner(&arg0.id), arg0.round, arg0.turn, true, v29);
                                v10 = 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::RentDecisionInfo>(v29);
                            };
                            v5 = 0x1::option::some<address>(0x1::vector::borrow<Player>(&arg0.players, (v19 as u64)).owner);
                            v6 = 0x1::option::some<u8>(v20);
                        } else {
                            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_building_toll();
                            arg0.pending_decision = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_PAY_RENT();
                            arg0.decision_tile = arg2;
                            arg0.decision_amount = v21;
                            v5 = 0x1::option::some<address>(0x1::vector::borrow<Player>(&arg0.players, (v19 as u64)).owner);
                            v6 = 0x1::option::some<u8>(v20);
                            v4 = v21;
                        };
                    } else {
                        let v30 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
                        let v31 = if (v30.cash >= v21) {
                            v30.cash = v30.cash - v21;
                            v21
                        } else {
                            v30.cash = 0;
                            v30.cash
                        };
                        let v32 = v30.cash == 0 && v21 > v31;
                        if (v31 > 0) {
                            let v33 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (v19 as u64));
                            v33.cash = v33.cash + v31;
                            0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(arg3, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_cash_delta(v2, true, v31, 1, arg2));
                            0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(arg3, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_cash_delta(v33.owner, false, v31, 1, arg2));
                            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_building_toll();
                            v4 = v31;
                        };
                        if (v32) {
                            let v34 = 0x1::option::some<address>(0x1::vector::borrow<Player>(&arg0.players, (v19 as u64)).owner);
                            handle_bankruptcy(arg0, arg7, arg8, v2, v34);
                        };
                        v5 = 0x1::option::some<address>(0x1::vector::borrow<Player>(&arg0.players, (v19 as u64)).owner);
                        v6 = 0x1::option::some<u8>(v20);
                    };
                } else {
                    let v35 = v12.level;
                    let v36 = 0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64)).owner;
                    if (v35 < 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::LEVEL_4()) {
                        let v37 = calculate_building_price(v13, v12, v35, v35 + 1, arg0, arg7);
                        let v38 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::building_size(v13);
                        let v39 = if (v38 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::SIZE_2X2()) {
                            if (v35 == 0) {
                                v12.building_type == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUILDING_NONE()
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (arg5 && !v39) {
                            let (v40, v41, v42, v43) = try_execute_upgrade_building(arg0, arg1, v11, arg2, v37, v35, arg7, v38, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUILDING_TEMPLE());
                            let v44 = v41;
                            if (v40) {
                                v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_none();
                                if (0x1::option::is_some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(&v44)) {
                                    0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(arg3, 0x1::option::destroy_some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(v44));
                                };
                                let v45 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_building_decision_info(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_UPGRADE_PROPERTY(), v11, arg2, v37, v42, v43);
                                0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_building_decision_event(0x2::object::uid_to_inner(&arg0.id), v36, arg0.round, arg0.turn, true, v45);
                                v9 = 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::BuildingDecisionInfo>(v45);
                            } else {
                                v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_none();
                                arg0.pending_decision = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_UPGRADE_PROPERTY();
                                arg0.decision_tile = arg2;
                                arg0.decision_amount = v37;
                            };
                        } else {
                            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_none();
                            arg0.pending_decision = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_UPGRADE_PROPERTY();
                            arg0.decision_tile = arg2;
                            arg0.decision_amount = v37;
                        };
                    } else {
                        v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_none();
                    };
                    v5 = 0x1::option::some<address>(v36);
                    v6 = 0x1::option::some<u8>(v35);
                };
            };
        } else if (v1 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::TILE_HOSPITAL()) {
            0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64)).in_hospital_turns = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DEFAULT_HOSPITAL_TURNS();
            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_hospital();
            v7 = 0x1::option::some<u8>(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DEFAULT_HOSPITAL_TURNS());
        } else if (v1 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::TILE_CARD()) {
            let (v46, v47) = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::draw_card_on_stop(0x2::random::generate_u8(arg9));
            0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::give_card_to_player(&mut 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64)).cards, v46, v47);
            0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CardDrawItem>(&mut v8, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_card_draw_item(arg2, v46, v47, false));
            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_card_stop();
        } else if (v1 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::TILE_CHANCE()) {
            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_none();
        } else if (v1 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::TILE_NEWS()) {
            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_none();
        } else if (v1 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::TILE_LOTTERY()) {
            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_none();
        } else if (v1 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::TILE_BONUS()) {
            let v48 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_special(v0) * calculate_price_index(arg0);
            let v49 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
            v49.cash = v49.cash + v48;
            0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(arg3, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_cash_delta(v2, false, v48, 4, arg2));
            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_bonus();
            v4 = v48;
        } else if (v1 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::TILE_FEE()) {
            let v50 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_special(v0) * calculate_price_index(arg0);
            let v51 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
            let v52 = if (v51.cash >= v50) {
                v51.cash = v51.cash - v50;
                v50
            } else {
                v51.cash = 0;
                v51.cash
            };
            if (v52 > 0) {
                0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(arg3, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_cash_delta(v2, true, v52, 5, arg2));
            };
            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_fee();
            v4 = v52;
            if (v51.cash == 0 && v50 > v52) {
                handle_bankruptcy(arg0, arg7, arg8, v2, 0x1::option::none<address>());
            };
        } else {
            v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::stop_none();
        };
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_stop_effect(arg2, v1, v3, v4, v5, v6, v7, v8, arg0.pending_decision, arg0.decision_tile, arg0.decision_amount, v9, v10)
    }

    fun has_defi_buff(arg0: &Player, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BuffEntry>(&arg0.buffs)) {
            let v1 = *0x1::vector::borrow<BuffEntry>(&arg0.buffs, v0);
            if (v1.kind == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun init_npc_spawn_pool(arg0: &vector<u8>) : vector<NpcSpawnEntry> {
        let v0 = 0x1::vector::empty<NpcSpawnEntry>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = 0;
            while (v2 < *0x1::vector::borrow<u8>(arg0, v1 + 1)) {
                let v3 = NpcSpawnEntry{
                    npc_kind          : *0x1::vector::borrow<u8>(arg0, v1),
                    next_active_round : 0,
                };
                0x1::vector::push_back<NpcSpawnEntry>(&mut v0, v3);
                v2 = v2 + 1;
            };
            v1 = v1 + 2;
        };
        v0
    }

    fun is_buff_active(arg0: &Player, arg1: u8, arg2: u16) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BuffEntry>(&arg0.buffs)) {
            let v1 = *0x1::vector::borrow<BuffEntry>(&arg0.buffs, v0);
            if (v1.kind == arg1 && v1.last_active_round >= arg2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_buff_npc(arg0: u8) : bool {
        arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_LAND_GOD() || arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_FORTUNE_GOD()
    }

    fun is_hospital_npc(arg0: u8) : bool {
        arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_BOMB() || arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_DOG()
    }

    fun is_npc_consumable(arg0: u8) : bool {
        if (arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_BARRIER()) {
            true
        } else if (arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_BOMB()) {
            true
        } else if (arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_DOG()) {
            true
        } else if (arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_WEALTH_GOD()) {
            true
        } else if (arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_LAND_GOD()) {
            true
        } else if (arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_FORTUNE_GOD()) {
            true
        } else {
            arg0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::NPC_POOR_GOD()
        }
    }

    fun is_player_bankrupt(arg0: &Game, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Player>(&arg0.players)) {
            let v1 = 0x1::vector::borrow<Player>(&arg0.players, v0);
            if (v1.owner == arg1) {
                return v1.bankrupt
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_tile_owned(arg0: &Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg3: u16) : bool {
        let v0 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_building_id(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg1, arg3));
        if (v0 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::no_building()) {
            return false
        };
        0x1::vector::borrow<Building>(&arg0.buildings, (v0 as u64)).owner != 255
    }

    fun is_valid_neighbor(arg0: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg1: u16, arg2: u16, arg3: u16) : bool {
        if (arg2 == arg3) {
            return false
        };
        if (arg2 == arg1) {
            return false
        };
        let v0 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg0, arg1);
        if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_w(v0)) {
            true
        } else if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_n(v0)) {
            true
        } else if (arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_e(v0)) {
            true
        } else {
            arg2 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_s(v0)
        }
    }

    entry fun join(arg0: &mut Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.status == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::STATUS_READY(), 6002);
        assert!(0x1::vector::length<Player>(&arg0.players) < (0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DEFAULT_MAX_PLAYERS() as u64), 6001);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Player>(&arg0.players)) {
            assert!(0x1::vector::borrow<Player>(&arg0.players, v1).owner != v0, 6005);
            v1 = v1 + 1;
        };
        let v2 = if (0x1::vector::length<Player>(&arg0.players) > 0) {
            0x1::vector::borrow<Player>(&arg0.players, 0).cash
        } else {
            0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::get_starting_cash(arg1)
        };
        let v3 = create_player_with_cash(v0, v2, arg2);
        let v4 = (0x1::vector::length<Player>(&arg0.players) as u8);
        0x1::vector::push_back<Player>(&mut arg0.players, v3);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_player_joined_event(0x2::object::uid_to_inner(&arg0.id), v0, v4);
        let v5 = Seat{
            id           : 0x2::object::new(arg2),
            game_id      : 0x2::object::uid_to_inner(&arg0.id),
            player       : v0,
            player_index : v4,
        };
        0x2::transfer::transfer<Seat>(v5, v0);
    }

    fun parse_game_params(arg0: &vector<u64>) : (u64, u8, u8) {
        let v0 = if (0x1::vector::length<u64>(arg0) > 0) {
            0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::validate_starting_cash(*0x1::vector::borrow<u64>(arg0, 0))
        } else {
            0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::get_default_starting_cash()
        };
        let v1 = if (0x1::vector::length<u64>(arg0) > 1) {
            0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::validate_price_rise_days((*0x1::vector::borrow<u64>(arg0, 1) as u8))
        } else {
            0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::get_default_price_rise_days()
        };
        let v2 = if (0x1::vector::length<u64>(arg0) > 2) {
            0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::validate_max_rounds((*0x1::vector::borrow<u64>(arg0, 2) as u8))
        } else {
            0
        };
        (v0, v1, v2)
    }

    fun place_npc_internal(arg0: &mut Game, arg1: u16, arg2: u8, arg3: bool, arg4: &mut vector<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcChangeItem>) {
        assert!(0x1::vector::borrow<Tile>(&arg0.tiles, (arg1 as u64)).npc_on == 65535, 2001);
        let v0 = NpcInst{
            tile_id     : arg1,
            kind        : arg2,
            consumable  : arg3,
            spawn_index : 65535,
        };
        0x1::vector::push_back<NpcInst>(&mut arg0.npc_on, v0);
        0x1::vector::borrow_mut<Tile>(&mut arg0.tiles, (arg1 as u64)).npc_on = (0x1::vector::length<NpcInst>(&arg0.npc_on) as u16);
        0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcChangeItem>(arg4, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_npc_change(arg1, arg2, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::npc_action_spawn(), arg3));
    }

    fun process_and_clear_expired_buffs(arg0: &mut Game, arg1: u8) {
        let v0 = arg0.round;
        let v1 = 0x1::vector::empty<BuffEntry>();
        let v2 = 0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64));
        let v3 = 0;
        while (v3 < 0x1::vector::length<BuffEntry>(&v2.buffs)) {
            let v4 = *0x1::vector::borrow<BuffEntry>(&v2.buffs, v3);
            if (v4.last_active_round < v0) {
                0x1::vector::push_back<BuffEntry>(&mut v1, v4);
            };
            v3 = v3 + 1;
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<BuffEntry>(&v1)) {
            handle_buff_expired(arg0, 0x1::vector::borrow<BuffEntry>(&v1, v5));
            v5 = v5 + 1;
        };
        let v6 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
        clear_expired_buffs(v6, v0);
    }

    fun random_spawn_tile(arg0: &Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg2: &mut 0x2::random::RandomGenerator) : 0x1::option::Option<u16> {
        let v0 = random_spawn_tile_probing(arg0, arg1, arg2, 0);
        if (0x1::option::is_some<u16>(&v0)) {
            return v0
        };
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Tile>(&arg0.tiles)) {
            if (0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::can_place_npc_on_tile(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_kind(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg1, (v2 as u16)))) && 0x1::vector::borrow<Tile>(&arg0.tiles, v2).npc_on == 65535) {
                0x1::vector::push_back<u16>(&mut v1, (v2 as u16));
            };
            v2 = v2 + 1;
        };
        if (0x1::vector::is_empty<u16>(&v1)) {
            return 0x1::option::none<u16>()
        };
        0x1::option::some<u16>(*0x1::vector::borrow<u16>(&v1, 0x2::random::generate_u64(arg2) % 0x1::vector::length<u16>(&v1)))
    }

    fun random_spawn_tile_probing(arg0: &Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg2: &mut 0x2::random::RandomGenerator, arg3: u8) : 0x1::option::Option<u16> {
        let v0 = 0x1::vector::length<Tile>(&arg0.tiles);
        if (v0 == 0) {
            return 0x1::option::none<u16>()
        };
        let v1 = if (v0 <= 10) {
            vector[3, 5]
        } else if (v0 <= 30) {
            vector[3, 5, 7, 11]
        } else {
            vector[7, 11, 13, 17, 19]
        };
        let v2 = v1;
        let v3 = if (v0 <= 10) {
            4
        } else {
            8
        };
        let v4 = 0;
        while (v4 < v3) {
            let v5 = ((((0x2::random::generate_u64(arg2) + (arg3 as u64)) % v0 + v4 * *0x1::vector::borrow<u64>(&v2, 0x2::random::generate_u64(arg2) % 0x1::vector::length<u64>(&v2))) % v0) as u16);
            if (0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::can_place_npc_on_tile(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_kind(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg1, v5))) && 0x1::vector::borrow<Tile>(&arg0.tiles, (v5 as u64)).npc_on == 65535) {
                return 0x1::option::some<u16>(v5)
            };
            v4 = v4 + 1;
        };
        0x1::option::none<u16>()
    }

    fun rebuild_temple_levels_cache(arg0: &mut Game, arg1: u8) {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<Building>(&arg0.buildings)) {
            let v2 = 0x1::vector::borrow<Building>(&arg0.buildings, v1);
            let v3 = if (v2.owner == arg1) {
                if (v2.building_type == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUILDING_TEMPLE()) {
                    v2.level > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                0x1::vector::push_back<u8>(&mut v0, v2.level);
            };
            v1 = v1 + 1;
        };
        0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64)).temple_levels = v0;
    }

    fun refresh_at_round_end(arg0: &mut Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        clean_expired_npcs(arg0);
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = &mut v0;
        let (v2, v3) = spawn_random_npc(arg0, arg2, v1);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_round_ended_event(0x2::object::uid_to_inner(&arg0.id), arg0.round - 1, v2, v3);
    }

    fun remove_npc_internal(arg0: &mut Game, arg1: u16, arg2: &mut vector<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcChangeItem>) {
        let v0 = 0x1::vector::borrow<Tile>(&arg0.tiles, (arg1 as u64)).npc_on;
        if (v0 == 65535) {
            return
        };
        let v1 = 0x1::vector::swap_remove<NpcInst>(&mut arg0.npc_on, (v0 as u64));
        0x1::vector::borrow_mut<Tile>(&mut arg0.tiles, (arg1 as u64)).npc_on = 65535;
        if ((v0 as u64) < 0x1::vector::length<NpcInst>(&arg0.npc_on)) {
            0x1::vector::borrow_mut<Tile>(&mut arg0.tiles, (0x1::vector::borrow<NpcInst>(&arg0.npc_on, (v0 as u64)).tile_id as u64)).npc_on = v0;
        };
        0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcChangeItem>(arg2, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_npc_change(arg1, v1.kind, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::npc_action_remove(), v1.consumable));
    }

    entry fun roll_and_step(arg0: &mut Game, arg1: &Seat, arg2: vector<u16>, arg3: bool, arg4: bool, arg5: bool, arg6: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg7: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        validate_map(arg0, arg7);
        validate_seat_and_turn(arg0, arg1);
        assert!(arg0.pending_decision == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_NONE(), 6007);
        arg0.has_rolled = true;
        let v0 = arg1.player_index;
        let v1 = 0x2::random::new_generator(arg8, arg10);
        let v2 = 0x1::vector::borrow<Player>(&arg0.players, (v0 as u64));
        let v3 = if (is_buff_active(v2, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUFF_MOVE_CTRL(), arg0.round)) {
            assert!(!0x1::vector::is_empty<u16>(&arg2) && 0x1::vector::length<u16>(&arg2) <= 12, 4003);
            (0x1::vector::length<u16>(&arg2) as u8)
        } else {
            let v4 = &mut v1;
            let v5 = get_dice_value(arg0, v0, v4);
            assert!(0x1::vector::length<u16>(&arg2) >= (v5 as u64), 4002);
            v5
        };
        let v6 = 0x1::vector::empty<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::StepEffect>();
        let v7 = 0x1::vector::empty<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>();
        let v8 = &mut v6;
        let v9 = &mut v7;
        let v10 = &mut v1;
        execute_step_movement_with_choices(arg0, arg1.player_index, v3, &arg2, v8, v9, arg3, arg4, arg5, arg6, arg7, v10);
        let v11 = vector[];
        let v12 = 0;
        while (v12 < v3) {
            0x1::vector::push_back<u16>(&mut v11, *0x1::vector::borrow<u16>(&arg2, (v12 as u64)));
            v12 = v12 + 1;
        };
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_roll_and_step_action_event_with_choices(0x2::object::uid_to_inner(&arg0.id), arg1.player, arg0.round, arg0.turn, v3, v11, v2.pos, v6, v7, 0x1::vector::borrow<Player>(&arg0.players, (v0 as u64)).pos);
        clean_turn_state(arg0, v0);
        if (arg0.pending_decision == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_NONE()) {
            advance_turn(arg0, arg6, arg7, arg8, arg10);
        };
    }

    fun send_to_hospital_internal(arg0: &mut Game, arg1: u8, arg2: u16, arg3: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData) {
        let v0 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
        v0.pos = arg2;
        v0.in_hospital_turns = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DEFAULT_HOSPITAL_TURNS();
    }

    fun should_skip_turn(arg0: &Game, arg1: u8) : bool {
        0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64)).in_hospital_turns > 0
    }

    entry fun skip_building_decision(arg0: &mut Game, arg1: &Seat, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg3: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        validate_map(arg0, arg3);
        validate_seat_and_turn(arg0, arg1);
        assert!(arg0.pending_decision == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_BUY_PROPERTY() || arg0.pending_decision == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_UPGRADE_PROPERTY(), 6006);
        let v0 = arg0.pending_decision;
        let v1 = arg0.decision_tile;
        clear_decision_state(arg0);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_decision_skipped_event(0x2::object::uid_to_inner(&arg0.id), arg1.player, v0, v1, arg0.round, arg0.turn);
        advance_turn(arg0, arg2, arg3, arg4, arg5);
    }

    entry fun skip_turn(arg0: &mut Game, arg1: &Seat, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg3: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        validate_map(arg0, arg3);
        validate_seat_and_turn(arg0, arg1);
        assert!(arg0.pending_decision == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_NONE(), 6007);
        assert!(should_skip_turn(arg0, arg1.player_index), 6008);
        handle_skip_turn(arg0, arg1.player_index);
        advance_turn(arg0, arg2, arg3, arg4, arg5);
    }

    fun spawn_random_npc(arg0: &mut Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg2: &mut 0x2::random::RandomGenerator) : (u8, u16) {
        if (0x1::vector::is_empty<NpcSpawnEntry>(&arg0.npc_spawn_pool)) {
            return (0, 0)
        };
        let v0 = arg0.round;
        let v1 = ((0x2::random::generate_u64(arg2) % 0x1::vector::length<NpcSpawnEntry>(&arg0.npc_spawn_pool)) as u16);
        let v2 = 0x1::vector::borrow<NpcSpawnEntry>(&arg0.npc_spawn_pool, (v1 as u64));
        if (v2.next_active_round > v0) {
            return (0, 0)
        };
        let v3 = v2.npc_kind;
        let v4 = random_spawn_tile_probing(arg0, arg1, arg2, v3);
        if (0x1::option::is_none<u16>(&v4)) {
            v4 = random_spawn_tile(arg0, arg1, arg2);
        };
        if (0x1::option::is_none<u16>(&v4)) {
            return (0, 0)
        };
        let v5 = 0x1::option::extract<u16>(&mut v4);
        let v6 = NpcInst{
            tile_id     : v5,
            kind        : v3,
            consumable  : is_npc_consumable(v3),
            spawn_index : v1,
        };
        0x1::vector::push_back<NpcInst>(&mut arg0.npc_on, v6);
        0x1::vector::borrow_mut<Tile>(&mut arg0.tiles, (v5 as u64)).npc_on = (0x1::vector::length<NpcInst>(&arg0.npc_on) as u16);
        let v7 = if (is_buff_npc(v3)) {
            3
        } else {
            2
        };
        0x1::vector::borrow_mut<NpcSpawnEntry>(&mut arg0.npc_spawn_pool, (v1 as u64)).next_active_round = v0 + v7;
        (v3, v5)
    }

    entry fun start(arg0: &mut Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg2: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_map(arg0, arg2);
        assert!(arg0.status == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::STATUS_READY(), 6002);
        assert!(0x1::vector::length<Player>(&arg0.players) >= 2, 6004);
        arg0.status = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::STATUS_ACTIVE();
        arg0.active_idx = 0;
        arg0.has_rolled = false;
        let v0 = 0x2::random::new_generator(arg3, arg5);
        let v1 = 0x1::vector::length<Player>(&arg0.players);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0;
            let v6 = 0;
            while (v5 < 10) {
                let v7 = &mut v0;
                let v8 = random_spawn_tile(arg0, arg2, v7);
                if (0x1::option::is_some<u16>(&v8)) {
                    let v9 = 0x1::option::extract<u16>(&mut v8);
                    if (!0x1::vector::contains<u16>(&v2, &v9)) {
                        v6 = v9;
                        0x1::vector::push_back<u16>(&mut v2, v9);
                        break
                    };
                };
                v5 = v5 + 1;
            };
            0x1::vector::push_back<u16>(&mut v3, v6);
            v4 = v4 + 1;
        };
        let v10 = 0;
        while (v10 < v1) {
            let v11 = *0x1::vector::borrow<u16>(&v3, v10);
            let v12 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, v10);
            v12.pos = v11;
            let v13 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_valid_neighbors(arg2, v11);
            if (!0x1::vector::is_empty<u16>(&v13)) {
                v12.last_tile_id = *0x1::vector::borrow<u16>(&v13, (0x2::random::generate_u8(&mut v0) as u64) % 0x1::vector::length<u16>(&v13));
            } else {
                v12.last_tile_id = v11;
            };
            v10 = v10 + 1;
        };
        let v14 = 0x1::vector::borrow<Player>(&arg0.players, 0).owner;
        let v15 = 0;
        while (v15 < 3) {
            let v16 = &mut v0;
            let (_, _) = spawn_random_npc(arg0, arg2, v16);
            v15 = v15 + 1;
        };
        let v19 = vector[];
        let v20 = 0;
        while (v20 < 0x1::vector::length<Player>(&arg0.players)) {
            0x1::vector::push_back<address>(&mut v19, 0x1::vector::borrow<Player>(&arg0.players, v20).owner);
            v20 = v20 + 1;
        };
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_game_started_event(0x2::object::uid_to_inner(&arg0.id), arg0.template_map_id, v19, v14);
    }

    fun try_execute_buy_building(arg0: &mut Game, arg1: u8, arg2: u16, arg3: u16, arg4: u64, arg5: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::BuildingStatic) : (bool, 0x1::option::Option<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>) {
        let v0 = 0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64));
        if (v0.cash <= arg4) {
            return (false, 0x1::option::none<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>())
        };
        let v1 = v0.owner;
        let v2 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
        v2.cash = v2.cash - arg4;
        let v3 = 0x1::vector::borrow_mut<Building>(&mut arg0.buildings, (arg2 as u64));
        v3.owner = arg1;
        v3.level = 1;
        if (v3.building_type == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUILDING_TEMPLE()) {
            0x1::vector::push_back<u8>(&mut v2.temple_levels, 1);
        };
        (true, 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_cash_delta(v1, true, arg4, 2, arg3)))
    }

    fun try_execute_rent_payment(arg0: &mut Game, arg1: u8, arg2: u8, arg3: u16, arg4: u64, arg5: bool) : (bool, vector<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>, bool) {
        let v0 = 0x1::vector::empty<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>();
        let v1 = 0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64));
        if (arg5 && 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::player_has_card(&v1.cards, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_RENT_FREE())) {
            if (!0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::use_player_card(&mut 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64)).cards, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::CARD_RENT_FREE())) {
                return (false, v0, false)
            };
            return (true, v0, true)
        };
        if (v1.cash < arg4) {
            return (false, v0, false)
        };
        let v2 = v1.owner;
        let v3 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
        v3.cash = v3.cash - arg4;
        let v4 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg2 as u64));
        v4.cash = v4.cash + arg4;
        0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(&mut v0, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_cash_delta(v2, true, arg4, 1, arg3));
        0x1::vector::push_back<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(&mut v0, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_cash_delta(0x1::vector::borrow<Player>(&arg0.players, (arg2 as u64)).owner, false, arg4, 1, arg3));
        (true, v0, false)
    }

    fun try_execute_upgrade_building(arg0: &mut Game, arg1: u8, arg2: u16, arg3: u16, arg4: u64, arg5: u8, arg6: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg7: u8, arg8: u8) : (bool, 0x1::option::Option<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>, u8, u8) {
        let v0 = 0x1::vector::borrow<Player>(&arg0.players, (arg1 as u64));
        if (v0.cash <= arg4) {
            return (false, 0x1::option::none<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(), arg5, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUILDING_NONE())
        };
        let v1 = v0.owner;
        let v2 = 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1 as u64));
        v2.cash = v2.cash - arg4;
        let v3 = arg5 + 1;
        let v4 = 0x1::vector::borrow_mut<Building>(&mut arg0.buildings, (arg2 as u64));
        if (arg7 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::SIZE_2X2() && arg5 == 0) {
            assert!(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::is_large_building_type(arg8), 7012);
            v4.building_type = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUILDING_TEMPLE();
        };
        v4.level = v3;
        let v5 = v4.building_type;
        if (v5 == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::BUILDING_TEMPLE()) {
            rebuild_temple_levels_cache(arg0, arg1);
        };
        (true, 0x1::option::some<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_cash_delta(v1, true, arg4, 3, arg3)), v3, v5)
    }

    entry fun upgrade_building(arg0: &mut Game, arg1: &Seat, arg2: u8, arg3: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg4: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        validate_map(arg0, arg4);
        validate_seat_and_turn(arg0, arg1);
        assert!(arg0.pending_decision == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_UPGRADE_PROPERTY(), 6006);
        let v0 = arg1.player_index;
        let v1 = 0x1::vector::borrow<Player>(&arg0.players, (v0 as u64));
        let v2 = v1.pos;
        assert!(v2 == arg0.decision_tile, 2003);
        let v3 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_tile(arg4, v2);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_kind(v3);
        let v4 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::tile_building_id(v3);
        assert!(v4 != 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::no_building(), 2004);
        let v5 = 0x1::vector::borrow<Building>(&arg0.buildings, (v4 as u64));
        assert!(v5.owner != 255, 2006);
        assert!(v5.owner == v0, 2007);
        let v6 = v5.level;
        assert!(v6 < 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::LEVEL_4(), 2009);
        let v7 = 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_building(arg4, v4);
        let v8 = calculate_building_price(v7, v5, v6, v6 + 1, arg0, arg3);
        assert!(v1.cash > v8, 2010);
        let (v9, _, v11, v12) = try_execute_upgrade_building(arg0, v0, v4, v2, v8, v6, arg3, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::building_size(v7), arg2);
        assert!(v9, 2010);
        clear_decision_state(arg0);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_building_decision_event(0x2::object::uid_to_inner(&arg0.id), arg1.player, arg0.round, arg0.turn, false, 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::make_building_decision_info(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_UPGRADE_PROPERTY(), v4, v2, v8, v11, v12));
        advance_turn(arg0, arg3, arg4, arg5, arg6);
    }

    entry fun use_card(arg0: &mut Game, arg1: &Seat, arg2: u8, arg3: vector<u16>, arg4: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::tycoon::GameData, arg5: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate, arg6: &mut 0x2::tx_context::TxContext) {
        validate_map(arg0, arg5);
        validate_seat_and_turn(arg0, arg1);
        assert!(arg0.pending_decision == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::DECISION_NONE(), 6007);
        assert!(!arg0.has_rolled, 1002);
        assert!(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::cards::use_player_card(&mut 0x1::vector::borrow_mut<Player>(&mut arg0.players, (arg1.player_index as u64)).cards, arg2), 5001);
        let v0 = 0x1::vector::empty<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::NpcChangeItem>();
        let v1 = 0x1::vector::empty<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::BuffChangeItem>();
        let v2 = 0x1::vector::empty<0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::CashDelta>();
        let v3 = &mut v0;
        let v4 = &mut v1;
        let v5 = &mut v2;
        apply_card_effect_with_collectors(arg0, arg1.player_index, arg2, &arg3, v3, v4, v5, arg5);
        0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::events::emit_use_card_action_event(0x2::object::uid_to_inner(&arg0.id), arg1.player, (arg0.round as u16), (arg0.turn as u8), arg2, arg3, v0, v1, v2);
    }

    fun validate_map(arg0: &Game, arg1: &0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::MapTemplate) {
        assert!(0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::map::get_map_id(arg1) == arg0.template_map_id, 9001);
    }

    fun validate_seat_and_turn(arg0: &Game, arg1: &Seat) {
        assert!((arg1.player_index as u64) < 0x1::vector::length<Player>(&arg0.players), 1006);
        assert!(arg1.game_id == 0x2::object::uid_to_inner(&arg0.id), 1003);
        assert!(0x1::vector::borrow<Player>(&arg0.players, (arg1.player_index as u64)).owner == arg1.player, 1001);
        assert!(arg1.player == get_active_player_address(arg0), 1001);
        assert!(arg0.status == 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types::STATUS_ACTIVE(), 1004);
    }

    // decompiled from Move bytecode v6
}

