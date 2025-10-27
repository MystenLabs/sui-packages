module 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::math_utils {
    public fun integer_sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 < 4) {
            return 1
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

