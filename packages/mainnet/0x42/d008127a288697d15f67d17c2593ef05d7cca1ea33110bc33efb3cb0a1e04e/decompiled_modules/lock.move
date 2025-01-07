module 0x42d008127a288697d15f67d17c2593ef05d7cca1ea33110bc33efb3cb0a1e04e::lock {
    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        lock_start: u64,
        lock_end: u64,
    }

    struct LockAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LockEvent has copy, drop {
        amount: u64,
        lock_start: u64,
        lock_end: u64,
    }

    struct UnlockEvent has copy, drop {
        amount: u64,
        lock_start: u64,
        lock_end: u64,
    }

    public entry fun lock<T0>(arg0: &LockAdminCap, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Lock<T0>{
            id         : 0x2::object::new(arg5),
            balance    : 0x2::balance::zero<T0>(),
            lock_start : v0,
            lock_end   : arg1,
        };
        let (v2, v3) = split_coin_vec<T0>(arg2, arg3, arg5);
        0x2::balance::join<T0>(&mut v1.balance, 0x2::coin::into_balance<T0>(v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<Lock<T0>>(v1, 0x2::tx_context::sender(arg5));
        let v4 = LockEvent{
            amount     : arg3,
            lock_start : v0,
            lock_end   : arg1,
        };
        0x2::event::emit<LockEvent>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LockAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LockAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun split_coin_vec<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        (0x2::coin::split<T0>(&mut v0, arg1, arg2), v0)
    }

    public entry fun unlock<T0>(arg0: &LockAdminCap, arg1: &mut Lock<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = UnlockEvent{
            amount     : v0,
            lock_start : arg1.lock_start,
            lock_end   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UnlockEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

