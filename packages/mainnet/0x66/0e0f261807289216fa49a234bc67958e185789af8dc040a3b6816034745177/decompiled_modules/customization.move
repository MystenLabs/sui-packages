module 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::customization {
    public(friend) fun auto_decline_pending(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData) {
        let v0 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::pending_item_mut(arg0);
        if (0x1::option::is_some<u64>(v0)) {
            let v1 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::get_item_by_id_mut(arg1, 0x1::option::extract<u64>(v0));
            0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_invalid_item(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_current_count(v1) > 0);
            0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::decrement_current_count(v1);
        };
    }

    public entry fun customise(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_image_too_large(0x1::vector::length<u8>(&arg3) < 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::max_image_size());
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_auth_sig(arg4 > 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::last_nonce(arg0));
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_no_pending(0x1::option::is_some<u64>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::get_pending(arg0)));
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_invalid_item(*0x1::option::borrow<u64>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::get_pending(arg0)) == arg2);
        let v0 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::find_item_by_id(arg1, arg2);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        let v1 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::utils::build_customization_signed_data(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::character_id(arg0), arg2, arg4, &arg3);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_auth_sig(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::utils::verify_ed25519_signature(&arg5, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::authority_pubkey(arg0), &v1));
        let v2 = 0;
        let v3 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::equipped_items_mut(arg0);
        while (v2 < 0x1::vector::length<u64>(v3)) {
            let v4 = *0x1::vector::borrow<u64>(v3, v2);
            let v5 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::find_item_by_id(arg1, v4);
            if (0x1::option::is_some<u64>(&v5)) {
                if (0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_type_id(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::get_item_by_id(arg1, v4)) == 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_type_id(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::get_item_by_id(arg1, arg2))) {
                    0x1::vector::remove<u64>(v3, v2);
                    let v6 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::get_item_by_id_mut(arg1, v4);
                    0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_invalid_item(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_current_count(v6) > 0);
                    0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::decrement_current_count(v6);
                    break
                };
            };
            v2 = v2 + 1;
        };
        0x1::vector::push_back<u64>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::equipped_items_mut(arg0), arg2);
        0x1::option::extract<u64>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::pending_item_mut(arg0));
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::set_last_nonce(arg0, arg4);
        *0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::image_bytes_mut(arg0) = arg3;
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::update_render_url(arg0);
    }

    public entry fun decline_pending(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData, arg2: u64) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_no_pending(0x1::option::is_some<u64>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::get_pending(arg0)));
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_invalid_item(*0x1::option::borrow<u64>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::get_pending(arg0)) == arg2);
        let v0 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::get_item_by_id_mut(arg1, 0x1::option::extract<u64>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::pending_item_mut(arg0)));
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_invalid_item(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_current_count(v0) > 0);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::decrement_current_count(v0);
    }

    // decompiled from Move bytecode v6
}

