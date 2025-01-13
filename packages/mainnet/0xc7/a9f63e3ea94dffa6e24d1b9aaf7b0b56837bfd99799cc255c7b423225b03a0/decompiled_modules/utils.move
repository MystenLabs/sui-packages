module 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils {
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

