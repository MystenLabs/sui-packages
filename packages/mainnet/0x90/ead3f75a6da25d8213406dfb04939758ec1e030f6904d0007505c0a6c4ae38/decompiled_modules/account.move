module 0x90ead3f75a6da25d8213406dfb04939758ec1e030f6904d0007505c0a6c4ae38::account {
    struct AccountRegistry has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct MemWalAccount has store, key {
        id: 0x2::object::UID,
        owner: address,
        delegate_keys: vector<DelegateKey>,
        created_at: u64,
        active: bool,
    }

    struct DelegateKey has copy, drop, store {
        public_key: vector<u8>,
        sui_address: address,
        label: 0x1::string::String,
        created_at: u64,
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

    public fun account_version(arg0: &MemWalAccount) : u64 {
        get_version(&arg0.id)
    }

    entry fun add_delegate_key(arg0: &mut MemWalAccount, arg1: vector<u8>, arg2: address, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_object_version(&arg0.id);
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 4);
        assert!(arg0.active, 6);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg3)) <= 64, 10);
        assert!(0x1::vector::length<DelegateKey>(&arg0.delegate_keys) < 20, 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelegateKey>(&arg0.delegate_keys)) {
            assert!(0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v0).public_key != arg1, 0);
            v0 = v0 + 1;
        };
        let v1 = DelegateKey{
            public_key  : arg1,
            sui_address : arg2,
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

    entry fun admin_migrate_account(arg0: &0x2::package::UpgradeCap, arg1: &mut MemWalAccount) {
        assert_cap_for_this_package(arg0);
        let v0 = get_version(&arg1.id);
        assert!(v0 < 2, 9);
        let v1 = &mut arg1.id;
        bump_version(v1, 2);
        let v2 = AccountMigrated{
            account_id : 0x2::object::id<MemWalAccount>(arg1),
            from       : v0,
            to         : 2,
        };
        0x2::event::emit<AccountMigrated>(v2);
    }

    fun assert_cap_for_this_package(arg0: &0x2::package::UpgradeCap) {
        let v0 = 0x2::package::upgrade_package(arg0);
        assert!(0x2::object::id_to_address(&v0) == @0x0, 8);
    }

    fun assert_object_version(arg0: &0x2::object::UID) {
        assert!(get_version(arg0) == 2, 7);
    }

    fun bump_version(arg0: &mut 0x2::object::UID, arg1: u64) {
        set_version(arg0, arg1);
    }

    entry fun create_account(arg0: &mut AccountRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_object_version(&arg0.id);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, v0), 3);
        let v1 = MemWalAccount{
            id            : 0x2::object::new(arg2),
            owner         : v0,
            delegate_keys : 0x1::vector::empty<DelegateKey>(),
            created_at    : 0x2::clock::timestamp_ms(arg1),
            active        : true,
        };
        let v2 = &mut v1.id;
        set_version(v2, 2);
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
        2
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
            id       : 0x2::object::new(arg0),
            accounts : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        let v1 = &mut v0.id;
        set_version(v1, 2);
        0x2::transfer::share_object<AccountRegistry>(v0);
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

    entry fun migrate_account(arg0: &mut MemWalAccount, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 4);
        let v0 = get_version(&arg0.id);
        assert!(v0 < 2, 9);
        let v1 = &mut arg0.id;
        bump_version(v1, 2);
        let v2 = AccountMigrated{
            account_id : 0x2::object::id<MemWalAccount>(arg0),
            from       : v0,
            to         : 2,
        };
        0x2::event::emit<AccountMigrated>(v2);
    }

    entry fun migrate_registry(arg0: &0x2::package::UpgradeCap, arg1: &mut AccountRegistry) {
        assert_cap_for_this_package(arg0);
        let v0 = get_version(&arg1.id);
        assert!(v0 < 2, 9);
        let v1 = &mut arg1.id;
        bump_version(v1, 2);
        let v2 = RegistryMigrated{
            registry_id : 0x2::object::id<AccountRegistry>(arg1),
            from        : v0,
            to          : 2,
        };
        0x2::event::emit<RegistryMigrated>(v2);
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

