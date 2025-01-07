module 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::point {
    struct Point has drop, store {
        epoch: u64,
        value: 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128,
    }

    public fun checkpoint(arg0: &mut vector<Point>, arg1: &0x2::table::Table<u64, 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128>, arg2: u64) {
        if (0x1::vector::is_empty<Point>(arg0)) {
            0x1::vector::push_back<Point>(arg0, new(arg2, 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::zero()));
            return
        };
        let v0 = last_checkpoint_mut(arg0);
        let v1 = epoch(v0);
        if (v1 < arg2) {
            if (0x2::table::contains<u64, 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128>(arg1, v1)) {
                increase(v0, *0x2::table::borrow<u64, 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128>(arg1, v1));
            };
            let v2 = value(v0);
            let v3 = v1 + 1;
            while (v3 < arg2) {
                if (0x2::table::contains<u64, 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128>(arg1, v3)) {
                    let v4 = 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::add(v2, *0x2::table::borrow<u64, 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128>(arg1, v3));
                    v2 = v4;
                    0x1::vector::push_back<Point>(arg0, new(v3, v4));
                };
                v3 = v3 + 1;
            };
            0x1::vector::push_back<Point>(arg0, new(v3, v2));
        };
    }

    public fun decrease(arg0: &mut Point, arg1: 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128) {
        arg0.value = 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::sub(arg0.value, arg1);
    }

    public fun epoch(arg0: &Point) : u64 {
        arg0.epoch
    }

    public fun find_greatest_under_at(arg0: &vector<Point>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<Point>(arg0) - 1;
        let v2 = 0;
        while (v0 <= v1) {
            let v3 = (v0 + v1) / 2;
            let v4 = epoch(0x1::vector::borrow<Point>(arg0, v3));
            if (v4 == arg1) {
                v2 = v3;
                break
            };
            if (v4 < arg1) {
                v0 = v3 + 1;
                v2 = v3;
                continue
            };
            if (v3 > 0) {
                v1 = v3 - 1;
            } else {
                break
            };
        };
        v2
    }

    public fun find_smallest_above_at(arg0: &vector<Point>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<Point>(arg0) - 1;
        let v2 = 0;
        while (v0 <= v1) {
            let v3 = (v0 + v1) / 2;
            if (epoch(0x1::vector::borrow<Point>(arg0, v3)) > arg1) {
                v1 = v3 - 1;
                v2 = v3;
                continue
            };
            v0 = v3 + 1;
        };
        v2
    }

    public fun increase(arg0: &mut Point, arg1: 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128) {
        arg0.value = 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::add(arg0.value, arg1);
    }

    public fun last_checkpoint(arg0: &vector<Point>) : &Point {
        let v0 = 0x1::vector::length<Point>(arg0);
        assert!(v0 > 0, 3);
        0x1::vector::borrow<Point>(arg0, v0 - 1)
    }

    public fun last_checkpoint_mut(arg0: &mut vector<Point>) : &mut Point {
        let v0 = 0x1::vector::length<Point>(arg0);
        assert!(v0 > 0, 3);
        0x1::vector::borrow_mut<Point>(arg0, v0 - 1)
    }

    public fun new(arg0: u64, arg1: 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128) : Point {
        Point{
            epoch : arg0,
            value : arg1,
        }
    }

    public fun value(arg0: &Point) : 0xf6e05421aa2e6474baa5a304ac844019841246b74eed5884cc85aa9f6348dc46::i128::I128 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

