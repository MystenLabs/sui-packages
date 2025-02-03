module 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::table_keys {
    struct TableKeys<T0: copy + drop + store, phantom T1: store> has store, key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<T0, T1>,
        keys: 0x2::vec_set::VecSet<T0>,
    }

    public fun new<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::tx_context::TxContext) : TableKeys<T0, T1> {
        TableKeys<T0, T1>{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<T0, T1>(arg0),
            keys  : 0x2::vec_set::empty<T0>(),
        }
    }

    public fun add_key_value_pair<T0: copy + drop + store, T1: store>(arg0: &mut TableKeys<T0, T1>, arg1: T0, arg2: T1) {
        0x2::table::add<T0, T1>(&mut arg0.table, arg1, arg2);
        0x2::vec_set::insert<T0>(&mut arg0.keys, arg1);
    }

    public fun borrow_mut_table<T0: copy + drop + store, T1: store>(arg0: &mut TableKeys<T0, T1>, arg1: T0) : &mut T1 {
        0x2::table::borrow_mut<T0, T1>(&mut arg0.table, arg1)
    }

    public fun borrow_table<T0: copy + drop + store, T1: store>(arg0: &TableKeys<T0, T1>, arg1: T0) : &T1 {
        0x2::table::borrow<T0, T1>(&arg0.table, arg1)
    }

    public fun delete<T0: copy + drop + store, T1: store>(arg0: &mut TableKeys<T0, T1>, arg1: T0) : T1 {
        0x2::vec_set::remove<T0>(&mut arg0.keys, &arg1);
        0x2::table::remove<T0, T1>(&mut arg0.table, arg1)
    }

    public fun get_keys<T0: copy + drop + store, T1: store>(arg0: &TableKeys<T0, T1>) : vector<T0> {
        0x2::vec_set::into_keys<T0>(arg0.keys)
    }

    public fun is_present<T0: copy + drop + store, T1: store>(arg0: &TableKeys<T0, T1>, arg1: T0) : bool {
        0x2::table::contains<T0, T1>(&arg0.table, arg1)
    }

    // decompiled from Move bytecode v6
}

