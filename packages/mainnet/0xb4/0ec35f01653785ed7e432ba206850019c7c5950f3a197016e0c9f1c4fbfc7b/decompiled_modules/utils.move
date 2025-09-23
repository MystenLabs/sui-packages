module 0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::utils {
    public fun calculate_yield_performance_fee(arg0: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg1: u64, arg2: u64) : u64 {
        if (arg1 > arg2) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::calculate_performance_fee(arg0, arg1 - arg2)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

