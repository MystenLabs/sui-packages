module 0xa96b9b4e29f7c94c982886ed4c7f65159933d7010703b93f1411ae5f52bec6ac::utils {
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

