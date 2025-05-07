module 0x6a38a2d67f288b92d46ed19c8d2cf5e1afb211b374f7725cc3fb706b1c7f6f34::penaltyvesting {
    struct PENALTYVESTING has drop {
        dummy_field: bool,
    }

    struct PenaltyVestingAuth has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Lock has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>,
        creation_time_ms: u64,
        expiration_time_ms: u64,
        strategy_set_time_ms: u64,
        unlock_start_time_ms: u64,
        final_unlock_time_ms: u64,
        last_claim_time_ms: u64,
        initial_locked_amount: u64,
        vested_amount: u64,
        penalty_percentage: u64,
        vesting_strategy: u64,
        owner: address,
    }

    struct LockCreatedEvent has copy, drop {
        lock_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
        owner: address,
    }

    struct VestingStrategySetEvent has copy, drop {
        lock_id: 0x2::object::ID,
        vesting_strategy: u64,
        owner: address,
    }

    struct TokensClaimedEvent has copy, drop {
        lock_id: 0x2::object::ID,
        amount: u64,
        owner: address,
        tokens_left: u64,
        time_left_ms: u64,
    }

    struct LockExpiredEvent has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
    }

    public fun auth_to_address(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<PENALTYVESTING>(arg0), 3);
        let v0 = PenaltyVestingAuth{
            id    : 0x2::object::new(arg2),
            owner : arg1,
        };
        0x2::transfer::transfer<PenaltyVestingAuth>(v0, arg1);
    }

    public fun claim_tokens(arg0: &mut Lock, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 5);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.vesting_strategy != 0, 1);
        assert!(v0 >= arg0.unlock_start_time_ms, 7);
        assert!(v0 >= arg0.creation_time_ms, 13);
        let v1 = 0;
        if (arg0.last_claim_time_ms != 0) {
            v1 = 1 + (arg0.last_claim_time_ms - arg0.unlock_start_time_ms) / 604800000;
        };
        let v2 = 1 + (v0 - arg0.unlock_start_time_ms) / 604800000;
        let v3 = v2 - v1;
        assert!(v3 > 0, 8);
        let v4 = 0;
        let v5 = 6;
        if (arg0.vesting_strategy == 1) {
            v4 = arg0.vested_amount / 7;
            v5 = 7;
        } else if (arg0.vesting_strategy == 2 || arg0.vesting_strategy == 3) {
            v4 = arg0.vested_amount / 6;
        };
        assert!(v1 < v5, 9);
        let v6 = v4 * v3;
        if (v3 + v2 > v5) {
            v6 = 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg0.balance);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>>(0x2::coin::take<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.balance, v6, arg2), arg0.owner);
        arg0.last_claim_time_ms = v0;
        let v7 = 0;
        if (arg0.final_unlock_time_ms > v0) {
            v7 = arg0.final_unlock_time_ms - v0;
        };
        let v8 = TokensClaimedEvent{
            lock_id      : 0x2::object::id<Lock>(arg0),
            amount       : v6,
            owner        : arg0.owner,
            tokens_left  : 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg0.balance),
            time_left_ms : v7,
        };
        0x2::event::emit<TokensClaimedEvent>(v8);
    }

    public fun create_lock(arg0: &PenaltyVestingAuth, arg1: 0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 2);
        let v0 = 0x2::coin::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = Lock{
            id                    : 0x2::object::new(arg4),
            balance               : 0x2::coin::into_balance<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(arg1),
            creation_time_ms      : arg2,
            expiration_time_ms    : arg2 + 86400000 * 150,
            strategy_set_time_ms  : 0,
            unlock_start_time_ms  : 0,
            final_unlock_time_ms  : 0,
            last_claim_time_ms    : 0,
            initial_locked_amount : v0,
            vested_amount         : 0,
            penalty_percentage    : 0,
            vesting_strategy      : 0,
            owner                 : arg3,
        };
        let v2 = LockCreatedEvent{
            lock_id      : 0x2::object::id<Lock>(&v1),
            amount       : v0,
            timestamp_ms : arg2,
            owner        : arg3,
        };
        0x2::event::emit<LockCreatedEvent>(v2);
        0x2::transfer::share_object<Lock>(v1);
    }

    public(friend) fun creation_time_ms(arg0: &Lock) : u64 {
        arg0.creation_time_ms
    }

    public fun empty_expired_lock(arg0: &PenaltyVestingAuth, arg1: &mut Lock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expiration_time_ms, 10);
        assert!(arg1.vesting_strategy == 0, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>>(0x2::coin::take<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg1.balance, 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg1.balance), arg3), @0x23d6cdf351ecbcad7764f7de64244a7b8b828977a2a100b8222af07f2cc0c348);
        let v0 = LockExpiredEvent{
            lock_id : 0x2::object::id<Lock>(arg1),
            owner   : arg1.owner,
        };
        0x2::event::emit<LockExpiredEvent>(v0);
    }

    public(friend) fun expiration_time_ms(arg0: &Lock) : u64 {
        arg0.expiration_time_ms
    }

    fun init(arg0: PENALTYVESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<PENALTYVESTING>(arg0, arg1);
        auth_to_address(&v1, v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public(friend) fun owner(arg0: &Lock) : address {
        arg0.owner
    }

    public fun set_vesting_strategy(arg0: &mut Lock, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 5);
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else {
            arg1 == 3
        };
        assert!(v0, 6);
        assert!(arg0.vesting_strategy == 0, 0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.creation_time_ms, 13);
        assert!(v1 < arg0.expiration_time_ms, 12);
        arg0.vesting_strategy = arg1;
        arg0.strategy_set_time_ms = v1;
        if (arg1 == 1) {
            arg0.penalty_percentage = 75;
            arg0.unlock_start_time_ms = v1;
            arg0.final_unlock_time_ms = v1 + 604800000 * 6;
        } else if (arg1 == 2) {
            arg0.penalty_percentage = 50;
            if (v1 - arg0.creation_time_ms < 86400000 * 50) {
                arg0.unlock_start_time_ms = arg0.creation_time_ms + 86400000 * 50;
                arg0.final_unlock_time_ms = arg0.creation_time_ms + 86400000 * 50 + 604800000 * 5;
            } else {
                arg0.unlock_start_time_ms = v1;
                arg0.final_unlock_time_ms = v1 + 604800000 * 5;
            };
        } else if (arg1 == 3) {
            arg0.penalty_percentage = 0;
            arg0.unlock_start_time_ms = arg0.creation_time_ms + 86400000 * 95;
            arg0.final_unlock_time_ms = arg0.creation_time_ms + 86400000 * 95 + 604800000 * 5;
            if (v1 - arg0.creation_time_ms < 86400000 * 95) {
                arg0.unlock_start_time_ms = arg0.creation_time_ms + 86400000 * 95;
                arg0.final_unlock_time_ms = arg0.creation_time_ms + 86400000 * 95 + 604800000 * 5;
            } else {
                arg0.unlock_start_time_ms = v1;
                arg0.final_unlock_time_ms = v1 + 604800000 * 5;
            };
        };
        let v2 = arg0.initial_locked_amount * arg0.penalty_percentage / 100;
        let v3 = arg0.initial_locked_amount - v2;
        arg0.vested_amount = v3;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>>(0x2::coin::take<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.balance, v2, arg3), @0x23d6cdf351ecbcad7764f7de64244a7b8b828977a2a100b8222af07f2cc0c348);
        };
        if (arg1 == 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>>(0x2::coin::take<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.balance, v3 / 7, arg3), arg0.owner);
            arg0.last_claim_time_ms = v1;
        };
        let v4 = VestingStrategySetEvent{
            lock_id          : 0x2::object::id<Lock>(arg0),
            vesting_strategy : arg1,
            owner            : arg0.owner,
        };
        0x2::event::emit<VestingStrategySetEvent>(v4);
    }

    public(friend) fun value_of_balance(arg0: &Lock) : u64 {
        0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg0.balance)
    }

    public(friend) fun vesting_strategy(arg0: &Lock) : u64 {
        arg0.vesting_strategy
    }

    // decompiled from Move bytecode v6
}

