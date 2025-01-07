module 0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::master_chef {
    struct MASTER_CHEF has drop {
        dummy_field: bool,
    }

    struct MasterChefStorage has key {
        id: 0x2::object::UID,
        sip_per_ms: u64,
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
        accrued_sip_per_share: u256,
        balance_value: u64,
        pool_key: u64,
    }

    struct AccountStorage has key {
        id: 0x2::object::UID,
        accounts: 0x2::object_table::ObjectTable<u64, 0x2::object_bag::ObjectBag>,
    }

    struct MasterChefBalanceStorage has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Account has store, key {
        id: 0x2::object::UID,
        balance: u64,
        rewards_paid: u256,
        users: u64,
        referral_reward: u64,
        unclaimed_reward: u64,
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

    public entry fun add_pool<T0>(arg0: &MasterChefAdmin, arg1: &mut MasterChefStorage, arg2: &mut AccountStorage, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.total_allocation_points;
        let v1 = arg1.start_timestamp;
        update_all_pools(arg1, arg3);
        let v2 = 0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::utils::get_coin_info_string<T0>();
        assert!(!0x2::table::contains<0x1::ascii::String, PoolKey>(&arg1.pool_keys, v2), 1);
        arg1.total_allocation_points = v0 + arg4;
        let v3 = 0x2::table::length<0x1::ascii::String, PoolKey>(&arg1.pool_keys);
        0x2::object_table::add<u64, 0x2::object_bag::ObjectBag>(&mut arg2.accounts, v3, 0x2::object_bag::new(arg5));
        let v4 = PoolKey{key: v3};
        0x2::table::add<0x1::ascii::String, PoolKey>(&mut arg1.pool_keys, v2, v4);
        let v5 = 0x2::clock::timestamp_ms(arg3);
        let v6 = if (v5 > v1) {
            v5
        } else {
            v1
        };
        let v7 = Pool{
            id                    : 0x2::object::new(arg5),
            allocation_points     : arg4,
            last_reward_timestamp : v6,
            accrued_sip_per_share : 0,
            balance_value         : 0,
            pool_key              : v3,
        };
        0x2::object_table::add<u64, Pool>(&mut arg1.pools, v3, v7);
        let v8 = AddPool<T0>{
            key               : v3,
            allocation_points : arg4,
        };
        0x2::event::emit<AddPool<T0>>(v8);
        update_sip_pool(arg1);
    }

    public fun borrow_account<T0>(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: address) : &Account {
        0x2::object_bag::borrow<address, Account>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, get_pool_key<T0>(arg0)), arg2)
    }

    fun borrow_mut_account<T0>(arg0: &mut AccountStorage, arg1: u64, arg2: address) : &mut Account {
        0x2::object_bag::borrow_mut<address, Account>(0x2::object_table::borrow_mut<u64, 0x2::object_bag::ObjectBag>(&mut arg0.accounts, arg1), arg2)
    }

    fun borrow_mut_pool<T0>(arg0: &mut MasterChefStorage) : &mut Pool {
        0x2::object_table::borrow_mut<u64, Pool>(&mut arg0.pools, get_pool_key<T0>(arg0))
    }

    public fun borrow_pool<T0>(arg0: &MasterChefStorage) : &Pool {
        0x2::object_table::borrow<u64, Pool>(&arg0.pools, get_pool_key<T0>(arg0))
    }

    public entry fun claim_reward(arg0: &mut MasterChefStorage, arg1: &mut MasterChefBalanceStorage, arg2: &mut AccountStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        update_pool<0x2::sui::SUI>(arg0, arg3);
        let v0 = get_pool_key<0x2::sui::SUI>(arg0);
        borrow_mut_pool<0x2::sui::SUI>(arg0);
        let v1 = borrow_mut_account<0x2::sui::SUI>(arg2, v0, 0x2::tx_context::sender(arg4));
        assert!(v1.unclaimed_reward > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v1.unclaimed_reward, arg4), 0x2::tx_context::sender(arg4));
        v1.unclaimed_reward = 0;
    }

    public entry fun deposit(arg0: &mut MasterChefBalanceStorage, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_account_detail(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: address) : (u64, u256, u64, u64, u64) {
        let v0 = 0x2::object_bag::borrow<address, Account>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, get_pool_key<0x2::sui::SUI>(arg0)), arg2);
        (v0.balance, v0.rewards_paid, v0.users, v0.referral_reward, v0.unclaimed_reward)
    }

    public fun get_account_info(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: address) : (u64, u256) {
        let v0 = 0x2::object_bag::borrow<address, Account>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, get_pool_key<0x2::sui::SUI>(arg0)), arg2);
        (v0.balance, v0.rewards_paid)
    }

    public fun get_currrent_value(arg0: &mut MasterChefBalanceStorage) : u256 {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.balance) as u256)
    }

    public fun get_master_chef_storage_info(arg0: &MasterChefStorage) : (u64, u64, u64) {
        (arg0.sip_per_ms, arg0.total_allocation_points, arg0.start_timestamp)
    }

    public fun get_pending_rewards<T0>(arg0: &MasterChefStorage, arg1: &AccountStorage, arg2: &0x2::clock::Clock, arg3: address) : u256 {
        if (!0x2::object_bag::contains<address>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg1.accounts, get_pool_key<T0>(arg0)), arg3)) {
            return 0
        };
        let v0 = borrow_pool<T0>(arg0);
        let v1 = borrow_account<T0>(arg0, arg1, arg3);
        let v2 = (v1.balance as u256);
        if (v2 == 0 || (v0.balance_value as u256) == 0) {
            return 0
        };
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = v0.accrued_sip_per_share;
        let v5 = v4;
        let v6 = v0.pool_key == 0;
        if (v3 > v0.last_reward_timestamp) {
            let v7 = if (v6) {
                0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::math::fdiv_u256(((v3 - v0.last_reward_timestamp) as u256) * (arg0.sip_per_ms as u256) * (v0.allocation_points as u256) / (arg0.total_allocation_points as u256), (v0.balance_value as u256))
            } else {
                ((v3 - v0.last_reward_timestamp) as u256) * (arg0.sip_per_ms as u256) * (v0.allocation_points as u256) / (arg0.total_allocation_points as u256) / (v0.balance_value as u256)
            };
            v5 = v4 + v7;
        };
        if (v6) {
            0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::math::fmul_u256(v2, v5) - v1.rewards_paid
        } else {
            v2 * v5 - v1.rewards_paid
        }
    }

    public fun get_pool_info<T0>(arg0: &MasterChefStorage) : (u64, u64, u256, u64) {
        let v0 = 0x2::object_table::borrow<u64, Pool>(&arg0.pools, get_pool_key<T0>(arg0));
        (v0.allocation_points, v0.last_reward_timestamp, v0.accrued_sip_per_share, v0.balance_value)
    }

    fun get_pool_key<T0>(arg0: &MasterChefStorage) : u64 {
        0x2::table::borrow<0x1::ascii::String, PoolKey>(&arg0.pool_keys, 0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::utils::get_coin_info_string<T0>()).key
    }

    public fun get_rewards<T0>(arg0: &mut MasterChefStorage, arg1: &mut AccountStorage, arg2: &mut 0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::SIPStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::SIP> {
        update_pool<T0>(arg0, arg3);
        let v0 = borrow_pool<T0>(arg0);
        let v1 = borrow_mut_account<T0>(arg1, get_pool_key<T0>(arg0), 0x2::tx_context::sender(arg4));
        let v2 = v0.pool_key == 0;
        let v3 = if (v2) {
            0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::math::fmul_u256(((v1.balance as u256) as u256), v0.accrued_sip_per_share)
        } else {
            ((v1.balance as u256) as u256) * v0.accrued_sip_per_share
        };
        let v4 = v3 - v1.rewards_paid;
        assert!(v4 != 0, 3);
        let v5 = if (v2) {
            0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::math::fmul_u256((v1.balance as u256), v0.accrued_sip_per_share)
        } else {
            (v1.balance as u256) * v0.accrued_sip_per_share
        };
        v1.rewards_paid = v5;
        0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::mint(arg2, &arg0.publisher, (v4 as u64), arg4)
    }

    fun init(arg0: MASTER_CHEF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::new<u64, Pool>(arg1);
        let v1 = 0x2::table::new<0x1::ascii::String, PoolKey>(arg1);
        let v2 = 0x2::object_table::new<u64, 0x2::object_bag::ObjectBag>(arg1);
        let v3 = PoolKey{key: 0};
        0x2::table::add<0x1::ascii::String, PoolKey>(&mut v1, 0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::utils::get_coin_info_string<0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::SIP>(), v3);
        0x2::object_table::add<u64, 0x2::object_bag::ObjectBag>(&mut v2, 0, 0x2::object_bag::new(arg1));
        let v4 = Pool{
            id                    : 0x2::object::new(arg1),
            allocation_points     : 1000,
            last_reward_timestamp : 0,
            accrued_sip_per_share : 0,
            balance_value         : 0,
            pool_key              : 0,
        };
        0x2::object_table::add<u64, Pool>(&mut v0, 0, v4);
        let v5 = MasterChefStorage{
            id                      : 0x2::object::new(arg1),
            sip_per_ms              : 1268391,
            total_allocation_points : 1000,
            pool_keys               : v1,
            pools                   : v0,
            start_timestamp         : 0,
            publisher               : 0x2::package::claim<MASTER_CHEF>(arg0, arg1),
        };
        0x2::transfer::share_object<MasterChefStorage>(v5);
        let v6 = AccountStorage{
            id       : 0x2::object::new(arg1),
            accounts : v2,
        };
        0x2::transfer::share_object<AccountStorage>(v6);
        let v7 = MasterChefBalanceStorage{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MasterChefBalanceStorage>(v7);
        let v8 = MasterChefAdmin{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MasterChefAdmin>(v8, 0x2::tx_context::sender(arg1));
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
        update_sip_pool(arg1);
    }

    public fun stake(arg0: &mut MasterChefStorage, arg1: &mut MasterChefBalanceStorage, arg2: &mut AccountStorage, arg3: &mut 0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::SIPStorage, arg4: address, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::SIP> {
        update_pool<0x2::sui::SUI>(arg0, arg5);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = get_pool_key<0x2::sui::SUI>(arg0);
        if (!0x2::object_bag::contains<address>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg2.accounts, v1), v0)) {
            let v2 = Account{
                id               : 0x2::object::new(arg7),
                balance          : 0,
                rewards_paid     : 0,
                users            : 0,
                referral_reward  : 0,
                unclaimed_reward : 0,
            };
            0x2::object_bag::add<address, Account>(0x2::object_table::borrow_mut<u64, 0x2::object_bag::ObjectBag>(&mut arg2.accounts, v1), v0, v2);
        };
        if (arg4 != @0x0 && arg4 != v0) {
            if (!0x2::object_bag::contains<address>(0x2::object_table::borrow<u64, 0x2::object_bag::ObjectBag>(&arg2.accounts, v1), arg4)) {
                let v3 = Account{
                    id               : 0x2::object::new(arg7),
                    balance          : 0,
                    rewards_paid     : 0,
                    users            : 0,
                    referral_reward  : 0,
                    unclaimed_reward : 0,
                };
                0x2::object_bag::add<address, Account>(0x2::object_table::borrow_mut<u64, 0x2::object_bag::ObjectBag>(&mut arg2.accounts, v1), arg4, v3);
            };
        };
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        let v5 = borrow_mut_pool<0x2::sui::SUI>(arg0);
        if (arg4 != @0x0) {
            update_account_referral<0x2::sui::SUI>(arg2, v1, arg4, v4 * 5 / 100);
        };
        let v6 = borrow_mut_account<0x2::sui::SUI>(arg2, v1, v0);
        let v7 = v5.pool_key == 0;
        let v8 = 0;
        let v9 = (v6.balance as u256);
        if (v9 > 0) {
            let v10 = if (v7) {
                0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::math::fmul_u256(v9, v5.accrued_sip_per_share)
            } else {
                v9 * v5.accrued_sip_per_share
            };
            v8 = v10 - v6.rewards_paid;
        };
        v5.balance_value = v5.balance_value + v4;
        if (arg4 != @0x0) {
            v6.balance = v6.balance + v4 * 95 / 100;
        } else {
            v6.balance = v6.balance + v4;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        let v11 = if (v7) {
            0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::math::fmul_u256((v6.balance as u256), v5.accrued_sip_per_share)
        } else {
            (v6.balance as u256) * v5.accrued_sip_per_share
        };
        v6.rewards_paid = v11;
        let v12 = Stake<0x2::sui::SUI>{
            sender   : v0,
            amount   : v4,
            pool_key : v1,
            rewards  : (v8 as u64),
        };
        0x2::event::emit<Stake<0x2::sui::SUI>>(v12);
        0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::mint(arg3, &arg0.publisher, (v8 as u64), arg7)
    }

    public entry fun transfer_admin(arg0: MasterChefAdmin, arg1: address) {
        0x2::transfer::transfer<MasterChefAdmin>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    public fun unstake(arg0: &mut MasterChefStorage, arg1: &mut MasterChefBalanceStorage, arg2: &mut AccountStorage, arg3: &mut 0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::SIPStorage, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::SIP>, 0x2::coin::Coin<0x2::sui::SUI>) {
        update_pool<0x2::sui::SUI>(arg0, arg4);
        let v0 = get_pool_key<0x2::sui::SUI>(arg0);
        let v1 = borrow_mut_pool<0x2::sui::SUI>(arg0);
        let v2 = borrow_mut_account<0x2::sui::SUI>(arg2, v0, 0x2::tx_context::sender(arg6));
        let v3 = v1.pool_key == 0;
        let v4 = v2.balance;
        assert!(v4 >= arg5, 2);
        let v5 = if (v3) {
            0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::math::fmul_u256((v4 as u256), v1.accrued_sip_per_share)
        } else {
            (v4 as u256) * v1.accrued_sip_per_share
        };
        let v6 = v5 - v2.rewards_paid;
        v1.balance_value = v1.balance_value - arg5;
        v2.balance = v2.balance - arg5;
        let v7 = if (v3) {
            0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::math::fmul_u256((v2.balance as u256), v1.accrued_sip_per_share)
        } else {
            (v2.balance as u256) * v1.accrued_sip_per_share
        };
        v2.rewards_paid = v7;
        let v8 = Unstake<0x2::sui::SUI>{
            sender   : 0x2::tx_context::sender(arg6),
            amount   : arg5,
            pool_key : v0,
            rewards  : (v6 as u64),
        };
        0x2::event::emit<Unstake<0x2::sui::SUI>>(v8);
        (0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::mint(arg3, &arg0.publisher, (v6 as u64), arg6), 0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg5, arg6))
    }

    fun update_account_referral<T0>(arg0: &mut AccountStorage, arg1: u64, arg2: address, arg3: u64) {
        let v0 = 0x2::object_bag::borrow_mut<address, Account>(0x2::object_table::borrow_mut<u64, 0x2::object_bag::ObjectBag>(&mut arg0.accounts, arg1), arg2);
        v0.referral_reward = v0.referral_reward + arg3;
        v0.unclaimed_reward = v0.unclaimed_reward + arg3;
        v0.users = v0.users + 1;
    }

    public fun update_all_pools(arg0: &mut MasterChefStorage, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x2::object_table::length<u64, Pool>(&arg0.pools)) {
            let v1 = 0x2::object_table::borrow_mut<u64, Pool>(&mut arg0.pools, v0);
            update_pool_internal(v1, arg1, arg0.sip_per_ms, arg0.total_allocation_points, arg0.start_timestamp);
            v0 = v0 + 1;
        };
    }

    public fun update_pool<T0>(arg0: &mut MasterChefStorage, arg1: &0x2::clock::Clock) {
        let v0 = arg0.sip_per_ms;
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
        let v1 = if (arg0.pool_key == 0) {
            0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::math::fdiv_u256((arg0.allocation_points as u256) * ((v0 - arg0.last_reward_timestamp) as u256) * (arg2 as u256) / (arg3 as u256), (arg0.balance_value as u256))
        } else {
            (arg0.allocation_points as u256) * ((v0 - arg0.last_reward_timestamp) as u256) * (arg2 as u256) / (arg3 as u256) / (arg0.balance_value as u256)
        };
        arg0.accrued_sip_per_share = arg0.accrued_sip_per_share + v1;
    }

    public entry fun update_sip_per_ms(arg0: &MasterChefAdmin, arg1: &mut MasterChefStorage, arg2: &0x2::clock::Clock, arg3: u64) {
        update_all_pools(arg1, arg2);
        arg1.sip_per_ms = arg3;
    }

    fun update_sip_pool(arg0: &mut MasterChefStorage) {
        let v0 = arg0.total_allocation_points;
        let v1 = borrow_mut_pool<0xb0a82f3a518e12162abe93f8698fea25731b29a8bc5b407efa22bf6aa2db8d2b::sip::SIP>(arg0);
        let v2 = (v0 - v1.allocation_points) / 3;
        v1.allocation_points = v2;
        arg0.total_allocation_points = v0 + v2 - v1.allocation_points;
    }

    public entry fun withdraw(arg0: &MasterChefAdmin, arg1: &mut MasterChefBalanceStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

