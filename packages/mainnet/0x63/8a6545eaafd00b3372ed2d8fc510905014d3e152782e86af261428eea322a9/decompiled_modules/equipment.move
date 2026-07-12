module 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::equipment {
    struct Equipment has store, key {
        id: 0x2::object::UID,
        kind: u16,
        slot: u8,
        tier: u8,
        attack: u64,
        defence: u64,
        dexterity: u64,
        speed: u64,
        effects: 0x2::vec_map::VecMap<u16, u64>,
        name: 0x1::string::String,
    }

    struct ArmoryKey has copy, drop, store {
        pos0: u64,
    }

    struct SlotKey has copy, drop, store {
        pos0: u8,
    }

    struct EquipmentCrafted has copy, drop {
        player_id: 0x2::object::ID,
        kind: u16,
        armory_key: u64,
    }

    struct Equipped has copy, drop {
        player_id: 0x2::object::ID,
        slot: u8,
        kind: u16,
        swapped_to_armory: u64,
    }

    struct Unequipped has copy, drop {
        player_id: 0x2::object::ID,
        slot: u8,
        kind: u16,
        armory_key: u64,
    }

    public fun equip(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg2, arg3);
        let v0 = ArmoryKey{pos0: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<ArmoryKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v0), 13906834646789783553);
        let v1 = ArmoryKey{pos0: arg1};
        let v2 = 0x2::dynamic_object_field::remove<ArmoryKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v1);
        let v3 = v2.slot;
        let v4 = 0;
        let v5 = SlotKey{pos0: v3};
        if (0x2::dynamic_object_field::exists_with_type<SlotKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v5)) {
            let v6 = SlotKey{pos0: v3};
            let v7 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::next_armory_seq(arg0);
            v4 = v7;
            let v8 = ArmoryKey{pos0: v7};
            0x2::dynamic_object_field::add<ArmoryKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v8, 0x2::dynamic_object_field::remove<SlotKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v6));
        };
        let v9 = Equipped{
            player_id         : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            slot              : v3,
            kind              : v2.kind,
            swapped_to_armory : v4,
        };
        0x2::event::emit<Equipped>(v9);
        let v10 = SlotKey{pos0: v3};
        0x2::dynamic_object_field::add<SlotKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v10, v2);
    }

    public(friend) fun equipped_bonuses(arg0: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player) : (u64, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 7) {
            let v5 = SlotKey{pos0: v4};
            if (0x2::dynamic_object_field::exists_with_type<SlotKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid(arg0), v5)) {
                let v6 = SlotKey{pos0: v4};
                let v7 = 0x2::dynamic_object_field::borrow<SlotKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid(arg0), v6);
                v0 = v0 + v7.attack;
                v1 = v1 + v7.defence;
                v2 = v2 + v7.dexterity;
                v3 = v3 + v7.speed;
            };
            v4 = v4 + 1;
        };
        (v0, v1, v2, v3)
    }

    public fun kind(arg0: &Equipment) : u16 {
        arg0.kind
    }

    public(friend) fun mint_into_armory(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::equipment(arg1, arg2);
        let v1 = Equipment{
            id        : 0x2::object::new(arg3),
            kind      : arg2,
            slot      : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::equipment_slot(&v0),
            tier      : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::equipment_tier(&v0),
            attack    : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::equipment_attack(&v0),
            defence   : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::equipment_defence(&v0),
            dexterity : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::equipment_dexterity(&v0),
            speed     : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::equipment_speed(&v0),
            effects   : 0x2::vec_map::empty<u16, u64>(),
            name      : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::equipment_name(&v0),
        };
        let v2 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::next_armory_seq(arg0);
        let v3 = EquipmentCrafted{
            player_id  : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            kind       : arg2,
            armory_key : v2,
        };
        0x2::event::emit<EquipmentCrafted>(v3);
        let v4 = ArmoryKey{pos0: v2};
        0x2::dynamic_object_field::add<ArmoryKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v4, v1);
        v2
    }

    public fun name(arg0: &Equipment) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun put_in_armory(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: Equipment) : u64 {
        let v0 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::next_armory_seq(arg0);
        let v1 = ArmoryKey{pos0: v0};
        0x2::dynamic_object_field::add<ArmoryKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v1, arg1);
        v0
    }

    public fun slot(arg0: &Equipment) : u8 {
        arg0.slot
    }

    public(friend) fun take_from_armory(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: u64) : Equipment {
        let v0 = ArmoryKey{pos0: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<ArmoryKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid(arg0), v0), 13906834848653246465);
        let v1 = ArmoryKey{pos0: arg1};
        0x2::dynamic_object_field::remove<ArmoryKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v1)
    }

    public fun unequip(arg0: &mut 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::Player, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::assert_can_play(arg0, arg2, arg3);
        let v0 = SlotKey{pos0: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<SlotKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v0), 13906834775638933507);
        let v1 = SlotKey{pos0: arg1};
        let v2 = 0x2::dynamic_object_field::remove<SlotKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v1);
        let v3 = 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::next_armory_seq(arg0);
        let v4 = Unequipped{
            player_id  : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::id(arg0),
            slot       : arg1,
            kind       : v2.kind,
            armory_key : v3,
        };
        0x2::event::emit<Unequipped>(v4);
        let v5 = ArmoryKey{pos0: v3};
        0x2::dynamic_object_field::add<ArmoryKey, Equipment>(0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player::uid_mut(arg0), v5, v2);
    }

    // decompiled from Move bytecode v7
}

