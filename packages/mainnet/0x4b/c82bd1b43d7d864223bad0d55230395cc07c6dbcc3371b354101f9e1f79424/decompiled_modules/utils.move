module 0x4bc82bd1b43d7d864223bad0d55230395cc07c6dbcc3371b354101f9e1f79424::utils {
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

