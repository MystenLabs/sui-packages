module 0x7d2940d40236a76d75a9aabf8d63222fe193cbd57da364ccd5cc51b067b084a8::utils {
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

