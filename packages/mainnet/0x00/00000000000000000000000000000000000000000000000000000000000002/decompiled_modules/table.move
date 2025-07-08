module 0x2::table {
    struct Table<phantom T0: copy + drop + store, phantom T1: store> has store, key {
        id: 0x2::object::UID,
        size: u64,
    }

    public fun length<T0: copy + drop + store, T1: store>(arg0: &Table<T0, T1>) : u64 {
        arg0.size
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &Table<T0, T1>, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut Table<T0, T1>, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public fun destroy_empty<T0: copy + drop + store, T1: store>(arg0: Table<T0, T1>) {
        let Table {
            id   : v0,
            size : v1,
        } = arg0;
        assert!(v1 == 0, 0);
        0x2::object::delete(v0);
    }

    public fun add<T0: copy + drop + store, T1: store>(arg0: &mut Table<T0, T1>, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
        arg0.size = arg0.size + 1;
    }

    public fun remove<T0: copy + drop + store, T1: store>(arg0: &mut Table<T0, T1>, arg1: T0) : T1 {
        arg0.size = arg0.size - 1;
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public fun new<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::tx_context::TxContext) : Table<T0, T1> {
        Table<T0, T1>{
            id   : 0x2::object::new(arg0),
            size : 0,
        }
    }

    public fun contains<T0: copy + drop + store, T1: store>(arg0: &Table<T0, T1>, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    public fun drop<T0: copy + drop + store, T1: drop + store>(arg0: Table<T0, T1>) {
        let Table {
            id   : v0,
            size : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun is_empty<T0: copy + drop + store, T1: store>(arg0: &Table<T0, T1>) : bool {
        arg0.size == 0
    }

    // decompiled from Move bytecode v6
}

