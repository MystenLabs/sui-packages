module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stamina_logic {
    public(friend) fun amount_from_time_rate(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        arg0 / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::ms_per_min() * arg1 / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::rate_scale() + arg0 % 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::ms_per_min() * arg1 / 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::time_rate_den()
    }

    public(friend) fun calculate_max_stamina(arg0: u64) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stat_effects::endurance_max_stamina(arg0)
    }

    public(friend) fun consume_stamina(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina, arg1: u64) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stamina_current(arg0);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::errors::assert_sufficient_stamina(v0 >= arg1);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stamina_current(arg0, v0 - arg1);
    }

    public(friend) fun recover_stamina(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stamina_last_recovery_time(arg0);
        if (v0 <= v1) {
            return
        };
        let v2 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stamina_current(arg0);
        let v3 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stamina_max(arg0);
        if (v2 >= v3) {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stamina_last_recovery_time(arg0, v0);
            return
        };
        let v4 = amount_from_time_rate(v0 - v1, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stat_effects::endurance_stamina_regen_rate(arg1) + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::get_buff_strength(arg3, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::buff_type_stamina_regen(), arg2));
        let v5 = if (v2 + v4 > v3) {
            v3
        } else {
            v2 + v4
        };
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stamina_current(arg0, v5);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stamina_last_recovery_time(arg0, v0);
    }

    public(friend) fun restore_stamina_full_paid(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina, arg1: u64, arg2: &0x2::clock::Clock) {
        update_max_stamina(arg0, arg1);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stamina_current(arg0, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stamina_max(arg0));
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stamina_last_recovery_time(arg0, 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun update_max_stamina(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina, arg1: u64) {
        let v0 = calculate_max_stamina(arg1);
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stamina_max(arg0);
        let v2 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stamina_current(arg0);
        let v3 = if (v0 > v1) {
            v2 + v0 - v1
        } else if (v2 > v0) {
            v0
        } else {
            v2
        };
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stamina_max(arg0, v0);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::set_stamina_current(arg0, v3);
    }

    // decompiled from Move bytecode v6
}

