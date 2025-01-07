module 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::pool {
    struct RewardPool has key {
        id: 0x2::object::UID,
        version: u16,
        balance: 0x2::balance::Balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>,
    }

    struct StatsKey has copy, drop, store {
        name: 0x1::string::String,
        staking_window: 0x1::option::Option<u64>,
    }

    struct Stats has drop, store {
        total_staked_amount: u64,
        reserved_amount_by_epoch: 0x2::vec_map::VecMap<u64, u64>,
    }

    fun borrow<T0: copy + drop + store, T1: store>(arg0: &RewardPool, arg1: T0) : &T1 {
        assert!(is_version_eq(arg0), 0);
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut RewardPool, arg1: T0) : &mut T1 {
        assert!(is_version_eq(arg0), 0);
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun add_new_stats(arg0: &mut RewardPool, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>) {
        let v0 = StatsKey{
            name           : arg1,
            staking_window : arg2,
        };
        let v1 = Stats{
            total_staked_amount      : 0,
            reserved_amount_by_epoch : 0x2::vec_map::empty<u64, u64>(),
        };
        0x2::dynamic_field::add<StatsKey, Stats>(&mut arg0.id, v0, v1);
    }

    public(friend) fun add_reserved_amount(arg0: &mut Stats, arg1: u64, arg2: u64) {
        if (0x2::vec_map::contains<u64, u64>(&arg0.reserved_amount_by_epoch, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u64, u64>(&mut arg0.reserved_amount_by_epoch, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<u64, u64>(&mut arg0.reserved_amount_by_epoch, arg1, arg2);
        };
        if (0x2::vec_map::size<u64, u64>(&arg0.reserved_amount_by_epoch) > 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::constants::num_keeps_to_reserve()) {
            let (_, _) = 0x2::vec_map::remove_entry_by_idx<u64, u64>(&mut arg0.reserved_amount_by_epoch, 0);
        };
    }

    public(friend) fun add_total_staked_amount(arg0: &mut Stats, arg1: u64) {
        arg0.total_staked_amount = arg0.total_staked_amount + arg1;
    }

    public(friend) fun borrow_mut_stats(arg0: &mut RewardPool, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>) : &mut Stats {
        let v0 = StatsKey{
            name           : arg1,
            staking_window : arg2,
        };
        borrow_mut<StatsKey, Stats>(arg0, v0)
    }

    public fun borrow_stats(arg0: &RewardPool, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>) : &Stats {
        let v0 = StatsKey{
            name           : arg1,
            staking_window : arg2,
        };
        borrow<StatsKey, Stats>(arg0, v0)
    }

    public fun current_total_reserved_amount(arg0: &RewardPool, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = borrow_stats(arg0, arg1, arg2);
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<u64, u64>(&v0.reserved_amount_by_epoch);
        let v3 = 0x2::vec_map::size<u64, u64>(&v0.reserved_amount_by_epoch);
        while (v3 > 0) {
            v3 = v3 - 1;
            let v4 = 0x1::vector::borrow<u64>(&v2, v3);
            if (*v4 > 0x2::tx_context::epoch(arg3)) {
                v1 = v1 + *0x2::vec_map::get<u64, u64>(&v0.reserved_amount_by_epoch, v4);
                continue
            };
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id      : 0x2::object::new(arg0),
            version : 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::package::version(),
            balance : 0x2::balance::zero<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(),
        };
        let v1 = StatsKey{
            name           : 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::constants::open_ended_str(),
            staking_window : 0x1::option::none<u64>(),
        };
        let v2 = Stats{
            total_staked_amount      : 0,
            reserved_amount_by_epoch : 0x2::vec_map::empty<u64, u64>(),
        };
        0x2::dynamic_field::add<StatsKey, Stats>(&mut v0.id, v1, v2);
        let v3 = StatsKey{
            name           : 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::constants::locked_str(),
            staking_window : 0x1::option::some<u64>(90),
        };
        let v4 = Stats{
            total_staked_amount      : 0,
            reserved_amount_by_epoch : 0x2::vec_map::empty<u64, u64>(),
        };
        0x2::dynamic_field::add<StatsKey, Stats>(&mut v0.id, v3, v4);
        let v5 = StatsKey{
            name           : 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::constants::locked_str(),
            staking_window : 0x1::option::some<u64>(182),
        };
        let v6 = Stats{
            total_staked_amount      : 0,
            reserved_amount_by_epoch : 0x2::vec_map::empty<u64, u64>(),
        };
        0x2::dynamic_field::add<StatsKey, Stats>(&mut v0.id, v5, v6);
        let v7 = StatsKey{
            name           : 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::constants::locked_str(),
            staking_window : 0x1::option::some<u64>(365),
        };
        let v8 = Stats{
            total_staked_amount      : 0,
            reserved_amount_by_epoch : 0x2::vec_map::empty<u64, u64>(),
        };
        0x2::dynamic_field::add<StatsKey, Stats>(&mut v0.id, v7, v8);
        0x2::transfer::share_object<RewardPool>(v0);
    }

    public fun is_pool_balance_enough(arg0: &RewardPool, arg1: u64) : bool {
        0x2::balance::value<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&arg0.balance) >= arg1
    }

    public fun is_version_eq(arg0: &RewardPool) : bool {
        arg0.version == 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::package::version()
    }

    public fun place_in_pool(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>) {
        assert!(is_version_eq(arg0), 0);
        0x2::balance::join<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&mut arg0.balance, 0x2::coin::into_balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(arg1));
    }

    public(friend) fun remove_stats(arg0: &mut RewardPool, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>) : Stats {
        let v0 = StatsKey{
            name           : arg1,
            staking_window : arg2,
        };
        0x2::dynamic_field::remove<StatsKey, Stats>(&mut arg0.id, v0)
    }

    public(friend) fun sub_reserved_amount(arg0: &mut Stats, arg1: u64, arg2: u64) {
        if (0x2::vec_map::contains<u64, u64>(&arg0.reserved_amount_by_epoch, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u64, u64>(&mut arg0.reserved_amount_by_epoch, &arg1);
            *v0 = *v0 - arg2;
        };
    }

    public(friend) fun sub_total_staked_amount(arg0: &mut Stats, arg1: u64) {
        arg0.total_staked_amount = arg0.total_staked_amount - arg1;
    }

    public(friend) fun take_from_pool(arg0: &mut RewardPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES> {
        assert!(is_version_eq(arg0), 0);
        assert!(is_pool_balance_enough(arg0, arg1), 1);
        0x2::coin::from_balance<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(0x2::balance::split<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES>(&mut arg0.balance, arg1), arg2)
    }

    public fun total_locked_amount(arg0: &RewardPool, arg1: u64, arg2: &0x2::tx_context::TxContext) : u64 {
        total_staked_amount(arg0, 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::constants::locked_str(), 0x1::option::some<u64>(arg1)) + current_total_reserved_amount(arg0, 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::constants::locked_str(), 0x1::option::some<u64>(arg1), arg2)
    }

    public fun total_staked_amount(arg0: &RewardPool, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>) : u64 {
        borrow_stats(arg0, arg1, arg2).total_staked_amount
    }

    // decompiled from Move bytecode v6
}

