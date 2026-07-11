module 0xe7a2f95ae3897f2d5bca0d1fe0f47967635beb037da40d591bccdcb8b9f8dc2b::account {
    struct AccountRegistry has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, 0x2::object::ID>,
        migration_finalized: bool,
    }

    struct MemWalAccount has store, key {
        id: 0x2::object::UID,
        owner: address,
        delegate_keys: vector<DelegateKey>,
        created_at: u64,
        active: bool,
        migration_created: bool,
    }

    struct DelegateKey has copy, drop, store {
        public_key: vector<u8>,
        sui_address: address,
        label: 0x1::string::String,
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

    struct AccountMigrated has copy, drop {
        account_id: 0x2::object::ID,
        from: u64,
        to: u64,
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
    }

    public fun account_version(arg0: &MemWalAccount) : u64 {
        get_version(&arg0.id)
    }

    entry fun add_delegate_key(arg0: &mut MemWalAccount, arg1: vector<u8>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_object_version(&arg0.id);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 4);
        assert!(arg0.active, 6);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg2)) <= 64, 10);
        assert!(0x1::vector::length<DelegateKey>(&arg0.delegate_keys) < 20, 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelegateKey>(&arg0.delegate_keys)) {
            assert!(0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v0).public_key != arg1, 0);
            v0 = v0 + 1;
        };
        let v1 = DelegateKey{
            public_key  : arg1,
            sui_address : derive_sui_address(&arg1),
            label       : arg2,
            created_at  : 0x2::clock::timestamp_ms(arg3),
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

    entry fun admin_migrate_account(arg0: &AdminCap, arg1: &mut MemWalAccount) {
        let v0 = get_version(&arg1.id);
        assert!(v0 < 3, 9);
        let v1 = &mut arg1.id;
        bump_version(v1, 3);
        let v2 = AccountMigrated{
            account_id : 0x2::object::id<MemWalAccount>(arg1),
            from       : v0,
            to         : 3,
        };
        0x2::event::emit<AccountMigrated>(v2);
    }

    fun assert_object_version(arg0: &0x2::object::UID) {
        assert!(get_version(arg0) == 3, 7);
    }

    fun bump_version(arg0: &mut 0x2::object::UID, arg1: u64) {
        set_version(arg0, arg1);
    }

    public fun burn_migration_cap(arg0: MigrationCap) {
        let MigrationCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = MigrationCapBurned{cap_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<MigrationCapBurned>(v1);
    }

    entry fun create_account(arg0: &mut AccountRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_object_version(&arg0.id);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, v0), 3);
        let v1 = MemWalAccount{
            id                : 0x2::object::new(arg2),
            owner             : v0,
            delegate_keys     : 0x1::vector::empty<DelegateKey>(),
            created_at        : 0x2::clock::timestamp_ms(arg1),
            active            : true,
            migration_created : false,
        };
        let v2 = &mut v1.id;
        set_version(v2, 3);
        let v3 = 0x2::object::id<MemWalAccount>(&v1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.accounts, v0, v3);
        let v4 = AccountCreated{
            account_id : v3,
            owner      : v0,
        };
        0x2::event::emit<AccountCreated>(v4);
        0x2::transfer::share_object<MemWalAccount>(v1);
    }

    public fun current_version() : u64 {
        3
    }

    entry fun deactivate_account(arg0: &mut MemWalAccount, arg1: &0x2::tx_context::TxContext) {
        assert_object_version(&arg0.id);
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 4);
        assert!(arg0.active, 6);
        arg0.active = false;
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
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    entry fun finalize_migration(arg0: &AdminCap, arg1: &mut AccountRegistry) {
        assert_object_version(&arg1.id);
        arg1.migration_finalized = true;
        let v0 = MigrationFinalized{registry_id: 0x2::object::id<AccountRegistry>(arg1)};
        0x2::event::emit<MigrationFinalized>(v0);
    }

    fun get_version(arg0: &0x2::object::UID) : u64 {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, u64>(arg0, b"version")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(arg0, b"version")
        } else {
            1
        }
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
            id                  : 0x2::object::new(arg0),
            accounts            : 0x2::table::new<address, 0x2::object::ID>(arg0),
            migration_finalized : false,
        };
        let v1 = &mut v0.id;
        set_version(v1, 3);
        0x2::transfer::share_object<AccountRegistry>(v0);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &MemWalAccount) : bool {
        arg0.active
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

    public fun is_migration_created(arg0: &MemWalAccount) : bool {
        arg0.migration_created
    }

    entry fun migrate_account(arg0: &mut MemWalAccount, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 4);
        let v0 = get_version(&arg0.id);
        assert!(v0 < 3, 9);
        let v1 = &mut arg0.id;
        bump_version(v1, 3);
        let v2 = AccountMigrated{
            account_id : 0x2::object::id<MemWalAccount>(arg0),
            from       : v0,
            to         : 3,
        };
        0x2::event::emit<AccountMigrated>(v2);
    }

    entry fun migrate_add_delegate_key(arg0: &MigrationCap, arg1: &AccountRegistry, arg2: &mut MemWalAccount, arg3: vector<u8>, arg4: 0x1::string::String, arg5: u64) {
        assert_object_version(&arg1.id);
        assert!(!arg1.migration_finalized, 12);
        assert_object_version(&arg2.id);
        assert!(arg2.migration_created, 13);
        assert!(arg2.active, 6);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 5);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg4)) <= 64, 10);
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelegateKey>(&arg2.delegate_keys)) {
            if (0x1::vector::borrow<DelegateKey>(&arg2.delegate_keys, v0).public_key == arg3) {
                return
            };
            v0 = v0 + 1;
        };
        assert!(0x1::vector::length<DelegateKey>(&arg2.delegate_keys) < 20, 2);
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
    }

    entry fun migrate_import_account(arg0: &MigrationCap, arg1: &mut AccountRegistry, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_object_version(&arg1.id);
        assert!(!arg1.migration_finalized, 12);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.accounts, arg2), 3);
        let v0 = MemWalAccount{
            id                : 0x2::object::new(arg4),
            owner             : arg2,
            delegate_keys     : 0x1::vector::empty<DelegateKey>(),
            created_at        : arg3,
            active            : true,
            migration_created : true,
        };
        let v1 = &mut v0.id;
        set_version(v1, 3);
        let v2 = 0x2::object::id<MemWalAccount>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.accounts, arg2, v2);
        let v3 = AccountCreated{
            account_id : v2,
            owner      : arg2,
        };
        0x2::event::emit<AccountCreated>(v3);
        0x2::transfer::share_object<MemWalAccount>(v0);
    }

    entry fun migrate_registry(arg0: &AdminCap, arg1: &mut AccountRegistry) {
        let v0 = get_version(&arg1.id);
        assert!(v0 < 3, 9);
        let v1 = &mut arg1.id;
        bump_version(v1, 3);
        let v2 = RegistryMigrated{
            registry_id : 0x2::object::id<AccountRegistry>(arg1),
            from        : v0,
            to          : 3,
        };
        0x2::event::emit<RegistryMigrated>(v2);
    }

    public fun mint_migration_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : MigrationCap {
        let v0 = MigrationCap{id: 0x2::object::new(arg1)};
        let v1 = MigrationCapMinted{cap_id: 0x2::object::id<MigrationCap>(&v0)};
        0x2::event::emit<MigrationCapMinted>(v1);
        v0
    }

    public fun owner(arg0: &MemWalAccount) : address {
        arg0.owner
    }

    entry fun reactivate_account(arg0: &mut MemWalAccount, arg1: &0x2::tx_context::TxContext) {
        assert_object_version(&arg0.id);
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 4);
        assert!(!arg0.active, 11);
        arg0.active = true;
        let v0 = AccountReactivated{
            account_id : 0x2::object::id<MemWalAccount>(arg0),
            owner      : arg0.owner,
        };
        0x2::event::emit<AccountReactivated>(v0);
    }

    public fun registry_version(arg0: &AccountRegistry) : u64 {
        get_version(&arg0.id)
    }

    entry fun remove_delegate_key(arg0: &mut MemWalAccount, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_object_version(&arg0.id);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        let v0 = false;
        let v1 = @0x0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<DelegateKey>(&arg0.delegate_keys)) {
            if (0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v2).public_key == arg1) {
                v1 = 0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v2).sui_address;
                0x1::vector::remove<DelegateKey>(&mut arg0.delegate_keys, v2);
                v0 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v0, 1);
        let v3 = DelegateKeyRemoved{
            account_id  : 0x2::object::id<MemWalAccount>(arg0),
            public_key  : arg1,
            sui_address : v1,
        };
        0x2::event::emit<DelegateKeyRemoved>(v3);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &MemWalAccount, arg2: &0x2::tx_context::TxContext) {
        assert_object_version(&arg1.id);
        assert!(arg1.active, 6);
        let v0 = 0x2::bcs::to_bytes<address>(&arg1.owner);
        assert!(has_suffix(&arg0, &v0), 100);
        let v1 = 0x2::tx_context::sender(arg2);
        if (v1 == arg1.owner) {
            return
        };
        assert!(is_delegate_address(arg1, v1), 100);
    }

    public fun seal_key_id(arg0: address) : vector<u8> {
        0x2::bcs::to_bytes<address>(&arg0)
    }

    fun set_version(arg0: &mut 0x2::object::UID, arg1: u64) {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, u64>(arg0, b"version")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(arg0, b"version") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(arg0, b"version", arg1);
        };
    }

    // decompiled from Move bytecode v7
}

