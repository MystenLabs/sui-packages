module 0x1e260110eff93197d10654953b2171aa4a1abe24de5d58ba9adf22432c1cbfcc::oracle_utils {
    public fun calculate_amplitude(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0x2::address::max()
        };
        if (arg0 > arg1) {
            return (arg0 - arg1) * (0x1e260110eff93197d10654953b2171aa4a1abe24de5d58ba9adf22432c1cbfcc::oracle_constants::multiple() as u256) / arg1
        };
        (arg1 - arg0) * (0x1e260110eff93197d10654953b2171aa4a1abe24de5d58ba9adf22432c1cbfcc::oracle_constants::multiple() as u256) / arg0
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

