module 0x2c4e75d6f73a65f435d1a99636c4483536becd51e0fecd76e2b447104948b30f::weight_book {
    struct Book has store {
        day: u64,
        weight: u256,
        slope: u256,
        changes: 0x2::table::Table<u64, Change>,
    }

    struct Change has copy, drop, store {
        weight_add: u256,
        weight_sub: u256,
        slope_add: u256,
        slope_sub: u256,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Book {
        Book{
            day     : arg0 / 86400000,
            weight  : 0,
            slope   : 0,
            changes : 0x2::table::new<u64, Change>(arg1),
        }
    }

    public(friend) fun advance(arg0: &mut Book, arg1: u64) : bool {
        let v0 = arg1 / 86400000;
        assert!(v0 >= arg0.day, 1);
        let v1 = 0;
        while (arg0.day < v0 && v1 < 128) {
            if (0x2::table::is_empty<u64, Change>(&arg0.changes)) {
                assert!(arg0.slope == 0, 2);
                arg0.day = v0;
                return true
            };
            arg0.day = arg0.day + 1;
            arg0.weight = arg0.weight + arg0.slope;
            if (0x2::table::contains<u64, Change>(&arg0.changes, arg0.day)) {
                let v2 = 0x2::table::remove<u64, Change>(&mut arg0.changes, arg0.day);
                arg0.weight = arg0.weight + v2.weight_add - v2.weight_sub;
                arg0.slope = arg0.slope + v2.slope_add - v2.slope_sub;
            };
            v1 = v1 + 1;
        };
        arg0.day == v0
    }

    public fun ceil_day(arg0: u64) : u64 {
        let v0 = if (arg0 % 86400000 > 0) {
            1
        } else {
            0
        };
        arg0 / 86400000 + v0
    }

    fun change_lot(arg0: &mut Book, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) {
        assert!(arg0.day == arg5 / 86400000 && arg2 <= arg5, 1);
        assert!(arg4 >= 10000, 2);
        assert!(arg3 <= arg5 || arg3 - arg5 <= 7776000000, 1);
        let v0 = ceil_day(arg2);
        component(arg0, (arg1 as u256) * 10000, v0, 0x1::option::none<u64>(), arg6);
        if (arg4 > 10000) {
            component(arg0, (arg1 as u256) * ((arg4 - 10000) as u256), v0, 0x1::option::some<u64>(ceil_day(arg3)), arg6);
        };
    }

    fun component(arg0: &mut Book, arg1: u256, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: bool) {
        if (arg1 == 0) {
            return
        };
        let v0 = arg2 + 30;
        let v1 = if (0x1::option::is_some<u64>(&arg3)) {
            *0x1::option::borrow<u64>(&arg3)
        } else {
            18446744073709551615
        };
        if (v1 <= arg0.day || v1 <= arg2) {
            return
        };
        let v2 = if (arg0.day > arg2) {
            0x1::u64::min(arg0.day - arg2, 30)
        } else {
            0
        };
        let v3 = if (arg0.day >= arg2 && arg0.day < v0) {
            arg1
        } else {
            0
        };
        if (arg4) {
            arg0.weight = arg0.weight - arg1 * (v2 as u256);
            arg0.slope = arg0.slope - v3;
        } else {
            arg0.weight = arg0.weight + arg1 * (v2 as u256);
            arg0.slope = arg0.slope + v3;
        };
        if (arg2 > arg0.day) {
            schedule(arg0, arg2, 0, 0, arg1, 0, arg4);
        };
        if (v0 > arg0.day && v0 < v1) {
            schedule(arg0, v0, 0, 0, 0, arg1, arg4);
        };
        if (0x1::option::is_some<u64>(&arg3) && v1 > arg0.day) {
            let v4 = if (v1 <= v0) {
                arg1
            } else {
                0
            };
            schedule(arg0, v1, 0, arg1 * (0x1::u64::min(v1 - arg2, 30) as u256), 0, v4, arg4);
        };
    }

    public fun day(arg0: &Book) : u64 {
        arg0.day
    }

    public(friend) fun insert_lot(arg0: &mut Book, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        change_lot(arg0, arg1, arg2, arg3, arg4, arg5, false);
    }

    fun net(arg0: u256, arg1: u256) : (u256, u256) {
        if (arg0 >= arg1) {
            (arg0 - arg1, 0)
        } else {
            (0, arg1 - arg0)
        }
    }

    public fun pending_days(arg0: &Book) : u64 {
        0x2::table::length<u64, Change>(&arg0.changes)
    }

    public(friend) fun remove_lot(arg0: &mut Book, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        change_lot(arg0, arg1, arg2, arg3, arg4, arg5, true);
    }

    fun schedule(arg0: &mut Book, arg1: u64, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: bool) {
        assert!(arg1 > arg0.day, 2);
        let v0 = if (0x2::table::contains<u64, Change>(&arg0.changes, arg1)) {
            0x2::table::remove<u64, Change>(&mut arg0.changes, arg1)
        } else {
            Change{weight_add: 0, weight_sub: 0, slope_add: 0, slope_sub: 0}
        };
        let v1 = v0;
        let (v2, v3) = if (arg6) {
            (arg3, arg2)
        } else {
            (arg2, arg3)
        };
        let (v4, v5) = if (arg6) {
            (arg5, arg4)
        } else {
            (arg4, arg5)
        };
        let (v6, v7) = net(v1.weight_add + v2, v1.weight_sub + v3);
        let (v8, v9) = net(v1.slope_add + v4, v1.slope_sub + v5);
        let v10 = if (v6 > 0) {
            true
        } else if (v7 > 0) {
            true
        } else if (v8 > 0) {
            true
        } else {
            v9 > 0
        };
        if (v10) {
            let v11 = Change{
                weight_add : v6,
                weight_sub : v7,
                slope_add  : v8,
                slope_sub  : v9,
            };
            0x2::table::add<u64, Change>(&mut arg0.changes, arg1, v11);
        };
    }

    public fun total(arg0: &Book) : u256 {
        arg0.weight
    }

    // decompiled from Move bytecode v7
}

