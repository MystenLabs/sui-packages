module 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::cell {
    struct Cell<T0> {
        inner: T0,
    }

    public fun empty<T0>() : 0x1::option::Option<Cell<T0>> {
        0x1::option::none<Cell<T0>>()
    }

    public fun discard<T0>(arg0: 0x1::option::Option<Cell<T0>>) {
        0x1::option::destroy_none<Cell<T0>>(arg0);
    }

    public fun filled<T0>(arg0: &0x1::option::Option<Cell<T0>>) : bool {
        0x1::option::is_some<Cell<T0>>(arg0)
    }

    public fun hold<T0>(arg0: T0) : 0x1::option::Option<Cell<T0>> {
        let v0 = Cell<T0>{inner: arg0};
        0x1::option::some<Cell<T0>>(v0)
    }

    public fun take<T0>(arg0: 0x1::option::Option<Cell<T0>>) : T0 {
        let Cell { inner: v0 } = 0x1::option::destroy_some<Cell<T0>>(arg0);
        v0
    }

    // decompiled from Move bytecode v7
}

