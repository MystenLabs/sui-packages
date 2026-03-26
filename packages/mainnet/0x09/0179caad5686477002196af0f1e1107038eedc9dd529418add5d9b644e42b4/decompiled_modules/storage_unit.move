module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::storage_unit {
    struct StorageUnit has key {
        id: 0x2::object::UID,
        key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        owner_cap_id: 0x2::object::ID,
        type_id: u64,
        status: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::AssemblyStatus,
        location: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::Location,
        inventory_keys: vector<0x2::object::ID>,
        energy_source_id: 0x1::option::Option<0x2::object::ID>,
        metadata: 0x1::option::Option<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>,
        extension: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct StorageUnitCreatedEvent has copy, drop {
        storage_unit_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        owner_cap_id: 0x2::object::ID,
        type_id: u64,
        max_capacity: u64,
        location_hash: vector<u8>,
        status: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::Status,
    }

    struct ExtensionAuthorizedEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        extension_type: 0x1::type_name::TypeName,
        previous_extension: 0x1::option::Option<0x1::type_name::TypeName>,
        owner_cap_id: 0x2::object::ID,
    }

    struct ExtensionRevokedEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        revoked_extension: 0x1::type_name::TypeName,
        owner_cap_id: 0x2::object::ID,
    }

    public fun id(arg0: &StorageUnit) : 0x2::object::ID {
        0x2::object::id<StorageUnit>(arg0)
    }

    public fun owner_cap_id(arg0: &StorageUnit) : 0x2::object::ID {
        arg0.owner_cap_id
    }

    fun release_energy(arg0: &StorageUnit, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) {
        release_energy_by_type(arg1, arg2, arg0.type_id);
    }

    fun reserve_energy(arg0: &StorageUnit, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::reserve_energy(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::borrow_energy_source(arg1), 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1), arg2, arg0.type_id);
    }

    public fun freeze_extension_config(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>) {
        let v0 = 0x2::object::id<StorageUnit>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<StorageUnit>(arg1, v0), 13835903133047717895);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.extension), 13838999362087944221);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::is_extension_frozen(&arg0.id), 13838717891406069787);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::freeze_extension_config(&mut arg0.id, v0);
    }

    public fun is_extension_frozen(arg0: &StorageUnit) : bool {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::is_extension_frozen(&arg0.id)
    }

    public fun inventory(arg0: &StorageUnit, arg1: 0x2::object::ID) : &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory {
        0x2::dynamic_field::borrow<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&arg0.id, arg1)
    }

    public fun deposit_item<T0: drop>(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Item, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<StorageUnit>(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&arg0.extension, &v1), 13836185089060896777);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836748047604514829);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::tenant(&arg2) == 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::tenant(&arg0.key), 13837029526876323855);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::parent_id(&arg2) == v0, 13838155431078658071);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::deposit_item(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, arg0.owner_cap_id), v0, arg0.key, arg1, arg2);
    }

    public fun withdraw_item<T0: drop>(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg2: T0, arg3: u64, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Item {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&arg0.extension, &v0), 13836185209319981065);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836748167863599117);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::withdraw_item(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, arg0.owner_cap_id), 0x2::object::id<StorageUnit>(arg0), arg0.key, arg1, arg3, arg4, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::hash(&arg0.location), arg5)
    }

    public fun location(arg0: &StorageUnit) : &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::Location {
        &arg0.location
    }

    public fun reveal_location(arg0: &StorageUnit, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::LocationRegistry, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg2, arg7);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::reveal_location(arg1, 0x2::object::id<StorageUnit>(arg0), arg0.key, arg0.type_id, arg0.owner_cap_id, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::hash(&arg0.location), arg3, arg4, arg5, arg6);
    }

    public fun status(arg0: &StorageUnit) : &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::AssemblyStatus {
        &arg0.status
    }

    public fun anchor(arg0: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::ObjectRegistry, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : StorageUnit {
        assert!(arg5 != 0, 13835060597902802945);
        assert!(arg4 != 0, 13835342077174611971);
        let v0 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::create_key(arg4, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::tenant(arg2));
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::object_exists(arg0, v0), 13835623565036355589);
        let v1 = 0x2::derived_object::claim<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId>(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::borrow_registry_id(arg0), v0);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::create_owner_cap_by_id<StorageUnit>(v2, arg3, arg8);
        let v4 = 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>>(&v3);
        let v5 = StorageUnit{
            id               : v1,
            key              : v0,
            owner_cap_id     : v4,
            type_id          : arg5,
            status           : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::anchor(v2, v0),
            location         : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::attach(arg7),
            inventory_keys   : 0x1::vector::empty<0x2::object::ID>(),
            energy_source_id : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1)),
            metadata         : 0x1::option::some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::create_metadata(v2, v0, 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""))),
            extension        : 0x1::option::none<0x1::type_name::TypeName>(),
        };
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::transfer_owner_cap<StorageUnit>(v3, 0x2::object::id_address<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character>(arg2));
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::connect_assembly(arg1, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut v5.inventory_keys, v4);
        0x2::dynamic_field::add<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut v5.id, v4, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::create(arg6));
        let v6 = open_storage_key_from_id(v2);
        0x1::vector::push_back<0x2::object::ID>(&mut v5.inventory_keys, v6);
        0x2::dynamic_field::add<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut v5.id, v6, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::create(arg6));
        let v7 = StorageUnitCreatedEvent{
            storage_unit_id : v2,
            assembly_key    : v0,
            owner_cap_id    : v4,
            type_id         : arg5,
            max_capacity    : arg6,
            location_hash   : arg7,
            status          : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::status(&v5.status),
        };
        0x2::event::emit<StorageUnitCreatedEvent>(v7);
        v5
    }

    public fun offline(arg0: &mut StorageUnit, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>) {
        let v0 = 0x2::object::id<StorageUnit>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<StorageUnit>(arg3, v0), 13835903356386017287);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.energy_source_id), 13837310744155127825);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.energy_source_id) == 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1), 13837310757040029713);
        release_energy(arg0, arg1, arg2);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::offline(&mut arg0.status, v0, arg0.key);
    }

    public fun online(arg0: &mut StorageUnit, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>) {
        let v0 = 0x2::object::id<StorageUnit>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<StorageUnit>(arg3, v0), 13835903279076605959);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.energy_source_id), 13837310658255781905);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.energy_source_id) == 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1), 13837310671140683793);
        reserve_energy(arg0, arg1, arg2);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::online(&mut arg0.status, v0, arg0.key);
    }

    public fun unanchor(arg0: StorageUnit, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg4: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg3, arg4);
        let StorageUnit {
            id               : v0,
            key              : v1,
            owner_cap_id     : _,
            type_id          : v3,
            status           : v4,
            location         : v5,
            inventory_keys   : v6,
            energy_source_id : v7,
            metadata         : v8,
            extension        : _,
        } = arg0;
        let v10 = v7;
        let v11 = v4;
        let v12 = v0;
        assert!(0x1::option::is_some<0x2::object::ID>(&v10), 13837313157926748177);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v10) == 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1), 13837313162221715473);
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&v11)) {
            release_energy_by_type(arg1, arg2, v3);
        };
        let v13 = 0x2::object::uid_to_inner(&v12);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::disconnect_assembly(arg1, v13);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::unanchor(v11, v13, v1);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::remove(v5);
        let v14 = v6;
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x2::object::ID>(&v14)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::delete(0x2::dynamic_field::remove<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut v12, 0x1::vector::pop_back<0x2::object::ID>(&mut v14)), v13, v1);
            v15 = v15 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v14);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::remove_frozen_marker_if_present(&mut v12);
        let v16 = v8;
        if (0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&v16)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::delete(0x1::option::destroy_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v16));
        } else {
            0x1::option::destroy_none<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v16);
        };
        0x1::option::destroy_with_default<0x2::object::ID>(v10, 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1));
        0x2::object::delete(v12);
    }

    public fun authorize_extension<T0: drop>(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>) {
        let v0 = 0x2::object::id<StorageUnit>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<StorageUnit>(arg1, v0), 13835903047148371975);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::is_extension_frozen(&arg0.id), 13838717801211756571);
        0x1::option::swap_or_fill<0x1::type_name::TypeName>(&mut arg0.extension, 0x1::type_name::with_defining_ids<T0>());
        let v1 = ExtensionAuthorizedEvent{
            assembly_id        : v0,
            assembly_key       : arg0.key,
            extension_type     : 0x1::type_name::with_defining_ids<T0>(),
            previous_extension : arg0.extension,
            owner_cap_id       : 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>>(arg1),
        };
        0x2::event::emit<ExtensionAuthorizedEvent>(v1);
    }

    fun bring_offline_and_release_energy(arg0: &mut StorageUnit, arg1: 0x2::object::ID, arg2: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::offline(&mut arg0.status, arg1, arg0.key);
            release_energy(arg0, arg2, arg3);
        };
    }

    public fun chain_item_to_game_inventory<T0: key>(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::ServerAddressRegistry, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>, arg4: u64, arg5: u32, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::character_address(arg2) == 0x2::tx_context::sender(arg8), 13837873792893059093);
        check_inventory_authorization<T0>(arg3, arg0, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::id(arg2));
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836747905870594061);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::burn_items_with_proof(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>>(arg3)), 0x2::object::id<StorageUnit>(arg0), arg0.key, arg2, arg1, &arg0.location, arg6, arg4, arg5, arg7, arg8);
    }

    fun check_inventory_authorization<T0: key>(arg0: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>, arg1: &StorageUnit, arg2: 0x2::object::ID) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (v0 == 0x1::type_name::with_defining_ids<StorageUnit>()) {
            assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<T0>(arg0, 0x2::object::id<StorageUnit>(arg1)), 13836469553334976523);
        } else {
            assert!(v0 == 0x1::type_name::with_defining_ids<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character>(), 13836469570514845707);
            assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<T0>(arg0, arg2), 13836469561924911115);
        };
    }

    public fun deposit_by_owner<T0: key>(arg0: &mut StorageUnit, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Item, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::character_address(arg2) == 0x2::tx_context::sender(arg4), 13837874639001616405);
        let v0 = 0x2::object::id<StorageUnit>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836748751979151373);
        check_inventory_authorization<T0>(arg3, arg0, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::id(arg2));
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::tenant(&arg1) == 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::tenant(&arg0.key), 13837030235545927695);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::parent_id(&arg1) == v0, 13838156139748261911);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::deposit_item(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>>(arg3)), v0, arg0.key, arg2, arg1);
    }

    public fun deposit_to_open_inventory<T0: drop>(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Item, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<StorageUnit>(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&arg0.extension, &v1), 13836185351053901833);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836748309597519885);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::tenant(&arg2) == 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::tenant(&arg0.key), 13837029788869328911);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::parent_id(&arg2) == v0, 13838155693071663127);
        ensure_open_inventory(arg0);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::deposit_item(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, open_storage_key(arg0)), v0, arg0.key, arg1, arg2);
    }

    public fun deposit_to_owned<T0: drop>(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Item, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<StorageUnit>(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&arg0.extension, &v1), 13836185625931808777);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836748584475426829);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::tenant(&arg2) == 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::tenant(&arg0.key), 13837030063747235855);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::tenant(arg1) == 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::tenant(&arg0.key), 13837030068042203151);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::parent_id(&arg2) == v0, 13838155972244537367);
        let v2 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::owner_cap_id(arg1);
        if (!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, v2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.inventory_keys, v2);
            0x2::dynamic_field::add<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, v2, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::create(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::max_capacity(0x2::dynamic_field::borrow<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&arg0.id, arg0.owner_cap_id))));
        };
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::deposit_item(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, v2), v0, arg0.key, arg1, arg2);
    }

    public fun energy_source_id(arg0: &StorageUnit) : &0x1::option::Option<0x2::object::ID> {
        &arg0.energy_source_id
    }

    fun ensure_open_inventory(arg0: &mut StorageUnit) {
        let v0 = open_storage_key(arg0);
        if (!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.inventory_keys, v0);
            0x2::dynamic_field::add<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, v0, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::create(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::max_capacity(0x2::dynamic_field::borrow<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&arg0.id, arg0.owner_cap_id))));
        };
    }

    public fun game_item_to_chain_inventory<T0: key>(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::character_address(arg2) == 0x2::tx_context::sender(arg8), 13837876404233175061);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg8);
        let v0 = 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>>(arg3);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836750521505677325);
        check_inventory_authorization<T0>(arg3, arg0, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::id(arg2));
        if (!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.inventory_keys, v0);
            0x2::dynamic_field::add<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, v0, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::create(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::max_capacity(0x2::dynamic_field::borrow<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&arg0.id, arg0.owner_cap_id))));
        };
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::mint_items(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, v0), 0x2::object::id<StorageUnit>(arg0), arg0.key, arg2, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::tenant(&arg0.key), arg4, arg5, arg6, arg7);
    }

    public fun has_open_storage(arg0: &StorageUnit) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, open_storage_key(arg0))
    }

    public fun offline_connected_storage_unit(arg0: &mut StorageUnit, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::OfflineAssemblies, arg2: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::OfflineAssemblies {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::ids_length(&arg1) > 0) {
            let v0 = 0x2::object::id<StorageUnit>(arg0);
            if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::remove_assembly_id(&mut arg1, v0)) {
                bring_offline_and_release_energy(arg0, v0, arg2, arg3);
            };
        };
        arg1
    }

    public fun offline_orphaned_storage_unit(arg0: &mut StorageUnit, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::HandleOrphanedAssemblies, arg2: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::HandleOrphanedAssemblies {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::orphaned_assemblies_length(&arg1) > 0) {
            let v0 = 0x2::object::id<StorageUnit>(arg0);
            if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::remove_orphaned_assembly_id(&mut arg1, v0)) {
                bring_offline_and_release_energy(arg0, v0, arg2, arg3);
                arg0.energy_source_id = 0x1::option::none<0x2::object::ID>();
            };
        };
        arg1
    }

    public fun open_storage_key(arg0: &StorageUnit) : 0x2::object::ID {
        open_storage_key_from_id(0x2::object::id<StorageUnit>(arg0))
    }

    fun open_storage_key_from_id(arg0: 0x2::object::ID) : 0x2::object::ID {
        let v0 = 0x1::bcs::to_bytes<0x2::object::ID>(&arg0);
        0x1::vector::append<u8>(&mut v0, b"open_inventory");
        0x2::object::id_from_address(0x2::address::from_bytes(0x2::hash::blake2b256(&v0)))
    }

    fun release_energy_by_type(arg0: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg2: u64) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::release_energy(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::borrow_energy_source(arg0), 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg0), arg1, arg2);
    }

    public fun revoke_extension_authorization(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>) {
        let v0 = 0x2::object::id<StorageUnit>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<StorageUnit>(arg1, v0), 13835903188882292743);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::is_extension_frozen(&arg0.id), 13838717942945677339);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.extension), 13839562372171169825);
        arg0.extension = 0x1::option::none<0x1::type_name::TypeName>();
        let v1 = ExtensionRevokedEvent{
            assembly_id       : v0,
            assembly_key      : arg0.key,
            revoked_extension : 0x1::option::destroy_some<0x1::type_name::TypeName>(arg0.extension),
            owner_cap_id      : 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>>(arg1),
        };
        0x2::event::emit<ExtensionRevokedEvent>(v1);
    }

    public fun share_storage_unit(arg0: StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg2);
        0x2::transfer::share_object<StorageUnit>(arg0);
    }

    public fun unanchor_orphan(arg0: StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg2);
        let StorageUnit {
            id               : v0,
            key              : v1,
            owner_cap_id     : _,
            type_id          : _,
            status           : v4,
            location         : v5,
            inventory_keys   : v6,
            energy_source_id : v7,
            metadata         : v8,
            extension        : _,
        } = arg0;
        let v10 = v0;
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::remove(v5);
        let v11 = 0x2::object::uid_to_inner(&v10);
        let v12 = v6;
        let v13 = 0;
        while (v13 < 0x1::vector::length<0x2::object::ID>(&v12)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::delete(0x2::dynamic_field::remove<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut v10, 0x1::vector::pop_back<0x2::object::ID>(&mut v12)), v11, v1);
            v13 = v13 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v12);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::unanchor(v4, v11, v1);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::remove_frozen_marker_if_present(&mut v10);
        let v14 = v8;
        if (0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&v14)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::delete(0x1::option::destroy_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v14));
        } else {
            0x1::option::destroy_none<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v14);
        };
        0x1::option::destroy_none<0x2::object::ID>(v7);
        0x2::object::delete(v10);
    }

    public fun update_energy_source(arg0: &mut StorageUnit, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg2, arg3);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13837594203406860307);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::connect_assembly(arg1, 0x2::object::id<StorageUnit>(arg0));
        arg0.energy_source_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1));
    }

    public fun update_energy_source_connected_storage_unit(arg0: &mut StorageUnit, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::UpdateEnergySources, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::UpdateEnergySources {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::update_energy_sources_ids_length(&arg1) > 0) {
            if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::remove_energy_sources_assembly_id(&mut arg1, 0x2::object::id<StorageUnit>(arg0))) {
                assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13837594285011238931);
                arg0.energy_source_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg2));
            };
        };
        arg1
    }

    public fun update_metadata_description(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<StorageUnit>(arg1, 0x2::object::id<StorageUnit>(arg0)), 13835904601926533127);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13838437881013075993);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_description(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_metadata_name(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<StorageUnit>(arg1, 0x2::object::id<StorageUnit>(arg0)), 13835904554681892871);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13838437833768435737);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_name(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_metadata_url(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<StorageUnit>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<StorageUnit>(arg1, 0x2::object::id<StorageUnit>(arg0)), 13835904649171173383);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13838437928257716249);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_url(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun withdraw_by_owner<T0: key>(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>, arg3: u64, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Item {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::character_address(arg1) == 0x2::tx_context::sender(arg5), 13837874763555667989);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836748876533202957);
        check_inventory_authorization<T0>(arg2, arg0, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::id(arg1));
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::withdraw_item(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<T0>>(arg2)), 0x2::object::id<StorageUnit>(arg0), arg0.key, arg1, arg3, arg4, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::hash(&arg0.location), arg5)
    }

    public fun withdraw_from_open_inventory<T0: drop>(arg0: &mut StorageUnit, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg2: T0, arg3: u64, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Item {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&arg0.extension, &v0), 13836185484197888009);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836748442741506061);
        let v1 = open_storage_key(arg0);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, v1), 13839281726123016223);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::withdraw_item(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::inventory::Inventory>(&mut arg0.id, v1), 0x2::object::id<StorageUnit>(arg0), arg0.key, arg1, arg3, arg4, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::hash(&arg0.location), arg5)
    }

    // decompiled from Move bytecode v6
}

