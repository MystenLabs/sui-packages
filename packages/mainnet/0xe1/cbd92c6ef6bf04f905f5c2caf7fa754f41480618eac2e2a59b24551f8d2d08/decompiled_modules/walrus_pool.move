module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool {
    struct WalrusPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
    }

    struct WalrusPoolDeposited has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        deposited_by: address,
    }

    struct WalrusPoolWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        withdrawn_by: address,
    }

    struct WalrusPool has key {
        id: 0x2::object::UID,
        version: u64,
        available_funds: 0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>,
        admins: vector<address>,
    }

    public fun balance(arg0: &WalrusPool) : u64 {
        0x2::balance::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&arg0.available_funds)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : WalrusPool {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = WalrusPool{
            id              : 0x2::object::new(arg0),
            version         : 1,
            available_funds : 0x2::balance::zero<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(),
            admins          : v1,
        };
        let v3 = WalrusPoolCreated{
            pool_id : 0x2::object::id<WalrusPool>(&v2),
            admin   : v0,
        };
        0x2::event::emit<WalrusPoolCreated>(v3);
        v2
    }

    public fun add_admin(arg0: &mut WalrusPool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 1);
        assert!(arg1 != @0x0, 2);
        if (!0x1::vector::contains<address>(&arg0.admins, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        };
    }

    public fun admins(arg0: &WalrusPool) : &vector<address> {
        &arg0.admins
    }

    fun assert_version(arg0: &WalrusPool) {
        assert!(arg0.version == 1, 4);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<WalrusPool>(new(arg0));
    }

    public fun deposit(arg0: &mut WalrusPool, arg1: 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.available_funds, 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(arg1));
        let v0 = WalrusPoolDeposited{
            pool_id      : 0x2::object::id<WalrusPool>(arg0),
            amount       : 0x2::coin::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&arg1),
            deposited_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WalrusPoolDeposited>(v0);
    }

    public fun is_admin(arg0: &WalrusPool, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun migrate(arg0: &mut WalrusPool, arg1: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 1);
        assert!(arg0.version < 1, 4);
        arg0.version = 1;
    }

    public fun remove_admin(arg0: &mut WalrusPool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 1);
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 3);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.admins, v1);
        };
    }

    public fun return_funds(arg0: &mut WalrusPool, arg1: 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>) {
        assert_version(arg0);
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.available_funds, 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(arg1));
    }

    public fun take(arg0: &mut WalrusPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL> {
        assert_version(arg0);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 1);
        assert!(0x2::balance::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&arg0.available_funds) >= arg1, 0);
        0x2::coin::from_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0x2::balance::split<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.available_funds, arg1), arg2)
    }

    public fun take_all(arg0: &mut WalrusPool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL> {
        assert_version(arg0);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 1);
        0x2::coin::from_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0x2::balance::withdraw_all<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.available_funds), arg1)
    }

    public fun version(arg0: &WalrusPool) : u64 {
        arg0.version
    }

    public fun withdraw(arg0: &mut WalrusPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL> {
        assert_version(arg0);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 1);
        assert!(0x2::balance::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&arg0.available_funds) >= arg1, 0);
        let v0 = WalrusPoolWithdrawn{
            pool_id      : 0x2::object::id<WalrusPool>(arg0),
            amount       : arg1,
            withdrawn_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WalrusPoolWithdrawn>(v0);
        0x2::coin::from_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0x2::balance::split<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.available_funds, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

