module 0x5624ba80c66877c5870c90b60d6db9383a87ad04381bf4b07f99cdf7cd30c634::master_chef {
    struct MASTER_CHEF has drop {
        dummy_field: bool,
    }

    struct MasterChefStorage has key {
        id: 0x2::object::UID,
        sake_per_ms: u64,
        total_allocation_points: u64,
        pool_keys: 0x2::table::Table<0x1::ascii::String, PoolKey>,
        pools: 0x2::object_table::ObjectTable<u64, Pool>,
        start_timestamp: u64,
        publisher: 0x2::package::Publisher,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        allocation_points: u64,
        last_reward_timestamp: u64,
        accrued_sake_per_share: u256,
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

    struct TestCoinA has drop {
        dummy_field: bool,
    }

    struct TestCoinB has drop {
        dummy_field: bool,
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
        let v2 = 0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::utils::get_coin_info_string<T0>();
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
            id                     : 0x2::object::new(arg6),
            allocation_points      : arg4,
            last_reward_timestamp  : v6,
            accrued_sake_per_share : 0,
            balance_value          : 0,
            pool_key               : v3,
        };
        0x2::object_table::add<u64, Pool>(&mut arg1.pools, v3, v7);
        let v8 = AddPool<T0>{
            key               : v3,
            allocation_points : arg4,
        };
        0x2::event::emit<AddPool<T0>>(v8);
        update_sake_pool(arg1);
    }

    public entry fun add_pool_internal<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != 0, 4);
        let v0 = arg0.total_allocation_points;
        let v1 = arg0.start_timestamp;
        if (arg4) {
            update_all_pools(arg0, arg2);
        };
        let v2 = 0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::utils::get_coin_info_string<T0>();
        assert!(!0x2::table::contains<0x1::ascii::String, PoolKey>(&arg0.pool_keys, v2), 1);
        arg0.total_allocation_points = v0 + arg3;
        let v3 = 0x2::table::length<0x1::ascii::String, PoolKey>(&arg0.pool_keys);
        0x2::object_table::add<u64, 0x2::object_bag::ObjectBag>(&mut arg1.accounts, v3, 0x2::object_bag::new(arg5));
        let v4 = PoolKey{key: v3};
        0x2::table::add<0x1::ascii::String, PoolKey>(&mut arg0.pool_keys, v2, v4);
        let v5 = 0x2::clock::timestamp_ms(arg2);
        let v6 = if (v5 > v1) {
            v5
        } else {
            v1
        };
        let v7 = Pool{
            id                     : 0x2::object::new(arg5),
            allocation_points      : arg3,
            last_reward_timestamp  : v6,
            accrued_sake_per_share : 0,
            balance_value          : 0,
            pool_key               : v3,
        };
        0x2::object_table::add<u64, Pool>(&mut arg0.pools, v3, v7);
        let v8 = AddPool<T0>{
            key               : v3,
            allocation_points : arg3,
        };
        0x2::event::emit<AddPool<T0>>(v8);
        update_sake_pool(arg0);
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

    public entry fun burn_sake(arg0: &mut 0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SakeStorage, arg1: 0x2::coin::Coin<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>) {
        0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::burn(arg0, arg1);
    }

    public fun get_account_info<T0>(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: address) : (u64, u256) {
        let v0 = 0x2::object_bag::borrow<address, Account<T0>>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, get_pool_key<T0>(arg0)), arg2);
        (0x2::balance::value<T0>(&v0.balance), v0.rewards_paid)
    }

    fun get_farm<T0>(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: address, arg3: &mut vector<vector<u64>>) {
        let v0 = 0x1::vector::empty<u64>();
        let (v1, _, _, v4) = get_pool_info<T0>(arg0);
        0x1::vector::push_back<u64>(&mut v0, v1);
        0x1::vector::push_back<u64>(&mut v0, v4);
        if (account_exists<T0>(arg0, arg1, arg2)) {
            let (v5, _) = get_account_info<T0>(arg0, arg1, arg2);
            0x1::vector::push_back<u64>(&mut v0, v5);
        } else {
            0x1::vector::push_back<u64>(&mut v0, 0);
        };
        0x1::vector::push_back<vector<u64>>(arg3, v0);
    }

    public fun get_farms<T0, T1, T2>(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: address, arg3: u64) : vector<vector<u64>> {
        let v0 = 0x1::vector::empty<vector<u64>>();
        let v1 = &mut v0;
        get_farm<T0>(arg0, arg1, arg2, v1);
        if (arg3 == 1) {
            return v0
        };
        let v2 = &mut v0;
        get_farm<T1>(arg0, arg1, arg2, v2);
        if (arg3 == 2) {
            return v0
        };
        let v3 = &mut v0;
        get_farm<T2>(arg0, arg1, arg2, v3);
        v0
    }

    public fun get_master_chef_storage_info(arg0: &MasterChefStorage) : (u64, u64, u64) {
        (arg0.sake_per_ms, arg0.total_allocation_points, arg0.start_timestamp)
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
        let v4 = v0.accrued_sake_per_share;
        let v5 = v4;
        let v6 = v0.pool_key == 0;
        if (v3 > v0.last_reward_timestamp) {
            let v7 = if (v6) {
                0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::math::fdiv_u256(((v3 - v0.last_reward_timestamp) as u256) * (arg0.sake_per_ms as u256) * (v0.allocation_points as u256) / (arg0.total_allocation_points as u256), (v0.balance_value as u256))
            } else {
                ((v3 - v0.last_reward_timestamp) as u256) * (arg0.sake_per_ms as u256) * (v0.allocation_points as u256) / (arg0.total_allocation_points as u256) / (v0.balance_value as u256)
            };
            v5 = v4 + v7;
        };
        if (v6) {
            0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::math::fmul_u256(v2, v5) - v1.rewards_paid
        } else {
            assert!(v5 != 0, 12287);
            v2 * v5 - v1.rewards_paid
        }
    }

    public fun get_pool_info<T0>(arg0: &MasterChefStorage) : (u64, u64, u256, u64) {
        let v0 = 0x2::object_table::borrow<u64, Pool>(&arg0.pools, get_pool_key<T0>(arg0));
        (v0.allocation_points, v0.last_reward_timestamp, v0.accrued_sake_per_share, v0.balance_value)
    }

    fun get_pool_key<T0>(arg0: &MasterChefStorage) : u64 {
        0x2::table::borrow<0x1::ascii::String, PoolKey>(&arg0.pool_keys, 0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::utils::get_coin_info_string<T0>()).key
    }

    public entry fun get_rewards<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &mut 0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SakeStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_rewards_internal<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun get_rewards_internal<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &mut 0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SakeStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE> {
        update_pool<T0>(arg0, arg3);
        let v0 = borrow_pool<T0>(arg0);
        let v1 = borrow_mut_account<T0>(arg1, get_pool_key<T0>(arg0), 0x2::tx_context::sender(arg4));
        let v2 = v0.pool_key == 0;
        let v3 = if (v2) {
            0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::math::fmul_u256(((0x2::balance::value<T0>(&v1.balance) as u256) as u256), v0.accrued_sake_per_share)
        } else {
            ((0x2::balance::value<T0>(&v1.balance) as u256) as u256) * v0.accrued_sake_per_share
        };
        let v4 = v3 - v1.rewards_paid;
        assert!(v4 != 0, 3);
        let v5 = if (v2) {
            0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::math::fmul_u256((0x2::balance::value<T0>(&v1.balance) as u256), v0.accrued_sake_per_share)
        } else {
            (0x2::balance::value<T0>(&v1.balance) as u256) * v0.accrued_sake_per_share
        };
        v1.rewards_paid = v5;
        0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::mint(arg2, &arg0.publisher, (v4 as u64), arg4)
    }

    fun has_pool_key<T0>(arg0: &mut MasterChefStorage) : bool {
        0x2::table::contains<0x1::ascii::String, PoolKey>(&arg0.pool_keys, 0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::utils::get_coin_info_string<T0>())
    }

    fun init(arg0: MASTER_CHEF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::new<u64, Pool>(arg1);
        let v1 = 0x2::table::new<0x1::ascii::String, PoolKey>(arg1);
        let v2 = 0x2::object_table::new<u64, 0x2::object_bag::ObjectBag>(arg1);
        let v3 = PoolKey{key: 0};
        0x2::table::add<0x1::ascii::String, PoolKey>(&mut v1, 0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::utils::get_coin_info_string<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>(), v3);
        0x2::object_table::add<u64, 0x2::object_bag::ObjectBag>(&mut v2, 0, 0x2::object_bag::new(arg1));
        let v4 = Pool{
            id                     : 0x2::object::new(arg1),
            allocation_points      : 1000,
            last_reward_timestamp  : 10,
            accrued_sake_per_share : 0,
            balance_value          : 0,
            pool_key               : 0,
        };
        0x2::object_table::add<u64, Pool>(&mut v0, 0, v4);
        let v5 = AddPool<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>{
            key               : 0,
            allocation_points : 1000,
        };
        0x2::event::emit<AddPool<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>>(v5);
        let v6 = MasterChefStorage{
            id                      : 0x2::object::new(arg1),
            sake_per_ms             : 10,
            total_allocation_points : 1000,
            pool_keys               : v1,
            pools                   : v0,
            start_timestamp         : 10,
            publisher               : 0x2::package::claim<MASTER_CHEF>(arg0, arg1),
        };
        0x2::transfer::share_object<MasterChefStorage>(v6);
        let v7 = AccountStorage{
            id       : 0x2::object::new(arg1),
            accounts : v2,
        };
        0x2::transfer::share_object<AccountStorage>(v7);
        let v8 = MasterChefAdmin{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MasterChefAdmin>(v8, 0x2::tx_context::sender(arg1));
    }

    fun return_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
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
        update_sake_pool(arg1);
    }

    public entry fun stake<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &mut 0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SakeStorage, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::split<T0>(&mut arg4, arg5, arg6);
        stake_internal<T0>(arg0, arg1, arg2, arg3, v0, arg5, arg6);
        return_remaining_coin<T0>(arg4, arg6);
    }

    fun stake_internal<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &mut 0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SakeStorage, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = has_pool_key<T0>(arg0);
        if (!v0) {
            add_pool_internal<T0>(arg0, arg1, arg3, arg5, true, arg6);
        };
        update_pool<T0>(arg0, arg3);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = get_pool_key<T0>(arg0);
        if (!0x2::object_bag::contains<address>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, v2), v1)) {
            let v3 = Account<T0>{
                id           : 0x2::object::new(arg6),
                balance      : 0x2::balance::zero<T0>(),
                rewards_paid : 0,
            };
            0x2::object_bag::add<address, Account<T0>>(0x2::object_table::borrow_mut<u64, 0x2::object_bag::ObjectBag>(&mut arg1.accounts, v2), v1, v3);
        };
        let v4 = borrow_mut_pool<T0>(arg0);
        let v5 = borrow_mut_account<T0>(arg1, v2, v1);
        let v6 = v4.pool_key == 0;
        let v7 = 0;
        let v8 = (0x2::balance::value<T0>(&v5.balance) as u256);
        if (v8 > 0) {
            let v9 = if (v6) {
                0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::math::fmul_u256(v8, v4.accrued_sake_per_share)
            } else {
                v8 * v4.accrued_sake_per_share
            };
            v7 = v9 - v5.rewards_paid;
        };
        let v10 = 0x2::coin::value<T0>(&arg4);
        v4.balance_value = v4.balance_value + v10;
        0x2::balance::join<T0>(&mut v5.balance, 0x2::coin::into_balance<T0>(arg4));
        let v11 = if (v6) {
            0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::math::fmul_u256((0x2::balance::value<T0>(&v5.balance) as u256), v4.accrued_sake_per_share)
        } else {
            (0x2::balance::value<T0>(&v5.balance) as u256) * v4.accrued_sake_per_share
        };
        v5.rewards_paid = v11;
        let v12 = Stake<T0>{
            sender   : v1,
            amount   : v10,
            pool_key : v2,
            rewards  : (v7 as u64),
        };
        0x2::event::emit<Stake<T0>>(v12);
    }

    public entry fun transfer_admin(arg0: MasterChefAdmin, arg1: address) {
        0x2::transfer::transfer<MasterChefAdmin>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    public entry fun unstake<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &mut 0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SakeStorage, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = unstake_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
    }

    fun unstake_internal<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &mut 0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SakeStorage, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>, 0x2::coin::Coin<T0>) {
        update_pool<T0>(arg0, arg3);
        let v0 = get_pool_key<T0>(arg0);
        let v1 = borrow_mut_pool<T0>(arg0);
        let v2 = borrow_mut_account<T0>(arg1, v0, 0x2::tx_context::sender(arg5));
        let v3 = v1.pool_key == 0;
        let v4 = 0x2::balance::value<T0>(&v2.balance);
        assert!(v4 >= arg4, 2);
        let v5 = if (v3) {
            0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::math::fmul_u256((v4 as u256), v1.accrued_sake_per_share)
        } else {
            (v4 as u256) * v1.accrued_sake_per_share
        };
        let v6 = v5 - v2.rewards_paid;
        let v7 = 0x2::coin::take<T0>(&mut v2.balance, arg4, arg5);
        v1.balance_value = v1.balance_value - arg4;
        let v8 = if (v3) {
            0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::math::fmul_u256((0x2::balance::value<T0>(&v2.balance) as u256), v1.accrued_sake_per_share)
        } else {
            (0x2::balance::value<T0>(&v2.balance) as u256) * v1.accrued_sake_per_share
        };
        v2.rewards_paid = v8;
        let v9 = Unstake<T0>{
            sender   : 0x2::tx_context::sender(arg5),
            amount   : arg4,
            pool_key : v0,
            rewards  : (v6 as u64),
        };
        0x2::event::emit<Unstake<T0>>(v9);
        (0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::mint(arg2, &arg0.publisher, (v6 as u64), arg5), v7)
    }

    public entry fun update_all_pools(arg0: &mut MasterChefStorage, arg1: &0x2::clock::Clock) {
        update_all_pools_internal(arg0, arg1);
    }

    fun update_all_pools_internal(arg0: &mut MasterChefStorage, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x2::object_table::length<u64, Pool>(&arg0.pools)) {
            let v1 = 0x2::object_table::borrow_mut<u64, Pool>(&mut arg0.pools, v0);
            update_pool_internal2(v1, arg1, arg0.sake_per_ms, arg0.total_allocation_points, arg0.start_timestamp);
            v0 = v0 + 1;
        };
    }

    public entry fun update_pool<T0>(arg0: &mut MasterChefStorage, arg1: &0x2::clock::Clock) {
        update_pool_internal<T0>(arg0, arg1);
    }

    fun update_pool_internal<T0>(arg0: &mut MasterChefStorage, arg1: &0x2::clock::Clock) {
        let v0 = arg0.sake_per_ms;
        let v1 = arg0.total_allocation_points;
        let v2 = arg0.start_timestamp;
        let v3 = borrow_mut_pool<T0>(arg0);
        update_pool_internal2(v3, arg1, v0, v1, v2);
    }

    fun update_pool_internal2(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 == arg0.last_reward_timestamp || arg4 > v0) {
            return
        };
        arg0.last_reward_timestamp = v0;
        if (arg0.allocation_points == 0 || arg0.balance_value == 0) {
            return
        };
        let v1 = if (arg0.pool_key == 0) {
            0x10a1f113e1709c4f3e884e4937400b8723dd121df20ec7a11fb9f1dfc1065f8f::math::fdiv_u256((arg0.allocation_points as u256) * ((v0 - arg0.last_reward_timestamp) as u256) * (arg2 as u256) / (arg3 as u256), (arg0.balance_value as u256))
        } else {
            (arg0.allocation_points as u256) * ((v0 - arg0.last_reward_timestamp) as u256) * (arg2 as u256) / (arg3 as u256) / (arg0.balance_value as u256)
        };
        arg0.accrued_sake_per_share = arg0.accrued_sake_per_share + v1;
    }

    public entry fun update_sake_per_ms(arg0: &MasterChefAdmin, arg1: &mut MasterChefStorage, arg2: &0x2::clock::Clock, arg3: u64) {
        update_all_pools(arg1, arg2);
        arg1.sake_per_ms = arg3;
    }

    fun update_sake_pool(arg0: &mut MasterChefStorage) {
        let v0 = arg0.total_allocation_points;
        let v1 = borrow_mut_pool<0x1cfcf2119839539c410e2259100a544d772cd34c4aef9d4478a3768f80e61daf::sake::SAKE>(arg0);
        let v2 = (v0 - v1.allocation_points) / 3;
        v1.allocation_points = v2;
        arg0.total_allocation_points = v0 + v2 - v1.allocation_points;
    }

    // decompiled from Move bytecode v6
}

