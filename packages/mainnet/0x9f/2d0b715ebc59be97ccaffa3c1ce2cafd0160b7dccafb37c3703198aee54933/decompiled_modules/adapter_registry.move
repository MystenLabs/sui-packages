module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry {
    struct AdapterRegistry has key {
        id: 0x2::object::UID,
        adapters: 0x2::table::Table<vector<u8>, AdapterMeta>,
        count: u64,
    }

    struct AdapterRegistryV2 has key {
        id: 0x2::object::UID,
        version: u64,
        protocol_config_id: 0x2::object::ID,
        adapters: 0x2::table::Table<vector<u8>, AdapterMeta>,
        count: u64,
    }

    struct RegistryAdminCap has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct AdapterMeta has copy, drop, store {
        adapter_id: vector<u8>,
        chain: vector<u8>,
        active: bool,
        label: vector<u8>,
    }

    struct AdapterRegistered has copy, drop {
        adapter_id: vector<u8>,
        chain: vector<u8>,
    }

    struct AdapterSetActive has copy, drop {
        adapter_id: vector<u8>,
        active: bool,
    }

    struct RegistryAdminCapCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct RegistryAdminCapTransferred has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        recipient: address,
    }

    public fun assert_active(arg0: &AdapterRegistry, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, AdapterMeta>(&arg0.adapters, arg1), 1);
        assert!(0x2::table::borrow<vector<u8>, AdapterMeta>(&arg0.adapters, arg1).active, 1);
    }

    public fun assert_active_v2(arg0: &AdapterRegistryV2, arg1: vector<u8>) {
        assert_canonical_v2(arg0);
        assert!(0x2::table::contains<vector<u8>, AdapterMeta>(&arg0.adapters, arg1), 1);
        assert!(0x2::table::borrow<vector<u8>, AdapterMeta>(&arg0.adapters, arg1).active, 1);
    }

    public fun assert_active_v2_on_chain(arg0: &AdapterRegistryV2, arg1: vector<u8>, arg2: vector<u8>) {
        assert_active_v2(arg0, arg1);
        assert!(0x2::table::borrow<vector<u8>, AdapterMeta>(&arg0.adapters, arg1).chain == arg2, 13);
    }

    fun assert_admin_cap(arg0: &RegistryAdminCap, arg1: &AdapterRegistryV2) {
        assert!(arg1.version == 2, 3);
        assert!(arg1.protocol_config_id == 0x2::object::id_from_address(@0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba), 11);
        assert!(arg0.registry_id == 0x2::object::id<AdapterRegistryV2>(arg1), 6);
    }

    public fun assert_canonical_v2(arg0: &AdapterRegistryV2) {
        assert!(arg0.version == 2, 3);
        assert!(arg0.protocol_config_id == 0x2::object::id_from_address(@0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba), 11);
    }

    fun assert_governance_recipient(arg0: address) {
        assert!(arg0 != @0x0, 8);
        assert!(arg0 != @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 10);
    }

    public fun bootstrap_registry_v2(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x2::package::UpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id_address<0x2::package::UpgradeCap>(arg1) == @0xfb7a7925da9332ab039cd7296828f5ebaef5ff7246f1bfa051d0a409fa15eb2d, 4);
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg0) == @0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba, 11);
        assert_governance_recipient(arg2);
        bootstrap_registry_v2_internal(arg0, arg2, arg3);
    }

    fun bootstrap_registry_v2_internal(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::adapter_registry_v2_bootstrapped(arg0), 12);
        let v0 = AdapterRegistryV2{
            id                 : 0x2::object::new(arg2),
            version            : 2,
            protocol_config_id : 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg0),
            adapters           : 0x2::table::new<vector<u8>, AdapterMeta>(arg2),
            count              : 0,
        };
        let v1 = 0x2::object::id<AdapterRegistryV2>(&v0);
        let v2 = RegistryAdminCap{
            id          : 0x2::object::new(arg2),
            registry_id : v1,
        };
        let v3 = 0x2::object::id<RegistryAdminCap>(&v2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::anchor_adapter_registry_v2(arg0, v1, v3, arg1);
        let v4 = RegistryAdminCapCreated{
            registry_id  : v1,
            admin_cap_id : v3,
            recipient    : arg1,
        };
        0x2::event::emit<RegistryAdminCapCreated>(v4);
        0x2::transfer::share_object<AdapterRegistryV2>(v0);
        0x2::transfer::transfer<RegistryAdminCap>(v2, arg1);
    }

    public fun count(arg0: &AdapterRegistry) : u64 {
        arg0.count
    }

    public fun count_v2(arg0: &AdapterRegistryV2) : u64 {
        arg0.count
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdapterRegistry{
            id       : 0x2::object::new(arg0),
            adapters : 0x2::table::new<vector<u8>, AdapterMeta>(arg0),
            count    : 0,
        };
        0x2::transfer::share_object<AdapterRegistry>(v0);
    }

    public fun is_active(arg0: &AdapterRegistry, arg1: vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, AdapterMeta>(&arg0.adapters, arg1)) {
            return false
        };
        0x2::table::borrow<vector<u8>, AdapterMeta>(&arg0.adapters, arg1).active
    }

    public fun is_active_v2(arg0: &AdapterRegistryV2, arg1: vector<u8>) : bool {
        if (arg0.version != 2 || arg0.protocol_config_id != 0x2::object::id_from_address(@0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba)) {
            return false
        };
        if (!0x2::table::contains<vector<u8>, AdapterMeta>(&arg0.adapters, arg1)) {
            return false
        };
        0x2::table::borrow<vector<u8>, AdapterMeta>(&arg0.adapters, arg1).active
    }

    public fun label_as_string(arg0: &AdapterMeta) : 0x1::string::String {
        0x1::string::utf8(arg0.label)
    }

    public fun register(arg0: &mut AdapterRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
        abort 3
    }

    public fun register_authenticated(arg0: &RegistryAdminCap, arg1: &mut AdapterRegistryV2, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        assert_admin_cap(arg0, arg1);
        assert!(!0x2::table::contains<vector<u8>, AdapterMeta>(&arg1.adapters, arg2), 2);
        let v0 = AdapterMeta{
            adapter_id : arg2,
            chain      : arg3,
            active     : true,
            label      : arg4,
        };
        0x2::table::add<vector<u8>, AdapterMeta>(&mut arg1.adapters, arg2, v0);
        arg1.count = arg1.count + 1;
        let v1 = AdapterRegistered{
            adapter_id : arg2,
            chain      : arg3,
        };
        0x2::event::emit<AdapterRegistered>(v1);
    }

    public fun retire_v2(arg0: &RegistryAdminCap, arg1: &mut AdapterRegistryV2) {
        assert_admin_cap(arg0, arg1);
        arg1.version = 2 + 1;
    }

    public fun set_active(arg0: &mut AdapterRegistry, arg1: vector<u8>, arg2: bool) {
        abort 3
    }

    public fun set_active_authenticated(arg0: &RegistryAdminCap, arg1: &mut AdapterRegistryV2, arg2: vector<u8>, arg3: bool) {
        assert_admin_cap(arg0, arg1);
        assert!(0x2::table::contains<vector<u8>, AdapterMeta>(&arg1.adapters, arg2), 1);
        0x2::table::borrow_mut<vector<u8>, AdapterMeta>(&mut arg1.adapters, arg2).active = arg3;
        let v0 = AdapterSetActive{
            adapter_id : arg2,
            active     : arg3,
        };
        0x2::event::emit<AdapterSetActive>(v0);
    }

    public fun transfer_admin_cap(arg0: RegistryAdminCap, arg1: address) {
        assert_governance_recipient(arg1);
        let v0 = RegistryAdminCapTransferred{
            registry_id  : arg0.registry_id,
            admin_cap_id : 0x2::object::id<RegistryAdminCap>(&arg0),
            recipient    : arg1,
        };
        0x2::event::emit<RegistryAdminCapTransferred>(v0);
        0x2::transfer::transfer<RegistryAdminCap>(arg0, arg1);
    }

    public fun version_v2(arg0: &AdapterRegistryV2) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

