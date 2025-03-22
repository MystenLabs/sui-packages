module 0x2a84831d5245da7639fe6d41fa220adcc43319088118f25dde0715577049810c::stake_pool {
    struct STAKE_POOL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakeItem has copy, drop, store {
        owner: address,
        pool: address,
        stake: u128,
        withdraw_stake: u128,
        reward_remaining: u128,
        stake_time: u64,
        unlock_time: u64,
        unstaked: bool,
        claimable: bool,
        claimmed: bool,
        lastest_updated_time: u64,
    }

    struct StakePool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        apy: u128,
        paused: bool,
        unlock_times: u64,
        stake_coins: 0x2::coin::Coin<T0>,
        reward_coins: 0x2::coin::Coin<T1>,
        stakes: 0x2::table::Table<address, vector<StakeItem>>,
    }

    struct ProjectRegistry has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, u64>,
        user_pools: 0x2::table::Table<address, vector<address>>,
    }

    struct CreatePoolEventID has copy, drop {
        pool: 0x2::object::ID,
        unlock_times: u64,
        apy: u128,
    }

    struct CreatePoolEventAddress has copy, drop {
        pool: address,
        unlock_times: u64,
        apy: u128,
    }

    public fun createPool<T0, T1>(arg0: &AdminCap, arg1: &mut ProjectRegistry, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 8001);
        let v0 = StakePool<T0, T1>{
            id           : 0x2::object::new(arg4),
            apy          : arg3,
            paused       : false,
            unlock_times : arg2,
            stake_coins  : 0x2::coin::zero<T0>(arg4),
            reward_coins : 0x2::coin::zero<T1>(arg4),
            stakes       : 0x2::table::new<address, vector<StakeItem>>(arg4),
        };
        0x2::table::add<address, u64>(&mut arg1.pools, 0x2::object::id_address<StakePool<T0, T1>>(&v0), 0);
        let v1 = CreatePoolEventID{
            pool         : 0x2::object::id<StakePool<T0, T1>>(&v0),
            unlock_times : arg2,
            apy          : arg3,
        };
        0x2::event::emit<CreatePoolEventID>(v1);
        let v2 = CreatePoolEventAddress{
            pool         : 0x2::object::id_address<StakePool<T0, T1>>(&v0),
            unlock_times : arg2,
            apy          : arg3,
        };
        0x2::event::emit<CreatePoolEventAddress>(v2);
        0x2::transfer::share_object<StakePool<T0, T1>>(v0);
    }

    fun init(arg0: STAKE_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = ProjectRegistry{
            id         : 0x2::object::new(arg1),
            pools      : 0x2::table::new<address, u64>(arg1),
            user_pools : 0x2::table::new<address, vector<address>>(arg1),
        };
        0x2::transfer::share_object<ProjectRegistry>(v1);
    }

    // decompiled from Move bytecode v6
}

