module 0x8903e53178a22aca0f3634511f729fdc979ad70920e712df25503e8999e101bd::print {
    struct Event<T0: copy + drop> has copy, drop {
        element: T0,
    }

    public fun print<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{element: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

