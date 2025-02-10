module 0x2b166a37ce0e047d3f0db65c2be4ae1e76d24388a3db1a028389cb045c752644::locking_mech {
    struct Locker<phantom T0> has store, key {
        id: 0x2::object::UID,
        unlock_timestamps: vector<u64>,
        balance: 0x2::balance::Balance<T0>,
        recipient: address,
        claimed_intervals: u8,
    }

    public entry fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, v0 + 360000);
        0x1::vector::push_back<u64>(v2, v0 + 540000);
        0x1::vector::push_back<u64>(v2, v0 + 720000);
        0x1::vector::push_back<u64>(v2, v0 + 900000);
        let v3 = Locker<T0>{
            id                : 0x2::object::new(arg3),
            unlock_timestamps : v1,
            balance           : 0x2::coin::into_balance<T0>(arg0),
            recipient         : arg1,
            claimed_intervals : 0,
        };
        0x2::transfer::transfer<Locker<T0>>(v3, arg1);
    }

    public fun unlock<T0>(arg0: &mut Locker<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 != arg0.recipient) {
            abort 2
        };
        let v1 = 4;
        let v2 = arg0.claimed_intervals;
        if (v2 >= v1) {
            abort 1
        };
        if (0x2::clock::timestamp_ms(arg1) < *0x1::vector::borrow<u64>(&arg0.unlock_timestamps, (v2 as u64))) {
            abort 1
        };
        arg0.claimed_intervals = v2 + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance) / ((v1 - v2) as u64), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

