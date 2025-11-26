module 0x7da96ff0a54fb10e09826de86d9482c8630bb47311d7552469068ee3ecaa3243::pushtest {
    public fun add(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun throw() {
        abort 13906834208703119361
    }

    // decompiled from Move bytecode v6
}

