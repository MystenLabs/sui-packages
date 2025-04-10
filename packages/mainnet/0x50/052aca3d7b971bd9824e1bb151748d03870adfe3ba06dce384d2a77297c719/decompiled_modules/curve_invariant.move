module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant {
    public(friend) fun a(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: &0x2::clock::Clock) : u256 {
        let v0 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::clock::timestamp_ms(arg4));
        if (v0 >= arg3) {
            return arg2
        };
        if (arg2 > arg0) {
            arg0 + (arg2 - arg0) * (v0 - arg1) / (arg3 - arg1)
        } else {
            arg0 - (arg0 - arg2) * (v0 - arg1) / (arg3 - arg1)
        }
    }

    public(friend) fun d(arg0: u256, arg1: vector<u256>) : u256 {
        let v0 = 0;
        0x1::vector::reverse<u256>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg1)) {
            v0 = v0 + 0x1::vector::pop_back<u256>(&mut arg1);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u256>(arg1);
        if (v0 == 0) {
            return 0
        } else {
            let v2 = 0x1::vector::length<u256>(&arg1);
            let v3 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v2);
            let v4 = v0;
            let v5 = arg0 * v3;
            let v6 = 100;
            let v7 = 0;
            while (255 > v7) {
                let v8 = v4;
                let v9 = 0;
                while (v9 < v2) {
                    let v10 = v8 * v4;
                    v8 = v10 / *0x1::vector::borrow<u256>(&arg1, v9) * v3;
                    v9 = v9 + 1;
                };
                let v11 = v4;
                v4 = (v5 * v0 / v6 + v8 * v3) * v4 / ((v5 - v6) * v4 / v6 + (v3 + 1) * v8);
                if (1 >= 0x1::u256::diff(v4, v11)) {
                    return v4
                };
                v7 = v7 + 1;
            };
            abort 1
        };
    }

    public(friend) fun y(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: vector<u256>) : u256 {
        assert!(arg1 != arg2, 0);
        let v0 = d(arg0, arg4);
        let v1 = v0;
        let v2 = 0;
        let v3 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x1::vector::length<u256>(&arg4));
        let v4 = arg0 * v3;
        let v5 = 100;
        let v6 = 0;
        while (v3 > v6) {
            if (v6 == arg1) {
                v2 = v2 + arg3;
                let v7 = v1 * v0;
                v1 = v7 / arg3 * v3;
            } else if (v6 != arg2) {
                let v8 = *0x1::vector::borrow<u256>(&arg4, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v6));
                v2 = v2 + v8;
                let v9 = v1 * v0;
                v1 = v9 / v8 * v3;
            };
            v6 = v6 + 1;
        };
        let v10 = v0;
        let v11 = 0;
        while (255 > v11) {
            let v12 = v10;
            v10 = (v10 * v10 + v1 * v0 * v5 / v4 * v3) / (2 * v10 + v2 + v0 * v5 / v4 - v0);
            if (1 >= 0x1::u256::diff(v10, v12)) {
                return v10
            };
            v11 = v11 + 1;
        };
        abort 2
    }

    public(friend) fun y_d(arg0: u256, arg1: u256, arg2: vector<u256>, arg3: u256) : u256 {
        let v0 = arg3;
        let v1 = 0;
        let v2 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x1::vector::length<u256>(&arg2));
        let v3 = arg0 * v2;
        let v4 = 0;
        while (v2 > v4) {
            if (v4 != arg1) {
                let v5 = *0x1::vector::borrow<u256>(&arg2, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v4));
                v1 = v1 + v5;
                let v6 = v0 * arg3;
                v0 = v6 / v5 * v2;
            };
            v4 = v4 + 1;
        };
        let v7 = 100;
        let v8 = arg3;
        loop {
            let v9 = v8;
            v8 = (v8 * v8 + v0 * arg3 * v7 / v3 * v2) / (2 * v8 + v1 + arg3 * v7 / v3 - arg3);
            if (1 >= 0x1::u256::diff(v8, v9)) {
                break
            };
        };
        v8
    }

    public(friend) fun y_lp(arg0: u256, arg1: u256, arg2: vector<u256>, arg3: u256, arg4: u256) : u256 {
        let v0 = d(arg0, arg2);
        y_d(arg0, arg1, arg2, v0 - arg3 * v0 / arg4)
    }

    // decompiled from Move bytecode v6
}

