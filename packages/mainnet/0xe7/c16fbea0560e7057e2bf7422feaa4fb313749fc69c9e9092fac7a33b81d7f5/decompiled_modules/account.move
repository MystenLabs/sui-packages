module 0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account {
    struct AccountRegistry has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, 0x2::object::ID>,
        migration_finalized: bool,
        pinned_allowlist_root: 0x1::option::Option<vector<u8>>,
        expected_account_imports: u64,
        expected_delegate_imports: u64,
        imported_accounts: u64,
        imported_delegates: u64,
        version: u64,
    }

    struct MemWalAccount has store, key {
        id: 0x2::object::UID,
        owner: address,
        delegate_keys: vector<DelegateKey>,
        created_at: u64,
        active: bool,
        admin_quarantined: bool,
        legacy_account_id: 0x1::option::Option<0x2::object::ID>,
        access_counter_version: u64,
    }

    struct DelegateKey has copy, drop, store {
        public_key: vector<u8>,
        sui_address: address,
        label: 0x1::string::String,
        created_at: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MigrationCap has key {
        id: 0x2::object::UID,
        allowlist_root: vector<u8>,
    }

    struct AccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct AccountImported has copy, drop {
        legacy_account_id: 0x2::object::ID,
        new_account_id: 0x2::object::ID,
        owner: address,
    }

    struct DelegateKeyAdded has copy, drop {
        account_id: 0x2::object::ID,
        public_key: vector<u8>,
        sui_address: address,
        label: 0x1::string::String,
    }

    struct DelegateKeyRemoved has copy, drop {
        account_id: 0x2::object::ID,
        public_key: vector<u8>,
        sui_address: address,
    }

    struct AccountDeactivated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct AccountReactivated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct AccountQuarantined has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct AccountQuarantineCleared has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct RegistryMigrated has copy, drop {
        registry_id: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct MigrationCapMinted has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct MigrationCapBurned has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct MigrationFinalized has copy, drop {
        registry_id: 0x2::object::ID,
        completion_evidence_sha256: vector<u8>,
        evidence_expires_at_ms: u64,
    }

    struct AllowlistRootPinned has copy, drop {
        registry_id: 0x2::object::ID,
        root: vector<u8>,
        expected_account_imports: u64,
        expected_delegate_imports: u64,
    }

    struct AllowlistRootRepinned has copy, drop {
        registry_id: 0x2::object::ID,
        old_root: vector<u8>,
        new_root: vector<u8>,
        expected_account_imports: u64,
        expected_delegate_imports: u64,
    }

    public fun access_counter_version(arg0: &MemWalAccount) : u64 {
        arg0.access_counter_version
    }

    entry fun add_delegate_key(arg0: &mut MemWalAccount, arg1: &AccountRegistry, arg2: vector<u8>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 4, 7);
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 4);
        assert!(arg1.migration_finalized, 18);
        assert!(arg0.active, 6);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg3)) <= 64, 10);
        assert!(0x1::vector::length<DelegateKey>(&arg0.delegate_keys) < 20, 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelegateKey>(&arg0.delegate_keys)) {
            assert!(0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v0).public_key != arg2, 0);
            v0 = v0 + 1;
        };
        let v1 = DelegateKey{
            public_key  : arg2,
            sui_address : derive_sui_address(&arg2),
            label       : arg3,
            created_at  : 0x2::clock::timestamp_ms(arg4),
        };
        let v2 = DelegateKeyAdded{
            account_id  : 0x2::object::id<MemWalAccount>(arg0),
            public_key  : v1.public_key,
            sui_address : v1.sui_address,
            label       : v1.label,
        };
        0x2::event::emit<DelegateKeyAdded>(v2);
        0x1::vector::push_back<DelegateKey>(&mut arg0.delegate_keys, v1);
    }

    entry fun admin_clear_quarantine(arg0: &AdminCap, arg1: &AccountRegistry, arg2: &mut MemWalAccount) {
        assert!(arg1.version == 4, 7);
        if (!arg2.admin_quarantined) {
            return
        };
        arg2.admin_quarantined = false;
        let v0 = AccountQuarantineCleared{
            account_id : 0x2::object::id<MemWalAccount>(arg2),
            owner      : arg2.owner,
        };
        0x2::event::emit<AccountQuarantineCleared>(v0);
    }

    entry fun admin_deactivate_account(arg0: &AdminCap, arg1: &mut MemWalAccount) {
        if (arg1.admin_quarantined) {
            return
        };
        arg1.admin_quarantined = true;
        rotate_access_counter(arg1);
        if (arg1.active) {
            arg1.active = false;
            let v0 = AccountDeactivated{
                account_id : 0x2::object::id<MemWalAccount>(arg1),
                owner      : arg1.owner,
            };
            0x2::event::emit<AccountDeactivated>(v0);
        };
        let v1 = AccountQuarantined{
            account_id : 0x2::object::id<MemWalAccount>(arg1),
            owner      : arg1.owner,
        };
        0x2::event::emit<AccountQuarantined>(v1);
    }

    fun assert_migration_proof(arg0: &vector<u8>, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<bool>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 14);
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<bool>(&arg3), 14);
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v2 = if (*0x1::vector::borrow<bool>(&arg3, v1)) {
                migration_merkle_parent(0x1::vector::borrow<vector<u8>>(&arg2, v1), &v0)
            } else {
                migration_merkle_parent(&v0, 0x1::vector::borrow<vector<u8>>(&arg2, v1))
            };
            v0 = v2;
            v1 = v1 + 1;
        };
        assert!(v0 == *arg0, 14);
    }

    fun assert_seal_id_owner(arg0: &vector<u8>, arg1: &MemWalAccount) : u64 {
        let v0 = 0x2::bcs::to_bytes<address>(&arg1.owner);
        assert!(0x1::vector::length<u8>(arg0) >= 0x1::vector::length<u8>(&v0) + 8, 100);
        let v1 = seal_id_counter(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        assert!(has_suffix(arg0, &v0), 100);
        v1
    }

    public fun burn_migration_cap(arg0: MigrationCap) {
        let MigrationCap {
            id             : v0,
            allowlist_root : _,
        } = arg0;
        let v2 = v0;
        0x2::object::delete(v2);
        let v3 = MigrationCapBurned{cap_id: 0x2::object::uid_to_inner(&v2)};
        0x2::event::emit<MigrationCapBurned>(v3);
    }

    entry fun create_account(arg0: &mut AccountRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 4, 7);
        assert!(arg0.migration_finalized, 18);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, v0), 3);
        let v1 = MemWalAccount{
            id                     : 0x2::object::new(arg2),
            owner                  : v0,
            delegate_keys          : 0x1::vector::empty<DelegateKey>(),
            created_at             : 0x2::clock::timestamp_ms(arg1),
            active                 : true,
            admin_quarantined      : false,
            legacy_account_id      : 0x1::option::none<0x2::object::ID>(),
            access_counter_version : 0,
        };
        let v2 = 0x2::object::id<MemWalAccount>(&v1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.accounts, v0, v2);
        let v3 = AccountCreated{
            account_id : v2,
            owner      : v0,
        };
        0x2::event::emit<AccountCreated>(v3);
        0x2::transfer::share_object<MemWalAccount>(v1);
    }

    public fun current_version() : u64 {
        4
    }

    entry fun deactivate_account(arg0: &mut MemWalAccount, arg1: &AccountRegistry, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 4, 7);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        assert!(arg1.migration_finalized, 18);
        assert!(arg0.active, 6);
        arg0.active = false;
        rotate_access_counter(arg0);
        let v0 = AccountDeactivated{
            account_id : 0x2::object::id<MemWalAccount>(arg0),
            owner      : arg0.owner,
        };
        0x2::event::emit<AccountDeactivated>(v0);
    }

    public fun delegate_address_at(arg0: &MemWalAccount, arg1: u64) : address {
        0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, arg1).sui_address
    }

    public fun delegate_count(arg0: &MemWalAccount) : u64 {
        0x1::vector::length<DelegateKey>(&arg0.delegate_keys)
    }

    public fun delegate_key_at(arg0: &MemWalAccount, arg1: u64) : &vector<u8> {
        &0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, arg1).public_key
    }

    public fun delegate_label_at(arg0: &MemWalAccount, arg1: u64) : &0x1::string::String {
        &0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, arg1).label
    }

    public fun derive_sui_address(arg0: &vector<u8>) : address {
        assert!(0x1::vector::length<u8>(arg0) == 32, 5);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    entry fun finalize_migration(arg0: &AdminCap, arg1: &mut AccountRegistry, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: u64) {
        assert!(arg1.version == 4, 7);
        assert!(!arg1.migration_finalized, 12);
        assert!(0x1::option::is_some<vector<u8>>(&arg1.pinned_allowlist_root), 17);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 22);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 <= arg4, 23);
        assert!(arg4 <= v0 + 900000, 22);
        assert!(arg1.imported_accounts == arg1.expected_account_imports && arg1.imported_delegates == arg1.expected_delegate_imports, 21);
        arg1.migration_finalized = true;
        let v1 = MigrationFinalized{
            registry_id                : 0x2::object::id<AccountRegistry>(arg1),
            completion_evidence_sha256 : arg3,
            evidence_expires_at_ms     : arg4,
        };
        0x2::event::emit<MigrationFinalized>(v1);
    }

    public fun has_account(arg0: &AccountRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, arg1)
    }

    fun has_suffix(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v1 > v0) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            if (*0x1::vector::borrow<u8>(arg0, v0 - v1 + v2) != *0x1::vector::borrow<u8>(arg1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountRegistry{
            id                        : 0x2::object::new(arg0),
            accounts                  : 0x2::table::new<address, 0x2::object::ID>(arg0),
            migration_finalized       : false,
            pinned_allowlist_root     : 0x1::option::none<vector<u8>>(),
            expected_account_imports  : 0,
            expected_delegate_imports : 0,
            imported_accounts         : 0,
            imported_delegates        : 0,
            version                   : 4,
        };
        0x2::transfer::share_object<AccountRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &MemWalAccount) : bool {
        arg0.active
    }

    public fun is_admin_quarantined(arg0: &MemWalAccount) : bool {
        arg0.admin_quarantined
    }

    public fun is_delegate(arg0: &MemWalAccount, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelegateKey>(&arg0.delegate_keys)) {
            if (&0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v0).public_key == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_delegate_address(arg0: &MemWalAccount, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelegateKey>(&arg0.delegate_keys)) {
            if (0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v0).sui_address == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_legacy_imported(arg0: &MemWalAccount) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.legacy_account_id)
    }

    public fun legacy_account_id(arg0: &MemWalAccount) : 0x1::option::Option<0x2::object::ID> {
        arg0.legacy_account_id
    }

    entry fun legacy_import_account(arg0: &MigrationCap, arg1: &mut AccountRegistry, arg2: 0x2::object::ID, arg3: address, arg4: bool, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<bool>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 4, 7);
        assert!(!arg1.migration_finalized, 12);
        assert!(0x1::option::is_some<vector<u8>>(&arg1.pinned_allowlist_root), 17);
        assert!(0x1::option::borrow<vector<u8>>(&arg1.pinned_allowlist_root) == &arg0.allowlist_root, 16);
        assert_migration_proof(&arg0.allowlist_root, migration_account_leaf(arg2, arg3, arg4, arg5), arg6, arg7);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.accounts, arg3), 3);
        assert!(arg1.imported_accounts < arg1.expected_account_imports, 21);
        let v0 = MemWalAccount{
            id                     : 0x2::object::new(arg8),
            owner                  : arg3,
            delegate_keys          : 0x1::vector::empty<DelegateKey>(),
            created_at             : arg5,
            active                 : arg4,
            admin_quarantined      : false,
            legacy_account_id      : 0x1::option::some<0x2::object::ID>(arg2),
            access_counter_version : 0,
        };
        let v1 = 0x2::object::id<MemWalAccount>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.accounts, arg3, v1);
        arg1.imported_accounts = arg1.imported_accounts + 1;
        let v2 = AccountCreated{
            account_id : v1,
            owner      : arg3,
        };
        0x2::event::emit<AccountCreated>(v2);
        let v3 = AccountImported{
            legacy_account_id : arg2,
            new_account_id    : v1,
            owner             : arg3,
        };
        0x2::event::emit<AccountImported>(v3);
        0x2::transfer::share_object<MemWalAccount>(v0);
    }

    entry fun legacy_import_delegate_key(arg0: &MigrationCap, arg1: &mut AccountRegistry, arg2: &mut MemWalAccount, arg3: vector<u8>, arg4: 0x1::string::String, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<bool>) {
        assert!(arg1.version == 4, 7);
        assert!(!arg1.migration_finalized, 12);
        assert!(0x1::option::is_some<vector<u8>>(&arg1.pinned_allowlist_root), 17);
        assert!(0x1::option::borrow<vector<u8>>(&arg1.pinned_allowlist_root) == &arg0.allowlist_root, 16);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg2.legacy_account_id), 13);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 5);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg4)) <= 64, 10);
        assert_migration_proof(&arg0.allowlist_root, migration_delegate_leaf(*0x1::option::borrow<0x2::object::ID>(&arg2.legacy_account_id), &arg3, &arg4, arg5), arg6, arg7);
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelegateKey>(&arg2.delegate_keys)) {
            if (0x1::vector::borrow<DelegateKey>(&arg2.delegate_keys, v0).public_key == arg3) {
                return
            };
            v0 = v0 + 1;
        };
        assert!(0x1::vector::length<DelegateKey>(&arg2.delegate_keys) < 20, 2);
        assert!(arg1.imported_delegates < arg1.expected_delegate_imports, 21);
        let v1 = DelegateKey{
            public_key  : arg3,
            sui_address : derive_sui_address(&arg3),
            label       : arg4,
            created_at  : arg5,
        };
        let v2 = DelegateKeyAdded{
            account_id  : 0x2::object::id<MemWalAccount>(arg2),
            public_key  : v1.public_key,
            sui_address : v1.sui_address,
            label       : v1.label,
        };
        0x2::event::emit<DelegateKeyAdded>(v2);
        0x1::vector::push_back<DelegateKey>(&mut arg2.delegate_keys, v1);
        arg1.imported_delegates = arg1.imported_delegates + 1;
    }

    entry fun migrate_registry(arg0: &AdminCap, arg1: &mut AccountRegistry) {
        let v0 = arg1.version;
        assert!(v0 < 4, 9);
        arg1.version = 4;
        let v1 = RegistryMigrated{
            registry_id : 0x2::object::id<AccountRegistry>(arg1),
            from        : v0,
            to          : 4,
        };
        0x2::event::emit<RegistryMigrated>(v1);
    }

    public fun migration_account_leaf(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64) : vector<u8> {
        let v0 = x"0400";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<bool>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x2::hash::blake2b256(&v0)
    }

    public fun migration_delegate_leaf(arg0: 0x2::object::ID, arg1: &vector<u8>, arg2: &0x1::string::String, arg3: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg1) == 32, 5);
        let v0 = x"0401";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x2::hash::blake2b256(&v0)
    }

    fun migration_merkle_parent(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) == 32, 14);
        assert!(0x1::vector::length<u8>(arg1) == 32, 14);
        let v0 = x"0402";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x2::hash::blake2b256(&v0)
    }

    public fun mint_migration_cap(arg0: &AdminCap, arg1: &AccountRegistry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : MigrationCap {
        assert!(arg1.version == 4, 7);
        assert!(!arg1.migration_finalized, 12);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 14);
        assert!(0x1::option::is_some<vector<u8>>(&arg1.pinned_allowlist_root), 17);
        assert!(0x1::option::borrow<vector<u8>>(&arg1.pinned_allowlist_root) == &arg2, 16);
        let v0 = MigrationCap{
            id             : 0x2::object::new(arg3),
            allowlist_root : arg2,
        };
        let v1 = MigrationCapMinted{cap_id: 0x2::object::id<MigrationCap>(&v0)};
        0x2::event::emit<MigrationCapMinted>(v1);
        v0
    }

    public fun owner(arg0: &MemWalAccount) : address {
        arg0.owner
    }

    entry fun pin_allowlist_root(arg0: &AdminCap, arg1: &mut AccountRegistry, arg2: vector<u8>, arg3: u64, arg4: u64) {
        assert!(arg1.version == 4, 7);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 14);
        assert!(0x1::option::is_none<vector<u8>>(&arg1.pinned_allowlist_root), 15);
        0x1::option::fill<vector<u8>>(&mut arg1.pinned_allowlist_root, arg2);
        arg1.expected_account_imports = arg3;
        arg1.expected_delegate_imports = arg4;
        let v0 = AllowlistRootPinned{
            registry_id               : 0x2::object::id<AccountRegistry>(arg1),
            root                      : arg2,
            expected_account_imports  : arg3,
            expected_delegate_imports : arg4,
        };
        0x2::event::emit<AllowlistRootPinned>(v0);
    }

    public fun pinned_allowlist_root(arg0: &AccountRegistry) : 0x1::option::Option<vector<u8>> {
        arg0.pinned_allowlist_root
    }

    entry fun reactivate_account(arg0: &mut MemWalAccount, arg1: &AccountRegistry, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 4, 7);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        assert!(arg1.migration_finalized, 18);
        assert!(!arg0.admin_quarantined, 20);
        assert!(!arg0.active, 11);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.legacy_account_id) && arg0.access_counter_version == 0) {
            rotate_access_counter(arg0);
        };
        arg0.active = true;
        let v0 = AccountReactivated{
            account_id : 0x2::object::id<MemWalAccount>(arg0),
            owner      : arg0.owner,
        };
        0x2::event::emit<AccountReactivated>(v0);
    }

    public fun registry_version(arg0: &AccountRegistry) : u64 {
        arg0.version
    }

    entry fun remove_delegate_key(arg0: &mut MemWalAccount, arg1: &AccountRegistry, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 4, 7);
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 4);
        assert!(arg1.migration_finalized, 18);
        let v0 = false;
        let v1 = @0x0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<DelegateKey>(&arg0.delegate_keys)) {
            if (0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v2).public_key == arg2) {
                v1 = 0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v2).sui_address;
                0x1::vector::remove<DelegateKey>(&mut arg0.delegate_keys, v2);
                v0 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v0, 1);
        rotate_access_counter(arg0);
        let v3 = DelegateKeyRemoved{
            account_id  : 0x2::object::id<MemWalAccount>(arg0),
            public_key  : arg2,
            sui_address : v1,
        };
        0x2::event::emit<DelegateKeyRemoved>(v3);
    }

    entry fun repin_allowlist_root(arg0: &AdminCap, arg1: &mut AccountRegistry, arg2: vector<u8>, arg3: u64, arg4: u64) {
        assert!(arg1.version == 4, 7);
        assert!(!arg1.migration_finalized, 12);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 14);
        assert!(0x1::option::is_some<vector<u8>>(&arg1.pinned_allowlist_root), 17);
        assert!(arg1.imported_accounts == 0 && arg1.imported_delegates == 0, 24);
        let v0 = 0x1::option::borrow_mut<vector<u8>>(&mut arg1.pinned_allowlist_root);
        *v0 = arg2;
        arg1.expected_account_imports = arg3;
        arg1.expected_delegate_imports = arg4;
        let v1 = AllowlistRootRepinned{
            registry_id               : 0x2::object::id<AccountRegistry>(arg1),
            old_root                  : *v0,
            new_root                  : arg2,
            expected_account_imports  : arg3,
            expected_delegate_imports : arg4,
        };
        0x2::event::emit<AllowlistRootRepinned>(v1);
    }

    fun rotate_access_counter(arg0: &mut MemWalAccount) {
        arg0.access_counter_version = arg0.access_counter_version + 1;
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &AccountRegistry, arg2: &MemWalAccount, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 4, 7);
        assert!(arg2.active, 6);
        assert!(assert_seal_id_owner(&arg0, arg2) <= arg2.access_counter_version, 100);
        let v0 = 0x2::tx_context::sender(arg3);
        if (v0 == arg2.owner) {
            return
        };
        assert!(is_delegate_address(arg2, v0), 100);
    }

    entry fun seal_encrypt_fence(arg0: vector<u8>, arg1: &AccountRegistry, arg2: &MemWalAccount) {
        assert!(arg1.version == 4, 7);
        assert!(assert_seal_id_owner(&arg0, arg2) == arg2.access_counter_version, 100);
    }

    fun seal_id_counter(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, 0x1::vector::length<u8>(arg0) - 8 + v1) as u64) << ((8 * v1) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun seal_key_id(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        v0
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun transfer_migration_cap(arg0: MigrationCap, arg1: address) {
        0x2::transfer::transfer<MigrationCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

