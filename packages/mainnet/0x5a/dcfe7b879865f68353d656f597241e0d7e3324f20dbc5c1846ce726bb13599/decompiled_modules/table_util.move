module 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::table_util {
    public fun upsert<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::table::Table<T0, T1>, arg1: T0, arg2: T1) {
        if (0x2::table::contains<T0, T1>(arg0, arg1)) {
            0x2::table::remove<T0, T1>(arg0, arg1);
        };
        0x2::table::add<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

