module 0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::package_registry_init_actions {
    struct AddPackageAction has drop, store {
        name: 0x1::string::String,
        addr: address,
        version: u64,
        action_types: vector<0x1::string::String>,
        category: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct UpdatePackageVersionAction has drop, store {
        name: 0x1::string::String,
        addr: address,
        version: u64,
    }

    struct UpdatePackageMetadataAction has drop, store {
        name: 0x1::string::String,
        new_action_types: vector<0x1::string::String>,
        new_category: 0x1::string::String,
        new_description: 0x1::string::String,
    }

    public fun add_add_package_spec(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        let v0 = AddPackageAction{
            name         : arg1,
            addr         : arg2,
            version      : arg3,
            action_types : arg4,
            category     : arg5,
            description  : arg6,
        };
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::package_registry_actions::AddPackage>(), 0x2::bcs::to_bytes<AddPackageAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v1, b"name", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_address(&mut v1, b"addr", arg2);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u64(&mut v1, b"version", arg3);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_vector_string(&mut v1, b"action_types", &arg4);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v1, b"category", arg5);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v1, b"description", arg6);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::package_registry_actions::AddPackage>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_package_metadata_spec(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = UpdatePackageMetadataAction{
            name             : arg1,
            new_action_types : arg2,
            new_category     : arg3,
            new_description  : arg4,
        };
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::package_registry_actions::UpdatePackageMetadata>(), 0x2::bcs::to_bytes<UpdatePackageMetadataAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v1, b"name", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_vector_string(&mut v1, b"new_action_types", &arg2);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v1, b"new_category", arg3);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v1, b"new_description", arg4);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::package_registry_actions::UpdatePackageMetadata>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_package_version_spec(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: address, arg3: u64) {
        let v0 = UpdatePackageVersionAction{
            name    : arg1,
            addr    : arg2,
            version : arg3,
        };
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::package_registry_actions::UpdatePackageVersion>(), 0x2::bcs::to_bytes<UpdatePackageVersionAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v1, b"name", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_address(&mut v1, b"addr", arg2);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u64(&mut v1, b"version", arg3);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::package_registry_actions::UpdatePackageVersion>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

