module 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::stake_math {
    public fun accrue_step(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : (u64, u64, u64) {
        if (arg3 == 0 || arg5 <= arg4) {
            return (arg1, arg2, 0)
        };
        if (!arg6) {
            let v0 = if (arg2 > arg4) {
                arg2 - arg4
            } else {
                0
            };
            return (arg1 + arg5 - arg4, arg5 + v0, 0)
        };
        if (arg5 >= arg2) {
            return (arg1, arg2, arg3)
        };
        let v1 = if (arg0 > arg3) {
            arg0 - arg3
        } else {
            0
        };
        let v2 = vested_at(arg0, arg1, arg2, arg5);
        let v3 = if (v2 > v1) {
            v2 - v1
        } else {
            0
        };
        let v4 = if (v3 > arg3) {
            arg3
        } else {
            v3
        };
        (arg1, arg2, v4)
    }

    public fun debt_after_add(arg0: u256, arg1: u64, arg2: u256) : u256 {
        arg0 + (arg1 as u256) * arg2
    }

    public fun debt_after_harvest(arg0: u256, arg1: u64) : u256 {
        arg0 + (arg1 as u256) * 1000000000000000000000000000
    }

    public fun debt_after_remove(arg0: u256, arg1: u64, arg2: u256) : u256 {
        let v0 = (arg1 as u256) * arg2;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            0
        }
    }

    public fun index_step(arg0: u64, arg1: u64, arg2: u256) : (u256, u256) {
        if (arg1 == 0) {
            return (0, arg2)
        };
        let v0 = (arg0 as u256) * 1000000000000000000000000000 + arg2;
        let v1 = (arg1 as u256);
        (v0 / v1, v0 % v1)
    }

    public fun merge_end(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u256) + (arg2 as u256);
        if (v0 == 0) {
            return arg3
        };
        ((((arg0 as u256) * (arg1 as u256) + (arg2 as u256) * (arg3 as u256) + v0 - 1) / v0) as u64)
    }

    public fun pending_of(arg0: u64, arg1: u256, arg2: u256) : u64 {
        let v0 = (arg0 as u256) * arg1 + 1766847064778384329583297500742918515827483896875618958121606201292619776;
        if (v0 <= arg2) {
            0
        } else {
            let v2 = (v0 - arg2) / 1000000000000000000000000000;
            if (v2 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v2 as u64)
            }
        }
    }

    public fun referral_bonuses(arg0: u64) : (u64, u64) {
        ((((arg0 as u128) * 10 / 100) as u64), (((arg0 as u128) * 1 / 100) as u64))
    }

    public fun scaled_from_whole(arg0: u256) : u256 {
        arg0 * 1000000000000000000000000000 + 1766847064778384329583297500742918515827483896875618958121606201292619776
    }

    public fun unlocked(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg0 as u128) >= (arg1 as u128) + (arg2 as u128)
    }

    public fun vested_at(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 >= arg2) {
            arg0
        } else if (arg3 <= arg1) {
            0
        } else {
            (((arg0 as u128) * ((arg3 - arg1) as u128) / ((arg2 - arg1) as u128)) as u64)
        }
    }

    public fun whole_debt(arg0: u256) : u256 {
        if (arg0 <= 1766847064778384329583297500742918515827483896875618958121606201292619776) {
            return 0
        };
        let v0 = 1000000000000000000000000000;
        (arg0 - 1766847064778384329583297500742918515827483896875618958121606201292619776 + v0 - 1) / v0
    }

    public fun zero_debt() : u256 {
        1766847064778384329583297500742918515827483896875618958121606201292619776
    }

    // decompiled from Move bytecode v7
}

