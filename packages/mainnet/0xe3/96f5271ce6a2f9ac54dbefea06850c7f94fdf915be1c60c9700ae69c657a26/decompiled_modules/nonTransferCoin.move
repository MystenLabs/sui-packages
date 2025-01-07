module 0xe396f5271ce6a2f9ac54dbefea06850c7f94fdf915be1c60c9700ae69c657a26::nonTransferCoin {
    struct NonTransferCoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
    }

    public fun borrow<T0>(arg0: &NonTransferCoin<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun borrow_mut<T0>(arg0: &mut NonTransferCoin<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public fun destroy_zero<T0>(arg0: NonTransferCoin<T0>) {
        let NonTransferCoin {
            id      : v0,
            balance : v1,
            owner   : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::object::delete(v0);
    }

    public fun join<T0>(arg0: &mut NonTransferCoin<T0>, arg1: NonTransferCoin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, into_balance<T0>(arg1));
    }

    public fun split<T0>(arg0: &mut NonTransferCoin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : NonTransferCoin<T0> {
        from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg1, arg3)
    }

    public fun value<T0>(arg0: &NonTransferCoin<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun zero<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : NonTransferCoin<T0> {
        NonTransferCoin<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
            owner   : arg0,
        }
    }

    public fun destroy_zero_or_transfer<T0>(arg0: NonTransferCoin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (value<T0>(&arg0) == 0) {
            destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<NonTransferCoin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : NonTransferCoin<T0> {
        NonTransferCoin<T0>{
            id      : 0x2::object::new(arg2),
            balance : arg0,
            owner   : arg1,
        }
    }

    public fun into_balance<T0>(arg0: NonTransferCoin<T0>) : 0x2::balance::Balance<T0> {
        let NonTransferCoin {
            id      : v0,
            balance : v1,
            owner   : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun join_vec<T0>(arg0: &mut NonTransferCoin<T0>, arg1: vector<NonTransferCoin<T0>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<NonTransferCoin<T0>>(&arg1)) {
            join<T0>(arg0, 0x1::vector::pop_back<NonTransferCoin<T0>>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<NonTransferCoin<T0>>(arg1);
    }

    public fun owner<T0>(arg0: &NonTransferCoin<T0>) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v6
}

