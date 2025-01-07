module 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::cup {
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

