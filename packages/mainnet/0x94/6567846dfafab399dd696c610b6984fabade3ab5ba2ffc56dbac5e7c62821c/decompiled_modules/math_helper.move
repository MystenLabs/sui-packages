module 0x946567846dfafab399dd696c610b6984fabade3ab5ba2ffc56dbac5e7c62821c::math_helper {
    public fun ageb_u128(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 2);
    }

    public fun ageb_u256(arg0: u256, arg1: u256) {
        assert!(arg0 >= arg1, 3);
    }

    public fun ageb_u64(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 1);
    }

    public fun ageb_u64_with_div(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 >= arg1 * arg2 / arg3, 1);
    }

    // decompiled from Move bytecode v6
}

