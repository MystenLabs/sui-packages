module 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::table {
    public(friend) fun update_or_add_in_table<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0x2::table::Table<T0, T1>, arg1: T0, arg2: T1) {
        if (0x2::table::contains<T0, T1>(arg0, arg1)) {
            *0x2::table::borrow_mut<T0, T1>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<T0, T1>(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

