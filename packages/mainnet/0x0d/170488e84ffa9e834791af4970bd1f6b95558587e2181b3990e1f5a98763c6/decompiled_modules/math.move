module 0xd170488e84ffa9e834791af4970bd1f6b95558587e2181b3990e1f5a98763c6::math {
    struct Result has copy, drop {
        value: u64,
        magic: u64,
    }

    public fun add_with_magic(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1 + 42
    }

    public fun compute(arg0: u64) : Result {
        Result{
            value : arg0 * 2,
            magic : 999,
        }
    }

    public fun get_magic(arg0: &Result) : u64 {
        arg0.magic
    }

    public fun get_value(arg0: &Result) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

