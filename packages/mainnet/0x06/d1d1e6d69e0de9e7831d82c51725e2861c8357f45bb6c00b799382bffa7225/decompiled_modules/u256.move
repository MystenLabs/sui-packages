module 0x6d1d1e6d69e0de9e7831d82c51725e2861c8357f45bb6c00b799382bffa7225::u256 {
    public fun sqrt(arg0: u256) : u256 {
        let v0 = 0;
        if (arg0 > 3) {
            v0 = arg0;
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                v0 = v1;
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
        } else if (arg0 != 0) {
            v0 = 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

