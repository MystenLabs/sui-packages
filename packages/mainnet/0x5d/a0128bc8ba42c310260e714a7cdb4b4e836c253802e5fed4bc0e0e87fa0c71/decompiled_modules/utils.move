module 0x5da0128bc8ba42c310260e714a7cdb4b4e836c253802e5fed4bc0e0e87fa0c71::utils {
    public fun add(arg0: u256, arg1: u256) : u256 {
        arg0 + arg1
    }

    public fun as_u64(arg0: u256) : u64 {
        (arg0 as u64)
    }

    public fun div(arg0: u256, arg1: u256) : u256 {
        arg0 / arg1
    }

    public fun from_u64(arg0: u64) : u256 {
        (arg0 as u256)
    }

    public fun mul(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1
    }

    public fun sub(arg0: u256, arg1: u256) : u256 {
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

