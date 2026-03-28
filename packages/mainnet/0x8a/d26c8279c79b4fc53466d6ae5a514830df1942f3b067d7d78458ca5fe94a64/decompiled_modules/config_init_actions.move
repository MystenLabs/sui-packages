module 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::config_init_actions {
    struct SetAuthorizationLevelAction has copy, drop, store {
        level: u8,
    }

    struct AddDepAction has copy, drop, store {
        addr: address,
        name: 0x1::string::String,
        version: u64,
    }

    struct RemoveDepAction has copy, drop, store {
        addr: address,
    }

    public fun add_add_dep_spec(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: address, arg2: 0x1::string::String, arg3: u64) {
        assert!(0x1::string::length(&arg2) > 0, 2);
        assert!(arg1 != @0x0, 3);
        let v0 = AddDepAction{
            addr    : arg1,
            name    : arg2,
            version : arg3,
        };
        let v1 = 0x2::bcs::to_bytes<AddDepAction>(&v0);
        assert!(0x1::vector::length<u8>(&v1) <= 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::constants::max_action_data_size(), 4);
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::config::ConfigAddDep>(), v1, 1));
        let v2 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_address(&mut v2, b"addr", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v2, b"name", arg2);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u64(&mut v2, b"version", arg3);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v2, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::config::ConfigAddDep>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_remove_dep_spec(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: address) {
        let v0 = RemoveDepAction{addr: arg1};
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::config::ConfigRemoveDep>(), 0x2::bcs::to_bytes<RemoveDepAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_address(&mut v1, b"addr", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::config::ConfigRemoveDep>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_set_authorization_level_spec(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: u8) {
        assert!(arg1 <= 2, 1);
        let v0 = SetAuthorizationLevelAction{level: arg1};
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::config::ConfigSetAuthorizationLevel>(), 0x2::bcs::to_bytes<SetAuthorizationLevelAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u8(&mut v1, b"level", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::config::ConfigSetAuthorizationLevel>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

