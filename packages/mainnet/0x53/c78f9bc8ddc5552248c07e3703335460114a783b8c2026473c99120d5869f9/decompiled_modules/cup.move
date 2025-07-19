module 0x53c78f9bc8ddc5552248c07e3703335460114a783b8c2026473c99120d5869f9::cup {
    struct Cup<T0> {
        value: T0,
    }

    public fun borrow<T0>(arg0: &Cup<T0>) : &T0 {
        &arg0.value
    }

    public fun borrow_mut<T0>(arg0: &mut Cup<T0>) : &mut T0 {
        &mut arg0.value
    }

    public fun value<T0>(arg0: Cup<T0>) : T0 {
        let Cup { value: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

