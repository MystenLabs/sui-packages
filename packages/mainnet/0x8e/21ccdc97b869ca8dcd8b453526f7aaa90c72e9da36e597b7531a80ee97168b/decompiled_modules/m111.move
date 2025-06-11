module 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::m111 {
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

