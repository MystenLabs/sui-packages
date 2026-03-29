module 0x7248300e9f57ef053b6e06ad2a61164de95d8054f5be89546e134a5a2d005dbb::lock {
    struct TokenLock<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        unlock_time: u64,
        amount: u64,
    }

    struct LockCreated has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        unlock_time: u64,
    }

    public fun get_amount<T0>(arg0: &TokenLock<T0>) : u64 {
        arg0.amount
    }

    public fun get_owner<T0>(arg0: &TokenLock<T0>) : address {
        arg0.owner
    }

    public fun get_unlock_time<T0>(arg0: &TokenLock<T0>) : u64 {
        arg0.unlock_time
    }

    public fun lock_tokens<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2), 0);
        let v2 = TokenLock<T0>{
            id          : 0x2::object::new(arg3),
            owner       : v0,
            balance     : 0x2::coin::into_balance<T0>(arg0),
            unlock_time : arg1,
            amount      : v1,
        };
        let v3 = LockCreated{
            lock_id     : 0x2::object::id<TokenLock<T0>>(&v2),
            owner       : v0,
            amount      : v1,
            unlock_time : arg1,
        };
        0x2::event::emit<LockCreated>(v3);
        0x2::transfer::share_object<TokenLock<T0>>(v2);
    }

    public fun unlock_tokens<T0>(arg0: TokenLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time, 0);
        let TokenLock {
            id          : v0,
            owner       : v1,
            balance     : v2,
            unlock_time : _,
            amount      : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), v1);
    }

    // decompiled from Move bytecode v6
}

