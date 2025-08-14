module 0x26e47e5750d2f91b1afdb36a0aebfd8bebfdd4c643f5edb1207253d4314c3e9e::math {
    public fun add(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun sub(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    // decompiled from Move bytecode v6
}

