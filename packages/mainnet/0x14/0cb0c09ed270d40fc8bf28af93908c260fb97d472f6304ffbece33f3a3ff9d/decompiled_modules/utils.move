module 0x140cb0c09ed270d40fc8bf28af93908c260fb97d472f6304ffbece33f3a3ff9d::utils {
    public fun calculate_yield_earnings(arg0: &0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::AuthorizedTransferTicket, arg1: u64, arg2: u64) : (u64, u64, u64) {
        if (arg1 > arg2) {
            let v3 = arg1 - arg2;
            let v4 = 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::calculate_performance_fee(arg0, v3);
            (v3, v4, v3 - v4)
        } else {
            (0, 0, 0)
        }
    }

    // decompiled from Move bytecode v6
}

