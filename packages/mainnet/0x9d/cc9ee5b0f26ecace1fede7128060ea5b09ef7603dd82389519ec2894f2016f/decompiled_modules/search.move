module 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::search {
    public fun at(arg0: &vector<u64>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(arg0, arg1)
    }

    public fun best(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: u64) : (bool, u64, u64, u64) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 > 0, 0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 1);
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = net_profit(*0x1::vector::borrow<u64>(arg0, v3), *0x1::vector::borrow<u64>(arg1, v3), arg2, arg3);
            if (v4 >= arg4 && v4 > 0) {
                v2 = true;
            };
            v3 = v3 + 1;
        };
        if (v2) {
            (true, v1, *0x1::vector::borrow<u64>(arg0, v1), *0x1::vector::borrow<u64>(arg1, v1))
        } else {
            (false, 0, 0, 0)
        }
    }

    public fun concat(arg0: vector<u64>, arg1: vector<u64>) : vector<u64> {
        0x1::vector::append<u64>(&mut arg0, arg1);
        arg0
    }

    public fun ladder(arg0: u64, arg1: u8) : vector<u64> {
        assert!(arg0 > 0 && arg1 > 0, 0);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<u64>(&mut v0, arg0);
            arg0 = arg0 * 2;
            v1 = v1 + 1;
        };
        v0
    }

    public fun net_profit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg0 + arg2 + arg3;
        if (arg1 > v0) {
            arg1 - v0
        } else {
            0
        }
    }

    public fun probes(arg0: u64, arg1: u64) : vector<u64> {
        assert!(arg1 > arg0, 0);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0);
        0x1::vector::push_back<u64>(v1, arg0 + (arg1 - arg0) / 2);
        0x1::vector::push_back<u64>(v1, arg1);
        v0
    }

    public fun refine(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 > 0, 0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v2 = v2 + 1;
        };
        let v3 = if (v1 == 0) {
            *0x1::vector::borrow<u64>(arg0, 0) / 2
        } else {
            *0x1::vector::borrow<u64>(arg0, v1 - 1)
        };
        let v4 = if (v1 + 1 < v0) {
            *0x1::vector::borrow<u64>(arg0, v1 + 1)
        } else {
            *0x1::vector::borrow<u64>(arg0, v0 - 1) * 2
        };
        (v3, v4)
    }

    // decompiled from Move bytecode v7
}

