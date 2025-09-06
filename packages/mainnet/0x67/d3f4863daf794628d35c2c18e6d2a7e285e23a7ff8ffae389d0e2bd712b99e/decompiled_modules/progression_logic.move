module 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression_logic {
    public(friend) fun activate_newbie_buff(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character_data::Character, arg1: &0x2::clock::Clock) {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::experience_logic::activate_newbie_buff(arg0, arg1);
    }

    public(friend) fun calculate_level_from_exp(arg0: u64) : u64 {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::experience_logic::calculate_level_from_exp(arg0)
    }

    public(friend) fun calculate_rarity_bonus_exp(arg0: u64) : u64 {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::experience_logic::calculate_rarity_bonus_exp(arg0)
    }

    public(friend) fun gain_experience(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::CharacterStats, arg1: u64) : bool {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::experience_logic::gain_experience(arg0, arg1)
    }

    public(friend) fun gain_experience_with_newbie_buff_check(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character_data::Character, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: &0x2::clock::Clock) : bool {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::experience_logic::gain_experience_with_newbie_buff_check(arg0, arg1, arg2, arg3)
    }

    public(friend) fun is_newbie_buff_active(arg0: &0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character_data::Character, arg1: &0x2::clock::Clock) : bool {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::experience_logic::is_newbie_buff_active(arg0, arg1)
    }

    public(friend) fun update_newbie_buff_state(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character_data::Character, arg1: &0x2::clock::Clock) {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::experience_logic::update_newbie_buff_state(arg0, arg1);
    }

    public(friend) fun add_wanted_level_with_stealth_and_rarity(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::WantedLevel, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::wanted_logic::add_wanted_level_with_stealth_and_rarity(arg0, arg1, arg2, arg3)
    }

    public(friend) fun allocate_stat_points_character(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character_data::Character, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stat_allocation_logic::allocate_stat_points_character(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) fun auto_release_if_time_passed(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::WantedLevel, arg1: &0x2::clock::Clock) {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::wanted_logic::auto_release_if_time_passed(arg0, arg1);
    }

    public(friend) fun calculate_max_stamina(arg0: u64) : u64 {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stamina_logic::calculate_max_stamina(arg0)
    }

    public(friend) fun calculate_rarity_wanted_bonus(arg0: u64) : u64 {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::wanted_logic::calculate_rarity_wanted_bonus(arg0)
    }

    public(friend) fun check_arrest_with_separate_rolls(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::WantedLevel, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext, arg6: &0x2::clock::Clock) : 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::arrest_result::ArrestResult {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::wanted_logic::check_arrest_with_separate_rolls(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun consume_stamina(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::Stamina, arg1: u64) {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stamina_logic::consume_stamina(arg0, arg1);
    }

    public(friend) fun recover_stamina(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::Stamina, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::global_buffs::GlobalBuffs) {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stamina_logic::recover_stamina(arg0, arg1, arg2, arg3);
    }

    public(friend) fun restore_stamina_full_paid(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::Stamina, arg1: u64, arg2: &0x2::clock::Clock) {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stamina_logic::restore_stamina_full_paid(arg0, arg1, arg2);
    }

    public(friend) fun update_max_stamina(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::Stamina, arg1: u64) {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stamina_logic::update_max_stamina(arg0, arg1);
    }

    public(friend) fun update_wanted_level(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::progression::WantedLevel, arg1: u64, arg2: &0x2::clock::Clock) {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::wanted_logic::update_wanted_level(arg0, arg1, arg2);
    }

    public(friend) fun validate_stat_allocation(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::stat_allocation_logic::validate_stat_allocation(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

