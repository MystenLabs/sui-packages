module 0xbefc81bcfd74ed784baf20e4df564e8238dcbf6326876b3d8014527b11f6b2c0::artfi_vesting_pool {
    struct VestingPool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        admin: address,
        start_time: u64,
        total_duration: u64,
        interval_duration: u64,
        tokens_per_interval: u64,
        num_intervals: u64,
        whitelisted_users: 0x2::table::Table<address, bool>,
        user_claims: 0x2::table::Table<address, UserClaim>,
        forfeited_tokens: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ClaimEvent has copy, drop {
        user: address,
        amount: u64,
        interval: u64,
    }

    struct UserClaim has copy, drop, store {
        last_claimed_interval: u64,
    }

    public entry fun add_tokens<T0>(arg0: &mut VestingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun add_whitelisted_user<T0>(arg0: &mut VestingPool<T0>, arg1: address, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        0x2::table::add<address, bool>(&mut arg0.whitelisted_users, arg1, true);
        let v0 = UserClaim{last_claimed_interval: 0};
        0x2::table::add<address, UserClaim>(&mut arg0.user_claims, arg1, v0);
    }

    public entry fun admin_withdraw<T0>(arg0: &mut VestingPool<T0>, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 6);
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<T0>(&arg0.balance), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg3), arg0.admin);
    }

    public entry fun claim_tokens<T0>(arg0: &mut VestingPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, bool>(&arg0.whitelisted_users, v0), 4);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= arg0.start_time, 9);
        assert!(v1 < arg0.start_time + arg0.total_duration, 3);
        let v2 = 0x2::table::borrow_mut<address, UserClaim>(&mut arg0.user_claims, v0);
        let v3 = (v1 - arg0.start_time) / arg0.interval_duration;
        assert!(v3 > v2.last_claimed_interval, 5);
        assert!(v3 < arg0.num_intervals, 8);
        let v4 = arg0.tokens_per_interval;
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v4, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v4, arg2), v0);
        let v5 = v3 - v2.last_claimed_interval - 1;
        if (v5 > 0) {
            let v6 = v5 * arg0.tokens_per_interval;
            if (v6 <= 0x2::balance::value<T0>(&arg0.balance)) {
                0x2::balance::join<T0>(&mut arg0.forfeited_tokens, 0x2::balance::split<T0>(&mut arg0.balance, v6));
            };
        };
        v2.last_claimed_interval = v3;
        let v7 = ClaimEvent{
            user     : v0,
            amount   : v4,
            interval : v3,
        };
        0x2::event::emit<ClaimEvent>(v7);
    }

    public entry fun create_vesting_pool<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg2 > v0, 10);
        let v1 = arg2 - v0;
        assert!(v1 > 0, 2);
        assert!(arg3 > 0, 7);
        assert!(arg4 > 0, 1);
        assert!(arg1 > 0, 1);
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
        let v2 = VestingPool<T0>{
            id                  : 0x2::object::new(arg6),
            balance             : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg6)),
            admin               : 0x2::tx_context::sender(arg6),
            start_time          : v0,
            total_duration      : v1,
            interval_duration   : v1 / arg3,
            tokens_per_interval : arg4,
            num_intervals       : arg3,
            whitelisted_users   : 0x2::table::new<address, bool>(arg6),
            user_claims         : 0x2::table::new<address, UserClaim>(arg6),
            forfeited_tokens    : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<VestingPool<T0>>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg6)};
        0x2::transfer::public_share_object<AdminCap>(v3);
    }

    public fun debug_vesting_info<T0>(arg0: &VestingPool<T0>, arg1: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        (0x2::clock::timestamp_ms(arg1), arg0.start_time, arg0.total_duration, arg0.start_time + arg0.total_duration)
    }

    public fun get_claimable_tokens<T0>(arg0: &VestingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = (0x2::clock::timestamp_ms(arg2) - arg0.start_time) / arg0.interval_duration;
        if (v0 > 0x2::table::borrow<address, UserClaim>(&arg0.user_claims, arg1).last_claimed_interval && v0 < arg0.num_intervals) {
            arg0.tokens_per_interval
        } else {
            0
        }
    }

    public fun get_pool_balance<T0>(arg0: &VestingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_user_claim_info<T0>(arg0: &VestingPool<T0>, arg1: address) : (u64, u64) {
        (0x2::table::borrow<address, UserClaim>(&arg0.user_claims, arg1).last_claimed_interval, arg0.num_intervals)
    }

    public fun get_vesting_schedule<T0>(arg0: &VestingPool<T0>) : (u64, u64, u64, u64) {
        (arg0.start_time, arg0.total_duration, arg0.interval_duration, arg0.tokens_per_interval)
    }

    public fun is_user_whitelisted<T0>(arg0: &VestingPool<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelisted_users, arg1)
    }

    public entry fun withdraw_forfeited_tokens<T0>(arg0: &mut VestingPool<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        assert!(0x2::balance::value<T0>(&arg0.forfeited_tokens) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.forfeited_tokens), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

