module 0x56ba7f681324665d979cd455f665020b869c4bcd9cf50b48bfee31c362ef7c5d::ibattle {
    struct PlayerBattleStats has key {
        id: 0x2::object::UID,
        recent_attack_ts: u64,
        battle_count: u64,
        battle_wins: u64,
        recent_lost_count: u64,
        total_battles: u64,
        recent_occupied_turf: u8,
    }

    struct Damage has drop {
        damage: u128,
        dice_roll_value: u64,
    }

    struct DamageMultiplier has store, key {
        id: 0x2::object::UID,
        multipliers: 0x2::vec_map::VecMap<0x1::string::String, u128>,
    }

    struct StatMultiplier has copy, drop, store {
        mux_type: 0x1::string::String,
        multiplier: u8,
    }

    struct RaidedResourceLog has copy, drop, store {
        cash: u128,
        weapon: u128,
        xp: u128,
    }

    struct GangsterBattleStatsLogger has copy, drop, store {
        name: 0x1::string::String,
        unit_id: u64,
        die_roll_number: u64,
        health: u128,
        total_health: u128,
        buffs: vector<StatMultiplier>,
        debuffs: vector<StatMultiplier>,
        damage_given: u128,
        damage_taken: u128,
        is_dead: bool,
    }

    struct GangsterUnitBattleStats has copy, drop, store {
        unit_id: u64,
        gangster_name: 0x1::string::String,
        read_health: u128,
        current_health: u128,
        read_attack: u128,
    }

    struct GameStateLogger has copy, drop, store {
        round: u8,
        attacker_unit: GangsterBattleStatsLogger,
        defender_unit: GangsterBattleStatsLogger,
    }

    struct SimulationResultEvent has copy, drop, store {
        battle_status: u8,
        attack_type: u8,
        attacker_id: 0x2::object::ID,
        attacker_dvd_id: 0x2::object::ID,
        defender_id: 0x1::option::Option<0x2::object::ID>,
        defender_turf_id: 0x1::option::Option<0x2::object::ID>,
        defender_dvd_id: 0x1::option::Option<0x2::object::ID>,
        attacker_name: 0x1::string::String,
        defender_name: 0x1::option::Option<0x1::string::String>,
        raided_resources: RaidedResourceLog,
        attacker_xp: u128,
        defender_xp: u128,
        logs: vector<GameStateLogger>,
        attacker_units: vector<GangsterUnitBattleStats>,
        defender_units: vector<GangsterUnitBattleStats>,
        level_point: u128,
    }

    public fun borrow_damage_value(arg0: &Damage) : u128 {
        arg0.damage
    }

    public fun borrow_dice_roll_value(arg0: &Damage) : u64 {
        arg0.dice_roll_value
    }

    public fun borrow_gangster_attack_power(arg0: &GangsterUnitBattleStats) : u128 {
        arg0.read_attack
    }

    public fun borrow_gangster_current_health(arg0: &GangsterUnitBattleStats) : u128 {
        arg0.current_health
    }

    public fun borrow_gangster_id(arg0: &GangsterUnitBattleStats) : u64 {
        arg0.unit_id
    }

    public fun borrow_gangster_life_status(arg0: &GangsterBattleStatsLogger) : bool {
        arg0.is_dead
    }

    public fun borrow_gangster_name(arg0: &GangsterUnitBattleStats) : 0x1::string::String {
        arg0.gangster_name
    }

    public fun borrow_gangster_read_health(arg0: &GangsterUnitBattleStats) : u128 {
        arg0.read_health
    }

    public fun borrow_gangsters_damage_multiplier(arg0: &DamageMultiplier, arg1: 0x1::string::String) : u128 {
        *0x2::vec_map::get<0x1::string::String, u128>(&arg0.multipliers, &arg1)
    }

    public fun borrow_player_battle_stats(arg0: &PlayerBattleStats) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0.battle_count);
        0x1::vector::push_back<u64>(v1, arg0.recent_attack_ts);
        0x1::vector::push_back<u64>(v1, arg0.total_battles);
        0x1::vector::push_back<u64>(v1, arg0.battle_wins);
        0x1::vector::push_back<u64>(v1, arg0.recent_lost_count);
        v0
    }

    public(friend) fun decrease_recent_occupied_turf_count(arg0: &mut PlayerBattleStats) {
        if (arg0.recent_occupied_turf == 0) {
            return
        };
        arg0.recent_occupied_turf = arg0.recent_occupied_turf - 1;
    }

    public(friend) fun emit_simulation_result_event(arg0: SimulationResultEvent) {
        0x2::event::emit<SimulationResultEvent>(arg0);
    }

    public fun has_gangsters_damage_multiplier(arg0: &DamageMultiplier, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, u128>(&arg0.multipliers, &arg1)
    }

    public fun has_multiplier_key(arg0: &DamageMultiplier, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, u128>(&arg0.multipliers, &arg1)
    }

    public(friend) fun increase_recent_occupied_turf_count(arg0: &mut PlayerBattleStats) {
        arg0.recent_occupied_turf = arg0.recent_occupied_turf + 1;
    }

    public(friend) fun increase_total_battles_count(arg0: &mut PlayerBattleStats) {
        arg0.total_battles = arg0.total_battles + 1;
    }

    public(friend) fun increase_won_battle_count(arg0: &mut PlayerBattleStats) {
        arg0.battle_wins = arg0.battle_wins + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DamageMultiplier{
            id          : 0x2::object::new(arg0),
            multipliers : 0x2::vec_map::empty<0x1::string::String, u128>(),
        };
        0x2::transfer::share_object<DamageMultiplier>(v0);
    }

    public(friend) fun new_damage(arg0: u128, arg1: u64) : Damage {
        Damage{
            damage          : arg0,
            dice_roll_value : arg1,
        }
    }

    public(friend) fun new_game_state_logger(arg0: u8, arg1: GangsterBattleStatsLogger, arg2: GangsterBattleStatsLogger) : GameStateLogger {
        GameStateLogger{
            round         : arg0,
            attacker_unit : arg1,
            defender_unit : arg2,
        }
    }

    public(friend) fun new_gangster_battle_stats_logger(arg0: u64, arg1: 0x1::string::String, arg2: u64, arg3: u128, arg4: u128, arg5: vector<StatMultiplier>, arg6: vector<StatMultiplier>, arg7: u128, arg8: u128) : GangsterBattleStatsLogger {
        let v0 = false;
        if (arg3 <= 0) {
            v0 = true;
        };
        GangsterBattleStatsLogger{
            name            : arg1,
            unit_id         : arg0,
            die_roll_number : arg2,
            health          : arg3,
            total_health    : arg4,
            buffs           : arg5,
            debuffs         : arg6,
            damage_given    : arg7,
            damage_taken    : arg8,
            is_dead         : v0,
        }
    }

    public(friend) fun new_gangster_unit_battle_stats(arg0: 0x1::string::String, arg1: u128, arg2: u128, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock) : GangsterUnitBattleStats {
        GangsterUnitBattleStats{
            unit_id        : 0x2::clock::timestamp_ms(arg5) + arg4,
            gangster_name  : arg0,
            read_health    : arg1,
            current_health : arg2,
            read_attack    : arg3,
        }
    }

    public(friend) fun new_player_battle_stats(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : PlayerBattleStats {
        PlayerBattleStats{
            id                   : 0x2::object::new(arg1),
            recent_attack_ts     : 0x2::clock::timestamp_ms(arg0),
            battle_count         : 0,
            battle_wins          : 0,
            recent_lost_count    : 0,
            total_battles        : 0,
            recent_occupied_turf : 0,
        }
    }

    public(friend) fun new_raided_resources(arg0: u128, arg1: u128, arg2: u128) : RaidedResourceLog {
        RaidedResourceLog{
            cash   : arg0,
            weapon : arg1,
            xp     : arg2,
        }
    }

    public(friend) fun new_result_simulation(arg0: u8, arg1: u8, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: 0x1::string::String, arg8: 0x1::option::Option<0x1::string::String>, arg9: RaidedResourceLog, arg10: u128, arg11: u128, arg12: vector<GameStateLogger>, arg13: vector<GangsterUnitBattleStats>, arg14: vector<GangsterUnitBattleStats>, arg15: u128) : SimulationResultEvent {
        SimulationResultEvent{
            battle_status    : arg0,
            attack_type      : arg1,
            attacker_id      : arg2,
            attacker_dvd_id  : arg3,
            defender_id      : arg5,
            defender_turf_id : arg4,
            defender_dvd_id  : arg6,
            attacker_name    : arg7,
            defender_name    : arg8,
            raided_resources : arg9,
            attacker_xp      : arg10,
            defender_xp      : arg11,
            logs             : arg12,
            attacker_units   : arg13,
            defender_units   : arg14,
            level_point      : arg15,
        }
    }

    public(friend) fun set_damage_multiplier(arg0: &mut DamageMultiplier, arg1: 0x1::string::String, arg2: u128) {
        if (!has_gangsters_damage_multiplier(arg0, arg1)) {
            0x2::vec_map::insert<0x1::string::String, u128>(&mut arg0.multipliers, arg1, arg2);
        } else {
            *0x2::vec_map::get_mut<0x1::string::String, u128>(&mut arg0.multipliers, &arg1) = arg2;
        };
    }

    public(friend) fun set_gangster_current_health(arg0: &mut GangsterUnitBattleStats, arg1: u128) {
        arg0.current_health = arg1;
    }

    public(friend) fun set_player_battle_counts(arg0: &mut PlayerBattleStats, arg1: u64) {
        arg0.battle_count = arg1;
    }

    public(friend) fun set_player_battle_ts(arg0: &mut PlayerBattleStats, arg1: u64) {
        arg0.recent_attack_ts = arg1;
    }

    public(friend) fun set_recent_lost(arg0: &mut PlayerBattleStats, arg1: u64) {
        arg0.recent_lost_count = arg1;
    }

    public(friend) fun share_player_battle_stats(arg0: PlayerBattleStats) {
        0x2::transfer::share_object<PlayerBattleStats>(arg0);
    }

    // decompiled from Move bytecode v6
}

