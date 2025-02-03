module 0x3c6ac23d80ac2b4654c686dd55f5dc4e07f4099489a3fee84e26e871ceef56af::oracle_utils {
    public fun abs_sub(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            return arg0 - arg1
        };
        arg1 - arg0
    }

    public fun calculate_amplitude(arg0: u256, arg1: u256) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 18446744073709551615
        };
        let v0 = abs_sub(arg0, arg1);
        if (v0 > 0x2::address::max() / (0x3c6ac23d80ac2b4654c686dd55f5dc4e07f4099489a3fee84e26e871ceef56af::oracle_constants::multiple() as u256)) {
            return 18446744073709551615
        };
        let v1 = v0 * (0x3c6ac23d80ac2b4654c686dd55f5dc4e07f4099489a3fee84e26e871ceef56af::oracle_constants::multiple() as u256) / arg0;
        if (v1 > (18446744073709551615 as u256)) {
            return 18446744073709551615
        };
        (v1 as u64)
    }

    public fun to_target_decimal_value(arg0: u256, arg1: u8, arg2: u8) : u256 {
        assert!(arg1 > 0 && arg2 > 0, 1);
        while (arg1 != arg2) {
            if (arg1 < arg2) {
                arg0 = arg0 * 10;
                arg1 = arg1 + 1;
                continue
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        arg0
    }

    public fun to_target_decimal_value_safe(arg0: u256, arg1: u64, arg2: u64) : u256 {
        while (arg1 != arg2 && arg0 != 0) {
            if (arg1 < arg2) {
                arg0 = arg0 * 10;
                arg1 = arg1 + 1;
                continue
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

