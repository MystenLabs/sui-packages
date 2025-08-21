module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_management {
    public(friend) fun calc_equipped_bonuses(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character) : (u64, u64, u64, u64) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::calculate_equipment_bonuses(arg0)
    }

    public(friend) fun equip_by_slot(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::type_id(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::get_item_by_instance_id(arg0, arg2));
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::equipped_by_type_mut(arg0);
        if (0x2::vec_map::contains<u64, u64>(v1, &v0)) {
            let (_, _) = 0x2::vec_map::remove<u64, u64>(v1, &v0);
        };
        0x2::vec_map::insert<u64, u64>(v1, v0, arg2);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::update_attributes(arg0, arg1);
    }

    public(friend) fun get_equipped_instance_by_type(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::equipped_by_type(arg0);
        if (0x2::vec_map::contains<u64, u64>(v0, &arg1)) {
            0x1::option::some<u64>(*0x2::vec_map::get<u64, u64>(v0, &arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun get_equipped_item_ids(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::equipped_by_type(arg0);
        let v2 = 0x2::vec_map::keys<u64, u64>(v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v4 = *0x1::vector::borrow<u64>(&v2, v3);
            0x1::vector::push_back<u64>(&mut v0, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::item_id(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::get_item_by_instance_id(arg0, *0x2::vec_map::get<u64, u64>(v1, &v4))));
            v3 = v3 + 1;
        };
        v0
    }

    public(friend) fun is_type_equipped(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: u64) : bool {
        0x2::vec_map::contains<u64, u64>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::equipped_by_type(arg0), &arg1)
    }

    public(friend) fun remove_item_by_instance_id(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::get_item_by_instance_id(arg0, arg2);
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::type_id(v0);
        let v2 = if (is_type_equipped(arg0, v1)) {
            let v3 = get_equipped_instance_by_type(arg0, v1);
            *0x1::option::borrow<u64>(&v3) == arg2
        } else {
            false
        };
        if (v2) {
            unequip_by_type(arg0, arg1, v1);
        };
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::decrement_current_count(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::get_item_by_id_mut(arg1, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::item_id(v0)));
        let v4 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::inventory_mut(arg0);
        let v5 = 0;
        let v6 = 0x1::option::none<u64>();
        while (v5 < 0x1::vector::length<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(v4)) {
            if (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::instance_id(0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(v4, v5)) == arg2) {
                v6 = 0x1::option::some<u64>(v5);
                break
            };
            v5 = v5 + 1;
        };
        assert!(0x1::option::is_some<u64>(&v6), 0);
        0x1::vector::remove<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(v4, *0x1::option::borrow<u64>(&v6));
    }

    public(friend) fun unequip_by_type(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::equipped_by_type_mut(arg0);
        if (0x2::vec_map::contains<u64, u64>(v0, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<u64, u64>(v0, &arg2);
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::update_attributes(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

