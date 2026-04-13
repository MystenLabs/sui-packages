module 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proven_value {
    struct ProvenValue<T0> {
        value: T0,
        by: 0x2::object::ID,
        recipient: 0x1::option::Option<0x2::object::ID>,
    }

    public fun by<T0>(arg0: &ProvenValue<T0>) : 0x2::object::ID {
        arg0.by
    }

    public fun drop<T0: drop>(arg0: ProvenValue<T0>) {
        let ProvenValue {
            value     : _,
            by        : _,
            recipient : _,
        } = arg0;
    }

    public fun recipient<T0>(arg0: &ProvenValue<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.recipient
    }

    public fun unwrap<T0>(arg0: ProvenValue<T0>) : T0 {
        let ProvenValue {
            value     : v0,
            by        : _,
            recipient : _,
        } = arg0;
        v0
    }

    public fun unwrap_as_recipient<T0>(arg0: ProvenValue<T0>, arg1: &0x2::object::UID) : T0 {
        let ProvenValue {
            value     : v0,
            by        : _,
            recipient : v2,
        } = arg0;
        let v3 = v2;
        if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            assert!(0x1::option::destroy_some<0x2::object::ID>(v3) == 0x2::object::uid_to_inner(arg1), 13906834328962203649);
        };
        v0
    }

    public fun wrap<T0>(arg0: &0x2::object::UID, arg1: T0) : ProvenValue<T0> {
        ProvenValue<T0>{
            value     : arg1,
            by        : 0x2::object::uid_to_inner(arg0),
            recipient : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun wrap_for_recipient<T0>(arg0: &0x2::object::UID, arg1: T0, arg2: 0x2::object::ID) : ProvenValue<T0> {
        ProvenValue<T0>{
            value     : arg1,
            by        : 0x2::object::uid_to_inner(arg0),
            recipient : 0x1::option::some<0x2::object::ID>(arg2),
        }
    }

    // decompiled from Move bytecode v6
}

