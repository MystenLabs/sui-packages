module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::assembly {
    struct Assembly has key {
        id: 0x2::object::UID,
        key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        owner_cap_id: 0x2::object::ID,
        type_id: u64,
        status: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::AssemblyStatus,
        location: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::Location,
        energy_source_id: 0x1::option::Option<0x2::object::ID>,
        metadata: 0x1::option::Option<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>,
    }

    struct AssemblyCreatedEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        owner_cap_id: 0x2::object::ID,
        type_id: u64,
    }

    public fun id(arg0: &Assembly) : 0x2::object::ID {
        0x2::object::id<Assembly>(arg0)
    }

    public fun anchor(arg0: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::ObjectRegistry, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : Assembly {
        assert!(arg5 != 0, 13835058862736015361);
        assert!(arg4 != 0, 13835340342007824387);
        let v0 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::create_key(arg4, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::tenant(arg2));
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::object_exists(arg0, v0), 13835621838459502597);
        let v1 = 0x2::derived_object::claim<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId>(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::borrow_registry_id(arg0), v0);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::create_owner_cap_by_id<Assembly>(v2, arg3, arg7);
        let v4 = 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Assembly>>(&v3);
        let v5 = Assembly{
            id               : v1,
            key              : v0,
            owner_cap_id     : v4,
            type_id          : arg5,
            status           : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::anchor(v2, v0),
            location         : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::attach(arg6),
            energy_source_id : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1)),
            metadata         : 0x1::option::some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::create_metadata(v2, v0, 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""))),
        };
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::transfer_owner_cap<Assembly>(v3, 0x2::object::id_address<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character>(arg2));
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::connect_assembly(arg1, v2);
        let v6 = AssemblyCreatedEvent{
            assembly_id  : v2,
            assembly_key : v0,
            owner_cap_id : v4,
            type_id      : arg5,
        };
        0x2::event::emit<AssemblyCreatedEvent>(v6);
        v5
    }

    fun bring_offline_and_release_energy(arg0: &mut Assembly, arg1: 0x2::object::ID, arg2: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::offline(&mut arg0.status, arg1, arg0.key);
            release_energy(arg0, arg2, arg3);
        };
    }

    public fun energy_source_id(arg0: &Assembly) : &0x1::option::Option<0x2::object::ID> {
        &arg0.energy_source_id
    }

    public fun offline(arg0: &mut Assembly, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Assembly>) {
        let v0 = 0x2::object::id<Assembly>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Assembly>(arg3, v0), 13835902845284909063);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.energy_source_id), 13836184333146652681);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.energy_source_id) == 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1), 13836184346031554569);
        release_energy(arg0, arg1, arg2);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::offline(&mut arg0.status, v0, arg0.key);
    }

    public fun offline_connected_assembly(arg0: &mut Assembly, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::OfflineAssemblies, arg2: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::OfflineAssemblies {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::ids_length(&arg1) > 0) {
            let v0 = 0x2::object::id<Assembly>(arg0);
            if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::remove_assembly_id(&mut arg1, v0)) {
                bring_offline_and_release_energy(arg0, v0, arg2, arg3);
            };
        };
        arg1
    }

    public fun offline_orphaned_assembly(arg0: &mut Assembly, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::HandleOrphanedAssemblies, arg2: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::HandleOrphanedAssemblies {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::orphaned_assemblies_length(&arg1) > 0) {
            let v0 = 0x2::object::id<Assembly>(arg0);
            if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::remove_orphaned_assembly_id(&mut arg1, v0)) {
                bring_offline_and_release_energy(arg0, v0, arg2, arg3);
                arg0.energy_source_id = 0x1::option::none<0x2::object::ID>();
            };
        };
        arg1
    }

    public fun online(arg0: &mut Assembly, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Assembly>) {
        let v0 = 0x2::object::id<Assembly>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Assembly>(arg3, v0), 13835902767975497735);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.energy_source_id), 13836184247247306761);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.energy_source_id) == 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1), 13836184260132208649);
        reserve_energy(arg0, arg1, arg2);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::online(&mut arg0.status, v0, arg0.key);
    }

    public fun owner_cap_id(arg0: &Assembly) : 0x2::object::ID {
        arg0.owner_cap_id
    }

    fun release_energy(arg0: &Assembly, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) {
        release_energy_by_type(arg1, arg2, arg0.type_id);
    }

    fun release_energy_by_type(arg0: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg2: u64) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::release_energy(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::borrow_energy_source(arg0), 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg0), arg1, arg2);
    }

    fun reserve_energy(arg0: &Assembly, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::reserve_energy(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::borrow_energy_source(arg1), 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1), arg2, arg0.type_id);
    }

    public fun reveal_location(arg0: &Assembly, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::LocationRegistry, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg2, arg7);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::reveal_location(arg1, 0x2::object::id<Assembly>(arg0), arg0.key, arg0.type_id, arg0.owner_cap_id, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::hash(&arg0.location), arg3, arg4, arg5, arg6);
    }

    public fun share_assembly(arg0: Assembly, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg2);
        0x2::transfer::share_object<Assembly>(arg0);
    }

    public fun status(arg0: &Assembly) : &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::AssemblyStatus {
        &arg0.status
    }

    public fun unanchor(arg0: Assembly, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg4: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg3, arg4);
        let Assembly {
            id               : v0,
            key              : v1,
            owner_cap_id     : _,
            type_id          : v3,
            status           : v4,
            location         : v5,
            energy_source_id : v6,
            metadata         : v7,
        } = arg0;
        let v8 = v6;
        let v9 = v4;
        let v10 = v0;
        assert!(0x1::option::is_some<0x2::object::ID>(&v8), 13836185402593509385);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v8) == 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1), 13836185415478411273);
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&v9)) {
            release_energy_by_type(arg1, arg2, v3);
        };
        let v11 = 0x2::object::uid_to_inner(&v10);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::disconnect_assembly(arg1, v11);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::remove(v5);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::unanchor(v9, v11, v1);
        let v12 = v7;
        if (0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&v12)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::delete(0x1::option::destroy_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v12));
        } else {
            0x1::option::destroy_none<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v12);
        };
        0x1::option::destroy_with_default<0x2::object::ID>(v8, 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1));
        0x2::object::delete(v10);
    }

    public fun unanchor_orphan(arg0: Assembly, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg2);
        let Assembly {
            id               : v0,
            key              : v1,
            owner_cap_id     : _,
            type_id          : _,
            status           : v4,
            location         : v5,
            energy_source_id : v6,
            metadata         : v7,
        } = arg0;
        let v8 = v6;
        let v9 = v4;
        let v10 = v0;
        assert!(0x1::option::is_none<0x2::object::ID>(&v8), 13836748524345884685);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&v9), 13836467053664010251);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::remove(v5);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::unanchor(v9, 0x2::object::uid_to_inner(&v10), v1);
        let v11 = v7;
        if (0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&v11)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::delete(0x1::option::destroy_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v11));
        } else {
            0x1::option::destroy_none<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v11);
        };
        0x1::option::destroy_none<0x2::object::ID>(v8);
        0x2::object::delete(v10);
    }

    public fun update_energy_source(arg0: &mut Assembly, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg2, arg3);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836466512498130955);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::connect_assembly(arg1, 0x2::object::id<Assembly>(arg0));
        arg0.energy_source_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1));
    }

    public fun update_energy_source_connected_assembly(arg0: &mut Assembly, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::UpdateEnergySources, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::UpdateEnergySources {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::update_energy_sources_ids_length(&arg1) > 0) {
            if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::remove_energy_sources_assembly_id(&mut arg1, 0x2::object::id<Assembly>(arg0))) {
                assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836466594102509579);
                arg0.energy_source_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg2));
            };
        };
        arg1
    }

    public fun update_metadata_description(arg0: &mut Assembly, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Assembly>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Assembly>(arg1, 0x2::object::id<Assembly>(arg0)), 13835902969838960647);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13837028874041294863);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_description(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_metadata_name(arg0: &mut Assembly, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Assembly>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Assembly>(arg1, 0x2::object::id<Assembly>(arg0)), 13835902922594320391);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13837028826796654607);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_name(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_metadata_url(arg0: &mut Assembly, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Assembly>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Assembly>(arg1, 0x2::object::id<Assembly>(arg0)), 13835903017083600903);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13837028921285935119);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_url(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    // decompiled from Move bytecode v6
}

