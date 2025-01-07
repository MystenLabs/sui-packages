module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2 {
    public fun borrow_mut_fill<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) : &mut T1 {
        if (!0x2::dynamic_field::exists_with_type<T0, T1>(arg0, arg1)) {
            set<T0, T1>(arg0, arg1, arg2);
        };
        0x2::dynamic_field::borrow_mut<T0, T1>(arg0, arg1)
    }

    public fun drop<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0) {
        if (0x2::dynamic_field::exists_<T0>(arg0, arg1)) {
            0x2::dynamic_field::remove<T0, T1>(arg0, arg1);
        };
    }

    public fun get_maybe<T0: copy + drop + store, T1: copy + store>(arg0: &0x2::object::UID, arg1: T0) : 0x1::option::Option<T1> {
        if (0x2::dynamic_field::exists_with_type<T0, T1>(arg0, arg1)) {
            0x1::option::some<T1>(*0x2::dynamic_field::borrow<T0, T1>(arg0, arg1))
        } else {
            0x1::option::none<T1>()
        }
    }

    public fun get_with_default<T0: copy + drop + store, T1: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0, arg2: T1) : T1 {
        if (0x2::dynamic_field::exists_with_type<T0, T1>(arg0, arg1)) {
            *0x2::dynamic_field::borrow<T0, T1>(arg0, arg1)
        } else {
            arg2
        }
    }

    public fun set<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        drop<T0, T1>(arg0, arg1);
        0x2::dynamic_field::add<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

