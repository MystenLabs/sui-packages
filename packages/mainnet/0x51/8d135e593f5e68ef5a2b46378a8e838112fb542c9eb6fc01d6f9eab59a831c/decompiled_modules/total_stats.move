module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats {
    struct TotalStats has drop {
        agility: u64,
        endurance: u64,
        stealth: u64,
        luck: u64,
    }

    public(friend) fun calculate_equipment_bonuses(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character) : (u64, u64, u64, u64) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::equipped_by_type(arg0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x2::vec_map::keys<u64, u64>(v0);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v5)) {
            let v7 = *0x1::vector::borrow<u64>(&v5, v6);
            let v8 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::get_item_by_instance_id(arg0, *0x2::vec_map::get<u64, u64>(v0, &v7));
            v1 = v1 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::agility_bonus(v8);
            v2 = v2 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::endurance_bonus(v8);
            v3 = v3 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::stealth_bonus(v8);
            v4 = v4 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::luck_bonus(v8);
            v6 = v6 + 1;
        };
        (v1, v2, v3, v4)
    }

    public(friend) fun calculate_total_stats(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character) : TotalStats {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::stats(arg0);
        let (v1, v2, v3, v4) = calculate_equipment_bonuses(arg0);
        new_total_stats(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_agility(v0) + v1, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_endurance(v0) + v2, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_stealth(v0) + v3, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_luck(v0) + v4)
    }

    fun new_total_stats(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : TotalStats {
        TotalStats{
            agility   : arg0,
            endurance : arg1,
            stealth   : arg2,
            luck      : arg3,
        }
    }

    public(friend) fun total_agility(arg0: &TotalStats) : u64 {
        arg0.agility
    }

    public(friend) fun total_endurance(arg0: &TotalStats) : u64 {
        arg0.endurance
    }

    public(friend) fun total_luck(arg0: &TotalStats) : u64 {
        arg0.luck
    }

    public(friend) fun total_stealth(arg0: &TotalStats) : u64 {
        arg0.stealth
    }

    // decompiled from Move bytecode v6
}

