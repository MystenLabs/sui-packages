module 0x7728c4c074d17bcdb3553475338e0e92e94a4d1623e5e2229d429a403da8335d::utils {
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

