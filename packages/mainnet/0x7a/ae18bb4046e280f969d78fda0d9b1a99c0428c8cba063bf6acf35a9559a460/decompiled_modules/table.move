module 0x7aae18bb4046e280f969d78fda0d9b1a99c0428c8cba063bf6acf35a9559a460::table {
    public fun insert_or_add(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(arg0, arg1, arg2);
        };
    }

    public fun remove_or_subtract(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
        if (arg2 < *v0) {
            *v0 = *v0 - arg2;
            return
        };
        assert!(arg2 == *v0, 0);
        0x2::table::remove<address, u64>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

