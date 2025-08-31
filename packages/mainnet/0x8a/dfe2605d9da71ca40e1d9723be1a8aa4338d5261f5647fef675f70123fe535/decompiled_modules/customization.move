module 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::customization {
    public(friend) fun customise(arg0: &mut 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::Character, arg1: &0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::game_data::GameData, arg2: &0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::render_config::RenderConfig, arg3: vector<u64>, arg4: 0x1::option::Option<0x1::string::String>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::progression_logic::auto_release_if_time_passed(0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::wanted_mut(arg0), arg7);
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::errors::assert_auth_sig(arg5 > 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::last_nonce(arg0));
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            let v2 = 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::inventory_item::item_id(0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::get_item_by_instance_id(arg0, *0x1::vector::borrow<u64>(&arg3, v1)));
            let v3 = 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::game_data::find_item_by_id(arg1, v2);
            0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::errors::assert_invalid_item(0x1::option::is_some<u64>(&v3));
            0x1::vector::push_back<u64>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v4 = 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::utils::build_customization_set_signed_data(0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::character_id(arg0), v0, arg5, &arg4);
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::errors::assert_auth_sig(0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::utils::verify_ed25519_signature(&arg6, 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::render_config::authority_pubkey(arg2), &v4));
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::inventory_management::equip_item_set(arg0, arg1, arg3);
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::set_last_nonce(arg0, arg5);
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::update_image_url(arg0, arg2, &arg4);
    }

    public(friend) fun customise_local(arg0: &mut 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::Character, arg1: &0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::game_data::GameData, arg2: &0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::render_config::RenderConfig, arg3: vector<u64>, arg4: &0x2::clock::Clock) {
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::progression_logic::auto_release_if_time_passed(0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::wanted_mut(arg0), arg4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg3)) {
            let v1 = 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::game_data::find_item_by_id(arg1, 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::inventory_item::item_id(0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::get_item_by_instance_id(arg0, *0x1::vector::borrow<u64>(&arg3, v0))));
            0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::errors::assert_invalid_item(0x1::option::is_some<u64>(&v1));
            v0 = v0 + 1;
        };
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::inventory_management::equip_item_set(arg0, arg1, arg3);
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::update_render_url(arg0, arg2);
    }

    public(friend) fun get_equipped_item_ids(arg0: &0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::Character) : vector<u64> {
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::inventory_management::get_equipped_item_ids(arg0)
    }

    // decompiled from Move bytecode v6
}

