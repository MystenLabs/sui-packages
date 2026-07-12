module 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::xp {
    public fun level_for_xp(arg0: u64) : u8 {
        let v0 = 1;
        let v1 = 0;
        let v2 = 400;
        while (v0 < 99) {
            v1 = v1 + v2;
            if (arg0 < v1) {
                return v0
            };
            let v3 = v2 * 106;
            v2 = v3 / 100;
            v0 = v0 + 1;
        };
        99
    }

    public fun max_level() : u8 {
        99
    }

    public fun xp_for_level(arg0: u8) : u64 {
        let v0 = if (arg0 == 0) {
            1
        } else {
            0x1::u8::min(arg0, 99)
        };
        let v1 = 0;
        let v2 = 400;
        let v3 = 1;
        while (v3 < v0) {
            v1 = v1 + v2;
            let v4 = v2 * 106;
            v2 = v4 / 100;
            v3 = v3 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v7
}

