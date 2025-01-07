module 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::comparator {
    struct Result has drop {
        inner: u8,
    }

    public fun compare<T0>(arg0: &T0, arg1: &T0) : Result {
        abort 0
    }

    public fun compare_u8_vector(arg0: vector<u8>, arg1: vector<u8>) : Result {
        abort 0
    }

    public fun is_equal(arg0: &Result) : bool {
        abort 0
    }

    public fun is_greater_than(arg0: &Result) : bool {
        abort 0
    }

    public fun is_smaller_than(arg0: &Result) : bool {
        abort 0
    }

    // decompiled from Move bytecode v6
}

