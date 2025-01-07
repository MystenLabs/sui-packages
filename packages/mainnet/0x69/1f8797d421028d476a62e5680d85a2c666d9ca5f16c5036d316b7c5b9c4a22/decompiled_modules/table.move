module 0x691f8797d421028d476a62e5680d85a2c666d9ca5f16c5036d316b7c5b9c4a22::table {
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

