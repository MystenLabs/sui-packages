module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_recipe {
    struct Ingredient has copy, drop, store {
        item_type: 0x1::string::String,
        name: 0x1::string::String,
        amount: u64,
    }

    struct ItemTemplate has drop, store {
        name: 0x1::string::String,
        item_category: 0x1::string::String,
        item_set: 0x1::string::String,
        item_type: 0x1::string::String,
        level: u8,
        stats_min: 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::ItemStatistics,
        stats_max: 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::ItemStatistics,
        damages: vector<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_damages::ItemDamages>,
    }

    struct Recipe has store, key {
        id: 0x2::object::UID,
        level: u8,
        ingredients: vector<Ingredient>,
        template: ItemTemplate,
    }

    struct Craft {
        recipe_id: 0x2::object::ID,
        ingredients: vector<Ingredient>,
    }

    struct FinishedCraft has key {
        id: 0x2::object::UID,
        recipe_id: 0x2::object::ID,
    }

    public fun admin_create_ingredient(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Ingredient {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg4);
        Ingredient{
            item_type : arg1,
            name      : arg3,
            amount    : arg2,
        }
    }

    public fun admin_create_recipe(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: u8, arg2: vector<Ingredient>, arg3: ItemTemplate, arg4: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg4);
        let v0 = 0x2::object::new(arg4);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_recipe_create_event(0x2::object::uid_to_inner(&v0));
        let v1 = Recipe{
            id          : v0,
            level       : arg1,
            ingredients : arg2,
            template    : arg3,
        };
        0x2::transfer::share_object<Recipe>(v1);
    }

    public fun admin_create_template(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::ItemStatistics, arg7: 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::ItemStatistics, arg8: vector<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_damages::ItemDamages>, arg9: &mut 0x2::tx_context::TxContext) : ItemTemplate {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg9);
        ItemTemplate{
            name          : arg1,
            item_category : arg2,
            item_set      : arg3,
            item_type     : arg4,
            level         : arg5,
            stats_min     : arg6,
            stats_max     : arg7,
            damages       : arg8,
        }
    }

    public fun admin_delete_recipe(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: Recipe, arg2: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg2);
        let Recipe {
            id          : v0,
            level       : _,
            ingredients : _,
            template    : _,
        } = arg1;
        let v4 = v0;
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_recipe_delete_event(0x2::object::uid_to_inner(&v4));
        0x2::object::delete(v4);
    }

    entry fun craft_item(arg0: &Recipe, arg1: FinishedCraft, arg2: &0x2::random::Random, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &0x2::transfer_policy::TransferPolicy<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>, arg6: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg6);
        let FinishedCraft {
            id        : v0,
            recipe_id : v1,
        } = arg1;
        let v2 = v1;
        0x2::object::delete(v0);
        assert!(&v2 == 0x2::object::uid_as_inner(&arg0.id), 101);
        assert!(0x2::kiosk_extension::is_installed<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::extension::AresRPG>(arg3), 102);
        let v3 = 0x2::random::new_generator(arg2, arg7);
        let v4 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::new(arg0.template.name, arg0.template.item_category, arg0.template.item_set, arg0.template.item_type, arg0.template.level, 1, false, arg7);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::augment_with_stats(&mut v4, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::new(0x2::random::generate_u16_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::vitality(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::vitality(&arg0.template.stats_max)), 0x2::random::generate_u16_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::wisdom(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::wisdom(&arg0.template.stats_max)), 0x2::random::generate_u16_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::strength(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::strength(&arg0.template.stats_max)), 0x2::random::generate_u16_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::intelligence(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::intelligence(&arg0.template.stats_max)), 0x2::random::generate_u16_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::chance(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::chance(&arg0.template.stats_max)), 0x2::random::generate_u16_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::agility(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::agility(&arg0.template.stats_max)), 0x2::random::generate_u8_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::range(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::range(&arg0.template.stats_max)), 0x2::random::generate_u8_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::movement(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::movement(&arg0.template.stats_max)), 0x2::random::generate_u8_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::action(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::action(&arg0.template.stats_max)), 0x2::random::generate_u8_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::critical(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::critical(&arg0.template.stats_max)), 0x2::random::generate_u16_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::raw_damage(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::raw_damage(&arg0.template.stats_max)), 0x2::random::generate_u8_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::critical_chance(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::critical_chance(&arg0.template.stats_max)), 0x2::random::generate_u8_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::critical_outcomes(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::critical_outcomes(&arg0.template.stats_max)), 0x2::random::generate_u8_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::earth_resistance(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::earth_resistance(&arg0.template.stats_max)), 0x2::random::generate_u8_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::fire_resistance(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::fire_resistance(&arg0.template.stats_max)), 0x2::random::generate_u8_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::water_resistance(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::water_resistance(&arg0.template.stats_max)), 0x2::random::generate_u8_in_range(&mut v3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::air_resistance(&arg0.template.stats_min), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats::air_resistance(&arg0.template.stats_max))));
        if (0x1::vector::length<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_damages::ItemDamages>(&arg0.template.damages) > 0) {
            0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_damages::augment_with_damages(&mut v4, arg0.template.damages);
        };
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_item_mint_event(0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(&v4), 0x2::object::id<0x2::kiosk::Kiosk>(arg3));
        0x2::kiosk::lock<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_mut(arg4), arg5, v4);
    }

    public fun prove_all_ingredients_used(arg0: Craft, arg1: &mut 0x2::tx_context::TxContext) {
        let Craft {
            recipe_id   : v0,
            ingredients : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x1::vector::length<Ingredient>(&v2) == 0, 103);
        let v3 = FinishedCraft{
            id        : 0x2::object::new(arg1),
            recipe_id : v0,
        };
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_finished_craft_event(0x2::object::id<FinishedCraft>(&v3), v0);
        0x2::transfer::transfer<FinishedCraft>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun start_craft(arg0: &Recipe, arg1: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version) : Craft {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg1);
        Craft{
            recipe_id   : 0x2::object::uid_to_inner(&arg0.id),
            ingredients : arg0.ingredients,
        }
    }

    public fun use_item_ingredient(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy::AresRPG_TransferPolicy<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>, arg4: &mut Craft, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy::extract_from_kiosk<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg3, arg0, arg1, arg2, arg5);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<Ingredient>(&arg4.ingredients)) {
            let v3 = *0x1::vector::borrow<Ingredient>(&arg4.ingredients, v1);
            if (v3.item_type == 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::item_type(&v0)) {
                assert!(v3.amount == (0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::amount(&v0) as u64), 104);
                v2 = true;
                0x1::vector::remove<Ingredient>(&mut arg4.ingredients, v1);
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 104);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_item_destroy_event(0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(&v0), 0x2::object::id<0x2::kiosk::Kiosk>(arg0));
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::destroy(v0);
    }

    public fun use_token_ingredient<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Craft) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<Ingredient>(&arg1.ingredients)) {
            let v2 = *0x1::vector::borrow<Ingredient>(&arg1.ingredients, v0);
            if (0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::string::to_ascii(0x1::string::sub_string(&v2.item_type, 2, 0x1::string::length(&v2.item_type)))) {
                assert!(0x2::coin::value<T0>(&arg0) == v2.amount, 104);
                0x1::vector::remove<Ingredient>(&mut arg1.ingredients, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 104);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x0);
    }

    // decompiled from Move bytecode v6
}

