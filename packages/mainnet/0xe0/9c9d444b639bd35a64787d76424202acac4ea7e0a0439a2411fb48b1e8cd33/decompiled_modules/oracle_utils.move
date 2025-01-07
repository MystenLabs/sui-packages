module 0xe09c9d444b639bd35a64787d76424202acac4ea7e0a0439a2411fb48b1e8cd33::oracle_utils {
    public fun calculate_amplitude(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0x2::address::max()
        };
        if (arg0 > arg1) {
            return (arg0 - arg1) * (0xe09c9d444b639bd35a64787d76424202acac4ea7e0a0439a2411fb48b1e8cd33::oracle_constants::multiple() as u256) / arg1
        };
        (arg1 - arg0) * (0xe09c9d444b639bd35a64787d76424202acac4ea7e0a0439a2411fb48b1e8cd33::oracle_constants::multiple() as u256) / arg0
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

    // decompiled from Move bytecode v6
}

