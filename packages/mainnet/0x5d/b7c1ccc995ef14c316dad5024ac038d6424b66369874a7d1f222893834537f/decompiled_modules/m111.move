module 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::m111 {
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

