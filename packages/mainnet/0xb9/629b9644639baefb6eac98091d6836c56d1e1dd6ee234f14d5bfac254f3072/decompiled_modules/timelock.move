module 0xb9629b9644639baefb6eac98091d6836c56d1e1dd6ee234f14d5bfac254f3072::timelock {
    struct Locker<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
        unlock_time_ms: u64,
        owner: address,
    }

    public entry fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Locker<T0>{
            id             : 0x2::object::new(arg2),
            coin           : arg0,
            unlock_time_ms : arg1,
            owner          : v0,
        };
        0x2::transfer::public_transfer<Locker<T0>>(v1, v0);
    }

    public entry fun unlock<T0>(arg0: Locker<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time_ms, 0);
        let Locker {
            id             : v0,
            coin           : v1,
            unlock_time_ms : _,
            owner          : v3,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v3);
    }

    // decompiled from Move bytecode v7
}

