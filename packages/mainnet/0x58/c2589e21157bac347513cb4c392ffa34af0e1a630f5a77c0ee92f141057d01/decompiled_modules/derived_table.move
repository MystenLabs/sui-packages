module 0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table {
    struct DerivedTable<phantom T0: copy + drop + store, phantom T1: store> has store, key {
        id: 0x2::object::UID,
        size: u64,
    }

    public fun length<T0: copy + drop + store, T1: store>(arg0: &DerivedTable<T0, T1>) : u64 {
        arg0.size
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &DerivedTable<T0, T1>, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut DerivedTable<T0, T1>, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public fun destroy_empty<T0: copy + drop + store, T1: store>(arg0: DerivedTable<T0, T1>) {
        let DerivedTable {
            id   : v0,
            size : v1,
        } = arg0;
        assert!(v1 == 0, 0);
        0x2::object::delete(v0);
    }

    public fun add<T0: copy + drop + store, T1: store>(arg0: &mut DerivedTable<T0, T1>, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
        arg0.size = arg0.size + 1;
    }

    public fun remove<T0: copy + drop + store, T1: store>(arg0: &mut DerivedTable<T0, T1>, arg1: T0) : T1 {
        arg0.size = arg0.size - 1;
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public fun contains<T0: copy + drop + store, T1: store>(arg0: &DerivedTable<T0, T1>, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    public fun drop<T0: copy + drop + store, T1: drop + store>(arg0: DerivedTable<T0, T1>) {
        let DerivedTable {
            id   : v0,
            size : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun is_empty<T0: copy + drop + store, T1: store>(arg0: &DerivedTable<T0, T1>) : bool {
        arg0.size == 0
    }

    public fun new<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &mut 0x2::object::UID, arg1: T0) : DerivedTable<T1, T2> {
        DerivedTable<T1, T2>{
            id   : 0x2::derived_object::claim<T0>(arg0, arg1),
            size : 0,
        }
    }

    // decompiled from Move bytecode v6
}

