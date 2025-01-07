module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::attest_token {
    public fun attest_token<T0>(arg0: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u32) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::assert_latest_only(arg0);
        let v1 = serialize_asset_meta<T0>(&v0, arg0, arg1);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::prepare_wormhole_message(&v0, arg0, arg2, v1)
    }

    fun serialize_asset_meta<T0>(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::LatestOnly, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &0x2::coin::CoinMetadata<T0>) : vector<u8> {
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::borrow_token_registry(arg1);
        if (0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::has<T0>(v0)) {
            let v1 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::verified_asset<T0>(v0);
            assert!(!0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::is_wrapped<T0>(&v1), 0);
        } else {
            assert!(!0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::create_wrapped::incomplete_metadata<T0>(arg2), 1);
            0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::add_new_native<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::borrow_mut_token_registry(arg0, arg1), arg2);
        };
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::asset_meta::serialize(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::asset_meta::from_metadata<T0>(arg2))
    }

    // decompiled from Move bytecode v6
}

