module 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::bisect {
    struct Bisect {
        sizes: vector<u64>,
        ix: u64,
        carry: u64,
        best_in: u64,
        best_out: u64,
    }

    public fun advance(arg0: Bisect) : Bisect {
        let Bisect {
            sizes    : v0,
            ix       : v1,
            carry    : v2,
            best_in  : v3,
            best_out : v4,
        } = arg0;
        let v5 = v0;
        if (v1 >= 0x1::vector::length<u64>(&v5)) {
            return Bisect{
                sizes    : v5,
                ix       : v1,
                carry    : v2,
                best_in  : v3,
                best_out : v4,
            }
        };
        let v6 = *0x1::vector::borrow<u64>(&v5, v1);
        let (v7, v8) = if (v3 == 0 || 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v2) > 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v3, v4)) {
            (v6, v2)
        } else {
            (v3, v4)
        };
        let v9 = v1 + 1;
        let v10 = if (v9 < 0x1::vector::length<u64>(&v5)) {
            *0x1::vector::borrow<u64>(&v5, v9)
        } else {
            0
        };
        Bisect{
            sizes    : v5,
            ix       : v9,
            carry    : v10,
            best_in  : v7,
            best_out : v8,
        }
    }

    public fun carry(arg0: &Bisect) : u64 {
        arg0.carry
    }

    public fun feed(arg0: Bisect, arg1: u64) : Bisect {
        let Bisect {
            sizes    : v0,
            ix       : v1,
            carry    : _,
            best_in  : v3,
            best_out : v4,
        } = arg0;
        Bisect{
            sizes    : v0,
            ix       : v1,
            carry    : arg1,
            best_in  : v3,
            best_out : v4,
        }
    }

    public fun finish(arg0: Bisect) : (u64, u64) {
        let Bisect {
            sizes    : _,
            ix       : _,
            carry    : _,
            best_in  : v3,
            best_out : v4,
        } = arg0;
        (v3, v4)
    }

    public fun rounds_left(arg0: &Bisect) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0.sizes);
        if (arg0.ix >= v0) {
            0
        } else {
            v0 - arg0.ix
        }
    }

    public fun start(arg0: vector<u64>) : Bisect {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 > 0, 31);
        assert!(v0 <= (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes() as u64), 32);
        let v1 = 0;
        while (v1 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg0, v1) > 0, 33);
            v1 = v1 + 1;
        };
        Bisect{
            sizes    : arg0,
            ix       : 0,
            carry    : *0x1::vector::borrow<u64>(&arg0, 0),
            best_in  : 0,
            best_out : 0,
        }
    }

    // decompiled from Move bytecode v7
}

