module 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::cup {
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

