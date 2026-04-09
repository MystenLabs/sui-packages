module 0x5d5469041f22c1912cbeb6976dee0be1ea69ba12bc2c04a1961ffe77889350d6::basics {
    public fun add(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun first(arg0: &vector<u64>) : u64 {
        assert!(0x1::vector::length<u64>(arg0) > 0, 1);
        *0x1::vector::borrow<u64>(arg0, 0)
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun push_value(arg0: &mut vector<u64>, arg1: u64) {
        0x1::vector::push_back<u64>(arg0, arg1);
    }

    public fun subtract(arg0: u64, arg1: u64) : u64 {
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

