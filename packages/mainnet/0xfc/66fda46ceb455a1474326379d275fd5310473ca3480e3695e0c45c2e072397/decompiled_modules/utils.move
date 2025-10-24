module 0xfc66fda46ceb455a1474326379d275fd5310473ca3480e3695e0c45c2e072397::utils {
    public fun calculate_yield_earnings(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg1: u64, arg2: u64) : (u64, u64, u64) {
        if (arg1 > arg2) {
            let v3 = arg1 - arg2;
            let v4 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::calculate_performance_fee(arg0, v3);
            (v3, v4, v3 - v4)
        } else {
            (0, 0, 0)
        }
    }

    // decompiled from Move bytecode v6
}

