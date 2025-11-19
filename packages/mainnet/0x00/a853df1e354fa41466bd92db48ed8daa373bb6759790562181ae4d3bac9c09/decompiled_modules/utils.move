module 0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::utils {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64, arg2: bool) : u64 {
        let v0 = if (0x2::clock::timestamp_ms(arg0) > arg1) {
            201
        } else {
            0
        };
        if (v0 != 0 && !arg2) {
            abort v0
        };
        v0
    }

    // decompiled from Move bytecode v6
}

