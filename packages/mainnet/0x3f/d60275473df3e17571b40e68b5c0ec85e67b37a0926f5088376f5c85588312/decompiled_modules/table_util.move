module 0x3fd60275473df3e17571b40e68b5c0ec85e67b37a0926f5088376f5c85588312::table_util {
    public fun upsert<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::table::Table<T0, T1>, arg1: T0, arg2: T1) {
        if (0x2::table::contains<T0, T1>(arg0, arg1)) {
            0x2::table::remove<T0, T1>(arg0, arg1);
        };
        0x2::table::add<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

