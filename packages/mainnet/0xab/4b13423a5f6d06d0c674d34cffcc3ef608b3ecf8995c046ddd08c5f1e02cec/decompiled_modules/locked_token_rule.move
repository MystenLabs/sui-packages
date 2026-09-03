module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::locked_token_rule {
    struct LockedTokenRule has drop {
        dummy_field: bool,
    }

    struct Config<phantom T0> has store {
        min_balance: u64,
        min_lock_ms: u64,
    }

    struct Lock<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<T0>,
        unlock_ms: u64,
    }

    struct LockCreated has copy, drop {
        lock: 0x2::object::ID,
        owner: address,
    }

    struct Deposited has copy, drop {
        lock: 0x2::object::ID,
        amount: u64,
        balance: u64,
    }

    struct Withdrawn has copy, drop {
        lock: 0x2::object::ID,
        amount: u64,
        balance: u64,
    }

    struct LockExtended has copy, drop {
        lock: 0x2::object::ID,
        set: 0x2::object::ID,
        unlock_ms: u64,
    }

    struct LockDestroyed has copy, drop {
        lock: 0x2::object::ID,
    }

    public fun destroy_empty<T0>(arg0: Lock<T0>) {
        let Lock {
            id        : v0,
            version   : _,
            balance   : v2,
            unlock_ms : _,
        } = arg0;
        let v4 = v0;
        0x2::balance::destroy_zero<T0>(v2);
        let v5 = LockDestroyed{lock: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<LockDestroyed>(v5);
        0x2::object::delete(v4);
    }

    public fun add<T0, T1>(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap, arg2: u64, arg3: u64, arg4: bool) {
        assert!(arg3 <= 315360000000, 2);
        let v0 = LockedTokenRule{dummy_field: false};
        let v1 = Config<T1>{
            min_balance : arg2,
            min_lock_ms : arg3,
        };
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::add<T0, LockedTokenRule, Config<T1>>(v0, arg0, arg1, v1, arg4);
    }

    fun assert_version<T0>(arg0: &Lock<T0>) {
        assert!(arg0.version == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 3);
    }

    public fun deposit<T0>(arg0: &mut Lock<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert_version<T0>(arg0);
        let v0 = Deposited{
            lock    : 0x2::object::id<Lock<T0>>(arg0),
            amount  : 0x2::coin::value<T0>(&arg1),
            balance : 0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1)),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun keep<T0>(arg0: Lock<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Lock<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun locked_balance<T0>(arg0: &Lock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun max_lock_ms() : u64 {
        315360000000
    }

    public fun migrate<T0>(arg0: &mut Lock<T0>) {
        assert!(arg0.version < 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 4);
        arg0.version = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version();
    }

    public fun min_balance<T0, T1>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>) : u64 {
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<T0, LockedTokenRule, Config<T1>>(arg0).min_balance
    }

    public fun min_lock_ms<T0, T1>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>) : u64 {
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<T0, LockedTokenRule, Config<T1>>(arg0).min_lock_ms
    }

    public fun new_lock<T0>(arg0: &mut 0x2::tx_context::TxContext) : Lock<T0> {
        let v0 = Lock<T0>{
            id        : 0x2::object::new(arg0),
            version   : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(),
            balance   : 0x2::balance::zero<T0>(),
            unlock_ms : 0,
        };
        let v1 = LockCreated{
            lock  : 0x2::object::id<Lock<T0>>(&v0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<LockCreated>(v1);
        v0
    }

    public fun prove<T0, T1>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<T0>, arg2: &mut Lock<T1>, arg3: &0x2::clock::Clock) {
        assert_version<T1>(arg2);
        let v0 = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<T0, LockedTokenRule, Config<T1>>(arg0);
        assert!(0x2::balance::value<T1>(&arg2.balance) >= v0.min_balance, 0);
        let v1 = 0x2::clock::timestamp_ms(arg3) + 0x1::u64::min(v0.min_lock_ms, 315360000000);
        if (v1 > arg2.unlock_ms) {
            arg2.unlock_ms = v1;
            let v2 = LockExtended{
                lock      : 0x2::object::id<Lock<T1>>(arg2),
                set       : 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>>(arg0),
                unlock_ms : v1,
            };
            0x2::event::emit<LockExtended>(v2);
        };
        let v3 = LockedTokenRule{dummy_field: false};
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::add_approval<T0, LockedTokenRule>(v3, arg0, arg1);
    }

    public fun remove<T0, T1>(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap) {
        let Config {
            min_balance : _,
            min_lock_ms : _,
        } = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::remove<T0, LockedTokenRule, Config<T1>>(arg0, arg1);
    }

    public fun unlock_ms<T0>(arg0: &Lock<T0>) : u64 {
        arg0.unlock_ms
    }

    public fun version<T0>(arg0: &Lock<T0>) : u64 {
        arg0.version
    }

    public fun withdraw<T0>(arg0: &mut Lock<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.unlock_ms, 1);
        let v0 = Withdrawn{
            lock    : 0x2::object::id<Lock<T0>>(arg0),
            amount  : arg1,
            balance : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<Withdrawn>(v0);
        0x2::coin::take<T0>(&mut arg0.balance, arg1, arg3)
    }

    // decompiled from Move bytecode v7
}

