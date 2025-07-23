module 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance {
    struct SBalance<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        supply: u64,
    }

    public fun destroy_zero<T0>(arg0: SBalance<T0>) {
        assert!(value<T0>(&arg0) == 0, 102002);
        let SBalance {
            balance : v0,
            supply  : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v0);
    }

    public fun split<T0>(arg0: &mut SBalance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(value<T0>(arg0) >= arg1, 102001);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public fun value<T0>(arg0: &SBalance<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun from_balance<T0>(arg0: 0x2::balance::Balance<T0>) : SBalance<T0> {
        SBalance<T0>{
            balance : arg0,
            supply  : 0x2::balance::value<T0>(&arg0),
        }
    }

    public fun increase<T0>(arg0: &mut SBalance<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        arg0.supply = arg0.supply + 0x2::balance::value<T0>(&arg1);
    }

    public fun into_balance<T0>(arg0: SBalance<T0>) : 0x2::balance::Balance<T0> {
        let SBalance {
            balance : v0,
            supply  : _,
        } = arg0;
        v0
    }

    public fun split_all<T0>(arg0: &mut SBalance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = value<T0>(arg0);
        split<T0>(arg0, v0)
    }

    public fun supply<T0>(arg0: &SBalance<T0>) : u64 {
        arg0.supply
    }

    // decompiled from Move bytecode v6
}

