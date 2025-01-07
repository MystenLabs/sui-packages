module 0xac608850e8d93d379de3d87f98da6c07be907d163fbe33383a829aab47633dae::cell {
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

