module 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::customization {
    public(friend) fun auto_decline_pending(arg0: &mut 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::Character, arg1: &mut 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::GameData) {
        let v0 = 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::pending_item_mut(arg0);
        if (0x1::option::is_some<u64>(v0)) {
            let v1 = 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::get_item_by_id_mut(arg1, 0x1::option::extract<u64>(v0));
            0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_invalid_item(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::item_types::item_info_current_count(v1) > 0);
            0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::item_types::decrement_current_count(v1);
        };
    }

    public entry fun customise(arg0: &mut 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::Character, arg1: &mut 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::GameData, arg2: &0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::render_config::RenderConfig, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>) {
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_image_too_large(0x1::vector::length<u8>(&arg4) < 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::constants::max_image_size());
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_auth_sig(arg5 > 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::last_nonce(arg0));
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_no_pending(0x1::option::is_some<u64>(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::get_pending(arg0)));
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_invalid_item(*0x1::option::borrow<u64>(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::get_pending(arg0)) == arg3);
        let v0 = 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::find_item_by_id(arg1, arg3);
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        let v1 = 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::utils::build_customization_signed_data(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::character_id(arg0), arg3, arg5, &arg4);
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_auth_sig(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::utils::verify_ed25519_signature(&arg6, 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::authority_pubkey(arg0), &v1));
        let v2 = 0;
        let v3 = 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::equipped_items_mut(arg0);
        while (v2 < 0x1::vector::length<u64>(v3)) {
            let v4 = *0x1::vector::borrow<u64>(v3, v2);
            let v5 = 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::find_item_by_id(arg1, v4);
            if (0x1::option::is_some<u64>(&v5)) {
                if (0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::item_types::item_info_type_id(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::get_item_by_id(arg1, v4)) == 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::item_types::item_info_type_id(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::get_item_by_id(arg1, arg3))) {
                    0x1::vector::remove<u64>(v3, v2);
                    let v6 = 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::get_item_by_id_mut(arg1, v4);
                    0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_invalid_item(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::item_types::item_info_current_count(v6) > 0);
                    0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::item_types::decrement_current_count(v6);
                    break
                };
            };
            v2 = v2 + 1;
        };
        0x1::vector::push_back<u64>(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::equipped_items_mut(arg0), arg3);
        0x1::option::extract<u64>(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::pending_item_mut(arg0));
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::set_last_nonce(arg0, arg5);
        *0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::image_bytes_mut(arg0) = arg4;
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::update_render_url(arg0, arg2);
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::update_attributes(arg0, arg1);
    }

    public entry fun decline_pending(arg0: &mut 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::Character, arg1: &mut 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::GameData, arg2: u64) {
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_no_pending(0x1::option::is_some<u64>(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::get_pending(arg0)));
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_invalid_item(*0x1::option::borrow<u64>(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::get_pending(arg0)) == arg2);
        let v0 = 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::get_item_by_id_mut(arg1, 0x1::option::extract<u64>(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::pending_item_mut(arg0)));
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_invalid_item(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::item_types::item_info_current_count(v0) > 0);
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::item_types::decrement_current_count(v0);
    }

    // decompiled from Move bytecode v6
}

