module 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::wit_table {
    struct WitTable<phantom T0: drop, T1: copy + drop + store, phantom T2: store> has store, key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<T1, T2>,
        keys: 0x1::option::Option<0x2::vec_set::VecSet<T1>>,
        with_keys: bool,
    }

    public fun length<T0: drop, T1: copy + drop + store, T2: store>(arg0: &WitTable<T0, T1, T2>) : u64 {
        0x2::table::length<T1, T2>(&arg0.table)
    }

    public fun borrow<T0: drop, T1: copy + drop + store, T2: store>(arg0: &WitTable<T0, T1, T2>, arg1: T1) : &T2 {
        0x2::table::borrow<T1, T2>(&arg0.table, arg1)
    }

    public fun borrow_mut<T0: drop, T1: copy + drop + store, T2: store>(arg0: T0, arg1: &mut WitTable<T0, T1, T2>, arg2: T1) : &mut T2 {
        0x2::table::borrow_mut<T1, T2>(&mut arg1.table, arg2)
    }

    public fun destroy_empty<T0: drop, T1: copy + drop + store, T2: store>(arg0: T0, arg1: WitTable<T0, T1, T2>) {
        let WitTable {
            id        : v0,
            table     : v1,
            keys      : _,
            with_keys : _,
        } = arg1;
        0x2::table::destroy_empty<T1, T2>(v1);
        0x2::object::delete(v0);
    }

    public fun new<T0: drop, T1: copy + drop + store, T2: store>(arg0: T0, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : WitTable<T0, T1, T2> {
        let v0 = if (arg1) {
            0x1::option::some<0x2::vec_set::VecSet<T1>>(0x2::vec_set::empty<T1>())
        } else {
            0x1::option::none<0x2::vec_set::VecSet<T1>>()
        };
        WitTable<T0, T1, T2>{
            id        : 0x2::object::new(arg2),
            table     : 0x2::table::new<T1, T2>(arg2),
            keys      : v0,
            with_keys : arg1,
        }
    }

    public fun add<T0: drop, T1: copy + drop + store, T2: store>(arg0: T0, arg1: &mut WitTable<T0, T1, T2>, arg2: T1, arg3: T2) {
        0x2::table::add<T1, T2>(&mut arg1.table, arg2, arg3);
        if (arg1.with_keys) {
            0x2::vec_set::insert<T1>(0x1::option::borrow_mut<0x2::vec_set::VecSet<T1>>(&mut arg1.keys), arg2);
        };
    }

    public fun contains<T0: drop, T1: copy + drop + store, T2: store>(arg0: &WitTable<T0, T1, T2>, arg1: T1) : bool {
        0x2::table::contains<T1, T2>(&arg0.table, arg1)
    }

    public fun drop<T0: drop, T1: copy + drop + store, T2: drop + store>(arg0: T0, arg1: WitTable<T0, T1, T2>) {
        let WitTable {
            id        : v0,
            table     : v1,
            keys      : _,
            with_keys : _,
        } = arg1;
        0x2::table::drop<T1, T2>(v1);
        0x2::object::delete(v0);
    }

    public fun is_empty<T0: drop, T1: copy + drop + store, T2: store>(arg0: &WitTable<T0, T1, T2>) : bool {
        0x2::table::is_empty<T1, T2>(&arg0.table)
    }

    public fun remove<T0: drop, T1: copy + drop + store, T2: store>(arg0: T0, arg1: &mut WitTable<T0, T1, T2>, arg2: T1) : T2 {
        if (arg1.with_keys) {
            0x2::vec_set::remove<T1>(0x1::option::borrow_mut<0x2::vec_set::VecSet<T1>>(&mut arg1.keys), &arg2);
        };
        0x2::table::remove<T1, T2>(&mut arg1.table, arg2)
    }

    public fun ge<T0: drop, T1: copy + drop + store, T2: store>(arg0: &WitTable<T0, T1, T2>, arg1: T1) : &T2 {
        0x2::table::borrow<T1, T2>(&arg0.table, arg1)
    }

    public fun keys<T0: drop, T1: copy + drop + store, T2: store>(arg0: &WitTable<T0, T1, T2>) : vector<T1> {
        if (arg0.with_keys) {
            0x2::vec_set::into_keys<T1>(*0x1::option::borrow<0x2::vec_set::VecSet<T1>>(&arg0.keys))
        } else {
            0x1::vector::empty<T1>()
        }
    }

    // decompiled from Move bytecode v6
}

