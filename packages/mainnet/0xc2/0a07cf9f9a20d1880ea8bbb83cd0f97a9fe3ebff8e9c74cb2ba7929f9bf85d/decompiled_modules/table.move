module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table {
    struct Table<phantom T0: copy + drop + store, phantom T1: store> has copy, drop, store {
        id: address,
        size: u64,
    }

    public fun length<T0: copy + drop + store, T1: store>(arg0: &Table<T0, T1>) : u64 {
        arg0.size
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &Table<T0, T1>, arg2: T0) : &T1 {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (700 as u64));
        0x2::dynamic_field::borrow<T0, T1>(arg0, arg2)
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut Table<T0, T1>, arg2: T0) : &mut T1 {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (700 as u64));
        0x2::dynamic_field::borrow_mut<T0, T1>(arg0, arg2)
    }

    public fun add<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut Table<T0, T1>, arg2: T0, arg3: T1) {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (700 as u64));
        0x2::dynamic_field::add<T0, T1>(arg0, arg2, arg3);
        arg1.size = arg1.size + 1;
    }

    public fun remove<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut Table<T0, T1>, arg2: T0) : T1 {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (700 as u64));
        arg1.size = arg1.size - 1;
        0x2::dynamic_field::remove<T0, T1>(arg0, arg2)
    }

    public fun contains<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &Table<T0, T1>, arg2: T0) : bool {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (700 as u64));
        0x2::dynamic_field::exists_with_type<T0, T1>(arg0, arg2)
    }

    public fun is_empty<T0: copy + drop + store, T1: store>(arg0: &Table<T0, T1>) : bool {
        arg0.size == 0
    }

    public fun new<T0: copy + drop + store, T1: store>(arg0: &address) : Table<T0, T1> {
        Table<T0, T1>{
            id   : *arg0,
            size : 0,
        }
    }

    // decompiled from Move bytecode v6
}

