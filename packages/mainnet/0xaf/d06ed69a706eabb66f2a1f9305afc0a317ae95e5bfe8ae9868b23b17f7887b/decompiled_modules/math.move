module 0xafd06ed69a706eabb66f2a1f9305afc0a317ae95e5bfe8ae9868b23b17f7887b::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u64 {
        assert!(arg2 > 0, 1);
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (arg2 as u128);
        let v2 = v0 / v1;
        let v3 = v2;
        if (v0 % v1 != 0 && arg3) {
            v3 = v2 + 1;
        };
        assert!(v3 <= 18446744073709551615, 0);
        (v3 as u64)
    }

    // decompiled from Move bytecode v6
}

