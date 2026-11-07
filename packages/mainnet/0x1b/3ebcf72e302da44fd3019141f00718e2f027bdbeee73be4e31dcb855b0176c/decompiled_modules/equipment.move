module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::equipment {
    struct EquipmentKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FoldedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct EquippedRecord has copy, drop, store {
        item: 0x2::object::ID,
        template: 0x2::object::ID,
        category: 0x1::string::String,
        stats: 0x1::option::Option<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>,
        damages: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>,
    }

    struct ItemEquipped has copy, drop {
        character: 0x2::object::ID,
        slot: 0x1::string::String,
        item: 0x2::object::ID,
    }

    struct ItemUnequipped has copy, drop {
        character: 0x2::object::ID,
        slot: 0x1::string::String,
        item: 0x2::object::ID,
    }

    fun borrow_equipment_mut(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : &mut 0x2::vec_map::VecMap<0x1::string::String, EquippedRecord> {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v1 = EquipmentKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<EquipmentKey>(v0, v1)) {
            let v2 = EquipmentKey{dummy_field: false};
            0x2::dynamic_field::add<EquipmentKey, 0x2::vec_map::VecMap<0x1::string::String, EquippedRecord>>(v0, v2, 0x2::vec_map::empty<0x1::string::String, EquippedRecord>());
        };
        let v3 = EquipmentKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<EquipmentKey, 0x2::vec_map::VecMap<0x1::string::String, EquippedRecord>>(v0, v3)
    }

    public(friend) fun equip(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: 0x1::string::String, arg2: 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item) {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_slot(&arg1), 1001);
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::category(&arg2);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::category_fits(&arg1, &v0), 1002);
        assert!((0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::level(arg0) as u64) >= (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::level(&arg2) as u64), 1003);
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::id(arg0);
        let v2 = borrow_equipment_mut(arg0);
        assert!(!0x2::vec_map::contains<0x1::string::String, EquippedRecord>(v2, &arg1), 1004);
        if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_relic_slot(&arg1)) {
            let v3 = 1;
            while (v3 <= 6) {
                let v4 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::relic_slot(v3);
                if (0x2::vec_map::contains<0x1::string::String, EquippedRecord>(v2, &v4)) {
                    assert!(0x2::vec_map::get<0x1::string::String, EquippedRecord>(v2, &v4).template != 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::template(&arg2), 1005);
                };
                v3 = v3 + 1;
            };
        };
        let v5 = if (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::has_stats(&arg2)) {
            0x1::option::some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::stats(&arg2))
        } else {
            0x1::option::none<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>()
        };
        let v6 = if (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::has_damages(&arg2)) {
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::damages(&arg2)
        } else {
            0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>()
        };
        let v7 = EquippedRecord{
            item     : 0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(&arg2),
            template : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::template(&arg2),
            category : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::category(&arg2),
            stats    : v5,
            damages  : v6,
        };
        0x2::vec_map::insert<0x1::string::String, EquippedRecord>(v2, arg1, v7);
        refold(arg0);
        let v8 = ItemEquipped{
            character : v1,
            slot      : arg1,
            item      : 0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(&arg2),
        };
        0x2::event::emit<ItemEquipped>(v8);
        0x2::transfer::public_transfer<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg2, 0x2::object::id_to_address(&v1));
    }

    public(friend) fun equipped(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : 0x2::vec_map::VecMap<0x1::string::String, EquippedRecord> {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0);
        let v1 = EquipmentKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<EquipmentKey>(v0, v1)) {
            return 0x2::vec_map::empty<0x1::string::String, EquippedRecord>()
        };
        let v2 = EquipmentKey{dummy_field: false};
        *0x2::dynamic_field::borrow<EquipmentKey, 0x2::vec_map::VecMap<0x1::string::String, EquippedRecord>>(v0, v2)
    }

    public(friend) fun folded(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0);
        let v1 = FoldedKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FoldedKey>(v0, v1)) {
            return 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::zero()
        };
        let v2 = FoldedKey{dummy_field: false};
        *0x2::dynamic_field::borrow<FoldedKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(v0, v2)
    }

    public(friend) fun has_any_equipped(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : bool {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0);
        let v1 = EquipmentKey{dummy_field: false};
        if (0x2::dynamic_field::exists<EquipmentKey>(v0, v1)) {
            let v3 = EquipmentKey{dummy_field: false};
            !0x2::vec_map::is_empty<0x1::string::String, EquippedRecord>(0x2::dynamic_field::borrow<EquipmentKey, 0x2::vec_map::VecMap<0x1::string::String, EquippedRecord>>(v0, v3))
        } else {
            false
        }
    }

    public(friend) fun pet_equipped(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : bool {
        let v0 = equipped(arg0);
        let v1 = 0x1::string::utf8(b"pet");
        0x2::vec_map::contains<0x1::string::String, EquippedRecord>(&v0, &v1)
    }

    public(friend) fun record_category(arg0: &EquippedRecord) : 0x1::string::String {
        arg0.category
    }

    public(friend) fun record_damages(arg0: &EquippedRecord) : vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages> {
        arg0.damages
    }

    fun refold(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) {
        let v0 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>();
        let v1 = equipped(arg0);
        let v2 = 0x2::vec_map::keys<0x1::string::String, EquippedRecord>(&v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v2)) {
            let v4 = 0x2::vec_map::get<0x1::string::String, EquippedRecord>(&v1, 0x1::vector::borrow<0x1::string::String>(&v2, v3));
            if (0x1::option::is_some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&v4.stats)) {
                0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&mut v0, *0x1::option::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&v4.stats));
            };
            v3 = v3 + 1;
        };
        let v5 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v6 = FoldedKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FoldedKey>(v5, v6)) {
            let v7 = FoldedKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<FoldedKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(v5, v7) = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::fold(&v0);
        } else {
            let v8 = FoldedKey{dummy_field: false};
            0x2::dynamic_field::add<FoldedKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(v5, v8, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::fold(&v0));
        };
    }

    public(friend) fun set_slot_stats(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: 0x1::string::String, arg2: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics) {
        let v0 = borrow_equipment_mut(arg0);
        assert!(0x2::vec_map::contains<0x1::string::String, EquippedRecord>(v0, &arg1), 1006);
        0x2::vec_map::get_mut<0x1::string::String, EquippedRecord>(v0, &arg1).stats = 0x1::option::some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(arg2);
        refold(arg0);
    }

    public(friend) fun tool_of(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : 0x1::string::String {
        let v0 = equipped(arg0);
        let v1 = 0x1::string::utf8(b"tool");
        if (!0x2::vec_map::contains<0x1::string::String, EquippedRecord>(&v0, &v1)) {
            return 0x1::string::utf8(b"")
        };
        0x2::vec_map::get<0x1::string::String, EquippedRecord>(&v0, &v1).category
    }

    public(friend) fun unequip(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: 0x1::string::String, arg2: 0x2::transfer::Receiving<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>) : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_slot(&arg1), 1001);
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::id(arg0);
        let v1 = borrow_equipment_mut(arg0);
        assert!(0x2::vec_map::contains<0x1::string::String, EquippedRecord>(v1, &arg1), 1006);
        let (_, v3) = 0x2::vec_map::remove<0x1::string::String, EquippedRecord>(v1, &arg1);
        let v4 = v3;
        let v5 = 0x2::transfer::public_receive<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0), arg2);
        assert!(0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(&v5) == v4.item, 1007);
        refold(arg0);
        let v6 = ItemUnequipped{
            character : v0,
            slot      : arg1,
            item      : v4.item,
        };
        0x2::event::emit<ItemUnequipped>(v6);
        v5
    }

    // decompiled from Move bytecode v7
}

