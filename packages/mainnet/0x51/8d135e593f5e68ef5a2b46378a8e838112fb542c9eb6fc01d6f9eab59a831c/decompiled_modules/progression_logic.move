module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic {
    public(friend) fun activate_newbie_buff(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::experience_logic::activate_newbie_buff(arg0, arg1);
    }

    public(friend) fun calculate_level_from_exp(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::experience_logic::calculate_level_from_exp(arg0)
    }

    public(friend) fun calculate_rarity_bonus_exp(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::experience_logic::calculate_rarity_bonus_exp(arg0)
    }

    public(friend) fun gain_experience(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::CharacterStats, arg1: u64) : bool {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::experience_logic::gain_experience(arg0, arg1)
    }

    public(friend) fun gain_experience_with_newbie_buff_check(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: &0x2::clock::Clock) : bool {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::experience_logic::gain_experience_with_newbie_buff_check(arg0, arg1, arg2, arg3)
    }

    public(friend) fun is_newbie_buff_active(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x2::clock::Clock) : bool {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::experience_logic::is_newbie_buff_active(arg0, arg1)
    }

    public(friend) fun update_newbie_buff_state(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::experience_logic::update_newbie_buff_state(arg0, arg1);
    }

    public(friend) fun add_wanted_level_with_stealth_and_rarity(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::WantedLevel, arg1: u64, arg2: u64) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::wanted_logic::add_wanted_level_with_stealth_and_rarity(arg0, arg1, arg2);
    }

    public(friend) fun allocate_stat_points_character(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stat_allocation_logic::allocate_stat_points_character(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) fun auto_release_if_time_passed(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::WantedLevel, arg1: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::wanted_logic::auto_release_if_time_passed(arg0, arg1);
    }

    public(friend) fun calculate_max_stamina(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stamina_logic::calculate_max_stamina(arg0)
    }

    public(friend) fun calculate_rarity_wanted_bonus(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::wanted_logic::calculate_rarity_wanted_bonus(arg0)
    }

    public(friend) fun check_arrest_with_separate_rolls(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::WantedLevel, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext, arg6: &0x2::clock::Clock) : 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::arrest_result::ArrestResult {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::wanted_logic::check_arrest_with_separate_rolls(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun consume_stamina(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina, arg1: u64) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stamina_logic::consume_stamina(arg0, arg1);
    }

    public(friend) fun recover_stamina(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stamina_logic::recover_stamina(arg0, arg1, arg2, arg3);
    }

    public(friend) fun restore_stamina_full_paid(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina, arg1: u64, arg2: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stamina_logic::restore_stamina_full_paid(arg0, arg1, arg2);
    }

    public(friend) fun update_max_stamina(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina, arg1: u64) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stamina_logic::update_max_stamina(arg0, arg1);
    }

    public(friend) fun update_wanted_level(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::WantedLevel, arg1: u64, arg2: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::wanted_logic::update_wanted_level(arg0, arg1, arg2);
    }

    public(friend) fun validate_stat_allocation(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stat_allocation_logic::validate_stat_allocation(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

