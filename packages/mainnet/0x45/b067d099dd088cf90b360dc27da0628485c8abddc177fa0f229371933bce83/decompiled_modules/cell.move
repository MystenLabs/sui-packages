module 0x45b067d099dd088cf90b360dc27da0628485c8abddc177fa0f229371933bce83::cell {
    struct Cell<T0> has store {
        element: 0x1::option::Option<T0>,
    }

    public fun destroy<T0>(arg0: Cell<T0>) : T0 {
        let Cell { element: v0 } = arg0;
        0x1::option::destroy_some<T0>(v0)
    }

    public fun get<T0>(arg0: &Cell<T0>) : &T0 {
        0x1::option::borrow<T0>(&arg0.element)
    }

    public fun new<T0>(arg0: T0) : Cell<T0> {
        Cell<T0>{element: 0x1::option::some<T0>(arg0)}
    }

    public fun set<T0>(arg0: &mut Cell<T0>, arg1: T0) : T0 {
        0x1::option::swap<T0>(&mut arg0.element, arg1)
    }

    // decompiled from Move bytecode v6
}

