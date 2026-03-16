module 0xc30480cc9e4eddedbb62fde442d2ca6f16f41dd6526d4d192bbce4abeca053da::bublz_lock {
    struct TimeLock<phantom T0> has store, key {
        id: 0x2::object::UID,
        coins: 0x2::coin::Coin<T0>,
        unlock_time_ms: u64,
        owner: address,
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeLock<T0>{
            id             : 0x2::object::new(arg2),
            coins          : arg0,
            unlock_time_ms : arg1,
            owner          : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::public_transfer<TimeLock<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun owner<T0>(arg0: &TimeLock<T0>) : address {
        arg0.owner
    }

    public fun unlock<T0>(arg0: TimeLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let TimeLock {
            id             : v0,
            coins          : v1,
            unlock_time_ms : v2,
            owner          : _,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v2, 0);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun unlock_time_ms<T0>(arg0: &TimeLock<T0>) : u64 {
        arg0.unlock_time_ms
    }

    // decompiled from Move bytecode v6
}

