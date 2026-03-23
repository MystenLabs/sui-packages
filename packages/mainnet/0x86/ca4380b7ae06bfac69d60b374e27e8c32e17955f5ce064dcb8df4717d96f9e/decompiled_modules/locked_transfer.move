module 0x86ca4380b7ae06bfac69d60b374e27e8c32e17955f5ce064dcb8df4717d96f9e::locked_transfer {
    struct TimeLock has key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        unlock_time_ms: u64,
        recipient: address,
    }

    public entry fun lock_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeLock{
            id             : 0x2::object::new(arg3),
            coin           : arg0,
            unlock_time_ms : arg2,
            recipient      : arg1,
        };
        0x2::transfer::transfer<TimeLock>(v0, arg1);
    }

    public entry fun unlock(arg0: TimeLock, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let TimeLock {
            id             : v0,
            coin           : v1,
            unlock_time_ms : v2,
            recipient      : v3,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v2, 0);
        assert!(0x2::tx_context::sender(arg2) == v3, 1);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v3);
    }

    // decompiled from Move bytecode v6
}

