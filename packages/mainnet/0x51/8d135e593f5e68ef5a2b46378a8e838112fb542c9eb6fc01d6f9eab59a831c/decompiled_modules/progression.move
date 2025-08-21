module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression {
    struct CharacterStats has drop, store {
        level: u64,
        experience: u64,
        stat_points: u64,
        agility: u64,
        endurance: u64,
        stealth: u64,
        luck: u64,
    }

    struct Stamina has drop, store {
        current: u64,
        max: u64,
        last_recovery_time: u64,
    }

    struct WantedLevel has drop, store {
        level: u64,
        arrest_ends_at: u64,
        last_decay_time: u64,
    }

    public(friend) fun escape_arrest(arg0: &mut WantedLevel, arg1: u64) {
        arg0.arrest_ends_at = 0;
        arg0.last_decay_time = arg1;
    }

    public(friend) fun has_sufficient_stamina(arg0: &Stamina, arg1: u64) : bool {
        arg0.current >= arg1
    }

    public(friend) fun is_arrested(arg0: &WantedLevel) : bool {
        arg0.arrest_ends_at > 0
    }

    public(friend) fun new_character_stats(arg0: u64, arg1: u64, arg2: u64) : CharacterStats {
        CharacterStats{
            level       : arg0,
            experience  : arg1,
            stat_points : arg2,
            agility     : 0,
            endurance   : 0,
            stealth     : 0,
            luck        : 0,
        }
    }

    public(friend) fun new_stamina(arg0: u64, arg1: u64) : Stamina {
        Stamina{
            current            : arg0,
            max                : arg0,
            last_recovery_time : arg1,
        }
    }

    public(friend) fun new_wanted_level(arg0: u64) : WantedLevel {
        WantedLevel{
            level           : 0,
            arrest_ends_at  : 0,
            last_decay_time : arg0,
        }
    }

    public(friend) fun set_arrest(arg0: &mut WantedLevel, arg1: u64) {
        arg0.arrest_ends_at = arg1;
    }

    public(friend) fun set_stamina_current(arg0: &mut Stamina, arg1: u64) {
        arg0.current = arg1;
    }

    public(friend) fun set_stamina_last_recovery_time(arg0: &mut Stamina, arg1: u64) {
        arg0.last_recovery_time = arg1;
    }

    public(friend) fun set_stamina_max(arg0: &mut Stamina, arg1: u64) {
        arg0.max = arg1;
    }

    public(friend) fun set_stats_experience(arg0: &mut CharacterStats, arg1: u64) {
        arg0.experience = arg1;
    }

    public(friend) fun set_stats_level(arg0: &mut CharacterStats, arg1: u64) {
        arg0.level = arg1;
    }

    public(friend) fun set_stats_stat_points(arg0: &mut CharacterStats, arg1: u64) {
        arg0.stat_points = arg1;
    }

    public(friend) fun set_wanted_arrest_ends_at(arg0: &mut WantedLevel, arg1: u64) {
        arg0.arrest_ends_at = arg1;
    }

    public(friend) fun set_wanted_last_decay_time(arg0: &mut WantedLevel, arg1: u64) {
        arg0.last_decay_time = arg1;
    }

    public(friend) fun set_wanted_level(arg0: &mut WantedLevel, arg1: u64) {
        arg0.level = arg1;
    }

    public(friend) fun stamina_current(arg0: &Stamina) : u64 {
        arg0.current
    }

    public(friend) fun stamina_last_recovery_time(arg0: &Stamina) : u64 {
        arg0.last_recovery_time
    }

    public(friend) fun stamina_max(arg0: &Stamina) : u64 {
        arg0.max
    }

    public(friend) fun stats_agility(arg0: &CharacterStats) : u64 {
        arg0.agility
    }

    public(friend) fun stats_agility_mut(arg0: &mut CharacterStats) : &mut u64 {
        &mut arg0.agility
    }

    public(friend) fun stats_endurance(arg0: &CharacterStats) : u64 {
        arg0.endurance
    }

    public(friend) fun stats_endurance_mut(arg0: &mut CharacterStats) : &mut u64 {
        &mut arg0.endurance
    }

    public(friend) fun stats_experience(arg0: &CharacterStats) : u64 {
        arg0.experience
    }

    public(friend) fun stats_level(arg0: &CharacterStats) : u64 {
        arg0.level
    }

    public(friend) fun stats_luck(arg0: &CharacterStats) : u64 {
        arg0.luck
    }

    public(friend) fun stats_luck_mut(arg0: &mut CharacterStats) : &mut u64 {
        &mut arg0.luck
    }

    public(friend) fun stats_stat_points(arg0: &CharacterStats) : u64 {
        arg0.stat_points
    }

    public(friend) fun stats_stealth(arg0: &CharacterStats) : u64 {
        arg0.stealth
    }

    public(friend) fun stats_stealth_mut(arg0: &mut CharacterStats) : &mut u64 {
        &mut arg0.stealth
    }

    public(friend) fun wanted_arrest_ends_at(arg0: &WantedLevel) : u64 {
        arg0.arrest_ends_at
    }

    public(friend) fun wanted_last_decay_time(arg0: &WantedLevel) : u64 {
        arg0.last_decay_time
    }

    public(friend) fun wanted_level(arg0: &WantedLevel) : u64 {
        arg0.level
    }

    // decompiled from Move bytecode v6
}

