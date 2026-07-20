module 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::swappable {
    struct Swappable<T0> has store {
        value: 0x1::option::Option<T0>,
    }

    public fun borrow<T0>(arg0: &Swappable<T0>) : &T0 {
        0x1::option::borrow<T0>(&arg0.value)
    }

    public fun swap<T0>(arg0: &mut Swappable<T0>, arg1: T0) : T0 {
        0x1::option::swap<T0>(&mut arg0.value, arg1)
    }

    public fun new<T0>(arg0: T0) : Swappable<T0> {
        Swappable<T0>{value: 0x1::option::some<T0>(arg0)}
    }

    // decompiled from Move bytecode v7
}

