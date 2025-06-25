module 0xf6b668302a8d006e599bf2c9bf7377e631db1a04d30158fd5478b079e92bced8::pagination {
    public fun get_cursor_based_index(arg0: &vector<u64>, arg1: 0x1::option::Option<u64>, arg2: bool) : 0x1::option::Option<u64> {
        if (0x1::vector::is_empty<u64>(arg0)) {
            return 0x1::option::none<u64>()
        };
        if (0x1::option::is_none<u64>(&arg1)) {
            let v0 = if (arg2) {
                0x1::vector::length<u64>(arg0) - 1
            } else {
                0
            };
            return 0x1::option::some<u64>(v0)
        };
        let v1 = 0x1::option::destroy_some<u64>(arg1);
        let v2 = 0xf6b668302a8d006e599bf2c9bf7377e631db1a04d30158fd5478b079e92bced8::common::find_upper_bound(*arg0, v1);
        if (v2 >= 0x1::vector::length<u64>(arg0) || *0x1::vector::borrow<u64>(arg0, v2) != v1) {
            return 0x1::option::none<u64>()
        };
        if (v2 == 0 || v2 >= 0x1::vector::length<u64>(arg0) - 1) {
            return 0x1::option::none<u64>()
        };
        if (arg2) {
            0x1::option::some<u64>(v2 - 1)
        } else {
            0x1::option::some<u64>(v2 + 1)
        }
    }

    public fun get_limit(arg0: 0x1::option::Option<u64>, arg1: u64) : u64 {
        let v0 = arg1;
        if (0x1::option::is_some<u64>(&arg0)) {
            let v1 = 0x1::option::destroy_some<u64>(arg0);
            v0 = v1;
            if (v1 > arg1) {
                v0 = arg1;
            };
        };
        v0
    }

    public fun get_page_based_index<T0>(arg0: &vector<T0>, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: bool) : 0x1::option::Option<u64> {
        if (0x1::vector::is_empty<T0>(arg0)) {
            return 0x1::option::none<u64>()
        };
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            let v1 = 0x1::option::destroy_some<u64>(arg1);
            if (v1 == 0) {
                1
            } else {
                v1
            }
        } else {
            1
        };
        if (arg3) {
            let v3 = 0x1::vector::length<T0>(arg0);
            let v4 = arg2 * (v0 - 1);
            if (v4 >= v3) {
                0x1::option::none<u64>()
            } else {
                0x1::option::some<u64>(v3 - v4 - 1)
            }
        } else {
            let v5 = arg2 * (v0 - 1);
            if (v5 >= 0x1::vector::length<T0>(arg0)) {
                0x1::option::none<u64>()
            } else {
                0x1::option::some<u64>(v5)
            }
        }
    }

    // decompiled from Move bytecode v6
}

