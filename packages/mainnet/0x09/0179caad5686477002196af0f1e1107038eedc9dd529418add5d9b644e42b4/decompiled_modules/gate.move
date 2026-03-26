module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::gate {
    struct GateConfig has key {
        id: 0x2::object::UID,
        max_distance_by_type: 0x2::table::Table<u64, u64>,
    }

    struct Gate has key {
        id: 0x2::object::UID,
        key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        owner_cap_id: 0x2::object::ID,
        type_id: u64,
        linked_gate_id: 0x1::option::Option<0x2::object::ID>,
        status: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::AssemblyStatus,
        location: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::Location,
        energy_source_id: 0x1::option::Option<0x2::object::ID>,
        metadata: 0x1::option::Option<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>,
        extension: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct JumpPermit has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        route_hash: vector<u8>,
        expires_at_timestamp_ms: u64,
    }

    struct GateCreatedEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        owner_cap_id: 0x2::object::ID,
        type_id: u64,
        location_hash: vector<u8>,
        status: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::Status,
    }

    struct GateLinkedEvent has copy, drop {
        source_gate_id: 0x2::object::ID,
        source_gate_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        destination_gate_id: 0x2::object::ID,
        destination_gate_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
    }

    struct GateUnlinkedEvent has copy, drop {
        source_gate_id: 0x2::object::ID,
        source_gate_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        destination_gate_id: 0x2::object::ID,
        destination_gate_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
    }

    struct JumpEvent has copy, drop {
        source_gate_id: 0x2::object::ID,
        source_gate_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        destination_gate_id: 0x2::object::ID,
        destination_gate_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        character_id: 0x2::object::ID,
        character_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
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

    public fun id(arg0: &Gate) : 0x2::object::ID {
        0x2::object::id<Gate>(arg0)
    }

    fun release_energy(arg0: &Gate, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) {
        release_energy_by_type(arg1, arg2, arg0.type_id);
    }

    fun reserve_energy(arg0: &Gate, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::reserve_energy(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::borrow_energy_source(arg1), 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1), arg2, arg0.type_id);
    }

    public fun freeze_extension_config(arg0: &mut Gate, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>) {
        let v0 = 0x2::object::id<Gate>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg1, v0), 13835903223242031111);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.extension), 13840125352189624357);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::is_extension_frozen(&arg0.id), 13839843881507749923);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::freeze_extension_config(&mut arg0.id, v0);
    }

    public fun is_extension_frozen(arg0: &Gate) : bool {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::is_extension_frozen(&arg0.id)
    }

    public fun anchor(arg0: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::ObjectRegistry, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : Gate {
        assert!(arg5 != 0, 13835060585017901057);
        assert!(arg4 != 0, 13835342064289710083);
        let v0 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::create_key(arg4, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::tenant(arg2));
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::object_exists(arg0, v0), 13835623552151453701);
        let v1 = 0x2::derived_object::claim<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId>(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::object_registry::borrow_registry_id(arg0), v0);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::create_owner_cap_by_id<Gate>(v2, arg3, arg7);
        let v4 = 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>>(&v3);
        let v5 = Gate{
            id               : v1,
            key              : v0,
            owner_cap_id     : v4,
            type_id          : arg5,
            linked_gate_id   : 0x1::option::none<0x2::object::ID>(),
            status           : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::anchor(v2, v0),
            location         : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::attach(arg6),
            energy_source_id : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1)),
            metadata         : 0x1::option::some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::create_metadata(v2, v0, 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""))),
            extension        : 0x1::option::none<0x1::type_name::TypeName>(),
        };
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::connect_assembly(arg1, v2);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::transfer_owner_cap<Gate>(v3, 0x2::object::id_address<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character>(arg2));
        let v6 = GateCreatedEvent{
            assembly_id   : v2,
            assembly_key  : v0,
            owner_cap_id  : v4,
            type_id       : v5.type_id,
            location_hash : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::hash(&v5.location),
            status        : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::status(&v5.status),
        };
        0x2::event::emit<GateCreatedEvent>(v6);
        v5
    }

    public fun are_gates_linked(arg0: &Gate, arg1: &Gate) : bool {
        let v0 = 0x2::object::id<Gate>(arg0);
        let v1 = 0x2::object::id<Gate>(arg1);
        0x1::option::contains<0x2::object::ID>(&arg0.linked_gate_id, &v1) && 0x1::option::contains<0x2::object::ID>(&arg1.linked_gate_id, &v0)
    }

    public fun authorize_extension<T0: drop>(arg0: &mut Gate, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>) {
        let v0 = 0x2::object::id<Gate>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg1, v0), 13835903150227587079);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::is_extension_frozen(&arg0.id), 13839843804198338595);
        0x1::option::swap_or_fill<0x1::type_name::TypeName>(&mut arg0.extension, 0x1::type_name::with_defining_ids<T0>());
        let v1 = ExtensionAuthorizedEvent{
            assembly_id        : v0,
            assembly_key       : arg0.key,
            extension_type     : 0x1::type_name::with_defining_ids<T0>(),
            previous_extension : arg0.extension,
            owner_cap_id       : 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>>(arg1),
        };
        0x2::event::emit<ExtensionAuthorizedEvent>(v1);
    }

    fun compute_route_hash(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<0x2::object::ID>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x2::hash::blake2b256(&v0)
    }

    public fun delete_jump_permit(arg0: JumpPermit) {
        let JumpPermit {
            id                      : v0,
            character_id            : _,
            route_hash              : _,
            expires_at_timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun delete_jump_permit_with_auth<T0: drop>(arg0: &Gate, arg1: JumpPermit, arg2: T0) {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.extension), 13836185488492855305);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::option::borrow<0x1::type_name::TypeName>(&arg0.extension) == &v0, 13836185497082789897);
        let JumpPermit {
            id                      : v1,
            character_id            : _,
            route_hash              : _,
            expires_at_timestamp_ms : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    public fun energy_source_id(arg0: &Gate) : &0x1::option::Option<0x2::object::ID> {
        &arg0.energy_source_id
    }

    public fun extension_type(arg0: &Gate) : &0x1::option::Option<0x1::type_name::TypeName> {
        &arg0.extension
    }

    public fun gate_config_id(arg0: &GateConfig) : 0x2::object::ID {
        0x2::object::id<GateConfig>(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GateConfig{
            id                   : 0x2::object::new(arg0),
            max_distance_by_type : 0x2::table::new<u64, u64>(arg0),
        };
        0x2::transfer::share_object<GateConfig>(v0);
    }

    public fun is_extension_configured(arg0: &Gate) : bool {
        0x1::option::is_some<0x1::type_name::TypeName>(&arg0.extension)
    }

    public fun is_online(arg0: &Gate) : bool {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status)
    }

    public fun issue_jump_permit<T0: drop>(arg0: &Gate, arg1: &Gate, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg3: T0, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg1.extension), 13836185303809261577);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.extension), 13836185308104228873);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::option::borrow<0x1::type_name::TypeName>(&arg0.extension) == &v0, 13836185320989130761);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::option::borrow<0x1::type_name::TypeName>(&arg1.extension) == &v1, 13836185351053901833);
        let v2 = JumpPermit{
            id                      : 0x2::object::new(arg5),
            character_id            : 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character>(arg2),
            route_hash              : compute_route_hash(0x2::object::id<Gate>(arg0), 0x2::object::id<Gate>(arg1)),
            expires_at_timestamp_ms : arg4,
        };
        0x2::transfer::transfer<JumpPermit>(v2, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::character_address(arg2));
    }

    public fun jump(arg0: &Gate, arg1: &Gate, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg4: &mut 0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg3, arg4);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.extension), 13836185565802266633);
        jump_internal(arg0, arg1, arg2);
    }

    fun jump_internal(arg0: &Gate, arg1: &Gate, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character) {
        let v0 = 0x2::object::id<Gate>(arg1);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836469110953345035);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg1.status), 13836469115248312331);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.linked_gate_id, &v0), 13837313553063739409);
        let v1 = JumpEvent{
            source_gate_id       : 0x2::object::id<Gate>(arg0),
            source_gate_key      : arg0.key,
            destination_gate_id  : v0,
            destination_gate_key : arg1.key,
            character_id         : 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character>(arg2),
            character_key        : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::key(arg2),
        };
        0x2::event::emit<JumpEvent>(v1);
    }

    public fun jump_permit_id(arg0: &JumpPermit) : 0x2::object::ID {
        0x2::object::id<JumpPermit>(arg0)
    }

    public fun jump_with_permit(arg0: &Gate, arg1: &Gate, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg3: JumpPermit, arg4: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg4, arg6);
        validate_jump_permit(arg0, arg1, arg2, arg3, arg5);
        jump_internal(arg0, arg1, arg2);
    }

    public fun link_gates(arg0: &mut Gate, arg1: &mut Gate, arg2: &GateConfig, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::ServerAddressRegistry, arg4: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg5: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>, arg6: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg4, arg9);
        let v0 = 0x2::object::id<Gate>(arg0);
        let v1 = 0x2::object::id<Gate>(arg1);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg5, v0), 13835903553954512903);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg6, v1), 13835903566839414791);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.linked_gate_id) && 0x1::option::is_none<0x2::object::ID>(&arg1.linked_gate_id), 13837029492516585487);
        assert!(arg0.type_id == arg1.type_id, 13839562784488030241);
        verify_gates_within_range(arg0, arg3, arg2, arg7, arg8, arg9);
        arg0.linked_gate_id = 0x1::option::some<0x2::object::ID>(v1);
        arg1.linked_gate_id = 0x1::option::some<0x2::object::ID>(v0);
        let v2 = GateLinkedEvent{
            source_gate_id       : v0,
            source_gate_key      : arg0.key,
            destination_gate_id  : v1,
            destination_gate_key : arg1.key,
        };
        0x2::event::emit<GateLinkedEvent>(v2);
    }

    public fun linked_gate_id(arg0: &Gate) : 0x1::option::Option<0x2::object::ID> {
        arg0.linked_gate_id
    }

    public fun location(arg0: &Gate) : &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::Location {
        &arg0.location
    }

    public(friend) fun max_distance(arg0: &GateConfig, arg1: u64) : u64 {
        assert!(arg1 != 0, 13835061413946589185);
        assert!(0x2::table::contains<u64, u64>(&arg0.max_distance_by_type, arg1), 13835061431126458369);
        *0x2::table::borrow<u64, u64>(&arg0.max_distance_by_type, arg1)
    }

    public fun offline(arg0: &mut Gate, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>) {
        let v0 = 0x2::object::id<Gate>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg3, v0), 13835903429400461319);
        let v1 = 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.energy_source_id, &v1), 13836747867215888397);
        release_energy(arg0, arg1, arg2);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::offline(&mut arg0.status, v0, arg0.key);
    }

    public fun offline_connected_gate(arg0: &mut Gate, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::OfflineAssemblies, arg2: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::OfflineAssemblies {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::ids_length(&arg1) > 0) {
            let v0 = 0x2::object::id<Gate>(arg0);
            if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::remove_assembly_id(&mut arg1, v0)) {
                if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status)) {
                    0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::offline(&mut arg0.status, v0, arg0.key);
                    release_energy(arg0, arg2, arg3);
                };
            };
        };
        arg1
    }

    public fun offline_orphaned_gate(arg0: &mut Gate, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::HandleOrphanedAssemblies, arg2: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::HandleOrphanedAssemblies {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::orphaned_assemblies_length(&arg1) > 0) {
            let v0 = 0x2::object::id<Gate>(arg0);
            if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::remove_orphaned_assembly_id(&mut arg1, v0)) {
                if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status)) {
                    0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::offline(&mut arg0.status, v0, arg0.key);
                    release_energy(arg0, arg2, arg3);
                };
                arg0.energy_source_id = 0x1::option::none<0x2::object::ID>();
            };
        };
        arg1
    }

    public fun online(arg0: &mut Gate, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>) {
        let v0 = 0x2::object::id<Gate>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg3, v0), 13835903356386017287);
        let v1 = 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.energy_source_id, &v1), 13836747794201444365);
        reserve_energy(arg0, arg1, arg2);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::online(&mut arg0.status, v0, arg0.key);
    }

    public fun owner_cap_id(arg0: &Gate) : 0x2::object::ID {
        arg0.owner_cap_id
    }

    fun release_energy_by_type(arg0: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg2: u64) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::release_energy(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::borrow_energy_source(arg0), 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg0), arg1, arg2);
    }

    public fun reveal_location(arg0: &Gate, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::LocationRegistry, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg2, arg7);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::reveal_location(arg1, 0x2::object::id<Gate>(arg0), arg0.key, arg0.type_id, arg0.owner_cap_id, 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::hash(&arg0.location), arg3, arg4, arg5, arg6);
    }

    public fun revoke_extension_authorization(arg0: &mut Gate, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>) {
        let v0 = 0x2::object::id<Gate>(arg0);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg1, v0), 13835903266191704071);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::is_extension_frozen(&arg0.id), 13839843920162455587);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.extension), 13840406874411106343);
        arg0.extension = 0x1::option::none<0x1::type_name::TypeName>();
        let v1 = ExtensionRevokedEvent{
            assembly_id       : v0,
            assembly_key      : arg0.key,
            revoked_extension : 0x1::option::destroy_some<0x1::type_name::TypeName>(arg0.extension),
            owner_cap_id      : 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>>(arg1),
        };
        0x2::event::emit<ExtensionRevokedEvent>(v1);
    }

    public fun route_hash(arg0: &Gate, arg1: &Gate) : vector<u8> {
        compute_route_hash(0x2::object::id<Gate>(arg0), 0x2::object::id<Gate>(arg1))
    }

    public fun set_max_distance(arg0: &mut GateConfig, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg4);
        assert!(arg2 != 0, 13835061323752275969);
        assert!(arg3 > 0, 13837594602838818835);
        if (0x2::table::contains<u64, u64>(&arg0.max_distance_by_type, arg2)) {
            0x2::table::remove<u64, u64>(&mut arg0.max_distance_by_type, arg2);
        };
        0x2::table::add<u64, u64>(&mut arg0.max_distance_by_type, arg2, arg3);
    }

    public fun share_gate(arg0: Gate, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg2);
        0x2::transfer::share_object<Gate>(arg0);
    }

    public fun status(arg0: &Gate) : &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::AssemblyStatus {
        &arg0.status
    }

    public fun unanchor(arg0: Gate, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg4: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg3, arg4);
        let Gate {
            id               : v0,
            key              : v1,
            owner_cap_id     : _,
            type_id          : v3,
            linked_gate_id   : v4,
            status           : v5,
            location         : v6,
            energy_source_id : v7,
            metadata         : v8,
            extension        : _,
        } = arg0;
        let v10 = v7;
        let v11 = v5;
        let v12 = v4;
        let v13 = v0;
        let v14 = 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&v10, &v14), 13836749825720975373);
        assert!(0x1::option::is_none<0x2::object::ID>(&v12), 13839001638420611101);
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&v11)) {
            release_energy_by_type(arg1, arg2, v3);
        };
        let v15 = 0x2::object::uid_to_inner(&v13);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::disconnect_assembly(arg1, v15);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::unanchor(v11, v15, v1);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::remove_frozen_marker_if_present(&mut v13);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::remove(v6);
        let v16 = v8;
        if (0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&v16)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::delete(0x1::option::destroy_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v16));
        } else {
            0x1::option::destroy_none<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v16);
        };
        0x1::option::destroy_with_default<0x2::object::ID>(v10, v14);
        0x2::object::delete(v13);
    }

    public fun unanchor_orphan(arg0: Gate, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg2);
        let Gate {
            id               : v0,
            key              : v1,
            owner_cap_id     : _,
            type_id          : _,
            linked_gate_id   : v4,
            status           : v5,
            location         : v6,
            energy_source_id : v7,
            metadata         : v8,
            extension        : _,
        } = arg0;
        let v10 = v7;
        let v11 = v5;
        let v12 = v4;
        let v13 = v0;
        assert!(0x1::option::is_none<0x2::object::ID>(&v10), 13838438830200848409);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&v11), 13838720309472657435);
        assert!(0x1::option::is_none<0x2::object::ID>(&v12), 13837312943178383377);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::unanchor(v11, 0x2::object::uid_to_inner(&v13), v1);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze::remove_frozen_marker_if_present(&mut v13);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::remove(v6);
        let v14 = v8;
        if (0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&v14)) {
            0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::delete(0x1::option::destroy_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v14));
        } else {
            0x1::option::destroy_none<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(v14);
        };
        0x2::object::delete(v13);
    }

    fun unlink(arg0: &mut Gate, arg1: &mut Gate) {
        let v0 = 0x2::object::id<Gate>(arg0);
        let v1 = 0x2::object::id<Gate>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.linked_gate_id, &v1) && 0x1::option::contains<0x2::object::ID>(&arg1.linked_gate_id, &v0), 13837313746337267729);
        arg0.linked_gate_id = 0x1::option::none<0x2::object::ID>();
        arg1.linked_gate_id = 0x1::option::none<0x2::object::ID>();
        let v2 = GateUnlinkedEvent{
            source_gate_id       : v0,
            source_gate_key      : arg0.key,
            destination_gate_id  : v1,
            destination_gate_key : arg1.key,
        };
        0x2::event::emit<GateUnlinkedEvent>(v2);
    }

    public fun unlink_and_unanchor(arg0: Gate, arg1: &mut Gate, arg2: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy::EnergyConfig, arg4: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg5: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        unlink_gates_by_admin(v0, arg1, arg4, arg5);
        unanchor(arg0, arg2, arg3, arg4, arg5);
    }

    public fun unlink_and_unanchor_orphan(arg0: Gate, arg1: &mut Gate, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        unlink_gates_by_admin(v0, arg1, arg2, arg3);
        unanchor_orphan(arg0, arg2, arg3);
    }

    public fun unlink_gates(arg0: &mut Gate, arg1: &mut Gate, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>, arg3: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg2, 0x2::object::id<Gate>(arg0)), 13835903760112943111);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg3, 0x2::object::id<Gate>(arg1)), 13835903772997844999);
        unlink(arg0, arg1);
    }

    public fun unlink_gates_by_admin(arg0: &mut Gate, arg1: &mut Gate, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg2, arg3);
        unlink(arg0, arg1);
    }

    public fun update_energy_source(arg0: &mut Gate, arg1: &mut 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg3: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg2, arg3);
        assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836468234780016651);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::connect_assembly(arg1, 0x2::object::id<Gate>(arg0));
        arg0.energy_source_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg1));
    }

    public fun update_energy_source_connected_gate(arg0: &mut Gate, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::UpdateEnergySources, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode) : 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::UpdateEnergySources {
        if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::update_energy_sources_ids_length(&arg1) > 0) {
            if (0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::remove_energy_sources_assembly_id(&mut arg1, 0x2::object::id<Gate>(arg0))) {
                assert!(!0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::status::is_online(&arg0.status), 13836467173923094539);
                arg0.energy_source_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::network_node::NetworkNode>(arg2));
            };
        };
        arg1
    }

    public fun update_metadata_description(arg0: &mut Gate, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg1, 0x2::object::id<Gate>(arg0)), 13835904503142285319);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13839282207159353375);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_description(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_metadata_name(arg0: &mut Gate, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg1, 0x2::object::id<Gate>(arg0)), 13835904455897645063);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13839282159914713119);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_name(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    public fun update_metadata_url(arg0: &mut Gate, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::OwnerCap<Gate>, arg2: 0x1::string::String) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized<Gate>(arg1, 0x2::object::id<Gate>(arg0)), 13835904533207056391);
        assert!(0x1::option::is_some<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&arg0.metadata), 13839282237224124447);
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::update_url(0x1::option::borrow_mut<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata::Metadata>(&mut arg0.metadata), arg0.key, arg2);
    }

    fun validate_jump_permit(arg0: &Gate, arg1: &Gate, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character, arg3: JumpPermit, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<Gate>(arg0);
        let v1 = 0x2::object::id<Gate>(arg1);
        assert!(arg3.expires_at_timestamp_ms > 0x2::clock::timestamp_ms(arg4), 13837876601801670677);
        assert!(arg3.character_id == 0x2::object::id<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::character::Character>(arg2), 13838158081073479703);
        assert!(arg3.route_hash == compute_route_hash(v0, v1) || arg3.route_hash == compute_route_hash(v1, v0), 13838158098253348887);
        let JumpPermit {
            id                      : v2,
            character_id            : _,
            route_hash              : _,
            expires_at_timestamp_ms : _,
        } = arg3;
        0x2::object::delete(v2);
    }

    fun verify_gates_within_range(arg0: &Gate, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::ServerAddressRegistry, arg2: &GateConfig, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location::verify_distance(&arg0.location, arg1, arg3, max_distance(arg2, arg0.type_id), arg5);
    }

    // decompiled from Move bytecode v6
}

