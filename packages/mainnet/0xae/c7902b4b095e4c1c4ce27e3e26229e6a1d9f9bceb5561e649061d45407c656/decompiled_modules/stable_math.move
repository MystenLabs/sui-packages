module 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math {
    public fun a(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: &0x2::clock::Clock) : u256 {
        let v0 = (0x2::clock::timestamp_ms(arg4) as u256);
        if (v0 >= arg3) {
            return arg2
        };
        if (arg2 > arg0) {
            arg0 + (arg2 - arg0) * (v0 - arg1) / (arg3 - arg1)
        } else {
            arg0 - (arg0 - arg2) * (v0 - arg1) / (arg3 - arg1)
        }
    }

    public fun invariant_(arg0: u256, arg1: vector<u256>) : u256 {
        let v0 = 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math256::sum(arg1);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x1::vector::length<u256>(&arg1);
        let v2 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v1);
        let v3 = v0;
        let v4 = arg0 * v2;
        let v5 = 0;
        while (255 > v5) {
            let v6 = v3;
            let v7 = 0;
            while (v7 < v1) {
                let v8 = v6 * v3;
                v6 = v8 / *0x1::vector::borrow<u256>(&arg1, v7) * v2;
                v7 = v7 + 1;
            };
            let v9 = v3;
            let v10 = (v4 * v0 + v6 * v2) * v3 / ((v4 - 1) * v3 + (v2 + 1) * v6);
            v3 = v10;
            if (1 >= 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math256::diff(v10, v9)) {
                return v10
            };
            v5 = v5 + 1;
        };
        v3
    }

    public fun y(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: vector<u256>) : u256 {
        assert!(arg1 != arg2, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::same_coin_index());
        let v0 = invariant_(arg0, arg4);
        let v1 = v0;
        let v2 = 0;
        let v3 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(0x1::vector::length<u256>(&arg4));
        let v4 = arg0 * v3;
        let v5 = 0;
        while (v3 > v5) {
            if (v5 == arg1) {
                v2 = v2 + arg3;
                let v6 = v1 * v0;
                v1 = v6 / arg3 * v3;
            } else if (v5 != arg2) {
                let v7 = *0x1::vector::borrow<u256>(&arg4, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u64(v5));
                v2 = v2 + v7;
                let v8 = v1 * v0;
                v1 = v8 / v7 * v3;
            };
            v5 = v5 + 1;
        };
        let v9 = v0;
        let v10 = 0;
        while (255 > v10) {
            let v11 = v9;
            let v12 = (v9 * v9 + v1 * v0 / v4 * v3) / (2 * v9 + v2 + v0 / v4 - v0);
            v9 = v12;
            if (1 >= 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math256::diff(v12, v11)) {
                return v12
            };
            v10 = v10 + 1;
        };
        v9
    }

    public fun y_d(arg0: u256, arg1: u256, arg2: vector<u256>, arg3: u256) : u256 {
        let v0 = arg3;
        let v1 = 0;
        let v2 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(0x1::vector::length<u256>(&arg2));
        let v3 = arg0 * v2;
        let v4 = 0;
        while (v2 > v4) {
            if (v4 != arg1) {
                let v5 = *0x1::vector::borrow<u256>(&arg2, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u64(v4));
                v1 = v1 + v5;
                let v6 = v0 * arg3;
                v0 = v6 / v5 * v2;
            };
            v4 = v4 + 1;
        };
        let v7 = arg3;
        loop {
            let v8 = v7;
            v7 = (v7 * v7 + v0 * arg3 / v3 * v2) / (2 * v7 + v1 + arg3 / v3 - arg3);
            if (1 >= 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math256::diff(v7, v8)) {
                break
            };
        };
        v7
    }

    public fun y_lp(arg0: u256, arg1: u256, arg2: vector<u256>, arg3: u256, arg4: u256) : u256 {
        let v0 = invariant_(arg0, arg2);
        y_d(arg0, arg1, arg2, v0 - arg3 * v0 / arg4)
    }

    // decompiled from Move bytecode v6
}

