module 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps {
    struct Bps has copy, drop, store {
        pos0: u64,
    }

    public fun apply_up(arg0: Bps, arg1: u64) : u64 {
        0x1::u64::mul_div_ceil(arg1, value(arg0), 10000)
    }

    public fun apportion(arg0: vector<Bps>, arg1: u64, arg2: 0x1::option::Option<u64>) : vector<u64> {
        let v0 = if (sum(arg0) == 10000) {
            let v1 = &arg2;
            0x1::option::is_none<u64>(v1) || *0x1::option::borrow<u64>(v1) < 0x1::vector::length<Bps>(&arg0)
        } else {
            false
        };
        assert!(v0, 1);
        let v2 = 10000;
        let v3 = vector[];
        0x1::vector::reverse<Bps>(&mut arg0);
        let v4 = 0;
        while (v4 < 0x1::vector::length<Bps>(&arg0)) {
            0x1::vector::push_back<u128>(&mut v3, (arg1 as u128) * (value(0x1::vector::pop_back<Bps>(&mut arg0)) as u128));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<Bps>(arg0);
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<u128>(&v3)) {
            let v7 = if (0x1::option::contains<u64>(&arg2, &v6)) {
                (0x1::u128::div_ceil(*0x1::vector::borrow<u128>(&v3, v6), v2) as u64)
            } else {
                ((*0x1::vector::borrow<u128>(&v3, v6) / v2) as u64)
            };
            0x1::vector::push_back<u64>(&mut v5, v7);
            v6 = v6 + 1;
        };
        let v8 = vector[];
        let v9 = 0;
        while (v9 < 0x1::vector::length<u128>(&v3)) {
            0x1::vector::push_back<u64>(&mut v8, v9);
            v9 = v9 + 1;
        };
        let v10 = vector[];
        0x1::vector::reverse<u64>(&mut v8);
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v8)) {
            let v12 = 0x1::vector::pop_back<u64>(&mut v8);
            if (!0x1::option::contains<u64>(&arg2, &v12)) {
                0x1::vector::push_back<u64>(&mut v10, v12);
            };
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<u64>(v8);
        let v13 = &mut v10;
        let v14 = 0x1::vector::length<u64>(v13);
        if (v14 < 2) {
        } else {
            let v15 = 1;
            while (v15 < v14) {
                loop {
                    let v16 = if (v15 > 0) {
                        let v17 = 0x1::vector::borrow<u64>(v13, v15 - 1);
                        let v18 = 0x1::vector::borrow<u64>(v13, v15);
                        let v19 = *0x1::vector::borrow<u128>(&v3, *v17) % v2;
                        let v20 = *0x1::vector::borrow<u128>(&v3, *v18) % v2;
                        let v21 = v19 > v20 || v19 == v20 && *v17 <= *v18;
                        !v21
                    } else {
                        false
                    };
                    if (v16) {
                        0x1::vector::swap<u64>(v13, v15, v15 - 1);
                        v15 = v15 - 1;
                    } else {
                        break
                    };
                };
                v15 = v15 + 1;
            };
        };
        let v22 = 0;
        0x1::vector::reverse<u64>(&mut v5);
        let v23 = 0;
        while (v23 < 0x1::vector::length<u64>(&v5)) {
            v22 = v22 + 0x1::vector::pop_back<u64>(&mut v5);
            v23 = v23 + 1;
        };
        0x1::vector::destroy_empty<u64>(v5);
        let v24 = 0;
        while (v24 < arg1 - v22) {
            let v25 = 0x1::vector::borrow_mut<u64>(&mut v5, *0x1::vector::borrow<u64>(&v10, v24));
            *v25 = *v25 + 1;
            v24 = v24 + 1;
        };
        v5
    }

    public fun new(arg0: u64) : Bps {
        assert!(arg0 <= 10000, 0);
        Bps{pos0: arg0}
    }

    public(friend) fun sum(arg0: vector<Bps>) : u64 {
        let v0 = 0;
        0x1::vector::reverse<Bps>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Bps>(&arg0)) {
            v0 = v0 + value(0x1::vector::pop_back<Bps>(&mut arg0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<Bps>(arg0);
        v0
    }

    public fun value(arg0: Bps) : u64 {
        arg0.pos0
    }

    // decompiled from Move bytecode v7
}

