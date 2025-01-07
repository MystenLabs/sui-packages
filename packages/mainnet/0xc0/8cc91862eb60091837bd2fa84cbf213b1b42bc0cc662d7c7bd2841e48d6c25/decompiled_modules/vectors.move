module 0xc08cc91862eb60091837bd2fa84cbf213b1b42bc0cc662d7c7bd2841e48d6c25::vectors {
    public fun find_upper_bound(arg0: &vector<u64>, arg1: u64) : u64 {
        if (0x1::vector::length<u64>(arg0) == 0) {
            return 0
        };
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(arg0);
        while (v0 < v1) {
            v1 = 0xc08cc91862eb60091837bd2fa84cbf213b1b42bc0cc662d7c7bd2841e48d6c25::math::average(v0, v1);
            if (*0x1::vector::borrow<u64>(arg0, v1) > arg1) {
                continue
            };
            v0 = v1 + 1;
        };
        if (v0 > 0 && *0x1::vector::borrow<u64>(arg0, v0 - 1) == arg1) {
            v0 - 1
        } else {
            v0
        }
    }

    public fun gt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 == 0x1::vector::length<u8>(arg1), 0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v2 > v3) {
                return true
            };
            if (v2 < v3) {
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun gte(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 == 0x1::vector::length<u8>(arg1), 0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v2 > v3) {
                return true
            };
            if (v2 < v3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun lt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 == 0x1::vector::length<u8>(arg1), 0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v2 < v3) {
                return true
            };
            if (v2 > v3) {
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun lte(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 == 0x1::vector::length<u8>(arg1), 0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v2 < v3) {
                return true
            };
            if (v2 > v3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

