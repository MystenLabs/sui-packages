module 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::genesis {
    struct Genesis<phantom T0> has key {
        id: 0x2::object::UID,
        allocations: 0x2::table::Table<address, u64>,
        claimed: 0x2::table::Table<address, u64>,
        genesis_balance: 0x2::balance::Balance<T0>,
        collected_staking_bonus: 0x2::balance::Balance<T0>,
        treasury: 0x2::coin::TreasuryCap<T0>,
        total_claimed: u64,
        total_burnt: u64,
        is_claiming_enabled: bool,
        staking_pool_id: 0x2::object::ID,
        min_claim_amount: u64,
    }

    public(friend) fun add<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut Genesis<T0>, arg2: vector<address>, arg3: vector<u64>) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x2::table::add<address, u64>(&mut arg1.allocations, 0x1::vector::pop_back<address>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3));
        };
    }

    public(friend) fun remove<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut Genesis<T0>, arg2: vector<address>) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x2::table::remove<address, u64>(&mut arg1.allocations, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public fun allocation<T0>(arg0: &Genesis<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.allocations, arg1)
    }

    public fun allocation_exists<T0>(arg0: &Genesis<T0>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.allocations, arg1)
    }

    public fun assert_valid_pool_id<T0>(arg0: &Genesis<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.staking_pool_id == arg1, 3);
    }

    fun calc_penalty(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 1) {
            0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::math::mul_factor(arg0, 66660000, 100000000)
        } else if (arg1 == 2) {
            0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::math::mul_factor(arg0, 33330000, 100000000)
        } else {
            assert!(arg1 == 3, 9223372951682809855);
            0
        }
    }

    public(friend) fun claim<T0>(arg0: &mut Genesis<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.is_claiming_enabled, 1);
        assert!(0x2::table::contains<address, u64>(&arg0.allocations, 0x2::tx_context::sender(arg3)), 2);
        assert!(arg1 >= arg0.min_claim_amount, 0);
        let v0 = if (0x2::table::contains<address, u64>(&arg0.claimed, 0x2::tx_context::sender(arg3))) {
            *0x2::table::borrow<address, u64>(&arg0.claimed, 0x2::tx_context::sender(arg3))
        } else {
            0
        };
        let v1 = *0x2::table::borrow<address, u64>(&arg0.allocations, 0x2::tx_context::sender(arg3));
        assert!(v1 >= arg1, 0);
        assert!(v1 >= v0, 0);
        assert!(v1 - v0 >= arg1, 0);
        let v2 = calc_penalty(arg1, arg2);
        let v3 = if (v2 > 0) {
            0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::math::mul_factor(v2, 50000000, 100000000)
        } else {
            0
        };
        let v4 = 0x2::balance::split<T0>(&mut arg0.genesis_balance, arg1);
        arg0.total_claimed = arg0.total_claimed + arg1;
        if (v2 > 0) {
            let v5 = 0x2::balance::split<T0>(&mut v4, v2);
            if (v3 > 0) {
                0x2::balance::join<T0>(&mut arg0.collected_staking_bonus, 0x2::balance::split<T0>(&mut v5, v3));
            };
            arg0.total_burnt = arg0.total_burnt + 0x2::balance::value<T0>(&v5);
            0x2::coin::burn<T0>(&mut arg0.treasury, 0x2::coin::from_balance<T0>(v5, arg3));
        };
        if (!0x2::table::contains<address, u64>(&arg0.claimed, 0x2::tx_context::sender(arg3))) {
            0x2::table::add<address, u64>(&mut arg0.claimed, 0x2::tx_context::sender(arg3), arg1);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claimed, 0x2::tx_context::sender(arg3)) = v0 + arg1;
        };
        v4
    }

    public fun claimed<T0>(arg0: &Genesis<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claimed, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed, arg1)
        } else {
            0
        }
    }

    public(friend) fun initialize<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Genesis<T0>{
            id                      : 0x2::object::new(arg3),
            allocations             : 0x2::table::new<address, u64>(arg3),
            claimed                 : 0x2::table::new<address, u64>(arg3),
            genesis_balance         : 0x2::balance::zero<T0>(),
            collected_staking_bonus : 0x2::balance::zero<T0>(),
            treasury                : arg1,
            total_claimed           : 0,
            total_burnt             : 0,
            is_claiming_enabled     : false,
            staking_pool_id         : arg2,
            min_claim_amount        : 0,
        };
        0x2::transfer::share_object<Genesis<T0>>(v0);
    }

    public fun is_claiming_enabled<T0>(arg0: &Genesis<T0>) : bool {
        arg0.is_claiming_enabled
    }

    public(friend) fun refill<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut Genesis<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.genesis_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public(friend) fun set_claiming_enabled<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut Genesis<T0>, arg2: bool) {
        arg1.is_claiming_enabled = arg2;
    }

    public(friend) fun set_min_claim_amount<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut Genesis<T0>, arg2: u64) {
        arg1.min_claim_amount = arg2;
    }

    public(friend) fun set_staking_pool_id<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut Genesis<T0>, arg2: 0x2::object::ID) {
        arg1.staking_pool_id = arg2;
    }

    public fun staking_pool_id<T0>(arg0: &Genesis<T0>) : 0x2::object::ID {
        arg0.staking_pool_id
    }

    public fun total_burnt<T0>(arg0: &Genesis<T0>) : u64 {
        arg0.total_burnt
    }

    public fun total_claimed<T0>(arg0: &Genesis<T0>) : u64 {
        arg0.total_claimed
    }

    public(friend) fun withdraw_collected_staking_bonus<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut Genesis<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg1.collected_staking_bonus, 0x2::balance::value<T0>(&arg1.collected_staking_bonus))
    }

    // decompiled from Move bytecode v6
}

