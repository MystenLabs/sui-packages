module 0xdeeafc597151642e620d5c91d61d574de574a80fdfd51d7b4b14d219549b79c8::pushtest {
    public fun add(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun throw() {
        abort 13906834208703119361
    }

    // decompiled from Move bytecode v6
}

