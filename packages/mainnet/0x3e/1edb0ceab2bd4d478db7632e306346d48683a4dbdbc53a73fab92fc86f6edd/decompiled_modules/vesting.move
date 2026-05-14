module 0xc6b5f087beaee003d909fff9e3e02b12c8b3c90e9fda2e9271ca98941186aac4::vesting {
    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        original_amount: u64,
        locked: 0x2::balance::Balance<T0>,
        coin_type: 0x1::ascii::String,
        label: 0x1::option::Option<0x1::string::String>,
        start_ms: u64,
        end_ms: u64,
    }

    struct LockCreated has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        start_ms: u64,
        end_ms: u64,
        label: 0x1::option::Option<0x1::string::String>,
    }

    struct LockClaimed has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct LockExtended has copy, drop {
        lock_id: 0x2::object::ID,
        old_end_ms: u64,
        new_end_ms: u64,
    }

    public fun amount<T0>(arg0: &Lock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked)
    }

    public fun claim<T0>(arg0: Lock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_ms, 3);
        let Lock {
            id              : v0,
            owner           : v1,
            original_amount : _,
            locked          : v3,
            coin_type       : v4,
            label           : _,
            start_ms        : _,
            end_ms          : _,
        } = arg0;
        let v8 = v3;
        let v9 = v0;
        let v10 = LockClaimed{
            lock_id   : 0x2::object::uid_to_inner(&v9),
            owner     : v1,
            coin_type : v4,
            amount    : 0x2::balance::value<T0>(&v8),
        };
        0x2::event::emit<LockClaimed>(v10);
        0x2::object::delete(v9);
        0x2::coin::from_balance<T0>(v8, arg2)
    }

    public fun coin_type_str<T0>(arg0: &Lock<T0>) : 0x1::ascii::String {
        arg0.coin_type
    }

    public fun create_lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Lock<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        assert!(arg1 > 0, 1);
        assert!(arg1 <= 3153600000000, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v1 + arg1;
        let v3 = Lock<T0>{
            id              : 0x2::object::new(arg4),
            owner           : 0x2::tx_context::sender(arg4),
            original_amount : v0,
            locked          : 0x2::coin::into_balance<T0>(arg0),
            coin_type       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            label           : arg2,
            start_ms        : v1,
            end_ms          : v2,
        };
        let v4 = LockCreated{
            lock_id   : 0x2::object::id<Lock<T0>>(&v3),
            owner     : v3.owner,
            coin_type : v3.coin_type,
            amount    : v0,
            start_ms  : v1,
            end_ms    : v2,
            label     : v3.label,
        };
        0x2::event::emit<LockCreated>(v4);
        v3
    }

    public fun create_lock_to_sender<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create_lock<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<Lock<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun end_ms<T0>(arg0: &Lock<T0>) : u64 {
        arg0.end_ms
    }

    public fun extend<T0>(arg0: &mut Lock<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > arg0.end_ms, 4);
        assert!(arg1 - arg0.start_ms <= 3153600000000, 2);
        arg0.end_ms = arg1;
        let v0 = LockExtended{
            lock_id    : 0x2::object::id<Lock<T0>>(arg0),
            old_end_ms : arg0.end_ms,
            new_end_ms : arg1,
        };
        0x2::event::emit<LockExtended>(v0);
    }

    public fun is_unlocked<T0>(arg0: &Lock<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.end_ms
    }

    public fun original_amount<T0>(arg0: &Lock<T0>) : u64 {
        arg0.original_amount
    }

    public fun owner<T0>(arg0: &Lock<T0>) : address {
        arg0.owner
    }

    public fun start_ms<T0>(arg0: &Lock<T0>) : u64 {
        arg0.start_ms
    }

    public fun time_left_ms<T0>(arg0: &Lock<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.end_ms) {
            0
        } else {
            arg0.end_ms - v0
        }
    }

    // decompiled from Move bytecode v7
}

