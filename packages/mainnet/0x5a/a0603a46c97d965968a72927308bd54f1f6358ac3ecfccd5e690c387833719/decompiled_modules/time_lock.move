module 0x5aa0603a46c97d965968a72927308bd54f1f6358ac3ecfccd5e690c387833719::time_lock {
    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        total_amount: u64,
        unlocked: bool,
        unlock_time: u64,
        lock_balance: 0x2::balance::Balance<T0>,
    }

    struct LockCreatedEvent has copy, drop {
        owner: address,
        total_amount: u64,
        unlock_time: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct UnlockEvent has copy, drop {
        owner: address,
        amount: u64,
        time: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun create_lock<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = Lock<T0>{
            id           : 0x2::object::new(arg3),
            owner        : arg0,
            total_amount : v0,
            unlocked     : false,
            unlock_time  : arg2,
            lock_balance : 0x2::coin::into_balance<T0>(arg1),
        };
        let v2 = LockCreatedEvent{
            owner        : arg0,
            total_amount : v0,
            unlock_time  : arg2,
            coin_type    : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<LockCreatedEvent>(v2);
        0x2::transfer::share_object<Lock<T0>>(v1);
    }

    public fun get_lock_info<T0>(arg0: &Lock<T0>) : (address, u64, bool, u64) {
        (arg0.owner, arg0.total_amount, arg0.unlocked, arg0.unlock_time)
    }

    public fun unlock<T0>(arg0: &mut Lock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 >= arg0.unlock_time, 1);
        assert!(!arg0.unlocked, 2);
        arg0.unlocked = true;
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.lock_balance);
        let v2 = UnlockEvent{
            owner     : arg0.owner,
            amount    : 0x2::balance::value<T0>(&v1),
            time      : v0,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<UnlockEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

