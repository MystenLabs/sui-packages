module 0xf972958a055c4a9be9c6f43b41d24442e1557a6121058927eb8f63f3bbf843a6::tools {
    public fun pow(arg0: u64, arg1: u8) : u64 {
        let v0 = 1;
        while (arg1 > 0) {
            if (arg1 % 2 == 1) {
                v0 = v0 * arg0;
            };
            arg1 = arg1 / 2;
            arg0 = arg0 * arg0;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

