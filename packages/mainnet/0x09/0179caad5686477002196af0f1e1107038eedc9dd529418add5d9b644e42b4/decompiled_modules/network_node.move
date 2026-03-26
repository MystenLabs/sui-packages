module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node {
    struct OfflineAssemblies {
        assembly_ids: vector<0x2::object::ID>,
    }

    struct HandleOrphanedAssemblies {
        assembly_ids: vector<0x2::object::ID>,
    }

    struct UpdateEnergySources {
        assembly_ids: vector<0x2::object::ID>,
    }

    struct NetworkNode has key {
        id: 0x2::object::UID,
        key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        owner_cap_id: 0x2::object::ID,
        type_id: u64,
        status: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::AssemblyStatus,
        location: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::Location,
        fuel: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::Fuel,
        energy_source: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergySource,
        metadata: 0x1::option::Option<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>,
        connected_assembly_ids: vector<0x2::object::ID>,
    }

    struct NetworkNodeCreatedEvent has copy, drop {
        network_node_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        owner_cap_id: 0x2::object::ID,
        type_id: u64,
        fuel_max_capacity: u64,
        fuel_burn_rate_in_ms: u64,
        max_energy_production: u64,
    }

    public fun id(arg0: &NetworkNode) : 0x2::object::ID {
        0x2::object::id<NetworkNode>(arg0)
    }

    public fun need_update(arg0: &NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::FuelConfig, arg2: &0x2::clock::Clock) : bool {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::need_update(&arg0.fuel, arg1, arg2)
    }

    public fun reveal_location(arg0: &NetworkNode, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::LocationRegistry, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg2, arg7);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::reveal_location(arg1, 0x2::object::id<NetworkNode>(arg0), arg0.key, arg0.type_id, arg0.owner_cap_id, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::hash(&arg0.location), arg3, arg4, arg5, arg6);
    }

    public fun anchor(arg0: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::ObjectRegistry, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : NetworkNode {
        assert!(arg4 != 0, 13835059296527712257);
        assert!(arg3 != 0, 13835340775799521283);
        let v0 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::create_key(arg3, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::tenant(arg1));
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::object_exists(arg0, v0), 13835622267956232197);
        let v1 = 0x2::derived_object::claim<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId>(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::borrow_registry_id(arg0), v0);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::create_owner_cap_by_id<NetworkNode>(v2, arg2, arg9);
        let v4 = 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<NetworkNode>>(&v3);
        let v5 = NetworkNode{
            id                     : v1,
            key                    : v0,
            owner_cap_id           : v4,
            type_id                : arg4,
            status                 : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::anchor(v2, v0),
            location               : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::attach(arg5),
            fuel                   : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::create(arg6, arg7),
            energy_source          : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::create(arg8),
            metadata               : 0x1::option::some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::create_metadata(v2, v0, 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""))),
            connected_assembly_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::transfer_owner_cap<NetworkNode>(v3, 0x2::object::id_address<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character>(arg1));
        let v6 = NetworkNodeCreatedEvent{
            network_node_id       : v2,
            assembly_key          : v0,
            owner_cap_id          : v4,
            type_id               : arg4,
            fuel_max_capacity     : arg6,
            fuel_burn_rate_in_ms  : arg7,
            max_energy_production : arg8,
        };
        0x2::event::emit<NetworkNodeCreatedEvent>(v6);
        v5
    }

    public(friend) fun borrow_energy_source(arg0: &mut NetworkNode) : &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergySource {
        &mut arg0.energy_source
    }

    public fun connect_assemblies(arg0: &mut NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: vector<0x2::object::ID>, arg3: &0x2::tx_context::TxContext) : UpdateEnergySources {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg3);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v1);
            connect_assembly(arg0, v2);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v2);
            v1 = v1 + 1;
        };
        UpdateEnergySources{assembly_ids: v0}
    }

    public(friend) fun connect_assembly(arg0: &mut NetworkNode, arg1: 0x2::object::ID) {
        assert!(!is_assembly_connected(arg0, arg1), 13836186210047361033);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.connected_assembly_ids, arg1);
    }

    public fun connected_assemblies(arg0: &NetworkNode) : vector<0x2::object::ID> {
        arg0.connected_assembly_ids
    }

    fun copy_connected_assembly_ids(arg0: &NetworkNode) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.connected_assembly_ids)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&arg0.connected_assembly_ids, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun deposit_fuel(arg0: &mut NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<NetworkNode>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<NetworkNode>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<NetworkNode>(arg2, v0), 13835902922594320391);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg7);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::deposit(&mut arg0.fuel, v0, arg0.key, arg3, arg4, arg5, arg6);
    }

    public fun destroy_network_node(arg0: NetworkNode, arg1: HandleOrphanedAssemblies, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg2, arg3);
        let v0 = 0x2::object::id<NetworkNode>(&arg0);
        destroy_orphaned_assemblies(arg1);
        let v1 = copy_connected_assembly_ids(&arg0);
        if (0x1::vector::length<0x2::object::ID>(&v1) > 0) {
            let v2 = &mut arg0;
            disconnect_assemblies(v2, v1);
        };
        let NetworkNode {
            id                     : v3,
            key                    : v4,
            owner_cap_id           : _,
            type_id                : _,
            status                 : v7,
            location               : v8,
            fuel                   : v9,
            energy_source          : v10,
            metadata               : v11,
            connected_assembly_ids : v12,
        } = arg0;
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::delete(v9, v0, v4);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::delete(v10);
        0x1::vector::destroy_empty<0x2::object::ID>(v12);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::remove(v8);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::unanchor(v7, v0, v4);
        let v13 = v11;
        if (0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&v13)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::delete(0x1::option::destroy_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v13));
        } else {
            0x1::option::destroy_none<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v13);
        };
        0x2::object::delete(v3);
    }

    public fun destroy_offline_assemblies(arg0: OfflineAssemblies) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.assembly_ids) == 0, 13836748940957712397);
        let OfflineAssemblies { assembly_ids: v0 } = arg0;
        0x1::vector::destroy_empty<0x2::object::ID>(v0);
    }

    public fun destroy_orphaned_assemblies(arg0: HandleOrphanedAssemblies) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.assembly_ids) == 0, 13837593443197648915);
        let HandleOrphanedAssemblies { assembly_ids: v0 } = arg0;
        0x1::vector::destroy_empty<0x2::object::ID>(v0);
    }

    public fun destroy_update_energy_sources(arg0: UpdateEnergySources) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.assembly_ids) == 0, 13837311929566101521);
        let UpdateEnergySources { assembly_ids: v0 } = arg0;
        0x1::vector::destroy_empty<0x2::object::ID>(v0);
    }

    fun disconnect_assemblies(arg0: &mut NetworkNode, arg1: vector<0x2::object::ID>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            disconnect_assembly(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public(friend) fun disconnect_assembly(arg0: &mut NetworkNode, arg1: 0x2::object::ID) {
        let v0 = &mut arg0.connected_assembly_ids;
        assert!(remove_id_from_assembly_ids(v0, arg1), 13836467710794006539);
    }

    public fun fuel_quantity(arg0: &NetworkNode) : u64 {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::quantity(&arg0.fuel)
    }

    public fun ids_length(arg0: &OfflineAssemblies) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.assembly_ids)
    }

    public fun is_assembly_connected(arg0: &NetworkNode, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.connected_assembly_ids)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.connected_assembly_ids, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_network_node_online(arg0: &NetworkNode) : bool {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status)
    }

    public fun offline(arg0: &mut NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::FuelConfig, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<NetworkNode>, arg3: &0x2::clock::Clock) : OfflineAssemblies {
        let v0 = 0x2::object::id<NetworkNode>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<NetworkNode>(arg2, v0), 13835903081508110343);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13837028985710444559);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::update(&mut arg0.fuel, v0, arg0.key, arg1, arg3);
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::is_burning(&arg0.fuel)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::stop_burning(&mut arg0.fuel, v0, arg0.key, arg1, arg3);
        };
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::current_energy_production(&arg0.energy_source) > 0) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::stop_energy_production(&mut arg0.energy_source, v0);
        };
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::offline(&mut arg0.status, v0, arg0.key);
        OfflineAssemblies{assembly_ids: copy_connected_assembly_ids(arg0)}
    }

    public fun online(arg0: &mut NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<NetworkNode>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<NetworkNode>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<NetworkNode>(arg1, v0), 13835903017083600903);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::start_burning(&mut arg0.fuel, v0, arg0.key, arg2);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::start_energy_production(&mut arg0.energy_source, v0);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::online(&mut arg0.status, v0, arg0.key);
    }

    public fun orphaned_assemblies_length(arg0: &HandleOrphanedAssemblies) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.assembly_ids)
    }

    public fun owner_cap_id(arg0: &NetworkNode) : 0x2::object::ID {
        arg0.owner_cap_id
    }

    public(friend) fun remove_assembly_id(arg0: &mut OfflineAssemblies, arg1: 0x2::object::ID) : bool {
        let v0 = &mut arg0.assembly_ids;
        remove_id_from_assembly_ids(v0, arg1)
    }

    public(friend) fun remove_energy_sources_assembly_id(arg0: &mut UpdateEnergySources, arg1: 0x2::object::ID) : bool {
        let v0 = &mut arg0.assembly_ids;
        remove_id_from_assembly_ids(v0, arg1)
    }

    fun remove_id_from_assembly_ids(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                0x1::vector::remove<0x2::object::ID>(arg0, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun remove_orphaned_assembly_id(arg0: &mut HandleOrphanedAssemblies, arg1: 0x2::object::ID) : bool {
        let v0 = &mut arg0.assembly_ids;
        remove_id_from_assembly_ids(v0, arg1)
    }

    public fun share_network_node(arg0: NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg2);
        0x2::transfer::share_object<NetworkNode>(arg0);
    }

    public fun unanchor(arg0: &mut NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x2::tx_context::TxContext) : HandleOrphanedAssemblies {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg2);
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::current_energy_production(&arg0.energy_source) > 0) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::stop_energy_production(&mut arg0.energy_source, 0x2::object::id<NetworkNode>(arg0));
        };
        HandleOrphanedAssemblies{assembly_ids: copy_connected_assembly_ids(arg0)}
    }

    public fun update_energy_sources_ids_length(arg0: &UpdateEnergySources) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.assembly_ids)
    }

    public fun update_fuel(arg0: &mut NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::FuelConfig, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : OfflineAssemblies {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg2, arg4);
        let v0 = 0x2::object::id<NetworkNode>(arg0);
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::update(&mut arg0.fuel, v0, arg0.key, arg1, arg3);
            if (!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::is_burning(&arg0.fuel)) {
                if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::current_energy_production(&arg0.energy_source) > 0) {
                    0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::stop_energy_production(&mut arg0.energy_source, v0);
                };
                0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::offline(&mut arg0.status, v0, arg0.key);
                return OfflineAssemblies{assembly_ids: copy_connected_assembly_ids(arg0)}
            };
        };
        OfflineAssemblies{assembly_ids: 0x1::vector::empty<0x2::object::ID>()}
    }

    public fun update_metadata_description(arg0: &mut NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<NetworkNode>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<NetworkNode>(arg1, 0x2::object::id<NetworkNode>(arg0)), 13835903240421900295);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13837873569554759701);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_description(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_metadata_name(arg0: &mut NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<NetworkNode>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<NetworkNode>(arg1, 0x2::object::id<NetworkNode>(arg0)), 13835903193177260039);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13837873522310119445);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_name(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_metadata_url(arg0: &mut NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<NetworkNode>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<NetworkNode>(arg1, 0x2::object::id<NetworkNode>(arg0)), 13835903287666540551);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13837873616799399957);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_url(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun withdraw_fuel(arg0: &mut NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<NetworkNode>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<NetworkNode>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<NetworkNode>(arg2, v0), 13835902987018829831);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg5);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::fuel::withdraw(&mut arg0.fuel, v0, arg0.key, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

