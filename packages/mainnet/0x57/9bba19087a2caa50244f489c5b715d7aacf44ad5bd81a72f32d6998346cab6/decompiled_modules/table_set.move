module 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::table_set {
    struct Empty has copy, drop, store {
        dummy_field: bool,
    }

    struct TableSet<phantom T0: copy + drop + store> has store {
        table: 0x2::table::Table<T0, Empty>,
    }

    public fun length<T0: copy + drop + store>(arg0: &TableSet<T0>) : u64 {
        0x2::table::length<T0, Empty>(&arg0.table)
    }

    public fun destroy_empty<T0: copy + drop + store>(arg0: TableSet<T0>) {
        let TableSet { table: v0 } = arg0;
        0x2::table::destroy_empty<T0, Empty>(v0);
    }

    public fun add<T0: copy + drop + store>(arg0: &mut TableSet<T0>, arg1: T0) {
        let v0 = Empty{dummy_field: false};
        0x2::table::add<T0, Empty>(&mut arg0.table, arg1, v0);
    }

    public fun contains<T0: copy + drop + store>(arg0: &TableSet<T0>, arg1: T0) : bool {
        0x2::table::contains<T0, Empty>(&arg0.table, arg1)
    }

    public fun drop<T0: copy + drop + store>(arg0: TableSet<T0>) {
        let TableSet { table: v0 } = arg0;
        0x2::table::drop<T0, Empty>(v0);
    }

    public fun is_empty<T0: copy + drop + store>(arg0: &TableSet<T0>) : bool {
        0x2::table::is_empty<T0, Empty>(&arg0.table)
    }

    public fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : TableSet<T0> {
        TableSet<T0>{table: 0x2::table::new<T0, Empty>(arg0)}
    }

    public fun remove<T0: copy + drop + store>(arg0: &mut TableSet<T0>, arg1: T0) {
        0x2::table::remove<T0, Empty>(&mut arg0.table, arg1);
    }

    // decompiled from Move bytecode v6
}

