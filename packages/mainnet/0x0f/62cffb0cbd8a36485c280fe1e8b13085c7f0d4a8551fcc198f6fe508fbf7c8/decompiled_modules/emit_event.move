module 0xf62cffb0cbd8a36485c280fe1e8b13085c7f0d4a8551fcc198f6fe508fbf7c8::emit_event {
    struct Wrapper<T0: copy + drop> has copy, drop {
        inner: T0,
    }

    public fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = Wrapper<T0>{inner: arg0};
        0x2::event::emit<Wrapper<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

