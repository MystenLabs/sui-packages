module 0x7ec68f4115dc2944426239b13ce6804dd9971b24069fb4efe88360d29b17f0ce::math {
    public(friend) fun sqrt_down(arg0: u256) : u256 {
        let v0 = (arg0 as u256);
        if (v0 == 0) {
            0
        } else {
            let v2 = (v0 as u256);
            let v3 = v2;
            let v4 = 0;
            let v5 = v4;
            if (v2 >> 128 > 0) {
                v3 = v2 >> 128;
                v5 = v4 + 128;
            };
            if (v3 >> 64 > 0) {
                v3 = v3 >> 64;
                v5 = v5 + 64;
            };
            if (v3 >> 32 > 0) {
                v3 = v3 >> 32;
                v5 = v5 + 32;
            };
            if (v3 >> 16 > 0) {
                v3 = v3 >> 16;
                v5 = v5 + 16;
            };
            if (v3 >> 8 > 0) {
                v3 = v3 >> 8;
                v5 = v5 + 8;
            };
            if (v3 >> 4 > 0) {
                v3 = v3 >> 4;
                v5 = v5 + 4;
            };
            if (v3 >> 2 > 0) {
                v3 = v3 >> 2;
                v5 = v5 + 2;
            };
            if (v3 >> 1 > 0) {
                v5 = v5 + 1;
            };
            let v6 = 1 << ((v5 >> 1) as u8);
            let v7 = v6 + v0 / v6 >> 1;
            let v8 = v7 + v0 / v7 >> 1;
            let v9 = v8 + v0 / v8 >> 1;
            let v10 = v9 + v0 / v9 >> 1;
            let v11 = v10 + v0 / v10 >> 1;
            let v12 = v11 + v0 / v11 >> 1;
            let v13 = v12 + v0 / v12 >> 1;
            let v14 = if (v13 < v0 / v13) {
                v13
            } else {
                v0 / v13
            };
            (v14 as u256)
        }
    }

    // decompiled from Move bytecode v6
}

