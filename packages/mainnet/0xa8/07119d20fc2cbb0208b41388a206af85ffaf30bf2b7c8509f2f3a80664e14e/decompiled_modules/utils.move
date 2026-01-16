module 0xa807119d20fc2cbb0208b41388a206af85ffaf30bf2b7c8509f2f3a80664e14e::utils {
    public fun calculate_yield_earnings(arg0: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg1: u64, arg2: u64) : (u64, u64, u64) {
        if (arg1 > arg2) {
            let v3 = arg1 - arg2;
            let v4 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::calculate_performance_fee(arg0, v3);
            (v3, v4, v3 - v4)
        } else {
            (0, 0, 0)
        }
    }

    // decompiled from Move bytecode v6
}

