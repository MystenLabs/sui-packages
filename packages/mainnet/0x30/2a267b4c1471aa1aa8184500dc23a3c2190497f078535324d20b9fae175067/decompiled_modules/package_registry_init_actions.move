module 0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::package_registry_init_actions {
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

    public fun add_add_package_spec(arg0: &mut 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        let v0 = AddPackageAction{
            name         : arg1,
            addr         : arg2,
            version      : arg3,
            action_types : arg4,
            category     : arg5,
            description  : arg6,
        };
        0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::add(arg0, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::package_registry_actions::AddPackage>(), 0x2::bcs::to_bytes<AddPackageAction>(&v0), 1));
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::new_builder();
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_string(&mut v1, b"name", arg1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_address(&mut v1, b"addr", arg2);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_u64(&mut v1, b"version", arg3);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_vector_string(&mut v1, b"action_types", &arg4);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_string(&mut v1, b"category", arg5);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_string(&mut v1, b"description", arg6);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::emit_action_params(v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_type(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_id(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::package_registry_actions::AddPackage>())), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_package_metadata_spec(arg0: &mut 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = UpdatePackageMetadataAction{
            name             : arg1,
            new_action_types : arg2,
            new_category     : arg3,
            new_description  : arg4,
        };
        0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::add(arg0, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::package_registry_actions::UpdatePackageMetadata>(), 0x2::bcs::to_bytes<UpdatePackageMetadataAction>(&v0), 1));
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::new_builder();
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_string(&mut v1, b"name", arg1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_vector_string(&mut v1, b"new_action_types", &arg2);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_string(&mut v1, b"new_category", arg3);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_string(&mut v1, b"new_description", arg4);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::emit_action_params(v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_type(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_id(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::package_registry_actions::UpdatePackageMetadata>())), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_package_version_spec(arg0: &mut 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: address, arg3: u64) {
        let v0 = UpdatePackageVersionAction{
            name    : arg1,
            addr    : arg2,
            version : arg3,
        };
        0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::add(arg0, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::package_registry_actions::UpdatePackageVersion>(), 0x2::bcs::to_bytes<UpdatePackageVersionAction>(&v0), 1));
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::new_builder();
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_string(&mut v1, b"name", arg1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_address(&mut v1, b"addr", arg2);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_u64(&mut v1, b"version", arg3);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::emit_action_params(v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_type(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_id(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::package_registry_actions::UpdatePackageVersion>())), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

