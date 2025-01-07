module 0xbd62b925b894d6f3b58d76e5a4e211c532efd919996742f90906b8b81ff941f4::m111 {
    fun t(arg0: bool) : u64 {
        if (arg0) {
            return 1
        };
        0
    }

    fun t2(arg0: bool) {
        if (arg0) {
            while (arg0) {
            };
            return
        };
    }

    fun t3(arg0: bool) {
        while (arg0) {
        };
    }

    // decompiled from Move bytecode v6
}

