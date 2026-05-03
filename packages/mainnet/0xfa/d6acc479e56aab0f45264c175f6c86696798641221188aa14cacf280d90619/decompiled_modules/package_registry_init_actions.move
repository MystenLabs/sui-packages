module 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_init_actions {
    public fun add_add_package_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        assert_metadata_string_len(&arg1);
        assert_action_types_len(&arg4);
        assert_metadata_string_len(&arg5);
        assert_metadata_string_len(&arg6);
        let v0 = 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions::new_add_package_action(arg1, arg2, arg3, arg4, arg5, arg6);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions::AddPackage>(0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions::add_package_marker(), 0x2::bcs::to_bytes<0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions::AddPackageAction>(&v0), 1));
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v1, b"name", arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_address(&mut v1, b"addr", arg2);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v1, b"version", arg3);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_vector_string(&mut v1, b"action_types", &arg4);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v1, b"category", arg5);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v1, b"description", arg6);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v1, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions::AddPackage>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_package_metadata_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        assert_metadata_string_len(&arg1);
        assert_action_types_len(&arg2);
        assert_metadata_string_len(&arg3);
        assert_metadata_string_len(&arg4);
        let v0 = 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions::new_update_package_metadata_action(arg1, arg2, arg3, arg4);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions::UpdatePackageMetadata>(0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions::update_package_metadata_marker(), 0x2::bcs::to_bytes<0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions::UpdatePackageMetadataAction>(&v0), 1));
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v1, b"name", arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_vector_string(&mut v1, b"new_action_types", &arg2);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v1, b"new_category", arg3);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v1, b"new_description", arg4);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v1, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions::UpdatePackageMetadata>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    fun assert_action_types_len(arg0: &vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(arg0) <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_package_registry_action_types(), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            assert_metadata_string_len(0x1::vector::borrow<0x1::string::String>(arg0, v0));
            v0 = v0 + 1;
        };
    }

    fun assert_metadata_string_len(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) <= 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::constants::max_action_data_size(), 2);
    }

    // decompiled from Move bytecode v6
}

