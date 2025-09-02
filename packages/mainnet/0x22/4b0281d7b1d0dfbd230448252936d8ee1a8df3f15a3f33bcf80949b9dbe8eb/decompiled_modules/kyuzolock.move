module 0x224b0281d7b1d0dfbd230448252936d8ee1a8df3f15a3f33bcf80949b9dbe8eb::kyuzolock {
    struct LockedCoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        unlock_time: u64,
        owner: address,
    }

    public fun lock_coin<T0>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : LockedCoin<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        assert!(0x2::balance::value<T0>(&v0) > 0, 102);
        LockedCoin<T0>{
            id          : 0x2::object::new(arg3),
            balance     : v0,
            unlock_time : 0x2::clock::timestamp_ms(arg0) + arg2 * 1000,
            owner       : 0x2::tx_context::sender(arg3),
        }
    }

    public entry fun lock_coin_entry<T0>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = lock_coin<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<LockedCoin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun time_until_unlock<T0>(arg0: &0x2::clock::Clock, arg1: &LockedCoin<T0>) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 >= arg1.unlock_time) {
            0
        } else {
            arg1.unlock_time - v0
        }
    }

    public fun unlock_coin<T0>(arg0: &0x2::clock::Clock, arg1: LockedCoin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let LockedCoin {
            id          : v0,
            balance     : v1,
            unlock_time : v2,
            owner       : v3,
        } = arg1;
        assert!(0x2::clock::timestamp_ms(arg0) >= v2, 100);
        assert!(v3 == 0x2::tx_context::sender(arg2), 101);
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    public entry fun unlock_coin_entry<T0>(arg0: &0x2::clock::Clock, arg1: LockedCoin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = unlock_coin<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

