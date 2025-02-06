module 0xf260c8a53a573e65f289147a9072836e02e171290e94af391877cee2c913bc3a::session_flow {
    struct SessionFlow<phantom T0, phantom T1> {
        kind: u64,
        value: u64,
        can_consoom: bool,
    }

    public fun allow_consoom<T0, T1>(arg0: &0x2::object::UID, arg1: &mut SessionFlow<T0, T1>) {
        0x66c4cf6e3c354c3f94db0d0b5a4de306767928e24f13023fd7f374a3a0dc0719::admin::has_authorized(arg0);
        arg1.can_consoom = true;
    }

    public fun can_consoom<T0, T1>(arg0: &SessionFlow<T0, T1>) : bool {
        arg0.can_consoom
    }

    public fun consoom_session<T0, T1>(arg0: SessionFlow<T0, T1>) {
        assert!(arg0.can_consoom, 9223372436286734337);
        let SessionFlow {
            kind        : _,
            value       : _,
            can_consoom : _,
        } = arg0;
    }

    public fun create_session<T0, T1>(arg0: &0x2::object::UID, arg1: u64, arg2: u64) : SessionFlow<T0, T1> {
        0x66c4cf6e3c354c3f94db0d0b5a4de306767928e24f13023fd7f374a3a0dc0719::admin::has_authorized(arg0);
        SessionFlow<T0, T1>{
            kind        : arg1,
            value       : arg2,
            can_consoom : false,
        }
    }

    public fun deposit_kind() : u64 {
        1
    }

    public fun is_deposit<T0, T1>(arg0: &SessionFlow<T0, T1>) : bool {
        if (arg0.kind == 1) {
            return true
        };
        false
    }

    public fun is_move<T0, T1>(arg0: &SessionFlow<T0, T1>) : bool {
        if (arg0.kind == 2) {
            return true
        };
        false
    }

    public fun is_withdrawal<T0, T1>(arg0: &SessionFlow<T0, T1>) : bool {
        if (arg0.kind == 0) {
            return true
        };
        false
    }

    public fun kind<T0, T1>(arg0: &SessionFlow<T0, T1>) : u64 {
        arg0.kind
    }

    public fun move_kind() : u64 {
        2
    }

    public fun value<T0, T1>(arg0: &SessionFlow<T0, T1>) : u64 {
        arg0.value
    }

    public fun withdrawal_kind() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

