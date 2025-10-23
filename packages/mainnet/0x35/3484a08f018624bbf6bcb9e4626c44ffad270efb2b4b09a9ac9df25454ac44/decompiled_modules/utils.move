module 0x353484a08f018624bbf6bcb9e4626c44ffad270efb2b4b09a9ac9df25454ac44::utils {
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

