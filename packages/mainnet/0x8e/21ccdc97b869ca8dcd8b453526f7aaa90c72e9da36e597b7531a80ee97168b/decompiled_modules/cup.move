module 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::cup {
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

