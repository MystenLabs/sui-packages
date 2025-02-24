module 0x5a6b9932a66bc18fb05f9fd3bd746fedb2556d8c3ae4579117f82821bf27d28a::cup {
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

