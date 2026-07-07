module 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        deployer: address,
        bots: 0x2::table::Table<address, bool>,
        balances: 0x2::bag::Bag,
        package_version: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        deployer: address,
    }

    struct BotAdded has copy, drop {
        vault_id: 0x2::object::ID,
        bot: address,
    }

    struct BotRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        bot: address,
    }

    struct TokenDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct TokenWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PackageVersionSynced has copy, drop {
        vault_id: 0x2::object::ID,
        package_version: u64,
    }

    public fun add_bot(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        assert_package_version(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg1.bots, arg2), 13906834633905143813);
        0x2::table::add<address, bool>(&mut arg1.bots, arg2, true);
        let v0 = BotAdded{
            vault_id : 0x2::object::id<Vault>(arg1),
            bot      : arg2,
        };
        0x2::event::emit<BotAdded>(v0);
    }

    public(friend) fun assert_authorized(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.deployer || 0x2::table::contains<address, bool>(&arg0.bots, v0), 13906834788523704321);
    }

    fun assert_package_version(arg0: &Vault) {
        assert!(arg0.package_version == 1, 13906834754164490249);
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_authorized(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        deposit_coin<T0>(arg0, arg1);
        if (v0 > 0) {
            let v1 = TokenDeposited{
                vault_id  : 0x2::object::id<Vault>(arg0),
                depositor : 0x2::tx_context::sender(arg2),
                coin_type : 0x1::type_name::with_defining_ids<T0>(),
                amount    : v0,
            };
            0x2::event::emit<TokenDeposited>(v1);
        };
    }

    public(friend) fun deposit_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public(friend) fun deposit_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        assert_package_version(arg0);
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Vault{
            id              : 0x2::object::new(arg0),
            deployer        : v0,
            bots            : 0x2::table::new<address, bool>(arg0),
            balances        : 0x2::bag::new(arg0),
            package_version : 1,
        };
        0x2::transfer::share_object<Vault>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
        let v3 = VaultCreated{
            vault_id : 0x2::object::id<Vault>(&v1),
            deployer : v0,
        };
        0x2::event::emit<VaultCreated>(v3);
    }

    public fun remove_bot(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        assert_package_version(arg1);
        assert!(0x2::table::contains<address, bool>(&arg1.bots, arg2), 13906834672559980551);
        0x2::table::remove<address, bool>(&mut arg1.bots, arg2);
        let v0 = BotRemoved{
            vault_id : 0x2::object::id<Vault>(arg1),
            bot      : arg2,
        };
        0x2::event::emit<BotRemoved>(v0);
    }

    public fun sync_package_version(arg0: &AdminCap, arg1: &mut Vault) {
        arg1.package_version = 1;
        let v0 = PackageVersionSynced{
            vault_id        : 0x2::object::id<Vault>(arg1),
            package_version : 1,
        };
        0x2::event::emit<PackageVersionSynced>(v0);
    }

    public fun token_balance<T0>(arg0: &Vault) : u64 {
        assert_package_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_authorized(arg0, arg2);
        let v0 = withdraw_coin<T0>(arg0, arg1, arg2);
        let v1 = TokenWithdrawn{
            vault_id  : 0x2::object::id<Vault>(arg0),
            recipient : 0x2::tx_context::sender(arg2),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<TokenWithdrawn>(v1);
        v0
    }

    public(friend) fun withdraw_coin<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_package_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 13906835084876578819);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 13906835093466513411);
        0x2::coin::take<T0>(v1, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

