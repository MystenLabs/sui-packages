module 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::morton {
    public fun depth_prefix(arg0: u64, arg1: u8) : u64 {
        assert!(arg1 <= 31, 3001);
        if (arg1 == 0) {
            return 1
        };
        let v0 = 1 << arg1 * 2;
        v0 | arg0 & v0 - 1
    }

    public fun interleave(arg0: u32, arg1: u32) : u64 {
        interleave_n(arg0, arg1, 32)
    }

    public fun interleave_n(arg0: u32, arg1: u32, arg2: u8) : u64 {
        assert!(arg2 <= 32, 3003);
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = v0 | ((arg0 as u64) >> v1 & 1) << v1 * 2;
            v0 = v2 | ((arg1 as u64) >> v1 & 1) << v1 * 2 + 1;
            v1 = v1 + 1;
        };
        v0
    }

    public fun max_depth() : u8 {
        31
    }

    public fun parent_key(arg0: u64) : u64 {
        assert!(arg0 > 1, 3002);
        arg0 >> 2
    }

    // decompiled from Move bytecode v7
}

