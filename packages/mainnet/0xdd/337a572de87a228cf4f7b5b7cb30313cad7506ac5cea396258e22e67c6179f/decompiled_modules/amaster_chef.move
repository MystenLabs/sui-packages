module 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef {
    struct MasterChefStorage has key {
        id: 0x2::object::UID,
        ipx_per_ms: u64,
        total_allocation_points: u64,
        pool_keys: 0x2::table::Table<0x1::ascii::String, PoolKey>,
        pools: 0x2::object_table::ObjectTable<u64, Pool>,
        start_timestamp: u64,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        allocation_points: u64,
        last_reward_timestamp: u64,
        accrued_ipx_per_share: u256,
        balance_value: u64,
        pool_key: u64,
    }

    struct AccountStorage has key {
        id: 0x2::object::UID,
        accounts: 0x2::object_table::ObjectTable<u64, 0x2::object_bag::ObjectBag>,
    }

    struct Account<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        rewards_paid: u256,
    }

    struct PoolKey has store {
        key: u64,
    }

    struct MasterChefAdmin has key {
        id: 0x2::object::UID,
    }

    struct SetAllocationPoints<phantom T0> has copy, drop {
        key: u64,
        allocation_points: u64,
    }

    struct AddPool<phantom T0> has copy, drop {
        key: u64,
        allocation_points: u64,
    }

    struct Stake<phantom T0> has copy, drop {
        sender: address,
        amount: u64,
        pool_key: u64,
        rewards: u64,
    }

    struct Unstake<phantom T0> has copy, drop {
        sender: address,
        amount: u64,
        pool_key: u64,
        rewards: u64,
    }

    struct NewAdmin has copy, drop {
        admin: address,
    }

    public fun account_exists<T0>(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: address) : bool {
        0x2::object_bag::contains<address>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, get_pool_key<T0>(arg0)), arg2)
    }

    public entry fun add_pool<T0>(arg0: &MasterChefAdmin, arg1: &mut MasterChefStorage, arg2: &mut AccountStorage, arg3: &0x2::clock::Clock, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 != 0, 4);
        let v0 = arg1.total_allocation_points;
        let v1 = arg1.start_timestamp;
        if (arg5) {
            update_all_pools(arg1, arg3);
        };
        let v2 = 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::get_coin_info_string<T0>();
        assert!(!0x2::table::contains<0x1::ascii::String, PoolKey>(&arg1.pool_keys, v2), 1);
        arg1.total_allocation_points = v0 + arg4;
        let v3 = 0x2::table::length<0x1::ascii::String, PoolKey>(&arg1.pool_keys);
        0x2::object_table::add<u64, 0x2::object_bag::ObjectBag>(&mut arg2.accounts, v3, 0x2::object_bag::new(arg6));
        let v4 = PoolKey{key: v3};
        0x2::table::add<0x1::ascii::String, PoolKey>(&mut arg1.pool_keys, v2, v4);
        let v5 = 0x2::clock::timestamp_ms(arg3);
        let v6 = if (v5 > v1) {
            v5
        } else {
            v1
        };
        let v7 = Pool{
            id                    : 0x2::object::new(arg6),
            allocation_points     : arg4,
            last_reward_timestamp : v6,
            accrued_ipx_per_share : 0,
            balance_value         : 0,
            pool_key              : v3,
        };
        0x2::object_table::add<u64, Pool>(&mut arg1.pools, v3, v7);
        let v8 = AddPool<T0>{
            key               : v3,
            allocation_points : arg4,
        };
        0x2::event::emit<AddPool<T0>>(v8);
    }

    public fun borrow_account<T0>(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: address) : &Account<T0> {
        0x2::object_bag::borrow<address, Account<T0>>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, get_pool_key<T0>(arg0)), arg2)
    }

    fun borrow_mut_account<T0>(arg0: &mut AccountStorage, arg1: u64, arg2: address) : &mut Account<T0> {
        0x2::object_bag::borrow_mut<address, Account<T0>>(0x2::object_table::borrow_mut<u64, 0x2::object_bag::ObjectBag>(&mut arg0.accounts, arg1), arg2)
    }

    fun borrow_mut_pool<T0>(arg0: &mut MasterChefStorage) : &mut Pool {
        0x2::object_table::borrow_mut<u64, Pool>(&mut arg0.pools, get_pool_key<T0>(arg0))
    }

    public fun borrow_pool<T0>(arg0: &MasterChefStorage) : &Pool {
        0x2::object_table::borrow<u64, Pool>(&arg0.pools, get_pool_key<T0>(arg0))
    }

    public fun get_account_info<T0>(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: address) : (u64, u256) {
        let v0 = 0x2::object_bag::borrow<address, Account<T0>>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, get_pool_key<T0>(arg0)), arg2);
        (0x2::balance::value<T0>(&v0.balance), v0.rewards_paid)
    }

    public fun get_master_chef_storage_info(arg0: &MasterChefStorage) : (u64, u64, u64) {
        (arg0.ipx_per_ms, arg0.total_allocation_points, arg0.start_timestamp)
    }

    public fun get_pending_rewards<T0>(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: &0x2::clock::Clock, arg3: address) : u256 {
        if (!0x2::object_bag::contains<address>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, get_pool_key<T0>(arg0)), arg3)) {
            return 0
        };
        let v0 = borrow_pool<T0>(arg0);
        let v1 = borrow_account<T0>(arg0, arg1, arg3);
        let v2 = (0x2::balance::value<T0>(&v1.balance) as u256);
        if (v2 == 0 || (v0.balance_value as u256) == 0) {
            return 0
        };
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = v0.accrued_ipx_per_share;
        let v5 = v4;
        if (v3 > v0.last_reward_timestamp) {
            v5 = v4 + ((v3 - v0.last_reward_timestamp) as u256) * (arg0.ipx_per_ms as u256) * (v0.allocation_points as u256) / (arg0.total_allocation_points as u256) / (v0.balance_value as u256);
        };
        v2 * v5 - v1.rewards_paid
    }

    public fun get_pool_info<T0>(arg0: &MasterChefStorage) : (u64, u64, u256, u64) {
        let v0 = 0x2::object_table::borrow<u64, Pool>(&arg0.pools, get_pool_key<T0>(arg0));
        (v0.allocation_points, v0.last_reward_timestamp, v0.accrued_ipx_per_share, v0.balance_value)
    }

    fun get_pool_key<T0>(arg0: &MasterChefStorage) : u64 {
        0x2::table::borrow<0x1::ascii::String, PoolKey>(&arg0.pool_keys, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::get_coin_info_string<T0>()).key
    }

    public fun get_rewards<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPXStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPX> {
        update_pool<T0>(arg0, arg3);
        let v0 = borrow_pool<T0>(arg0);
        let v1 = borrow_mut_account<T0>(arg1, get_pool_key<T0>(arg0), 0x2::tx_context::sender(arg4));
        let v2 = ((0x2::balance::value<T0>(&v1.balance) as u256) as u256) * v0.accrued_ipx_per_share - v1.rewards_paid;
        assert!(v2 != 0, 3);
        v1.rewards_paid = (0x2::balance::value<T0>(&v1.balance) as u256) * v0.accrued_ipx_per_share;
        0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::mint(arg2, (v2 as u64), arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MasterChefStorage{
            id                      : 0x2::object::new(arg0),
            ipx_per_ms              : 0,
            total_allocation_points : 0,
            pool_keys               : 0x2::table::new<0x1::ascii::String, PoolKey>(arg0),
            pools                   : 0x2::object_table::new<u64, Pool>(arg0),
            start_timestamp         : 0,
        };
        0x2::transfer::share_object<MasterChefStorage>(v0);
        let v1 = AccountStorage{
            id       : 0x2::object::new(arg0),
            accounts : 0x2::object_table::new<u64, 0x2::object_bag::ObjectBag>(arg0),
        };
        0x2::transfer::share_object<AccountStorage>(v1);
        let v2 = MasterChefAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MasterChefAdmin>(v2, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_allocation_points<T0>(arg0: &MasterChefAdmin, arg1: &mut MasterChefStorage, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool) {
        let v0 = arg1.total_allocation_points;
        if (arg4) {
            update_all_pools(arg1, arg2);
        };
        let v1 = get_pool_key<T0>(arg1);
        let v2 = borrow_mut_pool<T0>(arg1);
        if (v2.allocation_points == arg3) {
            return
        };
        v2.allocation_points = arg3;
        arg1.total_allocation_points = v0 + arg3 - v2.allocation_points;
        let v3 = SetAllocationPoints<T0>{
            key               : v1,
            allocation_points : arg3,
        };
        0x2::event::emit<SetAllocationPoints<T0>>(v3);
    }

    public fun stake<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPXStorage, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPX> {
        update_pool<T0>(arg0, arg3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = get_pool_key<T0>(arg0);
        if (!0x2::object_bag::contains<address>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, v1), v0)) {
            let v2 = Account<T0>{
                id           : 0x2::object::new(arg5),
                balance      : 0x2::balance::zero<T0>(),
                rewards_paid : 0,
            };
            0x2::object_bag::add<address, Account<T0>>(0x2::object_table::borrow_mut<u64, 0x2::object_bag::ObjectBag>(&mut arg1.accounts, v1), v0, v2);
        };
        let v3 = borrow_mut_pool<T0>(arg0);
        let v4 = borrow_mut_account<T0>(arg1, v1, v0);
        let v5 = 0;
        let v6 = (0x2::balance::value<T0>(&v4.balance) as u256);
        if (v6 > 0) {
            v5 = v6 * v3.accrued_ipx_per_share - v4.rewards_paid;
        };
        let v7 = 0x2::coin::value<T0>(&arg4);
        v3.balance_value = v3.balance_value + v7;
        0x2::balance::join<T0>(&mut v4.balance, 0x2::coin::into_balance<T0>(arg4));
        v4.rewards_paid = (0x2::balance::value<T0>(&v4.balance) as u256) * v3.accrued_ipx_per_share;
        let v8 = Stake<T0>{
            sender   : v0,
            amount   : v7,
            pool_key : v1,
            rewards  : (v5 as u64),
        };
        0x2::event::emit<Stake<T0>>(v8);
        0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::mint(arg2, (v5 as u64), arg5)
    }

    public entry fun transfer_admin(arg0: MasterChefAdmin, arg1: address) {
        0x2::transfer::transfer<MasterChefAdmin>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    public fun unstake<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPXStorage, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPX>, 0x2::coin::Coin<T0>) {
        update_pool<T0>(arg0, arg3);
        let v0 = get_pool_key<T0>(arg0);
        let v1 = borrow_mut_pool<T0>(arg0);
        let v2 = borrow_mut_account<T0>(arg1, v0, 0x2::tx_context::sender(arg5));
        let v3 = 0x2::balance::value<T0>(&v2.balance);
        assert!(v3 >= arg4, 2);
        let v4 = (v3 as u256) * v1.accrued_ipx_per_share - v2.rewards_paid;
        let v5 = 0x2::coin::take<T0>(&mut v2.balance, arg4, arg5);
        v1.balance_value = v1.balance_value - arg4;
        v2.rewards_paid = (0x2::balance::value<T0>(&v2.balance) as u256) * v1.accrued_ipx_per_share;
        let v6 = Unstake<T0>{
            sender   : 0x2::tx_context::sender(arg5),
            amount   : arg4,
            pool_key : v0,
            rewards  : (v4 as u64),
        };
        0x2::event::emit<Unstake<T0>>(v6);
        (0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::mint(arg2, (v4 as u64), arg5), v5)
    }

    public entry fun update_aipx_per_ms(arg0: &MasterChefAdmin, arg1: &mut MasterChefStorage, arg2: &0x2::clock::Clock, arg3: u64) {
        update_all_pools(arg1, arg2);
        arg1.ipx_per_ms = arg3;
    }

    public fun update_all_pools(arg0: &mut MasterChefStorage, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x2::object_table::length<u64, Pool>(&arg0.pools)) {
            let v1 = 0x2::object_table::borrow_mut<u64, Pool>(&mut arg0.pools, v0);
            update_pool_internal(v1, arg1, arg0.ipx_per_ms, arg0.total_allocation_points, arg0.start_timestamp);
            v0 = v0 + 1;
        };
    }

    public fun update_pool<T0>(arg0: &mut MasterChefStorage, arg1: &0x2::clock::Clock) {
        let v0 = arg0.ipx_per_ms;
        let v1 = arg0.total_allocation_points;
        let v2 = arg0.start_timestamp;
        let v3 = borrow_mut_pool<T0>(arg0);
        update_pool_internal(v3, arg1, v0, v1, v2);
    }

    fun update_pool_internal(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 == arg0.last_reward_timestamp || arg4 > v0) {
            return
        };
        arg0.last_reward_timestamp = v0;
        if (arg0.allocation_points == 0 || arg0.balance_value == 0) {
            return
        };
        arg0.accrued_ipx_per_share = arg0.accrued_ipx_per_share + (arg0.allocation_points as u256) * ((v0 - arg0.last_reward_timestamp) as u256) * (arg2 as u256) / (arg3 as u256) / (arg0.balance_value as u256);
    }

    // decompiled from Move bytecode v6
}

