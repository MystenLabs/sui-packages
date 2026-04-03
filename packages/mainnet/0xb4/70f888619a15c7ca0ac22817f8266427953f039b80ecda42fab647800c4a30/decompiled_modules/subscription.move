module 0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::subscription {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SkillRegistryAdmin has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        accounts: 0x2::table::Table<address, 0x2::object::ID>,
        delegate_accounts: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct WalcraftAccount has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        delegate_keys: vector<DelegateKey>,
        total_spent: u64,
        created_at: u64,
    }

    struct DelegateKey has copy, drop, store {
        public_key: vector<u8>,
        sui_address: address,
        label: 0x1::string::String,
        created_at: u64,
    }

    struct AdminCapCreated has copy, drop {
        admin: address,
    }

    struct AdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct AccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        created_by: address,
    }

    struct BalanceDeposited has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        new_total: u64,
    }

    struct BalanceWithdrawn has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        new_total: u64,
    }

    struct DelegateKeyAdded has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        public_key: vector<u8>,
        sui_address: address,
        label: 0x1::string::String,
    }

    struct DelegateKeyRemoved has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        public_key: vector<u8>,
        sui_address: address,
    }

    struct Subscribed has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        registry_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        amount_paid: u64,
        paid_by: address,
    }

    public fun account_balance(arg0: &WalcraftAccount) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun account_owner(arg0: &WalcraftAccount) : address {
        arg0.owner
    }

    public fun account_total_spent(arg0: &WalcraftAccount) : u64 {
        arg0.total_spent
    }

    public fun account_version(arg0: &WalcraftAccount) : u64 {
        arg0.version
    }

    public entry fun add_delegate_key(arg0: &mut WalcraftAccount, arg1: &mut SkillRegistryAdmin, arg2: vector<u8>, arg3: address, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 300);
        assert!(arg1.version == 1, 300);
        assert!(can_manage_account(arg0, 0x2::tx_context::sender(arg5)), 108);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 204);
        assert!(0x1::vector::length<DelegateKey>(&arg0.delegate_keys) < 20, 107);
        let v0 = 0x2::object::id<WalcraftAccount>(arg0);
        if (0x2::table::contains<address, 0x2::object::ID>(&arg1.delegate_accounts, arg3)) {
            assert!(*0x2::table::borrow<address, 0x2::object::ID>(&arg1.delegate_accounts, arg3) == v0, 202);
        };
        assert!(!is_registered_delegate(arg0, arg3), 105);
        let v1 = DelegateKey{
            public_key  : arg2,
            sui_address : arg3,
            label       : arg4,
            created_at  : 0x2::tx_context::epoch(arg5),
        };
        0x1::vector::push_back<DelegateKey>(&mut arg0.delegate_keys, v1);
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg1.delegate_accounts, arg3)) {
            0x2::table::add<address, 0x2::object::ID>(&mut arg1.delegate_accounts, arg3, v0);
        };
        let v2 = DelegateKeyAdded{
            account_id  : v0,
            owner       : arg0.owner,
            public_key  : v1.public_key,
            sui_address : v1.sui_address,
            label       : v1.label,
        };
        0x2::event::emit<DelegateKeyAdded>(v2);
    }

    public fun admin_version(arg0: &SkillRegistryAdmin) : u64 {
        arg0.version
    }

    fun can_manage_account(arg0: &WalcraftAccount, arg1: address) : bool {
        arg1 == arg0.owner || is_registered_delegate(arg0, arg1)
    }

    public entry fun create_account(arg0: &mut SkillRegistryAdmin, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 300);
        let v0 = 0x2::tx_context::sender(arg1);
        create_account_impl(arg0, v0, arg1);
    }

    fun create_account_impl(arg0: &mut SkillRegistryAdmin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, arg1), 109);
        let v0 = WalcraftAccount{
            id            : 0x2::object::new(arg2),
            version       : 1,
            owner         : arg1,
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            delegate_keys : 0x1::vector::empty<DelegateKey>(),
            total_spent   : 0,
            created_at    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        let v1 = 0x2::object::id<WalcraftAccount>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.accounts, arg1, v1);
        let v2 = AccountCreated{
            account_id : v1,
            owner      : arg1,
            created_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AccountCreated>(v2);
        0x2::transfer::share_object<WalcraftAccount>(v0);
    }

    fun delegate_has_access(arg0: &SkillRegistryAdmin, arg1: &0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::SkillRegistry, arg2: address) : bool {
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg0.delegate_accounts, arg2)) {
            return false
        };
        0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::registry_has_allowed_account(arg1, *0x2::table::borrow<address, 0x2::object::ID>(&arg0.delegate_accounts, arg2))
    }

    public entry fun deposit(arg0: &mut WalcraftAccount, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.version == 1, 300);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = BalanceDeposited{
            account_id : 0x2::object::id<WalcraftAccount>(arg0),
            owner      : arg0.owner,
            amount     : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_total  : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<BalanceDeposited>(v0);
    }

    public fun has_account(arg0: &SkillRegistryAdmin, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, arg1)
    }

    public fun has_delegate_account(arg0: &SkillRegistryAdmin, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.delegate_accounts, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCapCreated{admin: v0};
        0x2::event::emit<AdminCapCreated>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
        let v3 = SkillRegistryAdmin{
            id                : 0x2::object::new(arg0),
            version           : 1,
            admin             : v0,
            accounts          : 0x2::table::new<address, 0x2::object::ID>(arg0),
            delegate_accounts : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<SkillRegistryAdmin>(v3);
    }

    public fun is_delegate(arg0: &WalcraftAccount, arg1: address) : bool {
        is_registered_delegate(arg0, arg1)
    }

    public fun is_delegate_by_pubkey(arg0: &WalcraftAccount, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelegateKey>(&arg0.delegate_keys)) {
            if (&0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v0).public_key == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_registered_delegate(arg0: &WalcraftAccount, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelegateKey>(&arg0.delegate_keys)) {
            if (0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v0).sui_address == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun migrate_account(arg0: &mut WalcraftAccount, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 108);
        arg0.version = 1;
    }

    public fun migrate_admin(arg0: &mut SkillRegistryAdmin, arg1: &AdminCap) {
        arg0.version = 1;
    }

    fun owner_has_access(arg0: &SkillRegistryAdmin, arg1: &0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::SkillRegistry, arg2: address) : bool {
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, arg2)) {
            return false
        };
        0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::registry_has_allowed_account(arg1, *0x2::table::borrow<address, 0x2::object::ID>(&arg0.accounts, arg2))
    }

    public fun platform_admin(arg0: &SkillRegistryAdmin) : address {
        arg0.admin
    }

    fun registry_owner_has_access(arg0: &0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::SkillRegistry, arg1: address) : bool {
        0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::registry_owner(arg0) == arg1
    }

    public entry fun remove_delegate_key(arg0: &mut WalcraftAccount, arg1: &mut SkillRegistryAdmin, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 300);
        assert!(arg1.version == 1, 300);
        assert!(can_manage_account(arg0, 0x2::tx_context::sender(arg3)), 108);
        let v0 = false;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<DelegateKey>(&arg0.delegate_keys)) {
            if (0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v2).sui_address == arg2) {
                v1 = 0x1::vector::borrow<DelegateKey>(&arg0.delegate_keys, v2).public_key;
                0x1::vector::remove<DelegateKey>(&mut arg0.delegate_keys, v2);
                v0 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v0, 106);
        if (0x2::table::contains<address, 0x2::object::ID>(&arg1.delegate_accounts, arg2)) {
            if (*0x2::table::borrow<address, 0x2::object::ID>(&arg1.delegate_accounts, arg2) == 0x2::object::id<WalcraftAccount>(arg0)) {
                0x2::table::remove<address, 0x2::object::ID>(&mut arg1.delegate_accounts, arg2);
            };
        };
        let v3 = DelegateKeyRemoved{
            account_id  : 0x2::object::id<WalcraftAccount>(arg0),
            owner       : arg0.owner,
            public_key  : v1,
            sui_address : arg2,
        };
        0x2::event::emit<DelegateKeyRemoved>(v3);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &SkillRegistryAdmin, arg2: &0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::SkillRegistry, arg3: &0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::SkillVersion, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 300);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = if (arg0 == *0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::version_seal_key_id(arg3)) {
            if (registry_owner_has_access(arg2, v0)) {
                true
            } else if (owner_has_access(arg1, arg2, v0)) {
                true
            } else {
                delegate_has_access(arg1, arg2, v0)
            }
        } else {
            false
        };
        assert!(v1, 200);
    }

    public fun seal_key_id(arg0: &0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::SkillVersion) : vector<u8> {
        *0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::version_seal_key_id(arg0)
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: &mut SkillRegistryAdmin, arg2: address) {
        assert!(arg1.version == 1, 300);
        arg1.admin = arg2;
        let v0 = AdminChanged{
            old_admin : arg1.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public entry fun subscribe(arg0: &mut WalcraftAccount, arg1: &mut WalcraftAccount, arg2: &mut 0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::SkillRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 300);
        assert!(arg1.version == 1, 300);
        assert!(can_manage_account(arg0, 0x2::tx_context::sender(arg3)), 108);
        let v0 = 0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::registry_price(arg2);
        assert!(v0 > 0, 103);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v0, 100);
        let v1 = 0x2::object::id<WalcraftAccount>(arg0);
        assert!(!0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::registry_has_allowed_account(arg2, v1), 104);
        let v2 = 0x2::object::id<0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::SkillRegistry>(arg2);
        let v3 = 0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::registry_owner(arg2);
        assert!(arg1.owner == v3 || is_registered_delegate(arg1, v3), 108);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0));
        0xb470f888619a15c7ca0ac22817f8266427953f039b80ecda42fab647800c4a30::registry::add_allowed_account(arg2, v1);
        arg0.total_spent = arg0.total_spent + v0;
        let v4 = Subscribed{
            account_id  : v1,
            owner       : arg0.owner,
            registry_id : v2,
            version_id  : v2,
            amount_paid : v0,
            paid_by     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Subscribed>(v4);
    }

    public entry fun withdraw(arg0: &mut WalcraftAccount, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 300);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 108);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), arg0.owner);
        let v0 = BalanceWithdrawn{
            account_id : 0x2::object::id<WalcraftAccount>(arg0),
            owner      : arg0.owner,
            amount     : arg1,
            new_total  : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<BalanceWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

