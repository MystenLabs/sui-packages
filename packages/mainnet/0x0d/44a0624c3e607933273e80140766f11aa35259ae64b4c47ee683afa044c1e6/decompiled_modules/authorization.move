module 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization {
    struct ProvenValue<T0> {
        value: T0,
        by: 0x2::object::ID,
        recipient: 0x1::option::Option<0x2::object::ID>,
    }

    struct CloneableProvenValue<T0: copy + store> has copy, drop, store {
        value: T0,
        by: 0x2::object::ID,
        recipient: 0x1::option::Option<0x2::object::ID>,
    }

    struct Grant<T0: copy + store> has copy, drop, store {
        proof: CloneableProvenValue<T0>,
    }

    public fun by<T0>(arg0: &ProvenValue<T0>) : 0x2::object::ID {
        arg0.by
    }

    public fun cloneable_by<T0: copy + store>(arg0: &CloneableProvenValue<T0>) : 0x2::object::ID {
        arg0.by
    }

    public fun cloneable_into_proven_value<T0: copy + store>(arg0: CloneableProvenValue<T0>) : ProvenValue<T0> {
        let CloneableProvenValue {
            value     : v0,
            by        : v1,
            recipient : v2,
        } = arg0;
        ProvenValue<T0>{
            value     : v0,
            by        : v1,
            recipient : v2,
        }
    }

    public fun cloneable_recipient<T0: copy + store>(arg0: &CloneableProvenValue<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.recipient
    }

    public fun cloneable_value<T0: copy + store>(arg0: &CloneableProvenValue<T0>) : T0 {
        arg0.value
    }

    public fun drop<T0: drop>(arg0: ProvenValue<T0>) {
        let ProvenValue {
            value     : _,
            by        : _,
            recipient : _,
        } = arg0;
    }

    public fun grant<T0: copy + store>(arg0: &0x2::object::UID, arg1: T0) : Grant<T0> {
        Grant<T0>{proof: wrap_cloneable<T0>(arg0, arg1)}
    }

    public fun grant_by<T0: copy + store>(arg0: &Grant<T0>) : 0x2::object::ID {
        cloneable_by<T0>(&arg0.proof)
    }

    public fun grant_for_recipient<T0: copy + store>(arg0: &0x2::object::UID, arg1: T0, arg2: 0x2::object::ID) : Grant<T0> {
        Grant<T0>{proof: wrap_cloneable_for_recipient<T0>(arg0, arg1, arg2)}
    }

    public fun grant_into_proven_value<T0: copy + store>(arg0: Grant<T0>) : ProvenValue<T0> {
        let Grant { proof: v0 } = arg0;
        cloneable_into_proven_value<T0>(v0)
    }

    public fun grant_recipient<T0: copy + store>(arg0: &Grant<T0>) : 0x1::option::Option<0x2::object::ID> {
        cloneable_recipient<T0>(&arg0.proof)
    }

    public fun grant_value<T0: copy + store>(arg0: &Grant<T0>) : T0 {
        cloneable_value<T0>(&arg0.proof)
    }

    public fun recipient<T0>(arg0: &ProvenValue<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.recipient
    }

    public fun unwrap<T0>(arg0: ProvenValue<T0>) : T0 {
        let ProvenValue {
            value     : v0,
            by        : _,
            recipient : v2,
        } = arg0;
        let v3 = v2;
        assert!(0x1::option::is_none<0x2::object::ID>(&v3), 13906834505055862785);
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
            assert!(0x1::option::destroy_some<0x2::object::ID>(v3) == 0x2::object::uid_to_inner(arg1), 13906834548005535745);
        };
        v0
    }

    public fun unwrap_cloneable<T0: copy + store>(arg0: CloneableProvenValue<T0>) : T0 {
        let CloneableProvenValue {
            value     : v0,
            by        : _,
            recipient : v2,
        } = arg0;
        let v3 = v2;
        assert!(0x1::option::is_none<0x2::object::ID>(&v3), 13906834590955208705);
        v0
    }

    public fun wrap<T0>(arg0: &0x2::object::UID, arg1: T0) : ProvenValue<T0> {
        ProvenValue<T0>{
            value     : arg1,
            by        : 0x2::object::uid_to_inner(arg0),
            recipient : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun wrap_cloneable<T0: copy + store>(arg0: &0x2::object::UID, arg1: T0) : CloneableProvenValue<T0> {
        CloneableProvenValue<T0>{
            value     : arg1,
            by        : 0x2::object::uid_to_inner(arg0),
            recipient : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun wrap_cloneable_for_recipient<T0: copy + store>(arg0: &0x2::object::UID, arg1: T0, arg2: 0x2::object::ID) : CloneableProvenValue<T0> {
        CloneableProvenValue<T0>{
            value     : arg1,
            by        : 0x2::object::uid_to_inner(arg0),
            recipient : 0x1::option::some<0x2::object::ID>(arg2),
        }
    }

    public fun wrap_for_recipient<T0>(arg0: &0x2::object::UID, arg1: T0, arg2: 0x2::object::ID) : ProvenValue<T0> {
        ProvenValue<T0>{
            value     : arg1,
            by        : 0x2::object::uid_to_inner(arg0),
            recipient : 0x1::option::some<0x2::object::ID>(arg2),
        }
    }

    // decompiled from Move bytecode v7
}

