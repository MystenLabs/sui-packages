module 0x816684a152fdee1e7f15f65d18873ed7ee48540e8bd4205b3197a5ec0feda2c6::memory_registry {
    struct MemoryRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        governance_vault_id: 0x2::object::ID,
        provider_policies: 0x2::table::Table<0x1::string::String, ProviderPolicy>,
        active_entries: 0x2::table::Table<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>,
    }

    struct ProviderPolicy has copy, drop, store {
        provider: 0x1::string::String,
        enabled: bool,
        min_schema_version: u64,
        max_schema_version: u64,
        updated_epoch: u64,
        updated_by: address,
    }

    struct MemoryEntry has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        owner: address,
        app_id: 0x1::string::String,
        memory_id: 0x1::string::String,
        provider: 0x1::string::String,
        account_id: 0x2::object::ID,
        namespace_root: 0x1::string::String,
        artifact_code: 0x1::string::String,
        series_id: 0x2::object::ID,
        pinned_version_id: 0x1::option::Option<0x2::object::ID>,
        use_latest: bool,
        schema_version: u64,
        available: bool,
        owner_enabled: bool,
        owner_deleted: bool,
        deleted_epoch: 0x1::option::Option<u64>,
        created_epoch: u64,
        updated_epoch: u64,
        updated_by: address,
    }

    struct MemoryRegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        governance_vault_id: 0x2::object::ID,
        version: u64,
    }

    struct ProviderPolicySetEvent has copy, drop {
        registry_id: 0x2::object::ID,
        provider: 0x1::string::String,
        enabled: bool,
        min_schema_version: u64,
        max_schema_version: u64,
        updated_epoch: u64,
        updated_by: address,
    }

    struct MemoryEntryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        entry_id: 0x2::object::ID,
        owner: address,
        app_id: 0x1::string::String,
        memory_id: 0x1::string::String,
        provider: 0x1::string::String,
        account_id: 0x2::object::ID,
        namespace_root: 0x1::string::String,
        artifact_code: 0x1::string::String,
        series_id: 0x2::object::ID,
        pinned_version_id: 0x1::option::Option<0x2::object::ID>,
        use_latest: bool,
        schema_version: u64,
        available: bool,
        owner_enabled: bool,
        owner_deleted: bool,
        updated_epoch: u64,
    }

    struct MemoryEntryPointerUpdatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        entry_id: 0x2::object::ID,
        owner: address,
        account_id: 0x2::object::ID,
        namespace_root: 0x1::string::String,
        owner_enabled: bool,
        updated_epoch: u64,
    }

    struct MemoryEntryDeletedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        entry_id: 0x2::object::ID,
        owner: address,
        deleted_epoch: u64,
    }

    struct MemoryEntryAvailabilitySetEvent has copy, drop {
        registry_id: 0x2::object::ID,
        entry_id: 0x2::object::ID,
        owner: address,
        available: bool,
        updated_epoch: u64,
        updated_by: address,
    }

    struct MemoryEntryVersionPolicySetEvent has copy, drop {
        registry_id: 0x2::object::ID,
        entry_id: 0x2::object::ID,
        owner: address,
        series_id: 0x2::object::ID,
        pinned_version_id: 0x1::option::Option<0x2::object::ID>,
        use_latest: bool,
        updated_epoch: u64,
        updated_by: address,
    }

    public fun active_entry_id(arg0: &MemoryRegistry, arg1: address, arg2: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&arg0.active_entries, arg1)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&arg0.active_entries, arg1);
        if (!0x2::table::contains<0x1::string::String, 0x2::object::ID>(v0, arg2)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(v0, arg2))
    }

    fun assert_active_operator(arg0: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg1: address) {
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::active_operator(arg0) == arg1, 1);
    }

    fun assert_entry_registry(arg0: &MemoryRegistry, arg1: &MemoryEntry) {
        assert!(arg1.registry_id == 0x2::object::id<MemoryRegistry>(arg0), 1);
    }

    fun assert_governance_binding(arg0: 0x2::object::ID, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault) {
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg1);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg1) == arg0, 1);
    }

    fun assert_no_active_entry(arg0: &MemoryRegistry, arg1: address, arg2: 0x1::string::String) {
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&arg0.active_entries, arg1)) {
            return
        };
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(0x2::table::borrow<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&arg0.active_entries, arg1), arg2), 13);
    }

    fun assert_owner(arg0: &MemoryEntry, arg1: address) {
        assert!(arg0.owner == arg1, 10);
    }

    fun assert_registry_governance(arg0: &MemoryRegistry, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault) {
        assert_governance_binding(arg0.root_id, arg1);
        assert!(arg0.governance_vault_id == 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1), 1);
    }

    public fun create_memory_entry(arg0: &mut MemoryRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::object::ID, arg8: 0x1::option::Option<0x2::object::ID>, arg9: bool, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        validate_entry_input(&arg1, &arg2, &arg3, arg4, &arg5, &arg6, arg7, &arg8, arg9);
        let v0 = 0x2::tx_context::sender(arg11);
        assert_no_active_entry(arg0, v0, arg1);
        let v1 = MemoryEntry{
            id                : 0x2::object::new(arg11),
            version           : 1,
            registry_id       : 0x2::object::id<MemoryRegistry>(arg0),
            owner             : v0,
            app_id            : arg1,
            memory_id         : arg2,
            provider          : arg3,
            account_id        : arg4,
            namespace_root    : arg5,
            artifact_code     : arg6,
            series_id         : arg7,
            pinned_version_id : arg8,
            use_latest        : arg9,
            schema_version    : arg10,
            available         : true,
            owner_enabled     : true,
            owner_deleted     : false,
            deleted_epoch     : 0x1::option::none<u64>(),
            created_epoch     : 0x2::tx_context::epoch(arg11),
            updated_epoch     : 0x2::tx_context::epoch(arg11),
            updated_by        : v0,
        };
        let v2 = MemoryEntryCreatedEvent{
            registry_id       : 0x2::object::id<MemoryRegistry>(arg0),
            entry_id          : 0x2::object::id<MemoryEntry>(&v1),
            owner             : v0,
            app_id            : v1.app_id,
            memory_id         : v1.memory_id,
            provider          : v1.provider,
            account_id        : v1.account_id,
            namespace_root    : v1.namespace_root,
            artifact_code     : v1.artifact_code,
            series_id         : v1.series_id,
            pinned_version_id : v1.pinned_version_id,
            use_latest        : v1.use_latest,
            schema_version    : v1.schema_version,
            available         : v1.available,
            owner_enabled     : v1.owner_enabled,
            owner_deleted     : v1.owner_deleted,
            updated_epoch     : v1.updated_epoch,
        };
        0x2::event::emit<MemoryEntryCreatedEvent>(v2);
        ensure_owner_entries_table(arg0, v0, arg11);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&mut arg0.active_entries, v0), v1.app_id, 0x2::object::id<MemoryEntry>(&v1));
        0x2::transfer::share_object<MemoryEntry>(v1);
    }

    public fun create_registry(arg0: 0x2::object::ID, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert_governance_binding(arg0, arg1);
        assert_active_operator(arg1, 0x2::tx_context::sender(arg2));
        let v0 = MemoryRegistry{
            id                  : 0x2::object::new(arg2),
            version             : 1,
            root_id             : arg0,
            governance_vault_id : 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1),
            provider_policies   : 0x2::table::new<0x1::string::String, ProviderPolicy>(arg2),
            active_entries      : 0x2::table::new<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(arg2),
        };
        let v1 = MemoryRegistryCreatedEvent{
            registry_id         : 0x2::object::id<MemoryRegistry>(&v0),
            root_id             : arg0,
            governance_vault_id : 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1),
            version             : 1,
        };
        0x2::event::emit<MemoryRegistryCreatedEvent>(v1);
        0x2::transfer::share_object<MemoryRegistry>(v0);
    }

    public fun delete_own_memory_entry(arg0: &mut MemoryRegistry, arg1: &mut MemoryEntry, arg2: &mut 0x2::tx_context::TxContext) {
        assert_entry_registry(arg0, arg1);
        assert_owner(arg1, 0x2::tx_context::sender(arg2));
        release_active_entry(arg0, arg1.owner, arg1.app_id, 0x2::object::id<MemoryEntry>(arg1));
        arg1.owner_enabled = false;
        arg1.owner_deleted = true;
        arg1.available = false;
        arg1.deleted_epoch = 0x1::option::some<u64>(0x2::tx_context::epoch(arg2));
        arg1.updated_epoch = 0x2::tx_context::epoch(arg2);
        arg1.updated_by = 0x2::tx_context::sender(arg2);
        let v0 = MemoryEntryDeletedEvent{
            registry_id   : arg1.registry_id,
            entry_id      : 0x2::object::id<MemoryEntry>(arg1),
            owner         : arg1.owner,
            deleted_epoch : arg1.updated_epoch,
        };
        0x2::event::emit<MemoryEntryDeletedEvent>(v0);
    }

    public fun disable_own_memory_entry(arg0: &mut MemoryEntry, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.owner_enabled = false;
        arg0.updated_epoch = 0x2::tx_context::epoch(arg1);
        arg0.updated_by = 0x2::tx_context::sender(arg1);
        let v0 = MemoryEntryPointerUpdatedEvent{
            registry_id    : arg0.registry_id,
            entry_id       : 0x2::object::id<MemoryEntry>(arg0),
            owner          : arg0.owner,
            account_id     : arg0.account_id,
            namespace_root : arg0.namespace_root,
            owner_enabled  : false,
            updated_epoch  : arg0.updated_epoch,
        };
        0x2::event::emit<MemoryEntryPointerUpdatedEvent>(v0);
    }

    fun ensure_owner_entries_table(arg0: &mut MemoryRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&arg0.active_entries, arg1)) {
            0x2::table::add<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&mut arg0.active_entries, arg1, 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg2));
        };
    }

    public fun entry_account_id(arg0: &MemoryEntry) : 0x2::object::ID {
        arg0.account_id
    }

    public fun entry_app_id(arg0: &MemoryEntry) : 0x1::string::String {
        arg0.app_id
    }

    public fun entry_artifact_code(arg0: &MemoryEntry) : 0x1::string::String {
        arg0.artifact_code
    }

    public fun entry_available(arg0: &MemoryEntry) : bool {
        arg0.available
    }

    public fun entry_deleted_epoch(arg0: &MemoryEntry) : 0x1::option::Option<u64> {
        arg0.deleted_epoch
    }

    public fun entry_memory_id(arg0: &MemoryEntry) : 0x1::string::String {
        arg0.memory_id
    }

    public fun entry_namespace_root(arg0: &MemoryEntry) : 0x1::string::String {
        arg0.namespace_root
    }

    public fun entry_owner(arg0: &MemoryEntry) : address {
        arg0.owner
    }

    public fun entry_owner_deleted(arg0: &MemoryEntry) : bool {
        arg0.owner_deleted
    }

    public fun entry_owner_enabled(arg0: &MemoryEntry) : bool {
        arg0.owner_enabled
    }

    public fun entry_pinned_version_id(arg0: &MemoryEntry) : 0x1::option::Option<0x2::object::ID> {
        arg0.pinned_version_id
    }

    public fun entry_provider(arg0: &MemoryEntry) : 0x1::string::String {
        arg0.provider
    }

    public fun entry_schema_version(arg0: &MemoryEntry) : u64 {
        arg0.schema_version
    }

    public fun entry_series_id(arg0: &MemoryEntry) : 0x2::object::ID {
        arg0.series_id
    }

    public fun entry_use_latest(arg0: &MemoryEntry) : bool {
        arg0.use_latest
    }

    public fun is_entry_usable(arg0: &MemoryRegistry, arg1: &MemoryEntry) : bool {
        let v0 = if (!arg1.available) {
            true
        } else if (!arg1.owner_enabled) {
            true
        } else if (arg1.owner_deleted) {
            true
        } else {
            arg1.registry_id != 0x2::object::id<MemoryRegistry>(arg0)
        };
        if (v0) {
            return false
        };
        if (!0x2::table::contains<0x1::string::String, ProviderPolicy>(&arg0.provider_policies, arg1.provider)) {
            return false
        };
        let v1 = 0x2::table::borrow<0x1::string::String, ProviderPolicy>(&arg0.provider_policies, arg1.provider);
        if (v1.enabled) {
            if (arg1.schema_version >= v1.min_schema_version) {
                arg1.schema_version <= v1.max_schema_version
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun provider_policy(arg0: &MemoryRegistry, arg1: 0x1::string::String) : ProviderPolicy {
        assert!(0x2::table::contains<0x1::string::String, ProviderPolicy>(&arg0.provider_policies, arg1), 12);
        *0x2::table::borrow<0x1::string::String, ProviderPolicy>(&arg0.provider_policies, arg1)
    }

    public fun provider_policy_enabled(arg0: &ProviderPolicy) : bool {
        arg0.enabled
    }

    public fun provider_policy_max_schema_version(arg0: &ProviderPolicy) : u64 {
        arg0.max_schema_version
    }

    public fun provider_policy_min_schema_version(arg0: &ProviderPolicy) : u64 {
        arg0.min_schema_version
    }

    public fun registry_governance_vault_id(arg0: &MemoryRegistry) : 0x2::object::ID {
        arg0.governance_vault_id
    }

    public fun registry_root_id(arg0: &MemoryRegistry) : 0x2::object::ID {
        arg0.root_id
    }

    public fun registry_version(arg0: &MemoryRegistry) : u64 {
        arg0.version
    }

    fun release_active_entry(arg0: &mut MemoryRegistry, arg1: address, arg2: 0x1::string::String, arg3: 0x2::object::ID) {
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&arg0.active_entries, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::string::String, 0x2::object::ID>>(&mut arg0.active_entries, arg1);
        if (!0x2::table::contains<0x1::string::String, 0x2::object::ID>(v0, arg2)) {
            return
        };
        if (*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(v0, arg2) == arg3) {
            0x2::table::remove<0x1::string::String, 0x2::object::ID>(v0, arg2);
        };
    }

    public fun set_memory_availability(arg0: &MemoryRegistry, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &mut MemoryEntry, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_registry_governance(arg0, arg1);
        assert_entry_registry(arg0, arg2);
        assert_active_operator(arg1, 0x2::tx_context::sender(arg4));
        arg2.available = arg3;
        arg2.updated_epoch = 0x2::tx_context::epoch(arg4);
        arg2.updated_by = 0x2::tx_context::sender(arg4);
        let v0 = MemoryEntryAvailabilitySetEvent{
            registry_id   : 0x2::object::id<MemoryRegistry>(arg0),
            entry_id      : 0x2::object::id<MemoryEntry>(arg2),
            owner         : arg2.owner,
            available     : arg3,
            updated_epoch : arg2.updated_epoch,
            updated_by    : arg2.updated_by,
        };
        0x2::event::emit<MemoryEntryAvailabilitySetEvent>(v0);
    }

    public fun set_memory_version_policy(arg0: &MemoryRegistry, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &mut MemoryEntry, arg3: 0x2::object::ID, arg4: 0x1::option::Option<0x2::object::ID>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert_registry_governance(arg0, arg1);
        assert_entry_registry(arg0, arg2);
        assert_active_operator(arg1, 0x2::tx_context::sender(arg6));
        assert!(0x2::object::id_to_address(&arg3) != @0x0, 11);
        assert!(arg5 || 0x1::option::is_some<0x2::object::ID>(&arg4), 9);
        arg2.series_id = arg3;
        arg2.pinned_version_id = arg4;
        arg2.use_latest = arg5;
        arg2.updated_epoch = 0x2::tx_context::epoch(arg6);
        arg2.updated_by = 0x2::tx_context::sender(arg6);
        let v0 = MemoryEntryVersionPolicySetEvent{
            registry_id       : 0x2::object::id<MemoryRegistry>(arg0),
            entry_id          : 0x2::object::id<MemoryEntry>(arg2),
            owner             : arg2.owner,
            series_id         : arg3,
            pinned_version_id : arg4,
            use_latest        : arg5,
            updated_epoch     : arg2.updated_epoch,
            updated_by        : arg2.updated_by,
        };
        0x2::event::emit<MemoryEntryVersionPolicySetEvent>(v0);
    }

    public fun set_provider_policy(arg0: &mut MemoryRegistry, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: 0x1::string::String, arg3: bool, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_registry_governance(arg0, arg1);
        assert_active_operator(arg1, 0x2::tx_context::sender(arg6));
        validate_text(&arg2, 32, 3);
        let v0 = ProviderPolicy{
            provider           : arg2,
            enabled            : arg3,
            min_schema_version : arg4,
            max_schema_version : arg5,
            updated_epoch      : 0x2::tx_context::epoch(arg6),
            updated_by         : 0x2::tx_context::sender(arg6),
        };
        let v1 = v0.provider;
        if (0x2::table::contains<0x1::string::String, ProviderPolicy>(&arg0.provider_policies, v1)) {
            *0x2::table::borrow_mut<0x1::string::String, ProviderPolicy>(&mut arg0.provider_policies, v1) = v0;
        } else {
            0x2::table::add<0x1::string::String, ProviderPolicy>(&mut arg0.provider_policies, v1, v0);
        };
        let v2 = 0x2::table::borrow<0x1::string::String, ProviderPolicy>(&arg0.provider_policies, v1);
        let v3 = ProviderPolicySetEvent{
            registry_id        : 0x2::object::id<MemoryRegistry>(arg0),
            provider           : v2.provider,
            enabled            : v2.enabled,
            min_schema_version : v2.min_schema_version,
            max_schema_version : v2.max_schema_version,
            updated_epoch      : v2.updated_epoch,
            updated_by         : v2.updated_by,
        };
        0x2::event::emit<ProviderPolicySetEvent>(v3);
    }

    public fun update_memory_pointer(arg0: &mut MemoryEntry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x2::object::id_to_address(&arg1) != @0x0, 6);
        validate_text(&arg2, 128, 4);
        arg0.account_id = arg1;
        arg0.namespace_root = arg2;
        arg0.owner_enabled = arg3;
        arg0.updated_epoch = 0x2::tx_context::epoch(arg4);
        arg0.updated_by = 0x2::tx_context::sender(arg4);
        let v0 = MemoryEntryPointerUpdatedEvent{
            registry_id    : arg0.registry_id,
            entry_id       : 0x2::object::id<MemoryEntry>(arg0),
            owner          : arg0.owner,
            account_id     : arg1,
            namespace_root : arg0.namespace_root,
            owner_enabled  : arg3,
            updated_epoch  : arg0.updated_epoch,
        };
        0x2::event::emit<MemoryEntryPointerUpdatedEvent>(v0);
    }

    fun validate_entry_input(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: 0x2::object::ID, arg4: &0x1::string::String, arg5: &0x1::string::String, arg6: 0x2::object::ID, arg7: &0x1::option::Option<0x2::object::ID>, arg8: bool) {
        validate_text(arg0, 64, 2);
        validate_text(arg1, 128, 7);
        validate_text(arg2, 32, 3);
        validate_text(arg4, 128, 4);
        validate_text(arg5, 96, 8);
        assert!(0x2::object::id_to_address(&arg3) != @0x0, 6);
        assert!(0x2::object::id_to_address(&arg6) != @0x0, 11);
        assert!(arg8 || 0x1::option::is_some<0x2::object::ID>(arg7), 9);
    }

    fun validate_text(arg0: &0x1::string::String, arg1: u64, arg2: u64) {
        assert!(0x1::string::length(arg0) > 0, arg2);
        assert!(0x1::string::length(arg0) <= arg1, 5);
    }

    // decompiled from Move bytecode v7
}

