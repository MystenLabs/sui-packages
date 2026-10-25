module 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows {
    struct ItemKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct ItemTemplate has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        item_type: 0x1::string::String,
        category: 0x1::string::String,
        level: u8,
        pet_foods: vector<0x1::string::String>,
    }

    struct StatsMinKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StatsMaxKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DamagesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct EffectKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TemplateCreated has copy, drop {
        template: 0x2::object::ID,
        item_type: 0x1::string::String,
    }

    public fun consumable_effect(arg0: &ItemTemplate) : 0x1::option::Option<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect> {
        let v0 = EffectKey{dummy_field: false};
        if (0x2::dynamic_field::exists<EffectKey>(&arg0.id, v0)) {
            let v2 = EffectKey{dummy_field: false};
            0x1::option::some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect>(*0x2::dynamic_field::borrow<EffectKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect>(&arg0.id, v2))
        } else {
            0x1::option::none<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect>()
        }
    }

    public fun add_item(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: vector<0x1::string::String>, arg7: &0x2::tx_context::TxContext) : ItemTemplate {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_category(&arg4), 4501);
        let v0 = ItemKey{pos0: arg3};
        let v1 = ItemTemplate{
            id        : 0x2::derived_object::claim<ItemKey>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::uid_mut(arg0, arg1, arg7), v0),
            name      : arg2,
            item_type : arg3,
            category  : arg4,
            level     : arg5,
            pet_foods : arg6,
        };
        let v2 = TemplateCreated{
            template  : 0x2::object::uid_to_inner(&v1.id),
            item_type : v1.item_type,
        };
        0x2::event::emit<TemplateCreated>(v2);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"items"), v1.item_type, arg7);
        v1
    }

    public fun clear_damages(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut ItemTemplate, arg3: &0x2::tx_context::TxContext) {
        let v0 = DamagesKey{dummy_field: false};
        if (0x2::dynamic_field::exists<DamagesKey>(&arg2.id, v0)) {
            let v1 = DamagesKey{dummy_field: false};
            0x2::dynamic_field::remove<DamagesKey, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>>(&mut arg2.id, v1);
            0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"items"), arg2.item_type, arg3);
        };
    }

    public fun clear_effect(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut ItemTemplate, arg3: &0x2::tx_context::TxContext) {
        let v0 = EffectKey{dummy_field: false};
        if (0x2::dynamic_field::exists<EffectKey>(&arg2.id, v0)) {
            let v1 = EffectKey{dummy_field: false};
            0x2::dynamic_field::remove<EffectKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect>(&mut arg2.id, v1);
            0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"items"), arg2.item_type, arg3);
        };
    }

    public fun clear_stats(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut ItemTemplate, arg3: &0x2::tx_context::TxContext) {
        let v0 = StatsMinKey{dummy_field: false};
        if (0x2::dynamic_field::exists<StatsMinKey>(&arg2.id, v0)) {
            let v1 = StatsMinKey{dummy_field: false};
            0x2::dynamic_field::remove<StatsMinKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&mut arg2.id, v1);
            let v2 = StatsMaxKey{dummy_field: false};
            0x2::dynamic_field::remove<StatsMaxKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&mut arg2.id, v2);
            0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"items"), arg2.item_type, arg3);
        };
    }

    public fun damage_lines(arg0: &ItemTemplate) : vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages> {
        let v0 = DamagesKey{dummy_field: false};
        if (0x2::dynamic_field::exists<DamagesKey>(&arg0.id, v0)) {
            let v2 = DamagesKey{dummy_field: false};
            *0x2::dynamic_field::borrow<DamagesKey, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>>(&arg0.id, v2)
        } else {
            0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>()
        }
    }

    public fun has_stats(arg0: &ItemTemplate) : bool {
        let v0 = StatsMinKey{dummy_field: false};
        0x2::dynamic_field::exists<StatsMinKey>(&arg0.id, v0)
    }

    public fun overwrite_item(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut ItemTemplate, arg3: 0x1::string::String, arg4: u8, arg5: vector<0x1::string::String>, arg6: &0x2::tx_context::TxContext) {
        arg2.name = arg3;
        arg2.level = arg4;
        arg2.pet_foods = arg5;
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"items"), arg2.item_type, arg6);
    }

    public fun pet_foods(arg0: &ItemTemplate) : vector<0x1::string::String> {
        arg0.pet_foods
    }

    public fun set_damages(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut ItemTemplate, arg3: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>, arg4: &0x2::tx_context::TxContext) {
        assert!(!0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&arg2.category) && !0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_cosmetic(&arg2.category), 4502);
        let v0 = DamagesKey{dummy_field: false};
        if (0x2::dynamic_field::exists<DamagesKey>(&arg2.id, v0)) {
            let v1 = DamagesKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<DamagesKey, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>>(&mut arg2.id, v1) = arg3;
        } else {
            let v2 = DamagesKey{dummy_field: false};
            0x2::dynamic_field::add<DamagesKey, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>>(&mut arg2.id, v2, arg3);
        };
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"items"), arg2.item_type, arg4);
    }

    public fun set_effect(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut ItemTemplate, arg3: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.category == 0x1::string::utf8(b"consumable"), 4504);
        let v0 = EffectKey{dummy_field: false};
        if (0x2::dynamic_field::exists<EffectKey>(&arg2.id, v0)) {
            let v1 = EffectKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<EffectKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect>(&mut arg2.id, v1) = arg3;
        } else {
            let v2 = EffectKey{dummy_field: false};
            0x2::dynamic_field::add<EffectKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect>(&mut arg2.id, v2, arg3);
        };
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"items"), arg2.item_type, arg4);
    }

    public fun set_stats(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut ItemTemplate, arg3: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg4: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg5: &0x2::tx_context::TxContext) {
        assert!(!0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&arg2.category) && !0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_cosmetic(&arg2.category), 4502);
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(&arg4);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(&arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&v1)) {
            assert!(*0x1::vector::borrow<u16>(&v1, v2) <= *0x1::vector::borrow<u16>(&v0, v2), 4503);
            v2 = v2 + 1;
        };
        let v3 = StatsMinKey{dummy_field: false};
        if (0x2::dynamic_field::exists<StatsMinKey>(&arg2.id, v3)) {
            let v4 = StatsMinKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<StatsMinKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&mut arg2.id, v4) = arg3;
            let v5 = StatsMaxKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<StatsMaxKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&mut arg2.id, v5) = arg4;
        } else {
            let v6 = StatsMinKey{dummy_field: false};
            0x2::dynamic_field::add<StatsMinKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&mut arg2.id, v6, arg3);
            let v7 = StatsMaxKey{dummy_field: false};
            0x2::dynamic_field::add<StatsMaxKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&mut arg2.id, v7, arg4);
        };
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"items"), arg2.item_type, arg5);
    }

    public fun share_item(arg0: ItemTemplate) {
        0x2::transfer::share_object<ItemTemplate>(arg0);
    }

    public fun stats_max(arg0: &ItemTemplate) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics {
        let v0 = StatsMaxKey{dummy_field: false};
        *0x2::dynamic_field::borrow<StatsMaxKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&arg0.id, v0)
    }

    public fun stats_min(arg0: &ItemTemplate) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics {
        let v0 = StatsMinKey{dummy_field: false};
        *0x2::dynamic_field::borrow<StatsMinKey, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&arg0.id, v0)
    }

    public fun template_category(arg0: &ItemTemplate) : 0x1::string::String {
        arg0.category
    }

    public fun template_id(arg0: &ItemTemplate) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun template_level(arg0: &ItemTemplate) : u8 {
        arg0.level
    }

    public fun template_name(arg0: &ItemTemplate) : 0x1::string::String {
        arg0.name
    }

    public fun template_type(arg0: &ItemTemplate) : 0x1::string::String {
        arg0.item_type
    }

    // decompiled from Move bytecode v7
}

