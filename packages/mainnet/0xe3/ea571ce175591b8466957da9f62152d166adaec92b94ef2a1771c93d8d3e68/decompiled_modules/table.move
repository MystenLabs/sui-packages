module 0xe3ea571ce175591b8466957da9f62152d166adaec92b94ef2a1771c93d8d3e68::table {
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

