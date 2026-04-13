module 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::event {
    struct EventWrapper<T0> has copy, drop {
        event: T0,
    }

    public fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = EventWrapper<T0>{event: arg0};
        0x2::event::emit<EventWrapper<T0>>(v0);
    }

    public fun inner<T0: copy + drop>(arg0: &EventWrapper<T0>) : &T0 {
        &arg0.event
    }

    // decompiled from Move bytecode v6
}

