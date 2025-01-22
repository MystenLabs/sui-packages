module 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_median {
    public fun calculate_median(arg0: &mut vector<u256>) : u256 {
        let v0 = 0x1::vector::length<u256>(arg0);
        assert!(v0 > 0, 0);
        if (v0 == 1) {
            return *0x1::vector::borrow<u256>(arg0, 0)
        };
        if (v0 == 2) {
            let v1 = *0x1::vector::borrow<u256>(arg0, 0);
            let v2 = *0x1::vector::borrow<u256>(arg0, 1);
            return v1 / 2 + v2 / 2 + (v1 % 2 + v2 % 2) / 2
        };
        if (v0 == 3) {
            let v3 = *0x1::vector::borrow<u256>(arg0, 0);
            let v4 = *0x1::vector::borrow<u256>(arg0, 1);
            let v5 = *0x1::vector::borrow<u256>(arg0, 2);
            if (v3 <= v4) {
                if (v4 <= v5) {
                    return v4
                };
                if (v3 <= v5) {
                    return v5
                };
                return v3
            };
            if (v3 <= v5) {
                return v3
            };
            if (v4 <= v5) {
                return v5
            };
            return v4
        };
        sort(arg0);
        if (v0 % 2 == 1) {
            *0x1::vector::borrow<u256>(arg0, v0 / 2)
        } else {
            let v7 = *0x1::vector::borrow<u256>(arg0, v0 / 2 - 1);
            let v8 = *0x1::vector::borrow<u256>(arg0, v0 / 2);
            v7 / 2 + v8 / 2 + (v7 % 2 + v8 % 2) / 2
        }
    }

    public fun sort(arg0: &mut vector<u256>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<u256>(arg0)) {
            while (v0 > 0 && *0x1::vector::borrow<u256>(arg0, v0 - 1) > *0x1::vector::borrow<u256>(arg0, v0)) {
                0x1::vector::swap<u256>(arg0, v0 - 1, v0);
                v0 = v0 - 1;
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

