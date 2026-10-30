module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::timelock {
    struct PendingChange<T0: drop + store> has drop, store {
        value: T0,
        ready_at_ms: u64,
        expires_at_ms: u64,
    }

    fun assert_value_type<T0: copy + drop + store, T1: drop + store>(arg0: &0x2::object::UID, arg1: T0) {
        assert!(!0x2::dynamic_field::exists<T0>(arg0, arg1) || 0x2::dynamic_field::exists_with_type<T0, PendingChange<T1>>(arg0, arg1), 13835903124457783303);
    }

    public(friend) fun cancel<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        let PendingChange {
            value         : v0,
            ready_at_ms   : _,
            expires_at_ms : _,
        } = remove<T0, T1>(arg0, arg1);
        v0
    }

    public(friend) fun execute<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: &0x2::clock::Clock) : T1 {
        let PendingChange {
            value         : v0,
            ready_at_ms   : v1,
            expires_at_ms : v2,
        } = remove<T0, T1>(arg0, arg1);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        assert!(v3 >= v1, 13835339886741291011);
        assert!(v3 < v2, 13836184315966783497);
        v0
    }

    public(friend) fun expires_at_ms<T0: copy + drop + store, T1: drop + store>(arg0: &0x2::object::UID, arg1: T0) : 0x1::option::Option<u64> {
        assert_value_type<T0, T1>(arg0, arg1);
        if (0x2::dynamic_field::exists<T0>(arg0, arg1)) {
            0x1::option::some<u64>(0x2::dynamic_field::borrow<T0, PendingChange<T1>>(arg0, arg1).expires_at_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun pending_value<T0: copy + drop + store, T1: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0) : 0x1::option::Option<T1> {
        assert_value_type<T0, T1>(arg0, arg1);
        if (0x2::dynamic_field::exists<T0>(arg0, arg1)) {
            0x1::option::some<T1>(0x2::dynamic_field::borrow<T0, PendingChange<T1>>(arg0, arg1).value)
        } else {
            0x1::option::none<T1>()
        }
    }

    public(friend) fun ready_at_ms<T0: copy + drop + store, T1: drop + store>(arg0: &0x2::object::UID, arg1: T0) : 0x1::option::Option<u64> {
        assert_value_type<T0, T1>(arg0, arg1);
        if (0x2::dynamic_field::exists<T0>(arg0, arg1)) {
            0x1::option::some<u64>(0x2::dynamic_field::borrow<T0, PendingChange<T1>>(arg0, arg1).ready_at_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    fun remove<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0) : PendingChange<T1> {
        assert_value_type<T0, T1>(arg0, arg1);
        let v0 = 0x2::dynamic_field::remove_opt<T0, PendingChange<T1>>(arg0, arg1);
        if (0x1::option::is_some<PendingChange<T1>>(&v0)) {
            return 0x1::option::destroy_some<PendingChange<T1>>(v0)
        } else {
            0x1::option::destroy_none<PendingChange<T1>>(v0);
            abort 13835058669462487041
        };
    }

    public(friend) fun schedule<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1, arg3: u64, arg4: &0x2::clock::Clock) : (u64, 0x1::option::Option<T1>) {
        let v0 = 0x1::u64::checked_add(0x2::clock::timestamp_ms(arg4), arg3);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::destroy_some<u64>(v0);
            let v2 = 0x1::u64::checked_add(v1, 1209600000);
            if (0x1::option::is_some<u64>(&v2)) {
                assert_value_type<T0, T1>(arg0, arg1);
                let v3 = PendingChange<T1>{
                    value         : arg2,
                    ready_at_ms   : v1,
                    expires_at_ms : 0x1::option::destroy_some<u64>(v2),
                };
                let v4 = 0x2::dynamic_field::replace<T0, PendingChange<T1>, PendingChange<T1>>(arg0, arg1, v3);
                let v5 = if (0x1::option::is_some<PendingChange<T1>>(&v4)) {
                    let PendingChange {
                        value         : v6,
                        ready_at_ms   : _,
                        expires_at_ms : _,
                    } = 0x1::option::destroy_some<PendingChange<T1>>(v4);
                    0x1::option::some<T1>(v6)
                } else {
                    0x1::option::destroy_none<PendingChange<T1>>(v4);
                    0x1::option::none<T1>()
                };
                return (v1, v5)
            } else {
                0x1::option::destroy_none<u64>(v2);
                abort 13835621284408721413
            };
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 13835621271523819525
        };
    }

    // decompiled from Move bytecode v7
}

