module 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::probe {
    public fun treasury_balance<T0>(arg0: &0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner::OwnerCap, arg1: &mut 0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::balance::value<T0>(0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_balance<T0>(arg1)) + 0x2::balance::value<T0>(0xe8087c2b86351ce15e8d72e83a39c5772c0b1d054015ae9671305e686cef5034::suidollar::get_fee_balance<T0>(arg1))
    }

    // decompiled from Move bytecode v7
}

