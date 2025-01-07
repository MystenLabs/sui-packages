module 0x1bd92372a24a508e3915af187b3b74c00f70f5e16a4a986ed01acb4dc81d8677::locked_coin {
    struct LockedCoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        locked_balance: 0x2::balance::Balance<T0>,
    }

    public fun destroy_zero<T0>(arg0: LockedCoin<T0>) {
        let LockedCoin {
            id             : v0,
            locked_balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public entry fun join<T0>(arg0: &mut LockedCoin<T0>, arg1: LockedCoin<T0>) {
        let LockedCoin {
            id             : v0,
            locked_balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<T0>(&mut arg0.locked_balance, v1);
    }

    public fun split<T0>(arg0: &mut LockedCoin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : LockedCoin<T0> {
        LockedCoin<T0>{
            id             : 0x2::object::new(arg2),
            locked_balance : 0x2::balance::split<T0>(&mut arg0.locked_balance, arg1),
        }
    }

    public fun value<T0>(arg0: &LockedCoin<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked_balance)
    }

    public(friend) fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) : LockedCoin<T0> {
        LockedCoin<T0>{
            id             : 0x2::object::new(arg0),
            locked_balance : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : LockedCoin<T0> {
        LockedCoin<T0>{
            id             : 0x2::object::new(arg1),
            locked_balance : arg0,
        }
    }

    public(friend) fun into_balance<T0>(arg0: LockedCoin<T0>) : 0x2::balance::Balance<T0> {
        let LockedCoin {
            id             : v0,
            locked_balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

