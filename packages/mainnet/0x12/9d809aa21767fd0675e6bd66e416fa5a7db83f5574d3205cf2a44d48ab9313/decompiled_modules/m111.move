module 0x129d809aa21767fd0675e6bd66e416fa5a7db83f5574d3205cf2a44d48ab9313::m111 {
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

