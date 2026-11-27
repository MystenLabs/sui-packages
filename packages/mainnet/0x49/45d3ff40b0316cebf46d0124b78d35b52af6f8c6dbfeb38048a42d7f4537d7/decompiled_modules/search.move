module 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search {
    struct Search has copy, drop {
        hint: u64,
        hi: u64,
        k: u8,
        used: u8,
        phase: u8,
        x0: u64,
        p0: u64,
        xl: u64,
        pl_neg: bool,
        pl: u64,
        next_x: u64,
        best_x: u64,
        best_out: u64,
        best_p: u64,
    }

    public fun new(arg0: u64, arg1: u64, arg2: u8) : Search {
        let v0 = if (arg0 > arg1) {
            arg1
        } else {
            arg0
        };
        let v1 = v0 >> 10;
        let v2 = if (v1 == 0) {
            1
        } else {
            v1
        };
        let v3 = if (v0 == 0 || arg2 == 0) {
            3
        } else {
            0
        };
        Search{
            hint     : v0,
            hi       : arg1,
            k        : arg2,
            used     : 0,
            phase    : v3,
            x0       : v2,
            p0       : 0,
            xl       : 0,
            pl_neg   : false,
            pl       : 0,
            next_x   : 0,
            best_x   : 0,
            best_out : 0,
            best_p   : 0,
        }
    }

    public fun next(arg0: &mut Search) : u64 {
        if (arg0.used >= arg0.k || arg0.phase == 3) {
            return 0
        };
        if (arg0.phase == 0) {
            return arg0.x0
        };
        if (arg0.phase == 1) {
            return arg0.hint
        };
        arg0.next_x
    }

    public fun record(arg0: &mut Search, arg1: u64, arg2: u64) {
        arg0.used = arg0.used + 1;
        let (v0, v1) = if (arg2 >= arg1) {
            (false, arg2 - arg1)
        } else {
            (true, arg1 - arg2)
        };
        if (!v0 && v1 > arg0.best_p) {
            arg0.best_p = v1;
            arg0.best_x = arg1;
            arg0.best_out = arg2;
        };
        if (arg0.phase == 0) {
            if (v0 || v1 == 0) {
                arg0.phase = 3;
                return
            };
            arg0.p0 = v1;
            let v2 = if (arg0.hint > arg0.x0) {
                1
            } else {
                3
            };
            arg0.phase = v2;
            return
        };
        arg0.xl = arg1;
        arg0.pl_neg = v0;
        arg0.pl = v1;
        let v3 = vertex(arg0.x0, arg0.p0, arg0.xl, arg0.pl_neg, arg0.pl, arg0.hi);
        let v4 = if (v3 > arg1) {
            v3 - arg1
        } else {
            arg1 - v3
        };
        if ((v4 as u128) * 10000 <= (arg1 as u128) * (10 as u128) || v3 == arg0.best_x) {
            arg0.phase = 3;
            return
        };
        arg0.next_x = v3;
        arg0.phase = 2;
    }

    public fun result(arg0: &Search) : (u64, u64, u8) {
        (arg0.best_x, arg0.best_out, arg0.used)
    }

    fun vertex(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64) : u64 {
        if (arg2 <= arg0) {
            return arg5
        };
        let v0 = (arg1 as u256) * (arg2 as u256);
        let v1 = (arg4 as u256) * (arg0 as u256);
        let v2 = if (arg2 > arg5 / 2) {
            arg5
        } else {
            arg2 * 2
        };
        if (!arg3 && v1 >= v0) {
            return v2
        };
        let v3 = if (arg3) {
            v0 + v1
        } else {
            v0 - v1
        };
        let v4 = (arg0 as u256) / 2 + (arg1 as u256) * (arg2 as u256) * ((arg2 - arg0) as u256) / 2 * v3;
        if (v4 > (arg5 as u256)) {
            arg5
        } else if (v4 < (arg0 as u256)) {
            arg0
        } else {
            (v4 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

