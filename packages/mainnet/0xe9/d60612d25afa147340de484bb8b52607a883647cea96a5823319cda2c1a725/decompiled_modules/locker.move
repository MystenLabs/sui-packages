module 0xe9d60612d25afa147340de484bb8b52607a883647cea96a5823319cda2c1a725::locker {
    struct LockedToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        unlock_time: u64,
        locked_at: u64,
        amount: u64,
        coin: 0x2::coin::Coin<T0>,
    }

    struct TokenLocked has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        locked_at: u64,
        unlock_time: u64,
    }

    struct TokenUnlocked has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        unlocked_at: u64,
    }

    public fun is_unlockable<T0>(arg0: &LockedToken<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time
    }

    public entry fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        assert!(arg1 > 0, 3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 + arg1;
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = LockedToken<T0>{
            id          : 0x2::object::new(arg3),
            owner       : v3,
            unlock_time : v2,
            locked_at   : v1,
            amount      : v0,
            coin        : arg0,
        };
        let v5 = TokenLocked{
            lock_id     : 0x2::object::id<LockedToken<T0>>(&v4),
            owner       : v3,
            coin_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount      : v0,
            locked_at   : v1,
            unlock_time : v2,
        };
        0x2::event::emit<TokenLocked>(v5);
        0x2::transfer::transfer<LockedToken<T0>>(v4, v3);
    }

    public fun lock_info<T0>(arg0: &LockedToken<T0>) : (address, u64, u64, u64) {
        (arg0.owner, arg0.unlock_time, arg0.locked_at, arg0.amount)
    }

    public entry fun unlock<T0>(arg0: LockedToken<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let LockedToken {
            id          : v0,
            owner       : v1,
            unlock_time : v2,
            locked_at   : _,
            amount      : v4,
            coin        : v5,
        } = arg0;
        let v6 = v0;
        assert!(0x2::tx_context::sender(arg2) == v1, 0);
        assert!(0x2::clock::timestamp_ms(arg1) >= v2, 1);
        let v7 = TokenUnlocked{
            lock_id     : 0x2::object::uid_to_inner(&v6),
            owner       : v1,
            amount      : v4,
            unlocked_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TokenUnlocked>(v7);
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v1);
    }

    // decompiled from Move bytecode v6
}

