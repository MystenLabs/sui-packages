module 0x137dafdb3f8fbfd205967e304ad6249b59f4c6f733b7a0cee276a566f00131ca::buckyou_tools {
    public fun is_greater(arg0: u64, arg1: u64) {
        assert!(arg0 > arg1, 1);
    }

    public fun plus(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    // decompiled from Move bytecode v6
}

