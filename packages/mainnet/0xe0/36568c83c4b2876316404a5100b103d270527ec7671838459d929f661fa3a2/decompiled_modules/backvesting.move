module 0xe036568c83c4b2876316404a5100b103d270527ec7671838459d929f661fa3a2::backvesting {
    struct BACKVESTING has drop {
        dummy_field: bool,
    }

    struct BackvestingAuth has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Lock has store, key {
        id: 0x2::object::UID,
        locked_balance: 0x2::balance::Balance<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>,
        unlocked_balance: 0x2::balance::Balance<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>,
        creation_time_ms: u64,
        final_unlock_time_ms: u64,
        initial_locked_amount: u64,
        destination: address,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>,
        vesting_months: u64,
        destination: address,
        lock_count: u64,
    }

    struct PoolManager has store, key {
        id: 0x2::object::UID,
        pool_names: vector<0x1::string::String>,
        percentages: vector<u64>,
        total_percentage: u64,
    }

    struct PaymentReceivedEvent has copy, drop {
        amount: u64,
        timestamp_ms: u64,
    }

    struct TokensAddedToPoolEvent has copy, drop {
        pool_name: 0x1::string::String,
        amount: u64,
        timestamp_ms: u64,
    }

    struct LockCreatedEvent has copy, drop {
        lock_id: 0x2::object::ID,
        pool_name: 0x1::string::String,
        amount: u64,
        creation_time_ms: u64,
        final_unlock_time_ms: u64,
    }

    struct TokensUnlockedEvent has copy, drop {
        lock_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
    }

    struct TokensClaimedEvent has copy, drop {
        lock_id: 0x2::object::ID,
        amount: u64,
        destination: address,
        timestamp_ms: u64,
    }

    public entry fun add_pool(arg0: &BackvestingAuth, arg1: &mut PoolManager, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 1);
        let v0 = arg1.total_percentage + arg3;
        assert!(v0 <= 100, 2);
        let v1 = Pool{
            id             : 0x2::object::new(arg6),
            balance        : 0x2::balance::zero<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(),
            vesting_months : arg4,
            destination    : arg5,
            lock_count     : 0,
        };
        0x2::dynamic_object_field::add<0x1::string::String, Pool>(&mut arg1.id, arg2, v1);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.pool_names, arg2);
        0x1::vector::push_back<u64>(&mut arg1.percentages, arg3);
        arg1.total_percentage = v0;
    }

    fun add_to_pool(arg0: &mut Pool, arg1: 0x2::balance::Balance<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        0x2::balance::join<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.balance, arg1);
        let v0 = TokensAddedToPoolEvent{
            pool_name    : arg2,
            amount       : 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokensAddedToPoolEvent>(v0);
    }

    public entry fun backvesting_auth_to_address(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<BACKVESTING>(arg0), 0);
        let v0 = BackvestingAuth{
            id    : 0x2::object::new(arg2),
            owner : arg1,
        };
        0x2::transfer::transfer<BackvestingAuth>(v0, arg1);
    }

    fun claim_tokens(arg0: &mut Lock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg0.unlocked_balance);
        if (v0 > 0) {
            let v1 = TokensClaimedEvent{
                lock_id      : 0x2::object::id<Lock>(arg0),
                amount       : v0,
                destination  : arg0.destination,
                timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg1),
            };
            0x2::event::emit<TokensClaimedEvent>(v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>>(0x2::coin::from_balance<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(0x2::balance::split<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.unlocked_balance, v0), arg1), arg0.destination);
        };
    }

    fun create_lock(arg0: &mut Pool, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0 + arg0.vesting_months * 30 * 24 * 60 * 60 * 1000;
        let v2 = 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg0.balance);
        let v3 = Lock{
            id                    : 0x2::object::new(arg3),
            locked_balance        : 0x2::balance::split<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.balance, v2),
            unlocked_balance      : 0x2::balance::zero<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(),
            creation_time_ms      : v0,
            final_unlock_time_ms  : v1,
            initial_locked_amount : v2,
            destination           : arg0.destination,
        };
        let v4 = 0x1::string::utf8(b"lock_");
        0x1::string::append(&mut v4, 0x1::string::utf8(0x2::bcs::to_bytes<u64>(&arg0.lock_count)));
        arg0.lock_count = arg0.lock_count + 1;
        0x2::dynamic_object_field::add<0x1::string::String, Lock>(&mut arg0.id, v4, v3);
        let v5 = LockCreatedEvent{
            lock_id              : 0x2::object::id<Lock>(&v3),
            pool_name            : arg1,
            amount               : v2,
            creation_time_ms     : v0,
            final_unlock_time_ms : v1,
        };
        0x2::event::emit<LockCreatedEvent>(v5);
    }

    public entry fun create_pool_manager(arg0: &BackvestingAuth, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolManager{
            id               : 0x2::object::new(arg1),
            pool_names       : 0x1::vector::empty<0x1::string::String>(),
            percentages      : 0x1::vector::empty<u64>(),
            total_percentage : 0,
        };
        0x2::transfer::public_share_object<PoolManager>(v0);
    }

    fun init(arg0: BACKVESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<BACKVESTING>(arg0, arg1);
        backvesting_auth_to_address(&v1, v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    fun process_locks(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0.lock_count) {
            let v1 = 0x1::string::utf8(b"lock_");
            0x1::string::append(&mut v1, 0x1::string::utf8(0x2::bcs::to_bytes<u64>(&v0)));
            if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v1)) {
                let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Lock>(&mut arg0.id, v1);
                unlock_tokens(v2, arg1);
                claim_tokens(v2, arg2);
                if (0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&v2.locked_balance) == 0 && 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&v2.unlocked_balance) == 0) {
                    let Lock {
                        id                    : v3,
                        locked_balance        : v4,
                        unlocked_balance      : v5,
                        creation_time_ms      : _,
                        final_unlock_time_ms  : _,
                        initial_locked_amount : _,
                        destination           : _,
                    } = 0x2::dynamic_object_field::remove<0x1::string::String, Lock>(&mut arg0.id, v1);
                    0x2::object::delete(v3);
                    0x2::balance::destroy_zero<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(v4);
                    0x2::balance::destroy_zero<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(v5);
                };
            };
            v0 = v0 + 1;
        };
    }

    public entry fun receive_payment(arg0: &mut PoolManager, arg1: 0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg1);
        let v1 = 0x2::coin::into_balance<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(arg1);
        let v2 = PaymentReceivedEvent{
            amount       : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PaymentReceivedEvent>(v2);
        let v3 = 0;
        let v4 = 0x1::vector::length<0x1::string::String>(&arg0.pool_names);
        while (v3 < v4) {
            let v5 = *0x1::vector::borrow<0x1::string::String>(&arg0.pool_names, v3);
            let v6 = *0x1::vector::borrow<u64>(&arg0.percentages, v3);
            if (v6 > 0) {
                let v7 = v0 * v6 / 100;
                if (v7 > 0) {
                    let v8 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Pool>(&mut arg0.id, v5);
                    add_to_pool(v8, 0x2::balance::split<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut v1, v7), v5, arg2);
                };
            };
            v3 = v3 + 1;
        };
        if (0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&v1) > 0 && v4 > 0) {
            let v9 = *0x1::vector::borrow<0x1::string::String>(&arg0.pool_names, 0);
            let v10 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Pool>(&mut arg0.id, v9);
            add_to_pool(v10, v1, v9, arg2);
        } else {
            0x2::balance::destroy_zero<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(v1);
        };
    }

    fun unlock_tokens(arg0: &mut Lock, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.final_unlock_time_ms) {
            let v1 = 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg0.locked_balance);
            if (v1 > 0) {
                0x2::balance::join<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.unlocked_balance, 0x2::balance::split<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.locked_balance, v1));
                let v2 = TokensUnlockedEvent{
                    lock_id      : 0x2::object::id<Lock>(arg0),
                    amount       : v1,
                    timestamp_ms : v0,
                };
                0x2::event::emit<TokensUnlockedEvent>(v2);
            };
        } else {
            let v3 = 2592000000;
            let v4 = (arg0.final_unlock_time_ms - arg0.creation_time_ms) / v3;
            let v5 = v4;
            if (v4 == 0) {
                v5 = 1;
            };
            let v6 = arg0.initial_locked_amount / v5 * (v0 - arg0.creation_time_ms) / v3;
            let v7 = arg0.initial_locked_amount - 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg0.locked_balance);
            if (v6 > v7) {
                let v8 = v6 - v7;
                if (v8 > 0 && v8 <= 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg0.locked_balance)) {
                    0x2::balance::join<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.unlocked_balance, 0x2::balance::split<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.locked_balance, v8));
                    let v9 = TokensUnlockedEvent{
                        lock_id      : 0x2::object::id<Lock>(arg0),
                        amount       : v8,
                        timestamp_ms : v0,
                    };
                    0x2::event::emit<TokensUnlockedEvent>(v9);
                };
            };
        };
    }

    public entry fun update_all_pools(arg0: &BackvestingAuth, arg1: &mut PoolManager, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1.pool_names)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg1.pool_names, v0);
            let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Pool>(&mut arg1.id, v1);
            update_pool(v2, v1, arg2, arg3);
            v0 = v0 + 1;
        };
    }

    fun update_pool(arg0: &mut Pool, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg0.balance) > 0) {
            create_lock(arg0, arg1, arg2, arg3);
        };
        process_locks(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

