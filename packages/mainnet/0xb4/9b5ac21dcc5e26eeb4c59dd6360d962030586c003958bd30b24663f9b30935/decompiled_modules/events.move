module 0xb49b5ac21dcc5e26eeb4c59dd6360d962030586c003958bd30b24663f9b30935::events {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LogCap has store, key {
        id: 0x2::object::UID,
    }

    struct LoggerState has key {
        id: 0x2::object::UID,
        loggers: 0x2::vec_set::VecSet<address>,
    }

    struct MatchMetadata has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
        match_date: 0x1::string::String,
        player_count: u64,
    }

    struct PlayerIdentity has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
    }

    struct SurvivalOutcome has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
        escape_success: bool,
        time_survived: u64,
        deaths: u64,
    }

    struct CombatCoreStats has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
        kills: u64,
        assists: u64,
        accuracy: 0x1::string::String,
    }

    struct DamageBreakdown has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
        damage_to_players_by_gun: u64,
        damage_to_monsters_by_gun: u64,
        damage_to_players_by_active: u64,
        damage_to_monsters_by_active: u64,
        damage_to_players_by_ultimate: u64,
        damage_to_monsters_by_ultimate: u64,
    }

    struct SkillUsage has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
        active_skill_uses: u64,
        ultimate_skill_uses: u64,
        selected_active_skill: 0x1::string::String,
        selected_passive_skill: 0x1::string::String,
        selected_ultimate_skill: 0x1::string::String,
    }

    struct PlayerProgression has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
        level_reached: u64,
        total_xp_earned: u64,
    }

    struct MotusEconomy has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
        total_motus: u64,
        extracted_motus: u64,
        unextracted_motus: u64,
        unrecovered_motus: u64,
        earned_credit: u64,
    }

    struct ItemAcquisition has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
        weapons_acquired: u64,
        armors_acquired: u64,
        hp_potions_acquired: u64,
        sp_potions_acquired: u64,
        grenades_acquired: u64,
    }

    struct SupportUtilityActions has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
        revive_allies: u64,
        monster_beacon_opens: u64,
        distance_traveled: 0x1::string::String,
    }

    struct MonsterKillBreakdown has copy, drop {
        match_uuid: 0x1::string::String,
        player_id: 0x1::string::String,
        normal_monsters_killed: u64,
        elite_monsters_killed: u64,
        boss_monsters_killed: u64,
    }

    public fun add_logger(arg0: &AdminCap, arg1: &mut LoggerState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::vec_set::contains<address>(&arg1.loggers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.loggers, arg2);
        };
        let v0 = LogCap{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<LogCap>(v0, arg2);
    }

    public fun get_loggers(arg0: &LoggerState) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.loggers)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = LoggerState{
            id      : 0x2::object::new(arg0),
            loggers : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<LoggerState>(v1);
    }

    public fun log_combat_core_stats(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = CombatCoreStats{
            match_uuid : arg2,
            player_id  : arg3,
            kills      : arg4,
            assists    : arg5,
            accuracy   : arg6,
        };
        0x2::event::emit<CombatCoreStats>(v1);
    }

    public fun log_damage_breakdown(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = DamageBreakdown{
            match_uuid                     : arg2,
            player_id                      : arg3,
            damage_to_players_by_gun       : arg4,
            damage_to_monsters_by_gun      : arg5,
            damage_to_players_by_active    : arg6,
            damage_to_monsters_by_active   : arg7,
            damage_to_players_by_ultimate  : arg8,
            damage_to_monsters_by_ultimate : arg9,
        };
        0x2::event::emit<DamageBreakdown>(v1);
    }

    public fun log_item_acquisition(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = ItemAcquisition{
            match_uuid          : arg2,
            player_id           : arg3,
            weapons_acquired    : arg4,
            armors_acquired     : arg5,
            hp_potions_acquired : arg6,
            sp_potions_acquired : arg7,
            grenades_acquired   : arg8,
        };
        0x2::event::emit<ItemAcquisition>(v1);
    }

    public fun log_match_metadata(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = MatchMetadata{
            match_uuid   : arg2,
            player_id    : arg3,
            match_date   : arg4,
            player_count : arg5,
        };
        0x2::event::emit<MatchMetadata>(v1);
    }

    public fun log_monster_kill_breakdown(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = MonsterKillBreakdown{
            match_uuid             : arg2,
            player_id              : arg3,
            normal_monsters_killed : arg4,
            elite_monsters_killed  : arg5,
            boss_monsters_killed   : arg6,
        };
        0x2::event::emit<MonsterKillBreakdown>(v1);
    }

    public fun log_motus_economy(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = MotusEconomy{
            match_uuid        : arg2,
            player_id         : arg3,
            total_motus       : arg4,
            extracted_motus   : arg5,
            unextracted_motus : arg6,
            unrecovered_motus : arg7,
            earned_credit     : arg8,
        };
        0x2::event::emit<MotusEconomy>(v1);
    }

    public fun log_player_identity(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = PlayerIdentity{
            match_uuid : arg2,
            player_id  : arg3,
        };
        0x2::event::emit<PlayerIdentity>(v1);
    }

    public fun log_player_progression(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = PlayerProgression{
            match_uuid      : arg2,
            player_id       : arg3,
            level_reached   : arg4,
            total_xp_earned : arg5,
        };
        0x2::event::emit<PlayerProgression>(v1);
    }

    public fun log_skill_usage(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = SkillUsage{
            match_uuid              : arg2,
            player_id               : arg3,
            active_skill_uses       : arg4,
            ultimate_skill_uses     : arg5,
            selected_active_skill   : arg6,
            selected_passive_skill  : arg7,
            selected_ultimate_skill : arg8,
        };
        0x2::event::emit<SkillUsage>(v1);
    }

    public fun log_support_utility_actions(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = SupportUtilityActions{
            match_uuid           : arg2,
            player_id            : arg3,
            revive_allies        : arg4,
            monster_beacon_opens : arg5,
            distance_traveled    : arg6,
        };
        0x2::event::emit<SupportUtilityActions>(v1);
    }

    public fun log_survival_outcome(arg0: &LogCap, arg1: &LoggerState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::vec_set::contains<address>(&arg1.loggers, &v0), 0);
        let v1 = SurvivalOutcome{
            match_uuid     : arg2,
            player_id      : arg3,
            escape_success : arg4,
            time_survived  : arg5,
            deaths         : arg6,
        };
        0x2::event::emit<SurvivalOutcome>(v1);
    }

    public fun remove_logger(arg0: &AdminCap, arg1: &mut LoggerState, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg1.loggers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.loggers, &arg2);
        };
    }

    // decompiled from Move bytecode v6
}

