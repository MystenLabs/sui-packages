module 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::library {
    public fun get_amount_in(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg0 > 0, 201);
        assert!(arg1 > 0 && arg2 > 0, 202);
        assert!(arg0 < arg2, 202);
        let v0 = (arg2 - arg0) * (10000 - 30);
        let v1 = (arg1 * arg0 * 10000 + v0 - 1) / v0;
        if (v1 < 1000) {
            1000
        } else {
            v1
        }
    }

    public fun get_amount_out(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg0 > 0, 201);
        assert!(arg1 > 0 && arg2 > 0, 202);
        assert!(arg0 >= 1000, 201);
        let v0 = arg0 * (10000 - 30);
        let v1 = v0 * arg2 / (arg1 * 10000 + v0);
        assert!(v1 > 0, 205);
        v1
    }

    public fun get_amounts_in<T0, T1>(arg0: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg1: u256, arg2: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: bool) : u256 {
        let (v0, v1) = get_reserves<T0, T1>(arg0, arg2);
        let (v2, v3) = if (arg3) {
            (v1, v0)
        } else {
            (v0, v1)
        };
        get_amount_in(arg1, v2, v3)
    }

    public fun get_amounts_out<T0, T1>(arg0: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg1: u256, arg2: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>, arg3: bool) : u256 {
        let (v0, v1) = get_reserves<T0, T1>(arg0, arg2);
        let (v2, v3) = if (arg3) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        get_amount_out(arg1, v2, v3)
    }

    public fun get_reserves<T0, T1>(arg0: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::factory::Factory, arg1: &0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::Pair<T0, T1>) : (u256, u256) {
        let (v0, v1, _) = 0xefc1dc4d0c85becd7c4a255c00bd2caa478163aa69c16570df62e58edc51d8f4::pair::get_reserves<T0, T1>(arg1);
        (v0, v1)
    }

    public fun quote(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg0 > 0, 201);
        assert!(arg1 > 0 && arg2 > 0, 202);
        arg0 * arg2 / arg1
    }

    // decompiled from Move bytecode v6
}

