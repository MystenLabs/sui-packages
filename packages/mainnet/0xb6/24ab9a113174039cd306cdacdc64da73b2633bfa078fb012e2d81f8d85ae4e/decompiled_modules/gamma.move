module 0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::gamma {
    public(friend) fun choose(arg0: u256, arg1: u256) : u256 {
        if (arg1 > arg0) {
            return 0
        };
        let v0 = arg0 - arg1;
        let v1 = if (arg1 > v0) {
            v0
        } else {
            arg1
        };
        let v2 = 1;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = v2 * (arg0 - v1 + v3 + 1);
            v2 = v4 / (v3 + 1);
            v3 = v3 + 1;
        };
        v2
    }

    fun dec_out(arg0: u256, arg1: u256, arg2: u256, arg3: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        assert!(arg0 > 0, 1);
        let (v0, v1) = log_raw(arg0, arg1, arg2, arg3);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(v0, v1))
    }

    fun log2_fix(arg0: u256) : u256 {
        let v0 = 0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::ilog2(arg0);
        let v1 = if (v0 <= 127) {
            arg0 << 127 - v0
        } else {
            arg0 >> v0 - 127
        };
        let v2 = v1;
        let v3 = (v0 as u256);
        let v4 = 0;
        while (v4 < 72) {
            let v5 = v2 * v2;
            if (v5 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                v2 = v5 >> 128;
                let v6 = v3 * 2;
                v3 = v6 + 1;
            } else {
                v2 = v5 >> 127;
                v3 = v3 * 2;
            };
            v4 = v4 + 1;
        };
        v3
    }

    public fun log_binomial_down(arg0: u256, arg1: u256) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        dec_out(choose(arg0, arg1), 3273295013171879848905885505232959985733, 0, false)
    }

    public fun log_binomial_up(arg0: u256, arg1: u256) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        dec_out(choose(arg0, arg1), 3273295013171879848905893317736685276032, 0, true)
    }

    fun log_raw(arg0: u256, arg1: u256, arg2: u256, arg3: bool) : (bool, u256) {
        if (arg3) {
            scaled((log2_fix(arg0) + 2) * arg1, arg2, true)
        } else {
            scaled(log2_fix(arg0) * arg1, arg2, false)
        }
    }

    fun scaled(arg0: u256, arg1: u256, arg2: bool) : (bool, u256) {
        if (arg0 >= arg1) {
            if (arg2) {
                (false, arg0 - arg1 + 22300745198530623141535718272648361505980415 >> 144)
            } else {
                (false, arg0 - arg1 >> 144)
            }
        } else if (arg2) {
            (true, arg1 - arg0 >> 144)
        } else {
            (true, arg1 - arg0 + 22300745198530623141535718272648361505980415 >> 144)
        }
    }

    // decompiled from Move bytecode v7
}

