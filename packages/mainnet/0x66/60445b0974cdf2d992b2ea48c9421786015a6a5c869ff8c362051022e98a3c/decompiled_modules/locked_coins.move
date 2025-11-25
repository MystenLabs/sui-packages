module 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::locked_coins {
    struct LockedCoins<phantom T0> has store, key {
        id: 0x2::object::UID,
        coins: vector<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>>>,
        value: u64,
    }

    public(friend) fun value<T0>(arg0: &LockedCoins<T0>) : u64 {
        arg0.value
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : LockedCoins<T0> {
        LockedCoins<T0>{
            id    : 0x2::object::new(arg0),
            coins : 0x1::vector::empty<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>>>(),
            value : 0,
        }
    }

    public(friend) fun join<T0>(arg0: &mut LockedCoins<T0>, arg1: 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>>) {
        arg0.value = arg0.value + 0x2::coin::value<T0>(0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::borrow<0x2::coin::Coin<T0>>(&arg1));
        0x1::vector::push_back<0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>>>(&mut arg0.coins, arg1);
    }

    public(friend) fun unlock_unlockable<T0>(arg0: &mut LockedCoins<T0>, arg1: &0x2::clock::Clock) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::vector::unlock_unlockable<0x2::coin::Coin<T0>>(&mut arg0.coins, false, arg1);
        let v1 = &v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::coin::Coin<T0>>(v1)) {
            v2 = v2 + 0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(v1, v3));
            v3 = v3 + 1;
        };
        arg0.value = arg0.value - v2;
        v0
    }

    // decompiled from Move bytecode v6
}

