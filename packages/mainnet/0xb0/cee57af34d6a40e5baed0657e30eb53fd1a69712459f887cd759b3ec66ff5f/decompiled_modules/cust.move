module 0x6cc420510bd3ff84778c25f5a27753eb3ce7cfcefabd1ba16d5853a81db1149d::cust {
    struct Cust<T0> {
        cust: T0,
    }

    public(friend) fun lock<T0>(arg0: T0) : Cust<T0> {
        Cust<T0>{cust: arg0}
    }

    public(friend) fun unlock<T0>(arg0: Cust<T0>) : T0 {
        let Cust { cust: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

