module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::customization {
    public(friend) fun customise(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::GameData, arg2: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::render_config::RenderConfig, arg3: u64, arg4: 0x1::option::Option<0x1::string::String>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression_logic::auto_release_if_time_passed(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::wanted_mut(arg0), arg7);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_auth_sig(arg5 > 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::last_nonce(arg0));
        let v0 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item::item_id(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::get_item_by_instance_id(arg0, arg3));
        let v1 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::find_item_by_id(arg1, v0);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_invalid_item(0x1::option::is_some<u64>(&v1));
        let v2 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::utils::build_customization_signed_data(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::character_id(arg0), v0, arg5, &arg4);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_auth_sig(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::utils::verify_ed25519_signature(&arg6, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::render_config::authority_pubkey(arg2), &v2));
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_management::equip_by_slot(arg0, arg1, arg3);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::set_last_nonce(arg0, arg5);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::update_image_url(arg0, arg2, &arg4);
    }

    public(friend) fun customise_local(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::GameData, arg2: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::render_config::RenderConfig, arg3: u64, arg4: &0x2::clock::Clock) {
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression_logic::auto_release_if_time_passed(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::wanted_mut(arg0), arg4);
        let v0 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::find_item_by_id(arg1, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item::item_id(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::get_item_by_instance_id(arg0, arg3)));
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_management::equip_by_slot(arg0, arg1, arg3);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::update_render_url(arg0, arg2);
    }

    public(friend) fun get_equipped_item_ids(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character) : vector<u64> {
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_management::get_equipped_item_ids(arg0)
    }

    // decompiled from Move bytecode v6
}

