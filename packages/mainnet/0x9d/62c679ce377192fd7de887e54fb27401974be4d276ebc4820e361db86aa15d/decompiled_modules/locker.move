module 0x9d62c679ce377192fd7de887e54fb27401974be4d276ebc4820e361db86aa15d::locker {
    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        created_ms: u64,
        unlock_ms: u64,
        days: u64,
        is_dev: bool,
        funds: 0x2::balance::Balance<T0>,
    }

    struct Locked has copy, drop {
        lock_id: address,
        owner: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        created_ms: u64,
        unlock_ms: u64,
        days: u64,
        is_dev: bool,
    }

    struct Unlocked has copy, drop {
        lock_id: address,
        owner: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    public entry fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 7) {
            true
        } else if (arg1 == 30) {
            true
        } else {
            arg1 == 60
        };
        assert!(v0, 1);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0, 2);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = v2 + arg1 * 86400000;
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = Lock<T0>{
            id         : 0x2::object::new(arg4),
            owner      : v4,
            amount     : v1,
            created_ms : v2,
            unlock_ms  : v3,
            days       : arg1,
            is_dev     : arg2,
            funds      : 0x2::coin::into_balance<T0>(arg0),
        };
        let v6 = Locked{
            lock_id    : 0x2::object::uid_to_address(&v5.id),
            owner      : v4,
            coin_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount     : v1,
            created_ms : v2,
            unlock_ms  : v3,
            days       : arg1,
            is_dev     : arg2,
        };
        0x2::event::emit<Locked>(v6);
        0x2::transfer::share_object<Lock<T0>>(v5);
    }

    public entry fun unlock<T0>(arg0: Lock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms, 4);
        let Lock {
            id         : v0,
            owner      : v1,
            amount     : v2,
            created_ms : _,
            unlock_ms  : _,
            days       : _,
            is_dev     : _,
            funds      : v7,
        } = arg0;
        let v8 = v0;
        let v9 = Unlocked{
            lock_id   : 0x2::object::uid_to_address(&v8),
            owner     : v1,
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount    : v2,
        };
        0x2::event::emit<Unlocked>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg2), v1);
        0x2::object::delete(v8);
    }

    // decompiled from Move bytecode v7
}

