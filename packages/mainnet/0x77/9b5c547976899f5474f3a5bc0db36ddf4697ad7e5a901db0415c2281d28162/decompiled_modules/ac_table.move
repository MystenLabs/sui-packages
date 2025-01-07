module 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table {
    struct AcTable<phantom T0: drop, T1: copy + drop + store, phantom T2: store> has store, key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<T1, T2>,
        keys: 0x1::option::Option<0x2::vec_set::VecSet<T1>>,
        with_keys: bool,
    }

    struct AcTableOwnership has drop {
        dummy_field: bool,
    }

    struct AcTableCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        ownership: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::Ownership<AcTableOwnership>,
    }

    public fun length<T0: drop, T1: copy + drop + store, T2: store>(arg0: &AcTable<T0, T1, T2>) : u64 {
        0x2::table::length<T1, T2>(&arg0.table)
    }

    public fun borrow<T0: drop, T1: copy + drop + store, T2: store>(arg0: &AcTable<T0, T1, T2>, arg1: T1) : &T2 {
        0x2::table::borrow<T1, T2>(&arg0.table, arg1)
    }

    public fun borrow_mut<T0: drop, T1: copy + drop + store, T2: store>(arg0: &mut AcTable<T0, T1, T2>, arg1: &AcTableCap<T0>, arg2: T1) : &mut T2 {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::assert_owner<AcTableOwnership, AcTable<T0, T1, T2>>(&arg1.ownership, arg0);
        0x2::table::borrow_mut<T1, T2>(&mut arg0.table, arg2)
    }

    public fun destroy_empty<T0: drop, T1: copy + drop + store, T2: store>(arg0: AcTable<T0, T1, T2>, arg1: &AcTableCap<T0>) {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::assert_owner<AcTableOwnership, AcTable<T0, T1, T2>>(&arg1.ownership, &arg0);
        let AcTable {
            id        : v0,
            table     : v1,
            keys      : _,
            with_keys : _,
        } = arg0;
        0x2::table::destroy_empty<T1, T2>(v1);
        0x2::object::delete(v0);
    }

    public fun new<T0: drop, T1: copy + drop + store, T2: store>(arg0: T0, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : (AcTable<T0, T1, T2>, AcTableCap<T0>) {
        let v0 = if (arg1) {
            0x1::option::some<0x2::vec_set::VecSet<T1>>(0x2::vec_set::empty<T1>())
        } else {
            0x1::option::none<0x2::vec_set::VecSet<T1>>()
        };
        let v1 = AcTable<T0, T1, T2>{
            id        : 0x2::object::new(arg2),
            table     : 0x2::table::new<T1, T2>(arg2),
            keys      : v0,
            with_keys : arg1,
        };
        let v2 = AcTableOwnership{dummy_field: false};
        let v3 = AcTableCap<T0>{
            id        : 0x2::object::new(arg2),
            ownership : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::create_ownership<AcTableOwnership>(v2, 0x2::object::id<AcTable<T0, T1, T2>>(&v1), arg2),
        };
        (v1, v3)
    }

    public fun add<T0: drop, T1: copy + drop + store, T2: store>(arg0: &mut AcTable<T0, T1, T2>, arg1: &AcTableCap<T0>, arg2: T1, arg3: T2) {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::assert_owner<AcTableOwnership, AcTable<T0, T1, T2>>(&arg1.ownership, arg0);
        0x2::table::add<T1, T2>(&mut arg0.table, arg2, arg3);
        if (arg0.with_keys) {
            0x2::vec_set::insert<T1>(0x1::option::borrow_mut<0x2::vec_set::VecSet<T1>>(&mut arg0.keys), arg2);
        };
    }

    public fun contains<T0: drop, T1: copy + drop + store, T2: store>(arg0: &AcTable<T0, T1, T2>, arg1: T1) : bool {
        0x2::table::contains<T1, T2>(&arg0.table, arg1)
    }

    public fun drop<T0: drop, T1: copy + drop + store, T2: drop + store>(arg0: AcTable<T0, T1, T2>, arg1: &AcTableCap<T0>) {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::assert_owner<AcTableOwnership, AcTable<T0, T1, T2>>(&arg1.ownership, &arg0);
        let AcTable {
            id        : v0,
            table     : v1,
            keys      : _,
            with_keys : _,
        } = arg0;
        0x2::table::drop<T1, T2>(v1);
        0x2::object::delete(v0);
    }

    public fun is_empty<T0: drop, T1: copy + drop + store, T2: store>(arg0: &AcTable<T0, T1, T2>) : bool {
        0x2::table::is_empty<T1, T2>(&arg0.table)
    }

    public fun remove<T0: drop, T1: copy + drop + store, T2: store>(arg0: &mut AcTable<T0, T1, T2>, arg1: &AcTableCap<T0>, arg2: T1) : T2 {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::assert_owner<AcTableOwnership, AcTable<T0, T1, T2>>(&arg1.ownership, arg0);
        if (arg0.with_keys) {
            0x2::vec_set::remove<T1>(0x1::option::borrow_mut<0x2::vec_set::VecSet<T1>>(&mut arg0.keys), &arg2);
        };
        0x2::table::remove<T1, T2>(&mut arg0.table, arg2)
    }

    public fun keys<T0: drop, T1: copy + drop + store, T2: store>(arg0: &AcTable<T0, T1, T2>) : vector<T1> {
        if (arg0.with_keys) {
            0x2::vec_set::into_keys<T1>(*0x1::option::borrow<0x2::vec_set::VecSet<T1>>(&arg0.keys))
        } else {
            0x1::vector::empty<T1>()
        }
    }

    // decompiled from Move bytecode v6
}

