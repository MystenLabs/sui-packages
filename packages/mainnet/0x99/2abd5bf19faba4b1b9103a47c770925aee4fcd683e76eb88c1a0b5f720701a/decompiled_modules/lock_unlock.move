module 0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::lock_unlock {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Reserves has key {
        id: 0x2::object::UID,
        suip_balance: 0x2::balance::Balance<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>,
        nest_reserve: 0x2::balance::Balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>,
        total_suip_locked: u128,
        total_nest_in_circulation: u128,
        total_fees_collected: u128,
        total_locks: u64,
        total_unlocks: u64,
        is_initialized: bool,
        is_paused: bool,
    }

    struct Locked has copy, drop {
        user: address,
        suip_amount_in: u128,
        nest_amount_out: u128,
        nest_fee_to_staking: u128,
        suip_fee: u128,
        total_suip_locked: u128,
        total_nest_in_circulation: u128,
        timestamp: u64,
    }

    struct Unlocked has copy, drop {
        user: address,
        nest_amount_in: u128,
        suip_amount_out: u128,
        nest_fee_to_staking: u128,
        suip_fee: u128,
        total_suip_locked: u128,
        total_nest_in_circulation: u128,
        timestamp: u64,
    }

    struct ReservesInitialized has copy, drop {
        nest_amount: u128,
        timestamp: u64,
    }

    struct Paused has copy, drop {
        timestamp: u64,
    }

    struct Unpaused has copy, drop {
        timestamp: u64,
    }

    struct EmergencyWithdrawal has copy, drop {
        admin: address,
        token_type: vector<u8>,
        amount: u64,
        timestamp: u64,
    }

    struct AdminTransferred has copy, drop {
        from: address,
        to: address,
        timestamp: u64,
    }

    public fun calculate_lock_output(arg0: u128) : u128 {
        (arg0 - safe_mul_div(arg0, 50, 10000)) / 3
    }

    public fun calculate_unlock_output(arg0: u128) : u128 {
        let v0 = safe_mul(arg0, 3);
        v0 - safe_mul_div(v0, 50, 10000)
    }

    public entry fun emergency_withdraw_nest(arg0: &AdminCap, arg1: &mut Reserves, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 9);
        assert!(0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg1.nest_reserve) >= arg2, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>>(0x2::coin::from_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(0x2::balance::split<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg1.nest_reserve, arg2), arg4), v0);
        let v1 = EmergencyWithdrawal{
            admin      : v0,
            token_type : b"NEST",
            amount     : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EmergencyWithdrawal>(v1);
    }

    public entry fun emergency_withdraw_suip(arg0: &AdminCap, arg1: &mut Reserves, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 9);
        assert!(0x2::balance::value<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&arg1.suip_balance) >= arg2, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>>(0x2::coin::from_balance<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(0x2::balance::split<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&mut arg1.suip_balance, arg2), arg4), v0);
        let v1 = EmergencyWithdrawal{
            admin      : v0,
            token_type : b"SUIP",
            amount     : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EmergencyWithdrawal>(v1);
    }

    public fun get_backing_ratio(arg0: &Reserves) : u128 {
        if (arg0.total_nest_in_circulation == 0) {
            return 0
        };
        let v0 = arg0.total_nest_in_circulation * 3;
        if (v0 == 0) {
            return 0
        };
        safe_mul_div((0x2::balance::value<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&arg0.suip_balance) as u128), 10000, v0)
    }

    public fun get_fee_bps() : u128 {
        50
    }

    public fun get_fees_collected(arg0: &Reserves) : u128 {
        arg0.total_fees_collected
    }

    public fun get_lock_ratio() : u128 {
        3
    }

    public fun get_max_lock_amount() : u128 {
        100000000000000
    }

    public fun get_max_unlock_amount() : u128 {
        33333333333333
    }

    public fun get_min_lock_amount() : u128 {
        3
    }

    public fun get_nest_reserve(arg0: &Reserves) : u64 {
        0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.nest_reserve)
    }

    public fun get_nest_reserve_u128(arg0: &Reserves) : u128 {
        (0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.nest_reserve) as u128)
    }

    public fun get_reserves_stats(arg0: &Reserves) : (u64, u64, u128, u128, u128, u64, u64, bool, bool) {
        (0x2::balance::value<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&arg0.suip_balance), 0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.nest_reserve), arg0.total_suip_locked, arg0.total_nest_in_circulation, arg0.total_fees_collected, arg0.total_locks, arg0.total_unlocks, arg0.is_initialized, arg0.is_paused)
    }

    public fun get_suip_balance(arg0: &Reserves) : u64 {
        0x2::balance::value<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&arg0.suip_balance)
    }

    public fun get_suip_balance_u128(arg0: &Reserves) : u128 {
        (0x2::balance::value<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&arg0.suip_balance) as u128)
    }

    public fun get_total_in_circulation(arg0: &Reserves) : u128 {
        arg0.total_nest_in_circulation
    }

    public fun get_total_locked(arg0: &Reserves) : u128 {
        arg0.total_suip_locked
    }

    public fun get_total_locks(arg0: &Reserves) : u64 {
        arg0.total_locks
    }

    public fun get_total_nest_supply() : u128 {
        333000000000000
    }

    public fun get_total_unlocks(arg0: &Reserves) : u64 {
        arg0.total_unlocks
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserves{
            id                        : 0x2::object::new(arg0),
            suip_balance              : 0x2::balance::zero<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(),
            nest_reserve              : 0x2::balance::zero<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(),
            total_suip_locked         : 0,
            total_nest_in_circulation : 0,
            total_fees_collected      : 0,
            total_locks               : 0,
            total_unlocks             : 0,
            is_initialized            : false,
            is_paused                 : false,
        };
        0x2::transfer::share_object<Reserves>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_reserves(arg0: &mut Reserves, arg1: 0x2::coin::Coin<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>, arg2: &AdminCap, arg3: &0x2::clock::Clock) {
        assert!(!arg0.is_initialized, 3);
        let v0 = (0x2::coin::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg1) as u128);
        assert!(v0 > 0, 9);
        assert!(v0 == 333000000000000, 1);
        0x2::balance::join<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg0.nest_reserve, 0x2::coin::into_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(arg1));
        arg0.is_initialized = true;
        let v1 = ReservesInitialized{
            nest_amount : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReservesInitialized>(v1);
    }

    public fun is_healthy(arg0: &Reserves) : bool {
        get_backing_ratio(arg0) >= 10000
    }

    public fun is_initialized(arg0: &Reserves) : bool {
        arg0.is_initialized
    }

    public fun is_paused(arg0: &Reserves) : bool {
        arg0.is_paused
    }

    public entry fun lock(arg0: &mut Reserves, arg1: &mut 0xd30cbf6f80926be6cdb0f7ffff6d75b0766a0a08d822d38219b8729aeff10568::staking_pool::StakingPool, arg2: 0x2::coin::Coin<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 5);
        assert!(arg0.is_initialized, 4);
        let v0 = (0x2::coin::value<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&arg2) as u128);
        assert!(v0 > 0, 9);
        assert!(v0 >= 3, 6);
        assert!(v0 <= 100000000000000, 7);
        assert!(v0 % 3 == 0, 1);
        let v1 = safe_mul_div(v0, 50, 10000);
        let v2 = (v0 - v1) / 3;
        let v3 = v1 / 3;
        let v4 = v2 + v3;
        assert!((0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.nest_reserve) as u128) >= v4, 2);
        assert!(arg0.total_nest_in_circulation + v4 <= 333000000000000, 11);
        assert!(arg0.total_suip_locked + v0 <= 340282366920938463463374607431768211455, 8);
        assert!(arg0.total_nest_in_circulation + v4 <= 340282366920938463463374607431768211455, 8);
        assert!(arg0.total_fees_collected + v1 <= 340282366920938463463374607431768211455, 8);
        0x2::balance::join<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&mut arg0.suip_balance, 0x2::coin::into_balance<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(0x2::coin::split<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&mut arg2, (v1 as u64), arg4)));
        0x2::balance::join<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&mut arg0.suip_balance, 0x2::coin::into_balance<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(arg2));
        0xd30cbf6f80926be6cdb0f7ffff6d75b0766a0a08d822d38219b8729aeff10568::staking_pool::deposit_rewards(arg1, 0x2::coin::from_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(0x2::balance::split<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg0.nest_reserve, (v3 as u64)), arg4), arg3);
        let v5 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>>(0x2::coin::from_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(0x2::balance::split<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg0.nest_reserve, (v2 as u64)), arg4), v5);
        arg0.total_suip_locked = arg0.total_suip_locked + v0;
        arg0.total_nest_in_circulation = arg0.total_nest_in_circulation + v4;
        arg0.total_fees_collected = arg0.total_fees_collected + v1;
        arg0.total_locks = arg0.total_locks + 1;
        let v6 = Locked{
            user                      : v5,
            suip_amount_in            : v0,
            nest_amount_out           : v2,
            nest_fee_to_staking       : v3,
            suip_fee                  : v1,
            total_suip_locked         : arg0.total_suip_locked,
            total_nest_in_circulation : arg0.total_nest_in_circulation,
            timestamp                 : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Locked>(v6);
    }

    public entry fun pause(arg0: &AdminCap, arg1: &mut Reserves, arg2: &0x2::clock::Clock) {
        arg1.is_paused = true;
        let v0 = Paused{timestamp: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<Paused>(v0);
    }

    fun safe_mul(arg0: u128, arg1: u128) : u128 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        assert!(v0 <= (340282366920938463463374607431768211455 as u256), 8);
        (v0 as u128)
    }

    fun safe_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 1);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= (340282366920938463463374607431768211455 as u256), 8);
        (v0 as u128)
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = AdminTransferred{
            from      : 0x2::tx_context::sender(arg3),
            to        : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public entry fun unlock(arg0: &mut Reserves, arg1: &mut 0xd30cbf6f80926be6cdb0f7ffff6d75b0766a0a08d822d38219b8729aeff10568::staking_pool::StakingPool, arg2: 0x2::coin::Coin<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 5);
        assert!(arg0.is_initialized, 4);
        let v0 = (0x2::coin::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg2) as u128);
        assert!(v0 > 0, 9);
        assert!(v0 <= 33333333333333, 7);
        let v1 = safe_mul(v0, 3);
        let v2 = safe_mul_div(v1, 50, 10000);
        let v3 = v1 - v2;
        let v4 = v2 / 3;
        assert!((0x2::balance::value<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&arg0.suip_balance) as u128) >= v1, 2);
        assert!(arg0.total_suip_locked - v1 >= (arg0.total_nest_in_circulation - v0 - v4) * 3, 12);
        assert!(arg0.total_suip_locked >= v1, 2);
        assert!(arg0.total_nest_in_circulation >= v0 + v4, 2);
        assert!(arg0.total_fees_collected + v2 <= 340282366920938463463374607431768211455, 8);
        0x2::balance::join<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg0.nest_reserve, 0x2::coin::into_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(arg2));
        0xd30cbf6f80926be6cdb0f7ffff6d75b0766a0a08d822d38219b8729aeff10568::staking_pool::deposit_rewards(arg1, 0x2::coin::from_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(0x2::balance::split<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg0.nest_reserve, (v4 as u64)), arg4), arg3);
        0x2::balance::join<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&mut arg0.suip_balance, 0x2::balance::split<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&mut arg0.suip_balance, (v2 as u64)));
        let v5 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>>(0x2::coin::from_balance<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(0x2::balance::split<0x992abd5bf19faba4b1b9103a47c770925aee4fcd683e76eb88c1a0b5f720701a::suip::SUIP>(&mut arg0.suip_balance, (v3 as u64)), arg4), v5);
        arg0.total_suip_locked = arg0.total_suip_locked - v1;
        arg0.total_nest_in_circulation = arg0.total_nest_in_circulation - v0 - v4;
        arg0.total_fees_collected = arg0.total_fees_collected + v2;
        arg0.total_unlocks = arg0.total_unlocks + 1;
        let v6 = Unlocked{
            user                      : v5,
            nest_amount_in            : v0,
            suip_amount_out           : v3,
            nest_fee_to_staking       : v4,
            suip_fee                  : v2,
            total_suip_locked         : arg0.total_suip_locked,
            total_nest_in_circulation : arg0.total_nest_in_circulation,
            timestamp                 : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Unlocked>(v6);
    }

    public entry fun unpause(arg0: &AdminCap, arg1: &mut Reserves, arg2: &0x2::clock::Clock) {
        arg1.is_paused = false;
        let v0 = Unpaused{timestamp: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<Unpaused>(v0);
    }

    // decompiled from Move bytecode v6
}

