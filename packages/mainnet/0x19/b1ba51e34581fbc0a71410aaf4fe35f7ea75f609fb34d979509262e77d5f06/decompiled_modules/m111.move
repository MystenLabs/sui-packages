module 0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::m111 {
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

