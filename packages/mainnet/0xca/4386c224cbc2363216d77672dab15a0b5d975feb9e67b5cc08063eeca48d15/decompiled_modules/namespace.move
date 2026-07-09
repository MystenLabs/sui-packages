module 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace {
    struct MemoryNamespace has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        principal_acl: 0x2::table::Table<address, u32>,
        current_dek_version: u64,
        wrapped_deks: 0x2::table::Table<u64, vector<u8>>,
        created_at: u64,
        migrated_v1: bool,
    }

    struct NamespaceRegistry has key {
        id: 0x2::object::UID,
        namespaces: 0x2::table::Table<NamespaceKey, 0x2::object::ID>,
    }

    struct NamespaceKey has copy, drop, store {
        owner: address,
        name: 0x1::string::String,
    }

    struct NamespaceCreated has copy, drop {
        namespace_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        by: address,
    }

    struct PrincipalAclSet has copy, drop {
        namespace_id: 0x2::object::ID,
        principal: address,
        old_bits: u32,
        new_bits: u32,
        by: address,
    }

    struct PrincipalAclRemoved has copy, drop {
        namespace_id: 0x2::object::ID,
        principal: address,
        old_bits: u32,
        by: address,
    }

    struct NamespaceRenamed has copy, drop {
        namespace_id: 0x2::object::ID,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        by: address,
    }

    struct NamespaceOwnershipTransferred has copy, drop {
        namespace_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
        new_dek_version: u64,
        by: address,
    }

    struct NamespaceMigrated has copy, drop {
        namespace_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
        by: address,
    }

    struct NamespaceRegistryMigrated has copy, drop {
        registry_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
        by: address,
    }

    struct WrappedDekSet has copy, drop {
        namespace_id: 0x2::object::ID,
        dek_version: u64,
        dek_commitment: vector<u8>,
        by: address,
    }

    struct DekVersionBumped has copy, drop {
        namespace_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
        dek_commitment: vector<u8>,
        by: address,
    }

    struct DekVersionShredded has copy, drop {
        namespace_id: 0x2::object::ID,
        dek_version: u64,
        by: address,
    }

    public fun owner(arg0: &MemoryNamespace) : address {
        arg0.owner
    }

    entry fun admin_migrate_namespace(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AdminCap, arg1: &mut MemoryNamespace, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::stored(&arg1.id);
        assert!(v0 < 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::current(), 205);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::stamp(&mut arg1.id);
        let v1 = NamespaceMigrated{
            namespace_id : 0x2::object::id<MemoryNamespace>(arg1),
            from_version : v0,
            to_version   : 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::current(),
            by           : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NamespaceMigrated>(v1);
    }

    entry fun admin_migrate_namespace_registry(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AdminCap, arg1: &mut NamespaceRegistry, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::stored(&arg1.id);
        assert!(v0 < 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::current(), 205);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::stamp(&mut arg1.id);
        let v1 = NamespaceRegistryMigrated{
            registry_id  : 0x2::object::id<NamespaceRegistry>(arg1),
            from_version : v0,
            to_version   : 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::current(),
            by           : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NamespaceRegistryMigrated>(v1);
    }

    public(friend) fun assert_dek_ready_for_record(arg0: &MemoryNamespace, arg1: u64) {
        assert!(arg0.current_dek_version != 0, 212);
        assert!(arg0.current_dek_version == arg1, 210);
        assert!(0x2::table::contains<u64, vector<u8>>(&arg0.wrapped_deks, arg1), 209);
    }

    public(friend) fun assert_extend(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account, arg2: &MemoryNamespace, arg3: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg4: address) {
        assert!(effective_acl_bits(arg0, arg1, arg2, arg3, arg4) & 4 != 0, 201);
    }

    public(friend) fun assert_metadata_blob_write(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account, arg2: &MemoryNamespace, arg3: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg4: address) {
        assert!(effective_acl_bits(arg0, arg1, arg2, arg3, arg4) & 16 != 0, 201);
    }

    public(friend) fun assert_metadata_write(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account, arg2: &MemoryNamespace, arg3: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg4: address) {
        assert!(effective_acl_bits(arg0, arg1, arg2, arg3, arg4) & 8 != 0, 201);
    }

    public(friend) fun assert_migrated_v1(arg0: &MemoryNamespace) {
        assert!(arg0.migrated_v1, 216);
    }

    public(friend) fun assert_v1_recordable(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &MemoryNamespace) {
        assert_version(arg0, arg1);
        assert_migrated_v1(arg1);
        assert!(arg1.current_dek_version != 0, 212);
        assert!(0x2::table::contains<u64, vector<u8>>(&arg1.wrapped_deks, arg1.current_dek_version), 209);
    }

    public(friend) fun assert_valid_grant(arg0: u32) {
        assert!(arg0 == 4294967295 || arg0 & (31 ^ 4294967295) == 0, 202);
    }

    public(friend) fun assert_version(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &MemoryNamespace) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
    }

    public(friend) fun assert_write(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account, arg2: &MemoryNamespace, arg3: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg4: address) {
        assert!(effective_acl_bits(arg0, arg1, arg2, arg3, arg4) & 2 != 0, 201);
    }

    entry fun bump_dek_version(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &mut MemoryNamespace, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 200);
        assert!(arg1.current_dek_version == arg2, 210);
        let v0 = arg2 + 1;
        insert_wrapped_dek(arg1, v0, arg3);
        arg1.current_dek_version = v0;
        let v1 = DekVersionBumped{
            namespace_id   : 0x2::object::id<MemoryNamespace>(arg1),
            old_version    : arg2,
            new_version    : v0,
            dek_commitment : dek_commitment(&arg3),
            by             : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DekVersionBumped>(v1);
    }

    entry fun create_namespace(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &mut NamespaceRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = new_namespace(v0, arg2, 0x2::clock::timestamp_ms(arg3), false, arg4);
        register_namespace(arg1, 0x2::tx_context::sender(arg4), v1.name, 0x2::object::id<MemoryNamespace>(&v1));
        0x2::transfer::share_object<MemoryNamespace>(v1);
    }

    entry fun crypto_shred_dek_version(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &mut MemoryNamespace, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 200);
        assert!(0x2::table::contains<u64, vector<u8>>(&arg1.wrapped_deks, arg2), 213);
        assert!(arg2 != arg1.current_dek_version, 214);
        0x2::table::remove<u64, vector<u8>>(&mut arg1.wrapped_deks, arg2);
        let v0 = DekVersionShredded{
            namespace_id : 0x2::object::id<MemoryNamespace>(arg1),
            dek_version  : arg2,
            by           : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DekVersionShredded>(v0);
    }

    public fun current_dek_version(arg0: &MemoryNamespace) : u64 {
        arg0.current_dek_version
    }

    public fun defined_bits() : u32 {
        31
    }

    fun dek_commitment(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
    }

    public(friend) fun effective_acl_bits(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account, arg2: &MemoryNamespace, arg3: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg4: address) : u32 {
        assert_version(arg0, arg2);
        assert!(0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::is_active(arg1), 215);
        let v0 = 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::owner(arg1);
        assert!(0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::is_canonical_account(arg3, v0, 0x2::object::id<0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account>(arg1)), 208);
        let v1 = if (0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::is_root_key(arg1, arg4)) {
            4294967295
        } else {
            0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::delegate_acl_limit_for(arg1, arg4, 0x2::object::id<MemoryNamespace>(arg2))
        };
        principal_acl_bits_for(arg2, v0) & v1
    }

    public fun extend_bit() : u32 {
        4
    }

    public fun full() : u32 {
        4294967295
    }

    public fun has_acl_entry(arg0: &MemoryNamespace, arg1: address) : bool {
        0x2::table::contains<address, u32>(&arg0.principal_acl, arg1)
    }

    public fun has_namespace(arg0: &NamespaceRegistry, arg1: address, arg2: 0x1::string::String) : bool {
        let v0 = NamespaceKey{
            owner : arg1,
            name  : arg2,
        };
        0x2::table::contains<NamespaceKey, 0x2::object::ID>(&arg0.namespaces, v0)
    }

    public fun has_wrapped_dek(arg0: &MemoryNamespace, arg1: u64) : bool {
        0x2::table::contains<u64, vector<u8>>(&arg0.wrapped_deks, arg1)
    }

    public fun id_of(arg0: &NamespaceRegistry, arg1: address, arg2: 0x1::string::String) : 0x2::object::ID {
        let v0 = NamespaceKey{
            owner : arg1,
            name  : arg2,
        };
        *0x2::table::borrow<NamespaceKey, 0x2::object::ID>(&arg0.namespaces, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NamespaceRegistry{
            id         : 0x2::object::new(arg0),
            namespaces : 0x2::table::new<NamespaceKey, 0x2::object::ID>(arg0),
        };
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::stamp(&mut v0.id);
        0x2::transfer::share_object<NamespaceRegistry>(v0);
    }

    fun insert_wrapped_dek(arg0: &mut MemoryNamespace, arg1: u64, arg2: vector<u8>) {
        assert!(!0x2::table::contains<u64, vector<u8>>(&arg0.wrapped_deks, arg1), 206);
        0x2::table::add<u64, vector<u8>>(&mut arg0.wrapped_deks, arg1, arg2);
    }

    public fun is_migrated_v1(arg0: &MemoryNamespace) : bool {
        arg0.migrated_v1
    }

    public fun metadata_blob_write_bit() : u32 {
        16
    }

    public fun metadata_write_bit() : u32 {
        8
    }

    entry fun migrate_v1_create_namespace(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::MigrationCap, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg2: &mut NamespaceRegistry, arg3: address, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg1, &arg2.id);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_migration_open(arg1);
        let v0 = new_namespace(arg3, arg4, arg5, true, arg6);
        register_namespace(arg2, arg3, v0.name, 0x2::object::id<MemoryNamespace>(&v0));
        0x2::transfer::share_object<MemoryNamespace>(v0);
    }

    entry fun migrate_v1_import_account(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::MigrationCap, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg2: &mut 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg3: &mut NamespaceRegistry, arg4: address, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x1::string::String, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg1, &arg3.id);
        let v0 = 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::import_account_for_migration(arg0, arg1, arg2, arg4, arg5, arg6, arg8, arg9, arg10);
        let v1 = new_namespace(arg4, arg7, arg8, true, arg10);
        register_namespace(arg3, arg4, v1.name, 0x2::object::id<MemoryNamespace>(&v1));
        0x2::transfer::public_share_object<0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account>(v0);
        0x2::transfer::share_object<MemoryNamespace>(v1);
    }

    entry fun migrate_v1_seed_initial_dek(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::MigrationCap, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg2: &mut MemoryNamespace, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg1, &arg2.id);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_migration_open(arg1);
        assert_migrated_v1(arg2);
        assert!(arg2.current_dek_version == 0, 211);
        insert_wrapped_dek(arg2, 1, arg3);
        arg2.current_dek_version = 1;
        let v0 = WrappedDekSet{
            namespace_id   : 0x2::object::id<MemoryNamespace>(arg2),
            dek_version    : 1,
            dek_commitment : dek_commitment(&arg3),
            by             : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<WrappedDekSet>(v0);
    }

    public fun name(arg0: &MemoryNamespace) : &0x1::string::String {
        &arg0.name
    }

    fun new_namespace(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : MemoryNamespace {
        let v0 = MemoryNamespace{
            id                  : 0x2::object::new(arg4),
            owner               : arg0,
            name                : arg1,
            principal_acl       : 0x2::table::new<address, u32>(arg4),
            current_dek_version : 0,
            wrapped_deks        : 0x2::table::new<u64, vector<u8>>(arg4),
            created_at          : arg2,
            migrated_v1         : arg3,
        };
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::stamp(&mut v0.id);
        let v1 = NamespaceCreated{
            namespace_id : 0x2::object::id<MemoryNamespace>(&v0),
            owner        : arg0,
            name         : v0.name,
            by           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NamespaceCreated>(v1);
        v0
    }

    public(friend) fun principal_acl_bits_for(arg0: &MemoryNamespace, arg1: address) : u32 {
        if (arg1 == arg0.owner) {
            4294967295
        } else if (0x2::table::contains<address, u32>(&arg0.principal_acl, arg1)) {
            *0x2::table::borrow<address, u32>(&arg0.principal_acl, arg1)
        } else {
            0
        }
    }

    public fun read_bit() : u32 {
        1
    }

    fun register_namespace(arg0: &mut NamespaceRegistry, arg1: address, arg2: 0x1::string::String, arg3: 0x2::object::ID) {
        let v0 = NamespaceKey{
            owner : arg1,
            name  : arg2,
        };
        assert!(!0x2::table::contains<NamespaceKey, 0x2::object::ID>(&arg0.namespaces, v0), 207);
        0x2::table::add<NamespaceKey, 0x2::object::ID>(&mut arg0.namespaces, v0, arg3);
    }

    public fun registry_version(arg0: &NamespaceRegistry) : u64 {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::stored(&arg0.id)
    }

    fun rekey_namespace_registry(arg0: &mut NamespaceRegistry, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::string::String, arg4: address, arg5: 0x1::string::String) {
        let v0 = NamespaceKey{
            owner : arg2,
            name  : arg3,
        };
        assert!(0x2::table::contains<NamespaceKey, 0x2::object::ID>(&arg0.namespaces, v0), 208);
        assert!(0x2::table::remove<NamespaceKey, 0x2::object::ID>(&mut arg0.namespaces, v0) == arg1, 208);
        let v1 = NamespaceKey{
            owner : arg4,
            name  : arg5,
        };
        assert!(!0x2::table::contains<NamespaceKey, 0x2::object::ID>(&arg0.namespaces, v1), 207);
        0x2::table::add<NamespaceKey, 0x2::object::ID>(&mut arg0.namespaces, v1, arg1);
    }

    entry fun remove_principal_acl(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &mut MemoryNamespace, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 200);
        if (0x2::table::contains<address, u32>(&arg1.principal_acl, arg2)) {
            let v0 = PrincipalAclRemoved{
                namespace_id : 0x2::object::id<MemoryNamespace>(arg1),
                principal    : arg2,
                old_bits     : 0x2::table::remove<address, u32>(&mut arg1.principal_acl, arg2),
                by           : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<PrincipalAclRemoved>(v0);
        };
    }

    entry fun rename_namespace(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &mut MemoryNamespace, arg2: &mut NamespaceRegistry, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg2.id);
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 200);
        let v0 = arg1.name;
        rekey_namespace_registry(arg2, 0x2::object::id<MemoryNamespace>(arg1), arg1.owner, v0, arg1.owner, arg3);
        arg1.name = arg3;
        let v1 = NamespaceRenamed{
            namespace_id : 0x2::object::id<MemoryNamespace>(arg1),
            old_name     : v0,
            new_name     : arg3,
            by           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NamespaceRenamed>(v1);
    }

    entry fun revoke_reader_and_rotate(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &mut MemoryNamespace, arg2: address, arg3: u32, arg4: u64, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
        assert!(0x2::tx_context::sender(arg6) == arg1.owner, 200);
        assert!(arg2 != arg1.owner, 204);
        let v0 = if (0x2::table::contains<address, u32>(&arg1.principal_acl, arg2)) {
            *0x2::table::borrow<address, u32>(&arg1.principal_acl, arg2)
        } else {
            0
        };
        if (arg3 == 0) {
            if (0x2::table::contains<address, u32>(&arg1.principal_acl, arg2)) {
                0x2::table::remove<address, u32>(&mut arg1.principal_acl, arg2);
            };
            let v1 = PrincipalAclRemoved{
                namespace_id : 0x2::object::id<MemoryNamespace>(arg1),
                principal    : arg2,
                old_bits     : v0,
                by           : 0x2::tx_context::sender(arg6),
            };
            0x2::event::emit<PrincipalAclRemoved>(v1);
        } else {
            assert_valid_grant(arg3);
            if (0x2::table::contains<address, u32>(&arg1.principal_acl, arg2)) {
                *0x2::table::borrow_mut<address, u32>(&mut arg1.principal_acl, arg2) = arg3;
            } else {
                0x2::table::add<address, u32>(&mut arg1.principal_acl, arg2, arg3);
            };
            let v2 = PrincipalAclSet{
                namespace_id : 0x2::object::id<MemoryNamespace>(arg1),
                principal    : arg2,
                old_bits     : v0,
                new_bits     : arg3,
                by           : 0x2::tx_context::sender(arg6),
            };
            0x2::event::emit<PrincipalAclSet>(v2);
        };
        assert!(arg1.current_dek_version == arg4, 210);
        let v3 = arg4 + 1;
        insert_wrapped_dek(arg1, v3, arg5);
        arg1.current_dek_version = v3;
        let v4 = DekVersionBumped{
            namespace_id   : 0x2::object::id<MemoryNamespace>(arg1),
            old_version    : arg4,
            new_version    : v3,
            dek_commitment : dek_commitment(&arg5),
            by             : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<DekVersionBumped>(v4);
    }

    entry fun seed_initial_dek(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &mut MemoryNamespace, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 200);
        assert!(arg1.current_dek_version == 0, 211);
        insert_wrapped_dek(arg1, 1, arg2);
        arg1.current_dek_version = 1;
        let v0 = WrappedDekSet{
            namespace_id   : 0x2::object::id<MemoryNamespace>(arg1),
            dek_version    : 1,
            dek_commitment : dek_commitment(&arg2),
            by             : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WrappedDekSet>(v0);
    }

    entry fun set_principal_acl(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &mut MemoryNamespace, arg2: address, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 200);
        assert_valid_grant(arg3);
        assert!(arg2 != arg1.owner, 204);
        let v0 = if (0x2::table::contains<address, u32>(&arg1.principal_acl, arg2)) {
            let v1 = 0x2::table::borrow_mut<address, u32>(&mut arg1.principal_acl, arg2);
            *v1 = arg3;
            *v1
        } else {
            0x2::table::add<address, u32>(&mut arg1.principal_acl, arg2, arg3);
            0
        };
        let v2 = PrincipalAclSet{
            namespace_id : 0x2::object::id<MemoryNamespace>(arg1),
            principal    : arg2,
            old_bits     : v0,
            new_bits     : arg3,
            by           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PrincipalAclSet>(v2);
    }

    entry fun transfer_namespace_ownership(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &mut MemoryNamespace, arg2: &mut NamespaceRegistry, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg2.id);
        assert!(0x2::tx_context::sender(arg6) == arg1.owner, 200);
        assert!(arg1.current_dek_version == arg4, 210);
        let v0 = arg1.owner;
        rekey_namespace_registry(arg2, 0x2::object::id<MemoryNamespace>(arg1), v0, arg1.name, arg3, arg1.name);
        arg1.owner = arg3;
        let v1 = arg4 + 1;
        insert_wrapped_dek(arg1, v1, arg5);
        arg1.current_dek_version = v1;
        let v2 = NamespaceOwnershipTransferred{
            namespace_id    : 0x2::object::id<MemoryNamespace>(arg1),
            old_owner       : v0,
            new_owner       : arg3,
            new_dek_version : v1,
            by              : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<NamespaceOwnershipTransferred>(v2);
        let v3 = DekVersionBumped{
            namespace_id   : 0x2::object::id<MemoryNamespace>(arg1),
            old_version    : arg4,
            new_version    : v1,
            dek_commitment : dek_commitment(&arg5),
            by             : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<DekVersionBumped>(v3);
    }

    public fun version(arg0: &MemoryNamespace) : u64 {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::stored(&arg0.id)
    }

    public fun wrapped_dek(arg0: &MemoryNamespace, arg1: u64) : &vector<u8> {
        0x2::table::borrow<u64, vector<u8>>(&arg0.wrapped_deks, arg1)
    }

    public fun write_bit() : u32 {
        2
    }

    // decompiled from Move bytecode v7
}

