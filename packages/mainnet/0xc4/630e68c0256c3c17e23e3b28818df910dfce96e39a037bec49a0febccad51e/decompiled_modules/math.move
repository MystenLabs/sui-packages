module 0xec2fdf6ad3e7aeb2f5c9ea1fc492bd24c770600ee70adb8b01b3dd272c059cea::math {
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

