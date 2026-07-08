module 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::account {
    struct AccountRegistry has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct Account has store, key {
        id: 0x2::object::UID,
        owner: address,
        delegate_keys: 0x2::table::Table<address, DelegateKey>,
        delegate_limit: u64,
        created_at: u64,
        active: bool,
        legacy_account_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct DelegateKey has store {
        public_key: vector<u8>,
        addr: address,
        label: 0x1::string::String,
        default_acl_limit: u32,
        namespace_acl_limits: 0x2::table::Table<0x2::object::ID, u32>,
        created_at: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MigrationCap has store, key {
        id: 0x2::object::UID,
    }

    struct AccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        origin: u8,
        legacy_account_id: 0x1::option::Option<0x2::object::ID>,
        legacy_package_id: 0x1::option::Option<0x2::object::ID>,
        by: address,
    }

    struct DelegateKeyAdded has copy, drop {
        account_id: 0x2::object::ID,
        delegate_addr: address,
        label: 0x1::string::String,
        default_acl_limit: u32,
        by: address,
    }

    struct DelegateAclLimitSet has copy, drop {
        account_id: 0x2::object::ID,
        delegate_addr: address,
        namespace_id: 0x1::option::Option<0x2::object::ID>,
        limit: u32,
        by: address,
    }

    struct DelegateKeyRevoked has copy, drop {
        account_id: 0x2::object::ID,
        delegate_addr: address,
        by: address,
    }

    struct AccountDeactivated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        by: address,
    }

    struct AccountReactivated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        by: address,
    }

    struct AccountMigrated has copy, drop {
        account_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
        by: address,
    }

    struct AccountRegistryMigrated has copy, drop {
        registry_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
        by: address,
    }

    struct MigrationCapMinted has copy, drop {
        cap_id: 0x2::object::ID,
        by: address,
    }

    struct MigrationCapBurned has copy, drop {
        cap_id: 0x2::object::ID,
        by: address,
    }

    entry fun add_delegate_key(arg0: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::ProtocolVersion, arg1: &mut Account, arg2: vector<u8>, arg3: address, arg4: 0x1::string::String, arg5: u32, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::assert_current(arg0, &arg1.id);
        assert!(arg1.owner == 0x2::tx_context::sender(arg7), 4);
        assert!(arg1.active, 6);
        let v0 = 0x2::tx_context::sender(arg7);
        add_delegate_key_internal(arg1, arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6), v0, arg7);
    }

    fun add_delegate_key_internal(arg0: &mut Account, arg1: vector<u8>, arg2: address, arg3: 0x1::string::String, arg4: u32, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        assert!(arg2 == ed25519_address(&arg1), 13);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg3)) <= 64, 10);
        assert_valid_acl_limit(arg4);
        assert!(0x2::table::length<address, DelegateKey>(&arg0.delegate_keys) < arg0.delegate_limit, 2);
        assert!(!0x2::table::contains<address, DelegateKey>(&arg0.delegate_keys, arg2), 0);
        let v0 = DelegateKey{
            public_key           : arg1,
            addr                 : arg2,
            label                : arg3,
            default_acl_limit    : arg4,
            namespace_acl_limits : 0x2::table::new<0x2::object::ID, u32>(arg7),
            created_at           : arg5,
        };
        let v1 = DelegateKeyAdded{
            account_id        : 0x2::object::id<Account>(arg0),
            delegate_addr     : v0.addr,
            label             : v0.label,
            default_acl_limit : v0.default_acl_limit,
            by                : arg6,
        };
        0x2::event::emit<DelegateKeyAdded>(v1);
        0x2::table::add<address, DelegateKey>(&mut arg0.delegate_keys, arg2, v0);
    }

    entry fun admin_migrate_account(arg0: &AdminCap, arg1: &mut Account, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::stored(&arg1.id);
        assert!(v0 < 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::current(), 9);
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::stamp(&mut arg1.id);
        let v1 = AccountMigrated{
            account_id   : 0x2::object::id<Account>(arg1),
            from_version : v0,
            to_version   : 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::current(),
            by           : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AccountMigrated>(v1);
    }

    entry fun admin_migrate_account_registry(arg0: &AdminCap, arg1: &mut AccountRegistry, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::stored(&arg1.id);
        assert!(v0 < 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::current(), 9);
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::stamp(&mut arg1.id);
        let v1 = AccountRegistryMigrated{
            registry_id  : 0x2::object::id<AccountRegistry>(arg1),
            from_version : v0,
            to_version   : 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::current(),
            by           : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AccountRegistryMigrated>(v1);
    }

    entry fun admin_upgrade_protocol(arg0: &AdminCap, arg1: &mut 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::ProtocolVersion) {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::upgrade_protocol(arg1);
    }

    fun assert_valid_acl_limit(arg0: u32) {
        assert!(arg0 == 4294967295 || arg0 & (31 ^ 4294967295) == 0, 12);
    }

    fun borrow_delegate_mut(arg0: &mut Account, arg1: address) : &mut DelegateKey {
        assert!(0x2::table::contains<address, DelegateKey>(&arg0.delegate_keys, arg1), 1);
        0x2::table::borrow_mut<address, DelegateKey>(&mut arg0.delegate_keys, arg1)
    }

    public fun burn_migration_cap(arg0: &AdminCap, arg1: MigrationCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = MigrationCapBurned{
            cap_id : 0x2::object::id<MigrationCap>(&arg1),
            by     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MigrationCapBurned>(v0);
        let MigrationCap { id: v1 } = arg1;
        0x2::object::delete(v1);
    }

    entry fun create_account(arg0: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::ProtocolVersion, arg1: &mut AccountRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::assert_current(arg0, &arg1.id);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.accounts, v0), 3);
        let v1 = Account{
            id                : 0x2::object::new(arg3),
            owner             : v0,
            delegate_keys     : 0x2::table::new<address, DelegateKey>(arg3),
            delegate_limit    : 20,
            created_at        : 0x2::clock::timestamp_ms(arg2),
            active            : true,
            legacy_account_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::stamp(&mut v1.id);
        let v2 = 0x2::object::id<Account>(&v1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.accounts, v0, v2);
        let v3 = AccountCreated{
            account_id        : v2,
            owner             : v0,
            origin            : 0,
            legacy_account_id : 0x1::option::none<0x2::object::ID>(),
            legacy_package_id : 0x1::option::none<0x2::object::ID>(),
            by                : v0,
        };
        0x2::event::emit<AccountCreated>(v3);
        0x2::transfer::share_object<Account>(v1);
    }

    public fun current_version() : u64 {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::current()
    }

    entry fun deactivate_account(arg0: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::ProtocolVersion, arg1: &mut Account, arg2: &0x2::tx_context::TxContext) {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::assert_current(arg0, &arg1.id);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 4);
        assert!(arg1.active, 6);
        arg1.active = false;
        let v0 = AccountDeactivated{
            account_id : 0x2::object::id<Account>(arg1),
            owner      : arg1.owner,
            by         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AccountDeactivated>(v0);
    }

    public fun defined_acl_bits() : u32 {
        31
    }

    public(friend) fun delegate_acl_limit_for(arg0: &Account, arg1: address, arg2: 0x2::object::ID) : u32 {
        if (!0x2::table::contains<address, DelegateKey>(&arg0.delegate_keys, arg1)) {
            abort 100
        };
        let v0 = 0x2::table::borrow<address, DelegateKey>(&arg0.delegate_keys, arg1);
        if (0x2::table::contains<0x2::object::ID, u32>(&v0.namespace_acl_limits, arg2)) {
            *0x2::table::borrow<0x2::object::ID, u32>(&v0.namespace_acl_limits, arg2)
        } else {
            v0.default_acl_limit
        }
    }

    public fun delegate_count(arg0: &Account) : u64 {
        0x2::table::length<address, DelegateKey>(&arg0.delegate_keys)
    }

    fun ed25519_address(arg0: &vector<u8>) : address {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun full_acl_bits() : u32 {
        4294967295
    }

    public fun has_account(arg0: &AccountRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, arg1)
    }

    public fun id_of(arg0: &AccountRegistry, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.accounts, arg1)
    }

    public(friend) fun import_account_for_migration(arg0: &MigrationCap, arg1: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::ProtocolVersion, arg2: &mut AccountRegistry, arg3: address, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : Account {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::assert_current(arg1, &arg2.id);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg2.accounts, arg3), 3);
        let v0 = Account{
            id                : 0x2::object::new(arg8),
            owner             : arg3,
            delegate_keys     : 0x2::table::new<address, DelegateKey>(arg8),
            delegate_limit    : 20,
            created_at        : arg6,
            active            : arg7,
            legacy_account_id : 0x1::option::some<0x2::object::ID>(arg4),
        };
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::stamp(&mut v0.id);
        let v1 = 0x2::object::id<Account>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg2.accounts, arg3, v1);
        let v2 = AccountCreated{
            account_id        : v1,
            owner             : arg3,
            origin            : 1,
            legacy_account_id : 0x1::option::some<0x2::object::ID>(arg4),
            legacy_package_id : 0x1::option::some<0x2::object::ID>(arg5),
            by                : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<AccountCreated>(v2);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountRegistry{
            id       : 0x2::object::new(arg0),
            accounts : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::stamp(&mut v0.id);
        0x2::transfer::share_object<AccountRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &Account) : bool {
        arg0.active
    }

    public fun is_canonical_account(arg0: &AccountRegistry, arg1: address, arg2: 0x2::object::ID) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, arg1) && *0x2::table::borrow<address, 0x2::object::ID>(&arg0.accounts, arg1) == arg2
    }

    public(friend) fun is_root_key(arg0: &Account, arg1: address) : bool {
        arg1 == arg0.owner
    }

    entry fun issue_migration_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MigrationCap>(mint_migration_cap(arg0, arg2), arg1);
    }

    public fun legacy_account_id(arg0: &Account) : &0x1::option::Option<0x2::object::ID> {
        &arg0.legacy_account_id
    }

    entry fun migrate_v1_add_delegate_key(arg0: &MigrationCap, arg1: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::ProtocolVersion, arg2: &mut Account, arg3: vector<u8>, arg4: address, arg5: 0x1::string::String, arg6: u32, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::assert_current(arg1, &arg2.id);
        let v0 = 0x2::tx_context::sender(arg8);
        add_delegate_key_internal(arg2, arg3, arg4, arg5, arg6, arg7, v0, arg8);
    }

    public fun mint_migration_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : MigrationCap {
        let v0 = MigrationCap{id: 0x2::object::new(arg1)};
        let v1 = MigrationCapMinted{
            cap_id : 0x2::object::id<MigrationCap>(&v0),
            by     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<MigrationCapMinted>(v1);
        v0
    }

    public fun owner(arg0: &Account) : address {
        arg0.owner
    }

    entry fun reactivate_account(arg0: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::ProtocolVersion, arg1: &mut Account, arg2: &0x2::tx_context::TxContext) {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::assert_current(arg0, &arg1.id);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 4);
        assert!(!arg1.active, 11);
        arg1.active = true;
        let v0 = AccountReactivated{
            account_id : 0x2::object::id<Account>(arg1),
            owner      : arg1.owner,
            by         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AccountReactivated>(v0);
    }

    public fun registry_version(arg0: &AccountRegistry) : u64 {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::stored(&arg0.id)
    }

    entry fun remove_delegate_key(arg0: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::ProtocolVersion, arg1: &mut Account, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::assert_current(arg0, &arg1.id);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 4);
        let v0 = ed25519_address(&arg2);
        assert!(0x2::table::contains<address, DelegateKey>(&arg1.delegate_keys, v0), 1);
        let DelegateKey {
            public_key           : _,
            addr                 : _,
            label                : _,
            default_acl_limit    : _,
            namespace_acl_limits : v5,
            created_at           : _,
        } = 0x2::table::remove<address, DelegateKey>(&mut arg1.delegate_keys, v0);
        0x2::table::drop<0x2::object::ID, u32>(v5);
        let v7 = DelegateKeyRevoked{
            account_id    : 0x2::object::id<Account>(arg1),
            delegate_addr : v0,
            by            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DelegateKeyRevoked>(v7);
    }

    entry fun revoke_migration_cap(arg0: &AdminCap, arg1: MigrationCap, arg2: &0x2::tx_context::TxContext) {
        burn_migration_cap(arg0, arg1, arg2);
    }

    entry fun set_delegate_acl_limit(arg0: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::ProtocolVersion, arg1: &mut Account, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u32, arg5: &0x2::tx_context::TxContext) {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::assert_current(arg0, &arg1.id);
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 4);
        assert_valid_acl_limit(arg4);
        let v0 = borrow_delegate_mut(arg1, arg2);
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            let v1 = *0x1::option::borrow<0x2::object::ID>(&arg3);
            if (0x2::table::contains<0x2::object::ID, u32>(&v0.namespace_acl_limits, v1)) {
                *0x2::table::borrow_mut<0x2::object::ID, u32>(&mut v0.namespace_acl_limits, v1) = arg4;
            } else {
                0x2::table::add<0x2::object::ID, u32>(&mut v0.namespace_acl_limits, v1, arg4);
            };
        } else {
            v0.default_acl_limit = arg4;
        };
        let v2 = DelegateAclLimitSet{
            account_id    : 0x2::object::id<Account>(arg1),
            delegate_addr : arg2,
            namespace_id  : arg3,
            limit         : arg4,
            by            : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<DelegateAclLimitSet>(v2);
    }

    public fun version(arg0: &Account) : u64 {
        0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::stored(&arg0.id)
    }

    // decompiled from Move bytecode v7
}

