module 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async {
    struct SessionAsync<phantom T0, phantom T1> {
        value: u64,
        done: bool,
        kind: u8,
        can_consume: bool,
    }

    public fun allow_consume<T0, T1>(arg0: &0x2::object::UID, arg1: &mut SessionAsync<T0, T1>) {
        0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::has_authorized(arg0);
        arg1.can_consume = true;
    }

    public fun can_consume<T0, T1>(arg0: &SessionAsync<T0, T1>) : bool {
        arg0.can_consume
    }

    public fun consume_session<T0, T1>(arg0: SessionAsync<T0, T1>) {
        assert!(arg0.can_consume, 9223372393337323525);
        let SessionAsync {
            value       : _,
            done        : _,
            kind        : _,
            can_consume : _,
        } = arg0;
    }

    public fun create_session<T0, T1>(arg0: &0x2::object::UID, arg1: u64, arg2: u8) : SessionAsync<T0, T1> {
        0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::has_authorized(arg0);
        SessionAsync<T0, T1>{
            value       : arg1,
            done        : false,
            kind        : arg2,
            can_consume : false,
        }
    }

    public fun deposit_kind() : u8 {
        1
    }

    public fun done<T0, T1>(arg0: &SessionAsync<T0, T1>) : bool {
        arg0.done
    }

    public fun kind<T0, T1>(arg0: &SessionAsync<T0, T1>) : u8 {
        arg0.kind
    }

    public fun mark_done<T0, T1>(arg0: &0x2::object::UID, arg1: &mut SessionAsync<T0, T1>) {
        0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::has_authorized(arg0);
        assert!(!arg1.done, 9223372328912683011);
        arg1.done = true;
    }

    public fun value<T0, T1>(arg0: &SessionAsync<T0, T1>) : u64 {
        arg0.value
    }

    public fun withdraw_kind() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

