module 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry {
    struct Entry<T0: copy + drop + store> has copy, drop, store {
        position: 0x2::object::ID,
        value: T0,
    }

    struct Snapshot<T0: copy + drop + store> has store {
        timestamp_ms: u64,
        count: u64,
        cursor: u64,
        saved: 0x2::table::Table<u64, Entry<T0>>,
    }

    struct Registry<T0: copy + drop + store> has store {
        slots: 0x2::table::Table<u64, Entry<T0>>,
        indexes: 0x2::table::Table<0x2::object::ID, u64>,
        count: u64,
        snapshot: 0x1::option::Option<Snapshot<T0>>,
    }

    public fun length<T0: copy + drop + store>(arg0: &Registry<T0>) : u64 {
        arg0.count
    }

    public(friend) fun destroy_empty<T0: copy + drop + store>(arg0: Registry<T0>) {
        let Registry {
            slots    : v0,
            indexes  : v1,
            count    : v2,
            snapshot : v3,
        } = arg0;
        assert!(v2 == 0, 1);
        0x2::table::destroy_empty<u64, Entry<T0>>(v0);
        0x2::table::destroy_empty<0x2::object::ID, u64>(v1);
        0x1::option::destroy_none<Snapshot<T0>>(v3);
    }

    public fun contains<T0: copy + drop + store>(arg0: &Registry<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, u64>(&arg0.indexes, arg1)
    }

    public(friend) fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : Registry<T0> {
        Registry<T0>{
            slots    : 0x2::table::new<u64, Entry<T0>>(arg0),
            indexes  : 0x2::table::new<0x2::object::ID, u64>(arg0),
            count    : 0,
            snapshot : 0x1::option::none<Snapshot<T0>>(),
        }
    }

    public(friend) fun remove<T0: copy + drop + store>(arg0: &mut Registry<T0>, arg1: 0x2::object::ID) : T0 {
        let v0 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.indexes, arg1);
        let v1 = arg0.count - 1;
        preserve<T0>(arg0, v0);
        if (v0 != v1) {
            preserve<T0>(arg0, v1);
        };
        let Entry {
            position : v2,
            value    : v3,
        } = 0x2::table::remove<u64, Entry<T0>>(&mut arg0.slots, v0);
        assert!(v2 == arg1, 1);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.indexes, arg1);
        if (v0 != v1) {
            let v4 = 0x2::table::remove<u64, Entry<T0>>(&mut arg0.slots, v1);
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.indexes, v4.position) = v0;
            0x2::table::add<u64, Entry<T0>>(&mut arg0.slots, v0, v4);
        };
        arg0.count = v1;
        v3
    }

    public fun at<T0: copy + drop + store>(arg0: &Registry<T0>, arg1: u64) : Entry<T0> {
        *0x2::table::borrow<u64, Entry<T0>>(&arg0.slots, arg1)
    }

    public(friend) fun begin<T0: copy + drop + store>(arg0: &mut Registry<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<Snapshot<T0>>(&arg0.snapshot), 1);
        let v0 = Snapshot<T0>{
            timestamp_ms : arg1,
            count        : arg0.count,
            cursor       : 0,
            saved        : 0x2::table::new<u64, Entry<T0>>(arg2),
        };
        0x1::option::fill<Snapshot<T0>>(&mut arg0.snapshot, v0);
    }

    public(friend) fun cleanup_snapshot<T0: copy + drop + store>(arg0: &mut Snapshot<T0>, arg1: u64) : bool {
        assert!(arg1 > 0 && arg1 <= 64, 2);
        let v0 = 0;
        while (v0 < arg1 && arg0.cursor < arg0.count) {
            if (0x2::table::contains<u64, Entry<T0>>(&arg0.saved, arg0.cursor)) {
                0x2::table::remove<u64, Entry<T0>>(&mut arg0.saved, arg0.cursor);
            };
            arg0.cursor = arg0.cursor + 1;
            v0 = v0 + 1;
        };
        arg0.cursor == arg0.count
    }

    public(friend) fun destroy_snapshot<T0: copy + drop + store>(arg0: Snapshot<T0>) {
        let Snapshot {
            timestamp_ms : _,
            count        : v1,
            cursor       : v2,
            saved        : v3,
        } = arg0;
        assert!(v2 == v1, 1);
        0x2::table::destroy_empty<u64, Entry<T0>>(v3);
    }

    public(friend) fun detach<T0: copy + drop + store>(arg0: &mut Registry<T0>) : 0x1::option::Option<Snapshot<T0>> {
        let v0 = 0x1::option::none<Snapshot<T0>>();
        if (0x1::option::is_some<Snapshot<T0>>(&arg0.snapshot)) {
            0x1::option::fill<Snapshot<T0>>(&mut v0, 0x1::option::extract<Snapshot<T0>>(&mut arg0.snapshot));
        };
        v0
    }

    public(friend) fun finish<T0: copy + drop + store>(arg0: &mut Registry<T0>) {
        let Snapshot {
            timestamp_ms : _,
            count        : v1,
            cursor       : v2,
            saved        : v3,
        } = 0x1::option::extract<Snapshot<T0>>(&mut arg0.snapshot);
        assert!(v2 == v1, 1);
        0x2::table::destroy_empty<u64, Entry<T0>>(v3);
    }

    public fun get<T0: copy + drop + store>(arg0: &Registry<T0>, arg1: 0x2::object::ID) : &T0 {
        &0x2::table::borrow<u64, Entry<T0>>(&arg0.slots, *0x2::table::borrow<0x2::object::ID, u64>(&arg0.indexes, arg1)).value
    }

    public(friend) fun insert<T0: copy + drop + store>(arg0: &mut Registry<T0>, arg1: 0x2::object::ID, arg2: T0) {
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&arg0.indexes, arg1), 1);
        if (0x1::option::is_some<Snapshot<T0>>(&arg0.snapshot)) {
            let v0 = 0x1::option::borrow<Snapshot<T0>>(&arg0.snapshot);
            let v1 = if (arg0.count < v0.cursor) {
                true
            } else if (arg0.count >= v0.count) {
                true
            } else {
                0x2::table::contains<u64, Entry<T0>>(&v0.saved, arg0.count)
            };
            assert!(v1, 1);
        };
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.indexes, arg1, arg0.count);
        let v2 = Entry<T0>{
            position : arg1,
            value    : arg2,
        };
        0x2::table::add<u64, Entry<T0>>(&mut arg0.slots, arg0.count, v2);
        arg0.count = arg0.count + 1;
    }

    public(friend) fun peek_original<T0: copy + drop + store>(arg0: &Registry<T0>, arg1: u64) : 0x1::option::Option<Entry<T0>> {
        if (0x1::option::is_none<Snapshot<T0>>(&arg0.snapshot)) {
            return 0x1::option::none<Entry<T0>>()
        };
        let v0 = 0x1::option::borrow<Snapshot<T0>>(&arg0.snapshot);
        if (arg1 < v0.cursor || arg1 >= v0.count) {
            return 0x1::option::none<Entry<T0>>()
        };
        let v1 = if (0x2::table::contains<u64, Entry<T0>>(&v0.saved, arg1)) {
            *0x2::table::borrow<u64, Entry<T0>>(&v0.saved, arg1)
        } else {
            *0x2::table::borrow<u64, Entry<T0>>(&arg0.slots, arg1)
        };
        0x1::option::some<Entry<T0>>(v1)
    }

    fun preserve<T0: copy + drop + store>(arg0: &mut Registry<T0>, arg1: u64) {
        if (0x1::option::is_none<Snapshot<T0>>(&arg0.snapshot)) {
            return
        };
        let v0 = 0x1::option::borrow_mut<Snapshot<T0>>(&mut arg0.snapshot);
        let v1 = if (arg1 >= v0.cursor) {
            if (arg1 < v0.count) {
                !0x2::table::contains<u64, Entry<T0>>(&v0.saved, arg1)
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            0x2::table::add<u64, Entry<T0>>(&mut v0.saved, arg1, *0x2::table::borrow<u64, Entry<T0>>(&arg0.slots, arg1));
        };
    }

    public fun progress<T0: copy + drop + store>(arg0: &Registry<T0>) : (u64, u64, u64) {
        let v0 = 0x1::option::borrow<Snapshot<T0>>(&arg0.snapshot);
        (v0.timestamp_ms, v0.count, v0.cursor)
    }

    public(friend) fun replace<T0: copy + drop + store>(arg0: &mut Registry<T0>, arg1: 0x2::object::ID, arg2: T0) {
        let v0 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.indexes, arg1);
        preserve<T0>(arg0, v0);
        0x2::table::borrow_mut<u64, Entry<T0>>(&mut arg0.slots, v0).value = arg2;
    }

    public fun slot<T0: copy + drop + store>(arg0: &Registry<T0>, arg1: 0x2::object::ID) : u64 {
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.indexes, arg1)
    }

    public(friend) fun take<T0: copy + drop + store>(arg0: &mut Registry<T0>, arg1: u64) : vector<Entry<T0>> {
        assert!(arg1 > 0 && arg1 <= 64, 2);
        let v0 = 0x1::option::borrow_mut<Snapshot<T0>>(&mut arg0.snapshot);
        let v1 = 0x1::vector::empty<Entry<T0>>();
        while (0x1::vector::length<Entry<T0>>(&v1) < arg1 && v0.cursor < v0.count) {
            let v2 = if (0x2::table::contains<u64, Entry<T0>>(&v0.saved, v0.cursor)) {
                0x2::table::remove<u64, Entry<T0>>(&mut v0.saved, v0.cursor)
            } else {
                *0x2::table::borrow<u64, Entry<T0>>(&arg0.slots, v0.cursor)
            };
            0x1::vector::push_back<Entry<T0>>(&mut v1, v2);
            v0.cursor = v0.cursor + 1;
        };
        v1
    }

    public fun unpack<T0: copy + drop + store>(arg0: Entry<T0>) : (0x2::object::ID, T0) {
        let Entry {
            position : v0,
            value    : v1,
        } = arg0;
        (v0, v1)
    }

    // decompiled from Move bytecode v7
}

