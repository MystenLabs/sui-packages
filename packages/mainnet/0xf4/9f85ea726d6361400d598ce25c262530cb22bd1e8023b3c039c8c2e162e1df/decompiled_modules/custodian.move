module 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::custodian {
    struct Custodian<phantom T0> has store {
        reserve: 0x2::balance::Balance<T0>,
    }

    public fun withdraw_all<T0>(arg0: &mut Custodian<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.reserve), arg1)
    }

    public fun deposit<T0>(arg0: &mut Custodian<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun new<T0>() : Custodian<T0> {
        Custodian<T0>{reserve: 0x2::balance::zero<T0>()}
    }

    public fun reserve<T0>(arg0: &Custodian<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve)
    }

    public fun safe_withdraw<T0>(arg0: &mut Custodian<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = reserve<T0>(arg0);
        if (arg1 > v0) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, v0), arg2)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, arg1), arg2)
        }
    }

    public fun withdraw<T0>(arg0: &mut Custodian<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.reserve) >= arg1, 0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

