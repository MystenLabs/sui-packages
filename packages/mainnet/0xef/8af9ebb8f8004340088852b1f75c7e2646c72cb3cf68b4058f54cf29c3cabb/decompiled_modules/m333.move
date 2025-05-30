module 0xef8af9ebb8f8004340088852b1f75c7e2646c72cb3cf68b4058f54cf29c3cabb::m333 {
    struct S has drop {
        v: vector<u64>,
    }

    struct Q<T0> has drop {
        ts: vector<T0>,
    }

    public fun borrow_q<T0>(arg0: &Q<T0>, arg1: u64) : &T0 {
        0x1::vector::borrow<T0>(&arg0.ts, arg1)
    }

    public fun borrow_q_mut<T0>(arg0: &mut Q<T0>, arg1: u64) : &mut T0 {
        0x1::vector::borrow_mut<T0>(&mut arg0.ts, arg1)
    }

    public fun borrow_s(arg0: &S, arg1: u64) : &u64 {
        0x1::vector::borrow<u64>(&arg0.v, arg1)
    }

    public fun borrow_s_mut(arg0: &mut S, arg1: u64) : &mut u64 {
        0x1::vector::borrow_mut<u64>(&mut arg0.v, arg1)
    }

    public fun make_q<T0>(arg0: vector<T0>) : Q<T0> {
        Q<T0>{ts: arg0}
    }

    public fun make_s(arg0: vector<u64>) : S {
        S{v: arg0}
    }

    // decompiled from Move bytecode v6
}

