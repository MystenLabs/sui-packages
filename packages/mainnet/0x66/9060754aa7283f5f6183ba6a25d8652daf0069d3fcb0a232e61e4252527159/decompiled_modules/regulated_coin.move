module 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin {
    struct RegulatedCoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        creator: address,
    }

    public fun borrow<T0: drop>(arg0: T0, arg1: &RegulatedCoin<T0>) : &0x2::balance::Balance<T0> {
        &arg1.balance
    }

    public fun borrow_mut<T0: drop>(arg0: T0, arg1: &mut RegulatedCoin<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg1.balance
    }

    public fun join<T0: drop>(arg0: T0, arg1: &mut RegulatedCoin<T0>, arg2: RegulatedCoin<T0>) {
        0x2::balance::join<T0>(&mut arg1.balance, into_balance<T0>(arg0, arg2));
    }

    public fun split<T0: drop>(arg0: T0, arg1: &mut RegulatedCoin<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : RegulatedCoin<T0> {
        from_balance<T0>(arg0, 0x2::balance::split<T0>(&mut arg1.balance, arg3), arg2, arg4)
    }

    public fun value<T0>(arg0: &RegulatedCoin<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun zero<T0: drop>(arg0: T0, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : RegulatedCoin<T0> {
        RegulatedCoin<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
            creator : arg1,
        }
    }

    public fun creator<T0>(arg0: &RegulatedCoin<T0>) : address {
        arg0.creator
    }

    public fun from_balance<T0: drop>(arg0: T0, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : RegulatedCoin<T0> {
        RegulatedCoin<T0>{
            id      : 0x2::object::new(arg3),
            balance : arg1,
            creator : arg2,
        }
    }

    public fun into_balance<T0: drop>(arg0: T0, arg1: RegulatedCoin<T0>) : 0x2::balance::Balance<T0> {
        let RegulatedCoin {
            id      : v0,
            balance : v1,
            creator : _,
        } = arg1;
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

