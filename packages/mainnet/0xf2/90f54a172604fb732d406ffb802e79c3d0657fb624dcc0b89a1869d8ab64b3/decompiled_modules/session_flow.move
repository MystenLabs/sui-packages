module 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow {
    struct SessionFlow<phantom T0, phantom T1> {
        kind: u64,
        value: u64,
        done: bool,
        from_lending_pool: bool,
        to_lending_pool: bool,
        can_consoom: bool,
    }

    public(friend) fun allow_consoom<T0, T1>(arg0: &mut SessionFlow<T0, T1>) {
        arg0.can_consoom = true;
    }

    public fun assert_deposit<T0, T1>(arg0: &SessionFlow<T0, T1>) {
        assert!(arg0.kind == 1, 9223372178588827651);
    }

    public fun assert_move<T0, T1>(arg0: &SessionFlow<T0, T1>) {
        assert!(arg0.kind == 2, 9223372195768827909);
    }

    public fun assert_withdrawal<T0, T1>(arg0: &SessionFlow<T0, T1>) {
        assert!(arg0.kind == 0, 9223372161408827393);
    }

    public fun can_consoom<T0, T1>(arg0: &SessionFlow<T0, T1>) : bool {
        arg0.can_consoom
    }

    public fun consoom_session<T0, T1>(arg0: SessionFlow<T0, T1>) {
        assert!(arg0.can_consoom, 9223372569431113735);
        let SessionFlow {
            kind              : _,
            value             : _,
            done              : _,
            from_lending_pool : _,
            to_lending_pool   : _,
            can_consoom       : _,
        } = arg0;
    }

    public(friend) fun create_session<T0, T1>(arg0: u64, arg1: u64) : SessionFlow<T0, T1> {
        SessionFlow<T0, T1>{
            kind              : arg0,
            value             : arg1,
            done              : false,
            from_lending_pool : false,
            to_lending_pool   : false,
            can_consoom       : false,
        }
    }

    public fun deposit_kind() : u64 {
        1
    }

    public fun done<T0, T1>(arg0: &SessionFlow<T0, T1>) : bool {
        arg0.done
    }

    public fun from_lending_pool<T0, T1>(arg0: &SessionFlow<T0, T1>) : bool {
        arg0.from_lending_pool
    }

    public fun kind<T0, T1>(arg0: &SessionFlow<T0, T1>) : u64 {
        arg0.kind
    }

    public fun move_kind() : u64 {
        2
    }

    public(friend) fun register_as_done<T0, T1>(arg0: &mut SessionFlow<T0, T1>) {
        arg0.done = true;
    }

    public(friend) fun register_from_lending_pool<T0, T1>(arg0: &mut SessionFlow<T0, T1>) {
        arg0.from_lending_pool = true;
    }

    public(friend) fun register_to_lending_pool<T0, T1>(arg0: &mut SessionFlow<T0, T1>) {
        arg0.to_lending_pool = true;
    }

    public fun to_lending_pool<T0, T1>(arg0: &SessionFlow<T0, T1>) : bool {
        arg0.to_lending_pool
    }

    public(friend) fun update_value<T0, T1>(arg0: &mut SessionFlow<T0, T1>, arg1: u64) {
        arg0.value = arg1;
    }

    public fun value<T0, T1>(arg0: &SessionFlow<T0, T1>) : u64 {
        arg0.value
    }

    public fun withdrawal_kind() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

