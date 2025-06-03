module 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::table {
    public(friend) fun update_or_add_in_table<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0x2::table::Table<T0, T1>, arg1: T0, arg2: T1) {
        if (0x2::table::contains<T0, T1>(arg0, arg1)) {
            *0x2::table::borrow_mut<T0, T1>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<T0, T1>(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

