module 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::bitmap_math {
    public(friend) fun ceil256(arg0: u64) : u64 {
        let v0 = if (arg0 % 256 == 0) {
            0
        } else {
            1
        };
        arg0 / 256 + v0
    }

    public(friend) fun depth(arg0: u64) : u8 {
        let v0 = 1;
        while (arg0 > 256) {
            arg0 = ceil256(arg0);
            v0 = v0 + 1;
        };
        v0
    }

    public(friend) fun directional_mask(arg0: u256, arg1: u8, arg2: bool) : u256 {
        if (arg2) {
            arg0 >> arg1 << arg1
        } else if (arg1 == 255) {
            arg0
        } else {
            arg0 & (1 << arg1 + 1) - 1
        }
    }

    public(friend) fun extreme_bit(arg0: u256, arg1: bool) : u64 {
        assert!(arg0 != 0, 0);
        let v0 = 0;
        let v1 = 128;
        while (v1 > 0) {
            if (arg1) {
                let v2 = (1 << v1) - 1;
                if (arg0 & v2 == 0) {
                    v0 = v0 + (v1 as u64);
                    arg0 = arg0 >> v1;
                } else {
                    arg0 = arg0 & v2;
                };
            } else if (arg0 >> v1 != 0) {
                v0 = v0 + (v1 as u64);
                arg0 = arg0 >> v1;
            };
            v1 = v1 / 2;
        };
        v0
    }

    public(friend) fun level_bits(arg0: u64, arg1: u8) : u64 {
        let v0 = 0;
        while (v0 < arg1) {
            arg0 = ceil256(arg0);
            v0 = v0 + 1;
        };
        arg0
    }

    // decompiled from Move bytecode v7
}

