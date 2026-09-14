module 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary {
    struct Summary has copy, drop, store {
        total: u256,
        count: u64,
        largest: vector<u128>,
    }

    struct Schedule has copy, drop, store {
        cap: u64,
        remaining: u64,
        uncapped_weight: u256,
    }

    public fun count(arg0: &Summary) : u64 {
        arg0.count
    }

    public fun finish(arg0: &Summary, arg1: u64) : Schedule {
        let v0 = arg1 / 10;
        let v1 = arg1;
        let v2 = arg0.total;
        if (v0 == 0) {
            return Schedule{
                cap             : 0,
                remaining       : 0,
                uncapped_weight : 0,
            }
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(&arg0.largest) && v2 > 0) {
            let v4 = (*0x1::vector::borrow<u128>(&arg0.largest, v3) as u256);
            if ((v1 as u256) * v4 / v2 < (v0 as u256)) {
                break
            };
            v1 = v1 - v0;
            v2 = v2 - v4;
            v3 = v3 + 1;
        };
        Schedule{
            cap             : v0,
            remaining       : v1,
            uncapped_weight : v2,
        }
    }

    public fun new() : Summary {
        Summary{
            total   : 0,
            count   : 0,
            largest : vector[],
        }
    }

    public fun observe(arg0: &mut Summary, arg1: u128) {
        if (arg1 == 0) {
            return
        };
        arg0.total = arg0.total + (arg1 as u256);
        arg0.count = arg0.count + 1;
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(&arg0.largest) && *0x1::vector::borrow<u128>(&arg0.largest, v0) >= arg1) {
            v0 = v0 + 1;
        };
        if (v0 < 19) {
            0x1::vector::insert<u128>(&mut arg0.largest, arg1, v0);
            if (0x1::vector::length<u128>(&arg0.largest) > 19) {
                0x1::vector::pop_back<u128>(&mut arg0.largest);
            };
        };
    }

    public fun payout(arg0: &Schedule, arg1: u128) : u64 {
        if (arg1 == 0 || arg0.cap == 0) {
            return 0
        };
        if (arg0.uncapped_weight == 0) {
            return arg0.cap
        };
        let v0 = (arg0.remaining as u256) * (arg1 as u256) / arg0.uncapped_weight;
        if (v0 >= (arg0.cap as u256)) {
            arg0.cap
        } else {
            (v0 as u64)
        }
    }

    public fun retained(arg0: &Summary) : u64 {
        0x1::vector::length<u128>(&arg0.largest)
    }

    public fun total(arg0: &Summary) : u256 {
        arg0.total
    }

    // decompiled from Move bytecode v7
}

